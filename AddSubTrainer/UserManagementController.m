//
//  UserManagementController.m
//  AddSubTrainer
//
//  Created by Stephan Moser on 4/29/13.
//  Copyright (c) 2013 Stephan Moser. All rights reserved.
//

#import "UserManagementController.h"
#import "adSubUsermanager_Soap_ManagementService.h"
#import "TrainingController.h"
#import "GameMenuController.h"
//#import "TransitionController.h"
#import "Base64.h"
#import "AppDelegate.h"
#include <CommonCrypto/CommonDigest.h>
#include <CommonCrypto/CommonHMAC.h>

@interface UserManagementController ()

@end

@implementation UserManagementController

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
    BOOL isSessionActive = [defaults boolForKey:@"isSessionActive"];
    
    if (isSessionActive)
    {
        AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        [appDelegate changeRootViewController:@"gamemenu"];
    }
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(dismissKeyboard)];
    [tap setCancelsTouchesInView:NO];
    
    [self.view addGestureRecognizer:tap];

	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)dismissKeyboard {
    //self.resultLabel.text = [NSString stringWithFormat:@"%d",self.resultFieldOnes.text.intValue];
    [self.usernameField resignFirstResponder];
    [self.passwordField resignFirstResponder];
       
}

- (IBAction)okButtonTapped:(id)sender
{
    
   // requestActive = YES;
    NSString *key = @"414af31d50c26d20c52222c780ae240d";//@"fc54aa16f403391c924a018bb258e9f7";
    NSString *pw = self.passwordField.text;
    NSString *uname = self.usernameField.text;
    if (pw != nil && uname != nil) {
        const char *s = [pw cStringUsingEncoding:NSASCIIStringEncoding];
        NSData *pwdata = [NSData dataWithBytes:s length:strlen(s)];
        uint8_t digest[CC_SHA256_DIGEST_LENGTH] = {0};
        CC_SHA256(pwdata.bytes, pwdata.length, digest);
        NSData *out = [NSData dataWithBytes:digest length:CC_SHA256_DIGEST_LENGTH];
        NSString *hash = [out description];
        hash = [hash stringByReplacingOccurrencesOfString:@" " withString:@""];
        hash = [hash stringByReplacingOccurrencesOfString:@"<" withString:@""];
        hash = [hash stringByReplacingOccurrencesOfString:@">" withString:@""];
       // NSString *data = [NSString stringWithFormat:@"%@%@%@", uname, hash, @"3"];
        NSString *data = [NSString stringWithFormat:@"%@%@%@", uname, hash, @"12"];

        const char *cKey = [key cStringUsingEncoding:NSASCIIStringEncoding];
        const char *cData = [data cStringUsingEncoding:NSASCIIStringEncoding];
        unsigned char cHMAC[CC_SHA256_DIGEST_LENGTH];
        CCHmac(kCCHmacAlgSHA256, cKey, strlen(cKey), cData, strlen(cData), cHMAC);
        NSData *outhmac = [NSData dataWithBytes:cHMAC length:CC_SHA256_DIGEST_LENGTH];
        NSString *hmachash = [outhmac description];
        hmachash = [hmachash stringByReplacingOccurrencesOfString:@" " withString:@""];
        hmachash = [hmachash stringByReplacingOccurrencesOfString:@"<" withString:@""];
        hmachash = [hmachash stringByReplacingOccurrencesOfString:@">" withString:@""];
        NSLog(@"hmachash: %@", hmachash);
        NSLog(@"pwhash: %@", hash);
        //NSData *responseData = [NSMutableData data];
        adSubUsermanager_Soap_ManagementService *userManagerService = [[adSubUsermanager_Soap_ManagementService alloc] init];
        //[userManagerService isUserAllowed:self action:@selector(handleUMService:) username:uname password:hash idApp:3 hmacClient:hmachash];
        [userManagerService isUserAllowed:self action:@selector(handleUMService:) username:uname password:hash idApp:12 hmacClient:hmachash];
    }
   }

-(void) handleUMService: (id) result {
	//NSLog(@"inside usermanagerservice");
     NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	if(result == nil) {
        [defaults setBool:NO forKey:@"isSessionActive"];
        [defaults synchronize];
		self.errorLabel.text = @"Connection Error";
		return;
	}
	if([result isKindOfClass: [NSError class]]) {
        [defaults setBool:NO forKey:@"isSessionActive"];
        [defaults synchronize];
		self.errorLabel.text = @"There was an Error";
		return;
	}
	if([result isKindOfClass: [SoapFault class]]) {
        [defaults setBool:NO forKey:@"isSessionActive"];
        [defaults synchronize];
		self.errorLabel.text = @"There was an Error";
		return;
	}
	adSubUsermanager_Datastructure_LoginCredentials* res = (adSubUsermanager_Datastructure_LoginCredentials*) result;
	if(res != nil) {
		if ([res accepted]) {
           
            [defaults setInteger:res.idUser forKey:@"userID"];
            [defaults setBool:YES forKey:@"isSessionActive"];
            [defaults synchronize];
			self.errorLabel.text = @"SUCCESS";
            AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
            [appDelegate changeRootViewController:@"gamemenu"];
                      
        } else {
			self.errorLabel.text = @"Wrong User/PWD";
            [defaults setBool:NO forKey:@"isSessionActive"];
            [defaults synchronize];

            

		}
    }
}





- (NSString *)hmacsha1:(NSString *)data secret:(NSString *)key {
    
    const char *cKey  = [key cStringUsingEncoding:NSASCIIStringEncoding];
    const char *cData = [data cStringUsingEncoding:NSASCIIStringEncoding];
    
    unsigned char cHMAC[CC_SHA1_DIGEST_LENGTH];
    
    CCHmac(kCCHmacAlgSHA1, cKey, strlen(cKey), cData, strlen(cData), cHMAC);
    
    NSData *HMAC = [[NSData alloc] initWithBytes:cHMAC length:sizeof(cHMAC)];
    
    NSString *hash = [HMAC base64EncodedString];
    
    
    return hash;
}

- (IBAction)registerButtonTapped:(id)sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://mathe.tugraz.at"]];
}

@end
