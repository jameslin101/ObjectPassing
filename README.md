---
layout: post
title: "Using delegates for object passing between ViewControllers"
date: 2013-10-15 22:52
comments: true
categories: [iOS, delegates]
---

Passing objects between views controllers is tricky in iOS. 

In this example, I created a OneViewController and a TwoViewController. We are going to call them ONE and TWO for short.

We are going to pass a Person object from ONE to TWO.

{% img /images/object_passing_storyboard.png %}

The Person class just has a 'name' property:

	@interface Person : NSObject
	@property (strong, nonatomic) NSString *name;
	@end


Lets say we create a Person class in ONE and stored it in a property called myPerson. How do we pass it to TWO? We are going to assign a property called otherPerson in TWO to point to ONE's myPerson.

But how do we get access to a pointer to TWO? Since we are using a Navigation Controller, we can access it in the  prepareForSegue method.
	
	//ViewController.m
	- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
	{
	    if ([[segue identifier] isEqualToString:@"popTwo"])
	    {
	        // Get reference to the destination view controller
	        TwoViewController *tvc = [segue destinationViewController];

	        // Pass my person object to TWO
	        [tvc setOtherPerson:self.myPerson];
	        
	    }
	}

Now lets say I want to create a Person object assigned to TWO's myPerson property. How would I pass it back to ONE?

The bad way is to find a pointer to ONE and set its otherPerson property to TWO's myPerson:

	- (IBAction)sendButton:(id)sender {

	    NSArray *viewControllers = self.navigationController.viewControllers;
	    OneViewController *ovc = viewControllers[[viewControllers count] - 2 ];
	    
	    [ovc setOtherPerson:self.myPerson];
	    
	    [self.navigationController popViewControllerAnimated:YES];

	}

Although this works, theres a couple of problems.
First, it accesses the navigationControllers array to get to ONE. This is clearly pretty hacky.
It also forces TWO to have to know about ONE, and can only return the Person it created to ONE. This is the tight coupling situation which we want to avoid.
Second, suppose in the future if we wanted the button on TWO to be able to send the Person object to a new view controller called THREE instead? How would it do that?

The recommended solution is to use Delegates to pass the Person object.

We will first need to define a protocol on TWO

	@protocol TwoViewControllerDelegate <NSObject>
	- (void)passPersonViewController:(UIViewController *)controller didFinishPassingPerson:(Person *)person;
	@end

	@interface TwoViewController : UIViewController
	@property (nonatomic, weak) id <TwoViewControllerDelegate> delegate;
	...

Now in ONE's prepareForSegue method we need to set TWO's delegate to self (the part I always forget.)

	- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
	{
	    if ([[segue identifier] isEqualToString:@"popTwo"])
	    {
	        // Get reference to the destination view controller
	        TwoViewController *tvc = [segue destinationViewController];

	        // Pass my person object to TWO
	        [tvc setOtherPerson:self.myPerson];

	        // Set TwoViewController's delegate to self
	        tvc.delegate = self;
	        
	    }
	}	

We can erase any reference to ONE from TWO, such as an import that we needed before. The beauty of delegation is that TWO doesn't have to know who implements it.

	//delete this from TWO
	#import "OneViewController.h"

We can change the sendButton action to pass the Person object back throught the delegate:

	- (IBAction)sendButton:(id)sender {
	    
	    [self.delegate passPersonViewController:self didFinishPassingPerson:self.myPerson];
	    [self.navigationController popViewControllerAnimated:YES];
	    
	}

Lastly, we implement the delegate method in ONE

	- (void)passPersonViewController:(UIViewController *)controller didFinishPassingPerson:(Person *)person {
	    self.otherPerson = person;
	    [self refreshScreen];
	}

tldr:

Using the Delegate pattern for object back-passing in ViewControllers results in a cleaner and more flexible code.
This is also the Apple recommended way.