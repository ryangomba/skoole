#import <Foundation/Foundation.h>
#import "SKCode.h"

//////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////
/** Calendar Event QR Code Object
 
 An SKCode object representing a Calendar Event QR Code.
 */
@interface SKCalendarEventQRCode : SKCode {
	NSString *_name;
	NSDate *_startDate;
	NSDate *_endDate;
	NSString *_location;
	NSString *_description;
 	BOOL _allDay;	
}

/** The name of the calendar event. */
@property (nonatomic, retain) NSString *name;

/** The start date and time of the event. */
@property (nonatomic, retain) NSDate *startDate;

/** The end date and time of the event */
@property (nonatomic, retain) NSDate *endDate;

/** The location of the event. */
@property (nonatomic, retain) NSString *location;

/** A description of the event. */
@property (nonatomic, retain) NSString *description;

/** Indicates if the event is classified as all-day or not. */
@property (nonatomic) BOOL allDay;

@end