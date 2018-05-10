#import <Foundation/Foundation.h>
#import "SKCode.h"

//////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////
/** Phone Number QR Code Object
 
 An SKCode object representing a Phone Number QR Code.
 */
@interface SKPhoneNumberQRCode : SKCode {
	NSString *_number;
}

/** The phone number inside the QR Code. */
@property (nonatomic, copy) NSString *number;

@end