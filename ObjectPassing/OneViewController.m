//
//  ViewController.m
//  ObjectPassing
//
//  Created by Chemin Lin on 10/16/13.
//  Copyright (c) 2013 Chemin Lin. All rights reserved.
//

#import "OneViewController.h"

@interface OneViewController ()
@end

@implementation OneViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSLog(@"%@", self.myPerson);
}

- (void)viewWillAppear:(BOOL)animated
{
    [self refreshScreen];
}

- (void)refreshScreen {
    if (self.myPerson) {
        self.myPersonLabel.text = [@"My person's name is " stringByAppendingString:self.myPerson.name];
    } else {
        self.myPersonLabel.text = @"My Person does not exist.";
    }
    
    if (self.otherPerson) {
        self.otherPersonLabel.text = [@"The other person's name is " stringByAppendingString:self.otherPerson.name];
    } else {
        self.otherPersonLabel.text = @"The other Person does not exist";
    }
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"popTwo"])
    {
        // Get reference to the destination view controller
        TwoViewController *tvc = [segue destinationViewController];

        // Pass my person object to TWO
        [tvc setOtherPerson:self.myPerson];
        tvc.delegate = self;
        
    }
}

- (IBAction)createButton:(id)sender {
    if (!self.myPerson) {
        self.myPerson = [[Person alloc] init];
    }
    self.myPerson.name = self.nameTextField.text;
    [self refreshScreen];
}

- (IBAction)sendButton:(id)sender {
}

- (void)passPersonViewController:(UIViewController *)controller didFinishPassingPerson:(Person *)person {
    self.otherPerson = person;
    [self refreshScreen];
}

@end
