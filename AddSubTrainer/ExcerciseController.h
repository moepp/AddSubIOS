//
//  ExcerciseController.h
//  AddSubTrainer
//
//  Created by Stephan Moser on 4/25/13.
//  Copyright (c) 2013 Stephan Moser. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ExcerciseController : UIViewController

@property (nonatomic, strong) IBOutlet UILabel *firstNumber;
@property (nonatomic, strong) IBOutlet UILabel *secondNumber;
@property (nonatomic, strong) IBOutlet UILabel *plusMinus;
@property (nonatomic, strong) IBOutlet UILabel *resultLabel;
@property (nonatomic, strong) IBOutlet UILabel *wrongAnswerLabel;
@property (nonatomic, strong) IBOutlet UILabel *correctAnswersLabel;
@property (nonatomic, strong) IBOutlet UILabel *wrongAnswersLabel;

@property (nonatomic, strong) IBOutlet UILabel *firstOnes;
@property (nonatomic, strong) IBOutlet UILabel *firstTens;
@property (nonatomic, strong) IBOutlet UILabel *firstHundreds;
@property (nonatomic, strong) IBOutlet UILabel *secondOnes;
@property (nonatomic, strong) IBOutlet UILabel *secondTens;
@property (nonatomic, strong) IBOutlet UILabel *secondHundreds;
@property (nonatomic, strong) IBOutlet UILabel *moveCarries;

@property (nonatomic, strong) IBOutlet UITextField *carryOnes;
@property (nonatomic, strong) IBOutlet UITextField *carryTens;
@property (nonatomic, strong) IBOutlet UITextField *resultFieldOnes;
@property (nonatomic, strong) IBOutlet UITextField *resultFieldTens;
@property (nonatomic, strong) IBOutlet UITextField *resultFieldHundreds;

@property (nonatomic, strong) IBOutlet UIView *summaryView;


@property (nonatomic) int desiredResult;
@property (nonatomic) int rightAnswers;
@property (nonatomic) int wrongAnswers;


- (IBAction)okButtonTapped:(id)sender;
- (IBAction)delButtonTapped:(id)sender;
- (IBAction)stopButtonTapped:(id)sender;



@end
