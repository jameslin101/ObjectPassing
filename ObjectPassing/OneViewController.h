//
//  ViewController.h
//  ObjectPassing
//
//  Created by Chemin Lin on 10/16/13.
//  Copyright (c) 2013 Chemin Lin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Person.h"
#import "TwoViewController.h"

@interface OneViewController : UIViewController <TwoViewControllerDelegate>

@property (strong, nonatomic) Person *myPerson;
@property (strong, nonatomic) Person *otherPerson;

@property (weak, nonatomic) IBOutlet UILabel *myPersonLabel;
@property (weak, nonatomic) IBOutlet UILabel *otherPersonLabel;
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;


- (IBAction)createButton:(id)sender;
- (IBAction)sendButton:(id)sender;




@end
