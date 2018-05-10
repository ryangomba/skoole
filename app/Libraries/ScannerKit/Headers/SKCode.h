#import <Foundation/Foundation.h>

//////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////
/** Generic Code Object

This object is the root object for all codes recognized by ScannerKit. You'll find a number of subclassing representing many different types of 1 and 2 dimensional codes. 
 The object you set as the delegate of your SKScannerViewController instance will receive one of the subclasses of SKCode whenever a code is recognized by the scanner.
 You should use the class method on that SKCode object to determine what type of code was recognized, you can do so like this: if([code class] == [SKURLQRCode class])
*/
@interface SKCode : NSObject {
	NSString *_rawContent;
}

/** The raw, unparsed, unmodified content of the code. */
@property (nonatomic, retain) NSString *rawContent;

@end