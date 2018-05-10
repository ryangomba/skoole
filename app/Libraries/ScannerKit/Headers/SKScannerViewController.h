#import <UIKit/UIKit.h>
#import "SKScannerViewControllerDelegate.h"

@class SKCaptureSessionManager, SKScannerViewLoadingView;

//////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////
/** The SKScannerViewController class manages ScannerKit supplied user interfaces for recognizing both one and two dimensional barcodes 
placed in front of the phone's back-facing camera. This class manages user interactions and delivers the results of the process (i.e. the recognized barcode) 
to the delegate object you've associated with the view controller in the form of an SKCode object.

To use SKScannerViewController to handle the process of "live-recognizing" barcodes, perform these steps:

1. Verify the device your app is running on is capable of recognizing barcodes. Do this by calling the canRecognizeBarcodes class method on SKScannerViewController.

2. Set which types of codes you'd like to attempt to recognize. It's best to only turn on recognition of the codes your app specifically needs, 
you can do this with the many "shouldLookFor" properties on SKScannerViewController.

3. Tell SKScannerViewController to present itself modally.

4. Wait for the user to place a recognizable barcode in front of the devices camera and the delegate object you've associated with SKScannerViewController 's 
delegate property will get a callback in the form of the scannerViewController:didRecognizeCode: method.

5. Dismiss the SKScannerViewController.

6. Use the returned SKCode object and its properties to do whatever you may need to do in your app.
 
To use this class, you must provide a delegate that conforms to the SKScannerViewControllerDelegate protocol. See SKScannerViewControllerDelegate Protocol Reference.
 
*/

@interface SKScannerViewController : UIViewController <UIAccelerometerDelegate> {
	id <SKScannerViewControllerDelegate> _delegate;
	SKCaptureSessionManager *_captureManager;

	BOOL shouldLookForEAN13AndUPCACodes;
	BOOL shouldLookForEAN8Codes;
	BOOL shouldLookForUPCECodes;
	BOOL shouldLookForQRCodes;
	BOOL shouldLookForDataMatrixCodes;

	UIImageView *_bg;

	UILabel *_statusLabel;
	UIImageView *_statusIndicator;
	UIImageView *_holdStillIconImageView;
	UIImageView *_laserImageView;
	UIImageView *_boundariesFoundLaserImageView;
	UILabel *_scanningInstructionsLabel;
	
	BOOL _showingHoldStill;

	SKScannerViewLoadingView *_loadingView;

	UIImageView *_logo;
	UINavigationController *_browserNC;

	CGFloat _accelX;
	CGFloat _accelY;
	CGFloat _accelZ;
	CGFloat _lastUpdatedHoldStill;
	
	BOOL _shouldShowDefaultUI;
}

/** This class method returns a BOOL indicating whether or not the device supports looking for barcodes.
For example, if the device does not have a camera, barcode recognition would not be supported.￼

*/
+ (BOOL) canRecognizeBarcodes;

//////////////////////////////////////////////////////////////////////////////////////////
/// @name Starting and Stopping Looking For Barcodes
//////////////////////////////////////////////////////////////////////////////////////////

/** Starts grabbing frames from the camera and trying to recognize a barcode in them.￼

You shouldn't have to call this method yourself ever. However, it is provided here just in case you need to do some advanced customization. 
SKScannerViewController will call this method itself whenever its viewDidAppear: method gets called. Calling this method while
SKScannerViewController is already trying to recognize barcodes has no effect.

@see stopLookingForCodes
*/
- (void) startLookingForCodes;

/** Stops grabbing frames from the camera and stops attempting to recognize barcodes altogether.￼

This method will stop the SKScannerViewController from looking for barcodes, it will not hide or dismiss SKScannerViewController in any way.
Whenever a barcode is found, SKScannerViewController calls this method on itself. You should never need
to call this method directly, however, it is exposed here for those who may need to do advanced custom implementations. 
Calling this method while SKScannerViewController is already in a "stopped" state has no effect.

@see startLookingForCodes
*/
- (void) stopLookingForCodes;

//////////////////////////////////////////////////////////////////////////////////////////
/// @name Configuring The Scanner
//////////////////////////////////////////////////////////////////////////////////////////

/** The scanner's delegate object. 
 
The delegate receives callbacks when the user places a recognizable barcode in front of
the device's back-facing camera. You must provide a delegate object to use the scanner.
If this property is nil, the scanner is dismissed immediately if try to show it.

For more information about the methods you can implement for your delegate object, see SKScannerViewControllerDelegate.
 
 
 */
@property (nonatomic, assign) id <SKScannerViewControllerDelegate> delegate;

//////////////////////////////////////////////////////////////////////////////////////////
/// @name Configuring Which Types of Codes to Look For
//////////////////////////////////////////////////////////////////////////////////////////

/** 
 Defaults to YES.
*/
@property (nonatomic) BOOL shouldLookForEAN13AndUPCACodes;

/** Defaults to YES. */
@property (nonatomic) BOOL shouldLookForEAN8Codes;

/** Defaults to YES. */
@property (nonatomic) BOOL shouldLookForUPCECodes;

/** Defaults to NO. */
@property (nonatomic) BOOL shouldLookForQRCodes;

@end