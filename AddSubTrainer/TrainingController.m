//
//  TrainingController.m
//  AddSubTrainer
//
//  Created by Stephan Moser on 4/30/13.
//  Copyright (c) 2013 Stephan Moser. All rights reserved.
//

#import "TrainingController.h"
#import "Base64.h"
#include <CommonCrypto/CommonDigest.h>
#include <CommonCrypto/CommonHMAC.h>

@interface TrainingController ()

@end

@implementation TrainingController

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
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(dismissKeyboard)];
    [tap setCancelsTouchesInView:NO];
    
    [self.view addGestureRecognizer:tap];
    self.moveCarries.transform = CGAffineTransformMakeRotation (3.14/2);
    
    [self showNormalButtons];
    
    //[self.wrongAnswerButton setHidden:YES];
    


    self.errorLabel.text = @"Wird geladen...";
    self.firstOnes.text = @"";
    self.firstTens.text = @"";
    self.firstHundreds.text = @"";
    
    self.secondOnes.text = @"";
    self.secondTens.text = @"";
    self.secondHundreds.text = @"";
    [self getProblem];
}

- (IBAction)okButtonTapped:(id)sender
{
    
    
    int combinedResult=
    [[NSString stringWithFormat:@"%d%d%d",
      self.resultFieldHundreds.text.intValue,
      self.resultFieldTens.text.intValue,
      self.resultFieldOnes.text.intValue] intValue];
    
    int combinedCarry=
    [[NSString stringWithFormat:@"%d%d",
      self.carryTens.text.intValue,
      self.carryOnes.text.intValue] intValue];
    
    self.result = combinedResult;
    self.carry = combinedCarry;
    NSMutableString *result_pattern = [[NSMutableString alloc]init];
    NSMutableString *carry_pattern = [[NSMutableString alloc]init];
    
    if(self.resultFieldHundreds.text.length == 0)
        [result_pattern appendString:@"e"];
    else
        [result_pattern appendString:@"n"];
    
    if(self.resultFieldTens.text.length == 0)
        [result_pattern appendString:@"e"];
    else
        [result_pattern appendString:@"n"];
    
    if(self.resultFieldOnes.text.length == 0)
        [result_pattern appendString:@"e"];
    else
        [result_pattern appendString:@"n"];
    
    if(self.carryTens.text.length == 0)
        [carry_pattern appendString:@"e"];
    else
        [carry_pattern appendString:@"n"];
    
    if(self.carryOnes.text.length == 0)
        [carry_pattern appendString:@"e"];
    else
        [carry_pattern appendString:@"n"];
    
    self.result_pattern = result_pattern;
    self.carry_pattern = carry_pattern;
    self.errorLabel.text = @"Bitte warten...";
    
    [self receiveResult];

}


- (void)getProblem
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    int uid = [defaults integerForKey:@"userID"];
   // NSLog([NSString stringWithFormat:@"USERID %i",uid]);
    

    
    NSString *soapMessage = [NSString stringWithFormat:
                             @"<soapenv:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soapenv=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:web=\"http://plusminus.tugraz.at/webservice\">                             <soapenv:Header/>                       <soapenv:Body>                             <web:getProblem soapenv:encodingStyle=\"http://schemas.xmlsoap.org/soap/encoding/\"><userId xsi:type=\"xsd:int\">%d</userId>                             </web:getProblem></soapenv:Body></soapenv:Envelope>", uid
                             ];
	//NSLog(soapMessage);
    
   // NSURL *url = [NSURL URLWithString:@"http://mathe.neuhold.pro/webservice#getProblem"];
    NSURL *url = [NSURL URLWithString:@"http://plusminus.tugraz.at/webservice#getProblem"];

	NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:url];
	NSString *msgLength = [NSString stringWithFormat:@"%d", [soapMessage length]];
	
	[theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
	[theRequest addValue: @"http://plusminus.tugraz.at/webservice" forHTTPHeaderField:@"SOAPAction"];
	[theRequest addValue: msgLength forHTTPHeaderField:@"Content-Length"];
	[theRequest setHTTPMethod:@"POST"];
	[theRequest setHTTPBody: [soapMessage dataUsingEncoding:NSUTF8StringEncoding]];
	
	NSURLConnection *theConnection = [[NSURLConnection alloc] initWithRequest:theRequest delegate:self];
	
	if( theConnection )
	{
		webData = [NSMutableData data];
	}
	else
	{
		NSLog(@"theConnection is NULL");
	}
    
}
- (IBAction)delButtonTapped:(id)sender
{
    [self clearInput];
    
}
- (void) clearInput {
    self.resultFieldTens.text = @"";
    self.resultFieldOnes.text = @"";
    self.resultFieldHundreds.text = @"";
    self.carryOnes.text = @"";
    self.carryTens.text = @"";
}

