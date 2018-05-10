//
//  MainViewController.h
//  SkooleApp
//
//  Created by Ryan Gomba on 12/2/11.
//  Copyright (c) 2011 AppThat. All rights reserved.
//

#import <AudioToolbox/AudioServices.h>
#import "ScannerKit.h"

@interface MainViewController : UIViewController <SKScannerViewControllerDelegate> {
    IBOutlet UIButton *connectButton;
    IBOutlet UIButton *listButton;
}

@property(nonatomic, assign) IBOutlet UIButton *connectButton;
@property(nonatomic, assign) IBOutlet UIButton *listButton;

- (IBAction)connect:(id)sender;
- (IBAction)scanBook:(id)sender;

@end
