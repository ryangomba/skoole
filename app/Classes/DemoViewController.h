#import <UIKit/UIKit.h>
#import <AudioToolbox/AudioServices.h>
#import "ScannerKit.h"

@interface DemoViewController : UIViewController <SKScannerViewControllerDelegate, UITableViewDelegate, UITableViewDataSource> {
	UILabel *_codeInfoLabel;

	UITableView *_settingsTableView;

	UISwitch *_ean13AndUPCASwitch;
	UISwitch *_ean8Switch;
	UISwitch *_upcESwitch;
	UISwitch *_qrSwitch;
	
	NSString *_userPostalCode;
}

- (void) setupSettingsView;
- (void) settingsTapped;
- (void) settingsDoneTapped;

@end