- (void)receiveResult
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    int uid = [defaults integerForKey:@"userID"];
    // self.errorLabel.text =[NSString stringWithFormat:@"%i",uid];
    
    NSString *soapMessage = [NSString stringWithFormat:
                             @"<soapenv:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soapenv=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:web=\"http://plusminus.tugraz.at/webservice\">                             <soapenv:Header/><soapenv:Body>                             <web:receiveResult soapenv:encodingStyle=\"http://schemas.xmlsoap.org/soap/encoding/\">                             <userId xsi:type=\"xsd:int\">%d</userId>                             <problemId xsi:type=\"xsd:int\">%d</problemId>                             <result xsi:type=\"xsd:int\">%d</result>                             <carry xsi:type=\"xsd:int\">%d</carry>                             <result_pattern xsi:type=\"xsd:string\">%@</result_pattern>                             <carry_pattern xsi:type=\"xsd:string\">%@</carry_pattern>                                <duration xsi:type=\"xsd:float\">1</duration></web:receiveResult></soapenv:Body></soapenv:Envelope>", uid,self.problemId,self.result,self.carry,self.result_pattern, self.carry_pattern];
	//NSLog(soapMessage);
    
    NSURL *url = [NSURL URLWithString:@"http://plusminus.tugraz.at/webservice#receiveResult"];
	NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:url];
	NSString *msgLength = [NSString stringWithFormat:@"%d", [soapMessage length]];
	
	[theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
	[theRequest addValue: @"http://plusminus.tugraz.at/webservice" forHTTPHeaderField:@"SOAPAction"];
	[theRequest addValue: msgLength forHTTPHeaderField:@"Content-Length"];
	[theRequest setHTTPMethod:@"POST"];
	[theRequest setHTTPBody: [soapMessage dataUsingEncoding:NSUTF8StringEncoding]];
	
	NSURLConnection *theConnection = [[NSURLConnection alloc] initWithRequest:theRequest delegate:self];
	
	if( theConnection )
	{
		webData = [NSMutableData data];
	}
	else
	{
		NSLog(@"theConnection is NULL");
	}
    
}

-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
	[webData setLength: 0];
}
-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
	[webData appendData:data];
}
-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
	NSLog(@"ERROR with theConenction");

}
-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
	NSLog(@"DONE. Received Bytes: %d", [webData length]);
	//NSString *theXML = [[NSString alloc] initWithBytes: [webData mutableBytes] length:[webData length] encoding:NSUTF8StringEncoding];
	//NSLog(theXML);
	//[theXML release];
	
	//if(!xmlParser) {
        xmlParser = [[NSXMLParser alloc] initWithData: webData];
        [xmlParser setDelegate: self];
        [xmlParser setShouldResolveExternalEntities: YES];
        [xmlParser parse];
   // }
	
	//[connection release];
	//[webData release];
}


-(void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *) namespaceURI qualifiedName:(NSString *)qName
   attributes: (NSDictionary *)attributeDict
{
    
    if( [elementName isEqualToString:@"id"])
	{
        
		if(!soapResults)
		{
			soapResults = [[NSMutableString alloc] init];
		}
		recordResults = YES;
	}

    
    
	if( [elementName isEqualToString:@"first"])
	{
        
		if(!soapResults)
		{
			soapResults = [[NSMutableString alloc] init];
		}
		recordResults = YES;
	}
    if( [elementName isEqualToString:@"second"])
	{
        
		if(!soapResults)
		{
			soapResults = [[NSMutableString alloc] init];		}
		recordResults = YES;
	}
    if( [elementName isEqualToString:@"operator"])
	{
        
		if(!soapResults)
		{
			soapResults =[[NSMutableString alloc] init];		}
		recordResults = YES;
	}
    
    if( [elementName isEqualToString:@"ns1:receiveResultResponse"])
	{
        
		if(!soapResults)
		{
			soapResults = [[NSMutableString alloc] init];
		}
        soapResults = [soapResults init];
		recordResults = YES;
	}

}
-(void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
	if(recordResults)
	{
		[soapResults appendString: string];
        [soapResults appendString: @" "];
	}
}
-(void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    if( [elementName isEqualToString:@"id"])
	{
		recordResults = NO;
		//greeting.text = soapResults;
	}
    
	if( [elementName isEqualToString:@"first"])
	{
		recordResults = NO;
		//greeting.text = soapResults;
	}
    if( [elementName isEqualToString:@"second"])
	{
		recordResults = NO;
		//greeting.text = soapResults;
	}
    if( [elementName isEqualToString:@"operator"])
	{
		recordResults = NO;
        [self fillLabels:soapResults];
		//greeting.text = soapResults;
      
	}
    if( [elementName isEqualToString:@"ns1:receiveResultResponse"])
	{
		recordResults = NO;
        if([soapResults isEqualToString:@"true "] ) {
            self.errorLabel.text = @"Bitte Warten...";
            self.wrongAnswerLabel.textColor = [UIColor greenColor];
            self.wrongAnswerLabel.text = @"KORREKT";
            soapResults = [[NSMutableString alloc] init];
            [self getProblem];
        }
        else {
            self.errorLabel.text = @"FALSCH";
            self.wrongAnswerLabel.textColor = [UIColor redColor];
            self.wrongAnswerLabel.text = [NSString stringWithFormat:@"Ergebnis war: %d ", self.desired_result];
            [self showWrongAnswerButtons];
            /*[self.wrongAnswerButton setHidden:NO];
            [self.okButton setHidden:YES];
            [self.deleteButton setHidden:YES];*/
            /*[self.wrongAnswerButton setTitle:[NSString stringWithFormat:@"Ergebnis war: %d ", self.desired_result] forState:UIControlStateHighlighted];
            [self.wrongAnswerButton setTitle:[NSString stringWithFormat:@"Ergebnis war: %d ", self.desired_result] forState:UIControlStateNormal];
            [self.wrongAnswerButton setTitle:[NSString stringWithFormat:@"Ergebnis war: %d ", self.desired_result] forState:UIControlStateSelected];
            //self.wrongAnswerButton settitle*/
            soapResults = [[NSMutableString alloc] init];
        }
         
        
       // [self getProblem];
		//greeting.text = soapResults;
	}
    
}

