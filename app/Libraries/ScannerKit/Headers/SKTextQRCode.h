#import <Foundation/Foundation.h>
#import "SKCode.h"

//////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////
/** Text QR Code Object
 
 An SKCode object representing a Plain Text QR Code.
 */
@interface SKTextQRCode : SKCode {
	NSString *_text;
}

/** The text of the QR Code. */
@property (nonatomic, copy) NSString *text;

@end