//
//  AppDelegate.h
//  AddSubTrainer
//
//  Created by Stephan Moser on 4/25/13.
//  Copyright (c) 2013 Stephan Moser. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) UIViewController *rootView;
- (void)transitionToViewController:(UIViewController *)viewController
                    withTransition:(UIViewAnimationOptions)transition;
- (void)changeRootViewController:(NSString *)controllerName;


@end
