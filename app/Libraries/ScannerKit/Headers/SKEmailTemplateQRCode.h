#import <Foundation/Foundation.h>
#import "SKCode.h"

//////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////
/** Email Template QR Code Object
 
 An SKCode object representing an Email Template QR Code. These types of QR Code are typically used to present the user with the oppurtunity to send an email message based in its contents.
 */
@interface SKEmailTemplateQRCode : SKCode {
	NSString *_to;
	NSString *_subject;
	NSString *_body;	
}

/** The proposed send-to email address of the email template. */
@property (nonatomic, copy) NSString *to;

/** The proposed subject text of the email template. */
@property (nonatomic, copy) NSString *subject;

/** The proposed email body text of the email template. */
@property (nonatomic, copy) NSString *body;

@end