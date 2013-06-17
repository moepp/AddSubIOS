//
//  GameMenuController.m
//  AddSubTrainer
//
//  Created by Stephan Moser on 6/11/13.
//  Copyright (c) 2013 Stephan Moser. All rights reserved.
//

#import "GameMenuController.h"

@interface GameMenuController ()

@end

@implementation GameMenuController

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

- (IBAction)logoutButtonTapped:(id)sender
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setBool:NO forKey:@"isSessionActive"];
    //BOOL isSessionActive = [defaults integerForKey:@"isSessionActive"];
}

@end
