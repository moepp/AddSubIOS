//
//  UserManagementController.h
//  AddSubTrainer
//
//  Created by Stephan Moser on 4/29/13.
//  Copyright (c) 2013 Stephan Moser. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UserManagementController : UIViewController

@property (nonatomic, strong) IBOutlet UITextField *usernameField;
@property (nonatomic, strong) IBOutlet UITextField *passwordField;
@property (nonatomic, strong) IBOutlet UILabel *errorLabel;


- (IBAction)okButtonTapped:(id)sender;

@end
