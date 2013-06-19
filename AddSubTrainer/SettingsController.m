//
//  SettingsController.m
//  AddSubTrainer
//
//  Created by Stephan Moser on 6/18/13.
//  Copyright (c) 2013 Stephan Moser. All rights reserved.
//

#import "SettingsController.h"

@interface SettingsController ()

@end

@implementation SettingsController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    BOOL carryOnTop = [defaults boolForKey:@"carryOnTop"];
    
    if(carryOnTop)
        [self.carrySwitch setOn:YES];
    else
        [self.carrySwitch setOn:NO];

           
    // Do any additional setup after loading the view.
}
- (IBAction)switchCarries:(id)sender {
    
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
   
    
    if([self.carrySwitch isOn]) {
        NSLog(@"Carries on TOP");
        [defaults setBool:YES forKey:@"carryOnTop"];
        [defaults synchronize];

    } else {
        NSLog(@"Carries on BOTTOM");
        [defaults setBool:NO forKey:@"carryOnTop"];
        [defaults synchronize];

    }
    //if([self.carrySwitch isON]) {
        
   // }

    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
