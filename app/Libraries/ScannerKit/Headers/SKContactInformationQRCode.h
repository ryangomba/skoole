#import <Foundation/Foundation.h>
#import "SKCode.h"

//////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////
/** Contact Information QR Code Object
 
 An SKCode object representing a Contact Information QR Code.
 */
@interface SKContactInformationQRCode : SKCode {
	NSString *_name;
	NSArray *_phoneNumbers;
	NSString *_note;
	NSString *_email;
	NSURL *_url;
	NSString *_address;	
}

/** The name of the contact. */
@property (nonatomic, copy) NSString *name;

/** An array of phone numbers of the contact. */
@property (nonatomic, retain) NSArray *phoneNumbers;

/** A note about the contact. */
@property (nonatomic, copy) NSString *note;

/** The email address of the contact. */
@property (nonatomic, copy) NSString *email;

/** The URL of the contact. */
@property (nonatomic, copy) NSURL *url;

/** The street address of the contact. */
@property (nonatomic, copy) NSString *address;

@end