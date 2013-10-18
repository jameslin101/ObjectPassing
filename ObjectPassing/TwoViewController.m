//
//  TwoViewController.m
//  ObjectPassing
//
//  Created by Chemin Lin on 10/16/13.
//  Copyright (c) 2013 Chemin Lin. All rights reserved.
//

#import "TwoViewController.h"
//#import "OneViewController.h"
@interface TwoViewController ()
@end

@implementation TwoViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
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

- (IBAction)createButton:(id)sender {
    if (!self.myPerson) {
        self.myPerson = [[Person alloc] init];
    }
    self.myPerson.name = self.nameTextField.text;
    [self refreshScreen];
}

- (IBAction)sendButton:(id)sender {
    
//    NSArray *viewControllers = self.navigationController.viewControllers;
//    OneViewController *ovc = viewControllers[[viewControllers count] - 2 ];
//    
//    // Pass any objects to the view controller here, like...
//    [ovc setOtherPerson:self.myPerson];
//    

    [self.delegate passPersonViewController:self didFinishPassingPerson:self.myPerson];
    [self.navigationController popViewControllerAnimated:YES];
    
}

@end
