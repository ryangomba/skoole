//
//  FormViewController.h
//  SkooleApp
//
//  Created by Ryan Gomba on 12/2/11.
//  Copyright (c) 2011 AppThat. All rights reserved.
//

@interface FormViewController : UIViewController <UIPickerViewDelegate, UIPickerViewDataSource> {
    NSString *isbn;
    IBOutlet UITextField *price;
    IBOutlet UIPickerView *condition;
    NSNumber *conditionCode;
    IBOutlet UISegmentedControl *buySell;
}

@property (nonatomic, retain) NSString *isbn;
@property (nonatomic, retain) NSNumber *conditionCode;

@property (nonatomic, retain) IBOutlet UITextField *price;
@property (nonatomic, retain) IBOutlet UIPickerView *condition;
@property (nonatomic, retain) IBOutlet UISegmentedControl *buySell;

- (IBAction)listBook:(id)sender;
- (IBAction)cancelListing:(id)sender;
- (IBAction)showCondition:(id)sender;

@end
