/*
	adSubUsermanager_Datastructure_Roles.h
	The interface definition of properties and methods for the adSubUsermanager_Datastructure_Roles object.
	Generated by SudzC.com
*/

#import "Soap.h"
	
@class adSubArrayOfUsermanager_Datastructure_Role;

@interface adSubUsermanager_Datastructure_Roles : SoapObject
{
	adSubArrayOfUsermanager_Datastructure_Role* _roles;
	
}
		
	@property (retain, nonatomic) adSubArrayOfUsermanager_Datastructure_Role* roles;

	+ (adSubUsermanager_Datastructure_Roles*) newWithNode: (CXMLNode*) node;
	- (id) initWithNode: (CXMLNode*) node;
	- (NSMutableString*) serialize;
	- (NSMutableString*) serialize: (NSString*) nodeName;
	- (NSMutableString*) serializeAttributes;
	- (NSMutableString*) serializeElements;

@end