-(void)fillLabels:(NSString *) problemString
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    BOOL carryOnTop = [defaults boolForKey:@"carryOnTop"];
    
    if (carryOnTop)
    {
        [self moveCarriesOnTop];
    }
    NSLog(@"problemString: %@", problemString);
    NSArray *problemArray = [problemString componentsSeparatedByString:@" "];
    //NSArray  *problemArray = [NSArray arrayWithObjects:@"1",@"623",@"439",@"-", nil];
    self.problemId = [[problemArray objectAtIndex:0] intValue];
    NSString *firstNumString = [problemArray objectAtIndex:1];
    NSString *secondNumString = [problemArray objectAtIndex:2];
    
    
   
    NSString *firstOnes = 0;
    NSString *firstTens = 0;
    NSString *firstHundreds = 0;
    NSString *secondOnes = 0;
    NSString *secondTens = 0;
    NSString *secondHundreds = 0;
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
    
    if([[problemArray objectAtIndex:3] isEqualToString:@"+"] ) {
        self.plusMinus.text = @"+";
        self.desired_result = firstNumString.intValue + secondNumString.intValue;
    }else {
        self.plusMinus.text = @"-";
        self.desired_result = firstNumString.intValue - secondNumString.intValue;
    }
    
    
    self.errorLabel.text = @"";
    self.wrongAnswerLabel.text = @"";
    
    [self clearInput];
  /*  self.resultFieldOnes.text = @"";
    self.resultFieldTens.text = @"";
    self.resultFieldHundreds.text = @"";
    self.carryTens.text = @"";
    self.carryOnes.text = @"";*/
    
    //empty results from before
    soapResults = [[NSMutableString alloc] init];
   // soapResults = @"";
    
    
    
}

- (void)dismissKeyboard {
    //self.resultLabel.text = [NSString stringWithFormat:@"%d",self.resultFieldOnes.text.intValue];
    [self.resultFieldOnes resignFirstResponder];
    [self.resultFieldTens resignFirstResponder];
    [self.resultFieldHundreds resignFirstResponder];
    [self.carryOnes resignFirstResponder];
    [self.carryTens resignFirstResponder];
    
}

- (void)showNormalButtons {
    [self.wrongAnswerButton setHidden:YES];
    [self.okButton setHidden:NO];
    [self.deleteButton setHidden:NO];
    
}
- (void)showWrongAnswerButtons {
    [self.wrongAnswerButton setHidden:NO];
    [self.okButton setHidden:YES];
    [self.deleteButton setHidden:YES];
    
}

- (IBAction)wrongAnswerButtonTapped:(id) sender {
    
    [self showNormalButtons];
    [self getProblem];
    
}

- (IBAction)moveCarryFields:(id)sender
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    BOOL carryOnTop = [defaults boolForKey:@"carryOnTop"];
    
    if(carryOnTop) {
        [self moveCarriesToBottom];
        [defaults setBool:NO forKey:@"carryOnTop"];
        [defaults synchronize];
    } else {
        [self moveCarriesOnTop];
        [defaults setBool:YES forKey:@"carryOnTop"];
        [defaults synchronize];
    }
}
- (void)moveCarriesOnTop {
    CGRect onesFrame = self.carryOnes.frame;
    CGRect tensFrame = self.carryTens.frame;
    onesFrame.origin.y = 50;
    tensFrame.origin.y = 50;
    self.carryOnes.frame = onesFrame;
    self.carryTens.frame = tensFrame;
    
}
- (void)moveCarriesToBottom {
    CGRect onesFrame = self.carryOnes.frame;
    CGRect tensFrame = self.carryTens.frame;
    onesFrame.origin.y = 170;
    tensFrame.origin.y = 170;
    self.carryOnes.frame = onesFrame;
    self.carryTens.frame = tensFrame;
    
}

@end
