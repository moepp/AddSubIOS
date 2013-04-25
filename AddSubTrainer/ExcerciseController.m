//
//  ExcerciseController.m
//  AddSubTrainer
//
//  Created by Stephan Moser on 4/25/13.
//  Copyright (c) 2013 Stephan Moser. All rights reserved.
//

#import "ExcerciseController.h"

@interface ExcerciseController ()

@end

@implementation ExcerciseController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (IBAction)okButtonTapped:(id)sender
{
    int combinedInt=
    [[NSString stringWithFormat:@"%d%d%d",
      self.resultFieldHundreds.text.intValue,
      self.resultFieldTens.text.intValue,
      self.resultFieldOnes.text.intValue] intValue];
   
    if (combinedInt == self.desiredResult)
    {
        self.rightAnswers++;
        self.resultLabel.text = @"RIGHT";
    }
    else
    {
        self.wrongAnswers++;
        self.resultLabel.text = @"WRONG";
    }
    
    [self clearInput];

    [self fetchCalculation];
}

- (IBAction)delButtonTapped:(id)sender
{
    [self clearInput];
    
}

- (IBAction)stopButtonTapped:(id)sender
{
    [self.summaryView setHidden:NO];
    
    self.wrongAnswersLabel.text = [NSString stringWithFormat:@"%d", self.wrongAnswers];
    self.correctAnswersLabel.text = [NSString stringWithFormat:@"%d", self.rightAnswers];

    
}
- (void) clearInput {
    self.resultFieldTens.text = @"";
    self.resultFieldOnes.text = @"";
    self.resultFieldHundreds.text = @"";
}

- (void)fetchCalculation
{
    int plusMinus = (arc4random() % 2);
    int firstNum = (arc4random() % 1000);
    int secondNum = (arc4random() % 1000);
    
    if (firstNum < secondNum)
        plusMinus = 0;
    
    if (plusMinus == 0 && (firstNum + secondNum) >= 1000) {
        while((firstNum + secondNum) > 1000)
        {
            firstNum = (arc4random() % 1000);
            secondNum = (arc4random() % 1000);
        }
        
    }
    NSString *firstNumString = [NSString stringWithFormat:@"%d", firstNum];
    NSString *secondNumString = [NSString stringWithFormat:@"%d", secondNum];
    NSString *firstOnes;
    NSString *firstTens;
    NSString *firstHundreds;
    NSString *secondOnes;
    NSString *secondTens;
    NSString *secondHundreds;
  //  [firstNumString substringWithRange:<#(NSRange)#>]
    if ([firstNumString length] == 3) {
        firstOnes = [firstNumString substringWithRange:NSMakeRange(2, 1)];
        firstTens = [firstNumString substringWithRange:NSMakeRange(1, 1)];
        firstHundreds = [firstNumString substringWithRange:NSMakeRange(0, 1)];
        
    } else if ([firstNumString length] == 2) {
        firstOnes = [firstNumString substringWithRange:NSMakeRange(1, 1)];
        firstTens = [firstNumString substringWithRange:NSMakeRange(0, 1)];
        firstHundreds = @"";
    } else {
        
        firstOnes = [firstNumString substringWithRange:NSMakeRange(0, 1)];
        firstTens = @"";
        firstHundreds = @"";
    }
    
    if ([secondNumString length] == 3) {
        secondOnes = [secondNumString substringWithRange:NSMakeRange(2, 1)];
        secondTens = [secondNumString substringWithRange:NSMakeRange(1, 1)];
        secondHundreds = [secondNumString substringWithRange:NSMakeRange(0, 1)];
        
    } else if ([secondNumString length] == 2) {
        secondOnes = [secondNumString substringWithRange:NSMakeRange(1, 1)];
        secondTens = [secondNumString substringWithRange:NSMakeRange(0, 1)];
        secondHundreds = @"";
    } else {
        
        secondOnes = [secondNumString substringWithRange:NSMakeRange(0, 1)];
        secondTens = @"";
        secondHundreds = @"";
    }
    
    
    self.firstOnes.text = firstOnes;
    self.firstTens.text = firstTens;
    self.firstHundreds.text = firstHundreds;
    
    self.secondOnes.text = secondOnes;
    self.secondTens.text = secondTens;
    self.secondHundreds.text = secondHundreds;
    
    self.plusMinus.text = (plusMinus == 0) ? @"+" : @"-";    
    self.desiredResult = (plusMinus == 0) ? (firstNum + secondNum) : (firstNum - secondNum);

    
}



- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.summaryView setHidden:YES];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(dismissKeyboard)];
    [tap setCancelsTouchesInView:NO];   
    
    [self.view addGestureRecognizer:tap];
    
    [self fetchCalculation];
	// Do any additional setup after loading the view.
        
        
    //self.resultLabel.text = [NSString stringWithFormat:@"%d",self.resultFieldOnes.text.intValue];
    
   // self.resultFieldTens.text.intValue
    
        
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)dismissKeyboard {
    //self.resultLabel.text = [NSString stringWithFormat:@"%d",self.resultFieldOnes.text.intValue];
    [self.resultFieldOnes resignFirstResponder];
    [self.resultFieldTens resignFirstResponder];
    [self.resultFieldHundreds resignFirstResponder];
    [self.carryOnes resignFirstResponder];
    [self.carryTens resignFirstResponder];
    
}

@end
