//
//  ViewController.h
//  TPSDKExample
//
//  Copyright © 2017 Geopagos. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property IBOutlet UIPickerView* picker;
@property IBOutlet UISwitch* switch1;
@property IBOutlet UISwitch* switch2;
@property IBOutlet UISwitch* switch3;
@property IBOutlet UITextField* textField1;
@property IBOutlet UITextField* textField2;
@property IBOutlet UITextField* textField3;
@property IBOutlet UITextField* textField4;
@property IBOutlet UITextField* textField5;
@property IBOutlet UITextView* resultTextView;

- (IBAction)execute:(id)sender;

- (IBAction)clear:(id)sender;

@end

