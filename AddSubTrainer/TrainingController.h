//
//  TrainingController.h
//  AddSubTrainer
//
//  Created by Stephan Moser on 4/30/13.
//  Copyright (c) 2013 Stephan Moser. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "MathWebServiceServiceProxy.h"

@interface TrainingController : UIViewController {
	NSMutableData *webData;
	NSMutableString *soapResults;
	NSXMLParser *xmlParser;
	BOOL recordResults;
    
}

@property (nonatomic, strong) IBOutlet UITextField *usernameField;
@property (nonatomic, strong) IBOutlet UITextField *passwordField;
@property (nonatomic, strong) IBOutlet UILabel *errorLabel;
@property (nonatomic, strong) IBOutlet UILabel *wrongAnswerLabel;
@property (nonatomic, strong) IBOutlet UIButton *wrongAnswerButton;
@property (nonatomic, strong) IBOutlet UIButton *okButton;
@property (nonatomic, strong) IBOutlet UIButton *deleteButton;

//@property (nonatomic, strong) NSMutableString *soapResults;
@property (nonatomic, strong) NSDate *startTime;
@property (nonatomic, strong) NSDate *endTime;
@property (nonatomic) NSTimeInterval executionTime;


@property (nonatomic, strong) IBOutlet UILabel *firstOnes;
@property (nonatomic, strong) IBOutlet UILabel *firstTens;
@property (nonatomic, strong) IBOutlet UILabel *firstHundreds;
@property (nonatomic, strong) IBOutlet UILabel *secondOnes;
@property (nonatomic, strong) IBOutlet UILabel *secondTens;
@property (nonatomic, strong) IBOutlet UILabel *secondHundreds;
@property (nonatomic, strong) IBOutlet UILabel *plusMinus;
@property (nonatomic, strong) IBOutlet UILabel *moveCarries;

@property (nonatomic, strong) IBOutlet UITextField *carryOnes;
@property (nonatomic, strong) IBOutlet UITextField *carryTens;
@property (nonatomic, strong) IBOutlet UITextField *resultFieldOnes;
@property (nonatomic, strong) IBOutlet UITextField *resultFieldTens;
@property (nonatomic, strong) IBOutlet UITextField *resultFieldHundreds;

@property (nonatomic, strong) NSString *result_pattern;
@property (nonatomic, strong) NSString *carry_pattern;
@property (nonatomic) int result;
@property (nonatomic) int problemId;
@property (nonatomic) int carry;
@property (nonatomic) int desired_result;



@end
