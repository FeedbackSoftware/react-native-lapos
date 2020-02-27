//
//  ViewController.m
//  TPSDKExample
//
//  Copyright © 2017 Geopagos. All rights reserved.
//
//

#import "ViewController.h"
#import <LaPosSDK.h>

@interface ViewController () < UIPickerViewDelegate, UIPickerViewDataSource, UINavigationControllerDelegate, UIDocumentInteractionControllerDelegate>

@property NSArray* commands;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.commands = @[@"chargeAmount:", @"retrievePaymentInfoForOperationID:", @"retrievePaymentInfoForReference:", @"sendReceiptForOperationID:", @"getPDFReceiptForOperationID:", @"refundOperationID:", @"setMainColor:"];
    [self pickerView:self.picker didSelectRow:[self.picker selectedRowInComponent:0] inComponent:0];
    
    [self.view addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self.view action:@selector(endEditing:)]];
}

- (IBAction)execute:(id)sender {
    [self.textField1 resignFirstResponder];
    [self.textField2 resignFirstResponder];
    [self.textField3 resignFirstResponder];
    [self.textField4 resignFirstResponder];
    [self.textField5 resignFirstResponder];
    NSString* command = [self.commands objectAtIndex:[self.picker selectedRowInComponent:0]];
    LaPosSDK* sdk = [LaPosSDK sharedSDK];
    
    [self show:command];
    if ([command isEqualToString:@"chargeAmount:"]) {
        NSString* reference = self.textField1.text;
        if ([reference isEqualToString:@""])
            reference = nil;
        CGFloat amount = [self.textField2.text doubleValue];
        
        [sdk chargeAmount:amount reference:reference description:nil presentFromViewController:self completion:^(NSDictionary * _Nullable resultInfo, BOOL success) {
            [self showCompletionMessage:@"Payment Done" info:resultInfo success:success];
        }];
    } else if ([command isEqualToString:@"sendReceiptForOperationID:"]) {
        NSString* operationId = self.textField1.text;
        NSString* email = self.textField2.text;
        [sdk sendReceiptForOperationID:operationId toEmail:email completion:^(NSDictionary * _Nullable resultInfo, BOOL success) {
            [self showCompletionMessage:@"Sent" info:resultInfo success:success];
        }];
    } else if ([command isEqualToString:@"retrievePaymentInfoForOperationID:"]) {
        NSString* operationId = self.textField1.text;
        [sdk retrievePaymentInfoForOperationID:operationId completion:^(NSDictionary * _Nullable resultInfo, BOOL success) {
            [self showCompletionMessage:@"Payment Info" info:resultInfo success:success];
        }];
    } else if ([command isEqualToString:@"retrievePaymentInfoForReference:"]) {
        NSString* reference = self.textField1.text;
        [sdk retrievePaymentInfoForReference:reference completion:^(NSDictionary * _Nullable resultInfo, BOOL success) {
            [self showCompletionMessage:@"Payment Info" info:resultInfo success:success];
        }];
    } else if ([command isEqualToString:@"getPDFReceiptForOperationID:"]) {
        NSString* operationId = self.textField1.text;
        [sdk getPDFReceiptForOperationID:operationId completion:^(NSDictionary * _Nullable resultInfo, BOOL success) {
            [self show:[NSString stringWithFormat:@"Receipt: %d", success]];
            
            if (success) {
                NSData* receipt = [resultInfo objectForKey:@"receipt"];
                NSString* path = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
                NSString *file = [path stringByAppendingPathComponent:@"receipt.pdf"];
                [receipt writeToFile:file options:0 error:nil];
                
                NSURL *fileURL = [NSURL fileURLWithPath:file];
                
                UIDocumentInteractionController *interactionController = [UIDocumentInteractionController interactionControllerWithURL: fileURL];
                interactionController.delegate = self;
                [interactionController presentPreviewAnimated:YES];
            } else {
                [self show:[NSString stringWithFormat:@"Error: %@", [resultInfo objectForKey:@"error"]]];
            }
        }];
    } else if ([command isEqualToString:@"refundOperationID:"]) {
        NSString* operationId = self.textField1.text;
        BOOL partialEnabled = self.switch2.on;
        [sdk refundOperationID:operationId enablePartialAmount:partialEnabled presentFromViewController:self completion:^(NSDictionary * _Nullable resultInfo, BOOL success) {
            [self showCompletionMessage:@"Refund Done" info:resultInfo success:success];
        }];
    } else if ([command isEqualToString:@"setMainColor:"]) {
        NSString* hexColor = self.textField1.text;
        NSScanner *scanner = [NSScanner scannerWithString:hexColor];
        unsigned int baseColor;
        [scanner scanHexInt:&baseColor];
        CGFloat red   = ((baseColor & 0xFF0000) >> 16) / 255.0f;
        CGFloat green = ((baseColor & 0x00FF00) >>  8) / 255.0f;
        CGFloat blue  =  (baseColor & 0x0000FF) / 255.0f;
        UIColor* color = [UIColor colorWithRed:red green:green blue:blue alpha:1];
        [sdk setMainColor:color];
    }
}

