/*
	adSubUsermanager_Datastructure_Role.h
	The interface definition of properties and methods for the adSubUsermanager_Datastructure_Role object.
	Generated by SudzC.com
*/

#import "Soap.h"
	

@interface adSubUsermanager_Datastructure_Role : SoapObject
{
	NSString* _name;
	int _rank;
	
}
		
	@property (retain, nonatomic) NSString* name;
	@property int rank;

	+ (adSubUsermanager_Datastructure_Role*) newWithNode: (CXMLNode*) node;
	- (id) initWithNode: (CXMLNode*) node;
	- (NSMutableString*) serialize;
	- (NSMutableString*) serialize: (NSString*) nodeName;
	- (NSMutableString*) serializeAttributes;
	- (NSMutableString*) serializeElements;

@end
