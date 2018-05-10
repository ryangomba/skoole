#import <Foundation/Foundation.h>
#import "SKCode.h"

//////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////
/** Geographic Location QR Code Object
 
 An SKCode representing a Geographic Location QR Code.
 */
@interface SKGeographicLocationQRCode : SKCode {
	NSString *_location;
	NSString *_latLong;
	NSString *_query;	
}

/** The human-readable string describing the location. */
@property (nonatomic, copy) NSString *location;

/** A comma-seperated string describing the latitude and longitude coordinates of the location. Example: 33.137551, -97.03125 */
@property (nonatomic, copy) NSString *latLong;

/** A string representing the search query string used to find this location. */
@property (nonatomic, copy) NSString *query;

@end