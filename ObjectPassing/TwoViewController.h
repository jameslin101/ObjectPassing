//
//  TwoViewController.h
//  ObjectPassing
//
//  Created by Chemin Lin on 10/16/13.
//  Copyright (c) 2013 Chemin Lin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Person.h"

@protocol TwoViewControllerDelegate <NSObject>
- (void)passPersonViewController:(UIViewController *)controller didFinishPassingPerson:(Person *)person;
@end

@interface TwoViewController : UIViewController
@property (nonatomic, weak) id <TwoViewControllerDelegate> delegate;

@property (strong, nonatomic) Person *myPerson;
@property (weak, nonatomic) Person *otherPerson;

@property (weak, nonatomic) IBOutlet UILabel *myPersonLabel;
@property (weak, nonatomic) IBOutlet UILabel *otherPersonLabel;
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;

- (IBAction)createButton:(id)sender;
- (IBAction)sendButton:(id)sender;
@end
