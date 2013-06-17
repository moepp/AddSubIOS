//
//  ExcerciseMenuController.m
//  AddSubTrainer
//
//  Created by Stephan Moser on 6/12/13.
//  Copyright (c) 2013 Stephan Moser. All rights reserved.
//

#import "ExcerciseMenuController.h"

@interface ExcerciseMenuController ()

@end

@implementation ExcerciseMenuController

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
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)easyDifficultyTapped:(id)sender {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	[defaults setInteger:1 forKey:@"excerciseDifficulty"];
    [defaults synchronize];

    
}
- (IBAction)mediumDifficultyTapped:(id)sender {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	[defaults setInteger:2 forKey:@"excerciseDifficulty"];
    [defaults synchronize];
    
}
- (IBAction)hardDifficultyTapped:(id)sender {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	[defaults setInteger:3 forKey:@"excerciseDifficulty"];
    [defaults synchronize];
    
}

@end