- (void) showCompletionMessage:(NSString*)message info:(NSDictionary*) resultInfo success:(BOOL) success {
    NSString* resStr = [NSString stringWithFormat:@"%@. Success: %d", message, success];
    if (resultInfo) {
        for (NSString* key in resultInfo) {
            resStr = [NSString stringWithFormat:@"%@\n%@: %@", resStr, key, [resultInfo objectForKey:key]];
        }
    }
    [self show:resStr];
}

- (IBAction)clear:(id)sender {
    self.resultTextView.text = @"";
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    self.textField1.text = @"";
    self.textField2.text = @"";
    self.textField3.text = @"";
    self.textField4.text = @"";
    self.textField5.text = @"";
    self.textField1.placeholder = @"";
    self.textField2.placeholder = @"";
    self.textField3.placeholder = @"";
    self.textField4.placeholder = @"";
    self.textField5.placeholder = @"";
    self.textField1.enabled = NO;
    self.textField2.enabled = NO;
    self.textField3.enabled = NO;
    self.textField4.enabled = NO;
    self.textField5.enabled = NO;
    self.switch1.enabled = NO;
    self.switch2.enabled = NO;
    self.switch3.enabled = NO;
    self.switch1.on = YES;
    self.switch2.on = YES;
    self.switch3.on = YES;
    NSString* command = [self.commands objectAtIndex:row];
    if ([command isEqualToString:@"chargeAmount:"]) {
        self.textField1.placeholder = @"reference number";
        self.textField2.placeholder = @"amount";
        self.textField1.enabled = YES;
        self.textField2.enabled = YES;
    } else if ([command isEqualToString:@"retrievePaymentInfoForOperationID:"]) {
        self.textField1.placeholder = @"operationId";
        self.textField1.enabled = YES;
    } else if ([command isEqualToString:@"retrievePaymentInfoForReference:"]) {
        self.textField1.placeholder = @"reference";
        self.textField1.enabled = YES;
    } else if ([command isEqualToString:@"sendReceiptForOperationID:"]) {
        self.textField1.placeholder = @"operationId";
        self.textField2.placeholder = @"email";
        self.textField1.enabled = YES;
        self.textField2.enabled = YES;
    } else if ([command isEqualToString:@"getPDFReceiptForOperationID:"]) {
        self.textField1.placeholder = @"operationId";
        self.textField1.enabled = YES;
    } else if ([command isEqualToString:@"refundOperationID:"]) {
        self.textField1.placeholder = @"operationId";
        self.textField1.enabled = YES;
        self.textField2.text = @"partialEnabled:";
        self.switch2.enabled = YES;
    } else if ([command isEqualToString:@"setMainColor:"]) {
        self.textField1.placeholder = @"hexcolor";
        self.textField1.enabled = YES;
    }
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return self.commands.count;
}

- (nullable NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return [self.commands objectAtIndex:row];
}

- (void) show:(NSString*)str {
    NSLog(@"%@",str);
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"hh:mm:ss"];
    NSString *stringFromDate = [formatter stringFromDate:[NSDate date]];
    
    self.resultTextView.text = [NSString stringWithFormat:@"%@\n[%@] %@", self.resultTextView.text, stringFromDate, str];
    [self.resultTextView layoutIfNeeded];
    NSRange range = NSMakeRange(self.resultTextView.text.length - 1, 1);
    [self.resultTextView scrollRangeToVisible:range];
}

- (UIViewController *)documentInteractionControllerViewControllerForPreview:(UIDocumentInteractionController *)controller {
    return self;
}

@end
