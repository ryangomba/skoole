#import <Foundation/Foundation.h>
#import "SKCode.h"

//////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////
/** SMS Template QR Code Object
 
 An SKCode object representing an SMS Template QR Code. Typically used to represent a potential SMS message the user can send to someone.
 */

@interface SKSMSTemplateQRCode : SKCode {
	NSString *_number;
	NSString *_body;
}

/** The proposed send-to phone number of the SMS template. */
@property (nonatomic, copy) NSString *number;

/** The proposed body text of the SMS template. */
@property (nonatomic, copy) NSString *body;

@end