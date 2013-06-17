#import <Foundation/Foundation.h>
#import "USAdditions.h"
#import <libxml/tree.h>
#import "USGlobals.h"
@class MathWebServiceServiceSvc_WebserviceProblem;
@interface MathWebServiceServiceSvc_WebserviceProblem : NSObject {
	
/* elements */
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MathWebServiceServiceSvc_WebserviceProblem *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
/* attributes */
- (NSDictionary *)attributes;
@end
/* Cookies handling provided by http://en.wikibooks.org/wiki/Programming:WebObjects/Web_Services/Web_Service_Provider */
#import <libxml/parser.h>
#import "xsd.h"
#import "MathWebServiceServiceSvc.h"
@class MathWebServiceBinding;
@interface MathWebServiceServiceSvc : NSObject {
	
}
+ (MathWebServiceBinding *)MathWebServiceBinding;
@end
@class MathWebServiceBindingResponse;
@class MathWebServiceBindingOperation;
@protocol MathWebServiceBindingResponseDelegate <NSObject>
- (void) operation:(MathWebServiceBindingOperation *)operation completedWithResponse:(MathWebServiceBindingResponse *)response;
@end
@interface MathWebServiceBinding : NSObject <MathWebServiceBindingResponseDelegate> {
	NSURL *address;
	NSTimeInterval defaultTimeout;
	NSMutableArray *cookies;
	BOOL logXMLInOut;
	BOOL synchronousOperationComplete;
	NSString *authUsername;
	NSString *authPassword;
}
@property (copy) NSURL *address;
@property (assign) BOOL logXMLInOut;
@property (assign) NSTimeInterval defaultTimeout;
@property (nonatomic, retain) NSMutableArray *cookies;
@property (nonatomic, retain) NSString *authUsername;
@property (nonatomic, retain) NSString *authPassword;
- (id)initWithAddress:(NSString *)anAddress;
- (void)sendHTTPCallUsingBody:(NSString *)body soapAction:(NSString *)soapAction forOperation:(MathWebServiceBindingOperation *)operation;
- (void)addCookie:(NSHTTPCookie *)toAdd;
- (MathWebServiceBindingResponse *)getProblemUsingUserId:(NSNumber *)aUserId ;
- (void)getProblemAsyncUsingUserId:(NSNumber *)aUserId  delegate:(id<MathWebServiceBindingResponseDelegate>)responseDelegate;
- (MathWebServiceBindingResponse *)receiveResultUsingUserId:(NSNumber *)aUserId problemId:(NSNumber *)aProblemId result:(NSNumber *)aResult carry:(NSNumber *)aCarry result_pattern:(NSString *)aResult_pattern carry_pattern:(NSString *)aCarry_pattern ;
- (void)receiveResultAsyncUsingUserId:(NSNumber *)aUserId problemId:(NSNumber *)aProblemId result:(NSNumber *)aResult carry:(NSNumber *)aCarry result_pattern:(NSString *)aResult_pattern carry_pattern:(NSString *)aCarry_pattern  delegate:(id<MathWebServiceBindingResponseDelegate>)responseDelegate;
@end
@interface MathWebServiceBindingOperation : NSOperation {
	MathWebServiceBinding *binding;
	MathWebServiceBindingResponse *response;
	id<MathWebServiceBindingResponseDelegate> delegate;
	NSMutableData *responseData;
	NSURLConnection *urlConnection;
}
@property (retain) MathWebServiceBinding *binding;
@property (readonly) MathWebServiceBindingResponse *response;
@property (nonatomic, assign) id<MathWebServiceBindingResponseDelegate> delegate;
@property (nonatomic, retain) NSMutableData *responseData;
@property (nonatomic, retain) NSURLConnection *urlConnection;
- (id)initWithBinding:(MathWebServiceBinding *)aBinding delegate:(id<MathWebServiceBindingResponseDelegate>)aDelegate;
@end
@interface MathWebServiceBinding_getProblem : MathWebServiceBindingOperation {
	NSNumber * userId;
}
@property (retain) NSNumber * userId;
- (id)initWithBinding:(MathWebServiceBinding *)aBinding delegate:(id<MathWebServiceBindingResponseDelegate>)aDelegate
	userId:(NSNumber *)aUserId
;
@end
@interface MathWebServiceBinding_receiveResult : MathWebServiceBindingOperation {
	NSNumber * userId;
	NSNumber * problemId;
	NSNumber * result;
	NSNumber * carry;
	NSString * result_pattern;
	NSString * carry_pattern;
}
@property (retain) NSNumber * userId;
@property (retain) NSNumber * problemId;
@property (retain) NSNumber * result;
@property (retain) NSNumber * carry;
@property (retain) NSString * result_pattern;
@property (retain) NSString * carry_pattern;
- (id)initWithBinding:(MathWebServiceBinding *)aBinding delegate:(id<MathWebServiceBindingResponseDelegate>)aDelegate
	userId:(NSNumber *)aUserId
	problemId:(NSNumber *)aProblemId
	result:(NSNumber *)aResult
	carry:(NSNumber *)aCarry
	result_pattern:(NSString *)aResult_pattern
	carry_pattern:(NSString *)aCarry_pattern
;
@end
@interface MathWebServiceBinding_envelope : NSObject {
}
+ (MathWebServiceBinding_envelope *)sharedInstance;
- (NSString *)serializedFormUsingHeaderElements:(NSDictionary *)headerElements bodyElements:(NSDictionary *)bodyElements;
@end
@interface MathWebServiceBindingResponse : NSObject {
	NSArray *headers;
	NSArray *bodyParts;
	NSError *error;
}
@property (retain) NSArray *headers;
@property (retain) NSArray *bodyParts;
@property (retain) NSError *error;
@end
