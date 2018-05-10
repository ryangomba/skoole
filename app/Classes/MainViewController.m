//
//  MainViewController.m
//  SkooleApp
//
//  Created by Ryan Gomba on 12/2/11.
//  Copyright (c) 2011 AppThat. All rights reserved.
//

#import "MainViewController.h"
#import "FormViewController.h"

@implementation MainViewController

@synthesize connectButton, listButton;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)dealloc
{
    [connectButton release];
    [listButton release];
    [super dealloc];
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma Actions

- (IBAction)scanBook:(id)sender
{
    if([SKScannerViewController canRecognizeBarcodes]) { //Make sure we can even attempt barcode recognition, (i.e. on a device without a camera, you wouldn't be able to scan anything).
        
		SKScannerViewController *scannerVC = [[SKScannerViewController alloc] init]; //Insantiate a new SKScannerViewController
		scannerVC.delegate = self;
		scannerVC.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancelScan)];
		scannerVC.title = @"Scan a Barcode";
        
		scannerVC.shouldLookForEAN13AndUPCACodes = YES;
		scannerVC.shouldLookForEAN8Codes = NO;
		scannerVC.shouldLookForQRCodes = NO;
		scannerVC.shouldLookForUPCECodes = NO;
        
		UINavigationController *_nc = [[[UINavigationController alloc] initWithRootViewController:scannerVC] autorelease]; //Put our SKScannerViewController into a UINavigationController. (So it looks nice).
		[self presentModalViewController:_nc animated:YES]; //Slide it up onto the screen.
        
	} else {
        
		UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Sorry"
                                                            message:@"This device doesn't support barcode recognition." 
                                                           delegate:self
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil];
		[alertView show];
		[alertView release];
        
	}
    
}

- (void)cancelScan
{
    [self dismissModalViewControllerAnimated:YES];
}

- (IBAction)connect:(id)sender
{
    
}

#pragma mark SKScannerViewControllerDelegate Methods

- (void)scannerViewController:(SKScannerViewController *)scanner
              didRecognizeCode:(SKCode *)code
{
	NSLog(@"didRecognizeCode = %@", code.rawContent);
	AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
	//[self dismissModalViewControllerAnimated:YES]; //We're done scanning barcodes so we should dismiss our modal view controller.
    FormViewController *formViewController = [[FormViewController alloc] initWithNibName:@"FormView" bundle:nil];
    [formViewController setIsbn:code.rawContent];
    NSLog(@"ready to add");
    [scanner.navigationController pushViewController:formViewController animated:YES];
    NSLog(@"added");
    //[formViewController release];
}

- (void) scannerViewController:(SKScannerViewController *)scanner didStopLookingForCodesWithError:(NSError *)error
{
	[self dismissModalViewControllerAnimated:YES];
    
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:[[error userInfo] objectForKey:@"Reason"] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    
	[alert show];
	[alert release];
}

@end
