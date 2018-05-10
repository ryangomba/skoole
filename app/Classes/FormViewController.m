//
//  FormViewController.m
//  SkooleApp
//
//  Created by Ryan Gomba on 12/2/11.
//  Copyright (c) 2011 AppThat. All rights reserved.
//

#import "FormViewController.h"
#import "SGJSONKit.h"

@implementation FormViewController

@synthesize price, condition, isbn, conditionCode, buySell;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.navigationItem.title = @"List a Book";
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"List" style:UIBarButtonItemStyleDone target:self action:@selector(listBook:)];
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStyleBordered target:self action:@selector(cancelListing)];
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
    [isbn dealloc];
    [price dealloc];
    [conditionCode dealloc];
    [condition dealloc];
    [buySell dealloc];
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

#pragma mark Picker View

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)thePickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)thePickerView numberOfRowsInComponent:(NSInteger)component
{    
    return 3;
}

- (NSString *)pickerView:(UIPickerView *)thePickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    NSArray *conditions = [NSArray arrayWithObjects:@"New", @"Good", @"Fair", nil];
    return [conditions objectAtIndex:row];
}

- (void)pickerView:(UIPickerView *)thePickerView
      didSelectRow:(NSInteger)row
       inComponent:(NSInteger)component
{
    self.conditionCode = [NSNumber numberWithInt:row];
}

#pragma Listing

- (void)listBook:(id)sender
{
    NSNumberFormatter * f = [[NSNumberFormatter alloc] init];
    [f setNumberStyle:NSNumberFormatterDecimalStyle];
    NSNumber* listPrice = [f numberFromString:self.price.text];
    [f release];
    
    NSString *buyOrSellListing = @"buy_listing";
    int buyOrSell = self.buySell.selectedSegmentIndex;
    if (buyOrSell > 0) buyOrSellListing = @"sell_listing";
    
    NSDictionary *listing = [NSDictionary dictionaryWithObjectsAndKeys:
                             listPrice, @"price",
                             self.conditionCode, @"condition",
                             [NSNumber numberWithInt:1], @"user_id",
                             @"gatech", @"network",
                             nil];
    
    NSDictionary *report = [NSDictionary dictionaryWithObjectsAndKeys:
                            self.isbn, @"isbn",
                            listing, buyOrSellListing,
                            nil];
    NSURL *url = [NSURL URLWithString:@"http://buzzruns.com/listings"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:[report JSONData]];
    NSURLConnection *conn = [[[NSURLConnection alloc] initWithRequest:request delegate:self] autorelease];
    [conn start];
}

- (void)showCondition:(id)sender
{
    NSLog(@"kid keyboard");
    [self.price resignFirstResponder];
}

- (void)cancelListing:(id)sender
{
    [self dismissModalViewControllerAnimated:YES];
}

@end
