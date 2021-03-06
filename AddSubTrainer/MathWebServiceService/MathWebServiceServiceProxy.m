//------------------------------------------------------------------------------
// <wsdl2code-generated>
// This code was generated by http://www.wsdl2code.com iPhone version 1.5
// Date Of Creation: 6/11/2013 11:20:27 AM
//
//  Please dont change this code, regeneration will override your changes
//</wsdl2code-generated>
//
//------------------------------------------------------------------------------
//
//This source code was auto-generated by Wsdl2Code Version
//
#import "MathWebServiceServiceProxy.h"

@implementation MathWebServiceServiceProxy

-(id)initWithUrl:(NSString*)url AndDelegate:(id<Wsdl2CodeProxyDelegate>)delegate{
    self = [super init];
    if (self != nil){
        self.service = [[MathWebServiceService alloc] init];
        [self.service setUrl:url];
        [self setUrl:url];
        [self setProxyDelegate:delegate];
    }
    return self;
}

///Origin Return Type:WebserviceProblem
-(void)getProblem:(int)userId {
    [self.service addTarget:self AndAction:&getProblemTarget];
    [self.service getProblem:userId ];
}

void getProblemTarget(MathWebServiceServiceProxy* target, id sender, NSString* xml){
    @try{
        NSString *xmldata = [xml stringByReplacingOccurrencesOfString:@"xmlns=\"http://mathe.neuhold.pro/webservice\"" withString:@""];
        NSData *data = [xmldata dataUsingEncoding:NSUTF8StringEncoding];
        XPathQuery *xpathQuery = [[XPathQuery alloc] init];
        NSString * query = [NSString stringWithFormat:@"/soap:Envelope/soap:Body/getProblemResponse/*"];
        NSArray *arrayOfWSData = [xpathQuery newXMLXPathQueryResult:data andQuery:query];
        if([arrayOfWSData count] == 0 ){
            NSException *exception = [NSException exceptionWithName:@"Wsdl2Code" reason: @"Response is nil" userInfo: nil];
            if (target.proxyDelegate != nil){
                [target.proxyDelegate proxyRecievedError:exception InMethod:@"getProblem"];
                return;
            }
        }
        NSArray* array0 = [[arrayOfWSData objectAtIndex:0] objectForKey:@"nodeChildArray"];
        WebserviceProblem* result = [[WebserviceProblem alloc]initWithArray:array0];
        if (target.proxyDelegate != nil){
            [target.proxyDelegate proxydidFinishLoadingData:result InMethod:@"getProblem"];
            return;
        }
    }
    @catch(NSException *ex){
        if (target.proxyDelegate != nil){
            [target.proxyDelegate proxyRecievedError:ex InMethod:@"getProblem"];
            return;
        }
    }
}

///Origin Return Type:BOOL
-(void)receiveResult:(int)userId :(int)problemId :(int)result :(int)carry :(NSString *)result_pattern :(NSString *)carry_pattern {
    [self.service addTarget:self AndAction:&receiveResultTarget];
    [self.service receiveResult:userId :problemId :result :carry :result_pattern :carry_pattern ];
}

void receiveResultTarget(MathWebServiceServiceProxy* target, id sender, NSString* xml){
    @try{
        NSString *xmldata = [xml stringByReplacingOccurrencesOfString:@"xmlns=\"http://mathe.neuhold.pro/webservice\"" withString:@""];
        NSData *data = [xmldata dataUsingEncoding:NSUTF8StringEncoding];
        XPathQuery *xpathQuery = [[XPathQuery alloc] init];
        NSString * query = [NSString stringWithFormat:@"/soap:Envelope/soap:Body/receiveResultResponse/*"];
        NSArray *arrayOfWSData = [xpathQuery newXMLXPathQueryResult:data andQuery:query];
        if([arrayOfWSData count] == 0 ){
            NSException *exception = [NSException exceptionWithName:@"Wsdl2Code" reason: @"Response is nil" userInfo: nil];
            if (target.proxyDelegate != nil){
                [target.proxyDelegate proxyRecievedError:exception InMethod:@"receiveResult"];
                return;
            }
        }
        NSString *nodeContentValue = [[NSString alloc] initWithString:[[arrayOfWSData objectAtIndex:0] objectForKey:@"nodeContent"]];
        NSNumber* result = nil;
        result = [NSNumber numberWithBool:[nodeContentValue boolValue]];
        if (target.proxyDelegate != nil){
            [target.proxyDelegate proxydidFinishLoadingData:result InMethod:@"receiveResult"];
            return;
        }
    }
    @catch(NSException *ex){
        if (target.proxyDelegate != nil){
            [target.proxyDelegate proxyRecievedError:ex InMethod:@"receiveResult"];
            return;
        }
    }
}
@end
