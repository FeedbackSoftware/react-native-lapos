#import "Lapos.h"
#import <React/RCTLog.h>
#import <LaPosSDK/LaPosSDK.h>
#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "ViewController.h"

#define API_KEY @"dt_7635070623c3685bfa18a8b85cb5817959334ff248d511c9832b788d94985fc4"

#define USER_TOKEN @"st_cac12c02749d670616eede73a18aedfd44a3185ea1f4500c75206c9fdf83a3d2"

@implementation Lapos


RCT_EXPORT_MODULE();

- (NSArray<NSString *> *)supportedEvents
{
  return @[@"EventReminder"];
}

RCT_EXPORT_METHOD(initSdk:(NSString *)name callback:(RCTResponseSenderBlock)callback)
{

    if ([API_KEY isEqualToString:@"INSERT API KEY HERE"]) {
        RCTLogInfo(@"You shuld add your API KEY at the top of AppDelegate.m. Line 12.");
        //[NSException raise:@"API Key missing" format:@"You shuld add your API KEY at the top of AppDelegate.m. Line 12."];
    } else {
        [[LaPosSDK sharedSDK] startWithAPIKey:API_KEY];
    }

    if ([USER_TOKEN isEqualToString:@"INSERT USER TOKEN HERE"]) {
       RCTLogInfo(@"You shuld add your USER TOKEN at the top of AppDelegate.m. Line 13.");
       //[NSException raise:@"User Token missing" format:@"You shuld add your USER TOKEN at the top of AppDelegate.m. Line 13."];
    } else {
        [[LaPosSDK sharedSDK] setUserToken:USER_TOKEN];
    }
    
    callback(@[[NSNull null], @true]);
   //[ self sendEventWithName:@"EventReminder" body:@{@"initSdk": @true}];
}

RCT_EXPORT_METHOD(payEvent: (double)amount description:(NSString *)description)
    {

        dispatch_async(dispatch_get_main_queue(), ^{
            //         UIPageViewController *picker = [[UIPageViewController alloc] init];
            //         //picker.newPersonViewDelegate = self;
            //         UINavigationController* contactNavigator = [[UINavigationController alloc] initWithRootViewController:picker];
            //         AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
            //         [delegate.window.rootViewController presentViewController:contactNavigator animated:YES completion:nil];


            AppDelegate *share = (AppDelegate *)[UIApplication sharedApplication].delegate;
            UINavigationController *nav = (UINavigationController *) share.window.rootViewController;
            //         PageTwo *pagetwo = [[PageTwo alloc] init];
            //         [nav pushViewController:pagetwo animated:TRUE];

            [[LaPosSDK sharedSDK] chargeAmount:amount reference:nil description:description presentFromViewController:nav  completion:^(NSDictionary * _Nullable resultInfo, BOOL success) {
                 if (success) {
                   //[NSException raise:@"User Token missing" format:@"You shuld add your USER TOKEN at the top of AppDelegate.m. Line 13."];
                     //Transacción exitosa. En resultInfo se encuentran los datos de la transacción.
                   RCTLogInfo(@"Transacción exitosa. En resultInfo se encuentran los datos de la transacción");

                    NSString* resStr = [NSString stringWithFormat:@"PaymentDone:%d", success];
                   //NSString* resStr = [NSString string];
                   if (resultInfo) {
                       for (NSString* key in resultInfo) {
                           resStr = [NSString stringWithFormat:@"%@,%@:%@", resStr, key, [resultInfo objectForKey:key]];
                       }
                   }

                   [self sendEventWithName:@"EventReminder" body:@{@"result": @true, @"resultResponse": resStr}];
                 } else {
                   //[NSException raise:@"User Token missing" format:@"You shuld add your USER TOKEN at the top of AppDelegate.m. Line 13."];

                  // ???????????????????????????????

                   RCTLogInfo(@"No se pudo completar la transacción. En [resultInfo objectForKey puede encontrarse un NSError describiendo el error. ");
                     //No se pudo completar la transacción. En [resultInfo objectForKey:@"error"] puede encontrarse un NSError describiendo el error.
                   //NSString* resStr = [NSString stringWithFormat:@"PaymentFail: %d", success];
                   NSString* resStr = [NSString string];
                   if (resultInfo) {
                        for (NSString* key in resultInfo) {
                            resStr = [NSString stringWithFormat:@"Error: %@", [resultInfo objectForKey:key]];
                        }
                   }

                   [self sendEventWithName:@"EventReminder" body:@{@"error": resStr}];

                   // ???????????????????????????????

//                     NSDictionary *dict = @{ @"id": @"691", @"isClose": @"true", @"authorizationCode": @"404878", @"paymentType": @"CARD", @"total": @"10", @"cardHolderName": @"hola", @"issuerName": @"VISA", @"pan": @"11111****"};
//                     NSString* resStr = [NSString stringWithFormat:@"PaymentDone:%d", success];
//                     if (dict) {
//                        for (NSString* key in dict) {
//                            resStr = [NSString stringWithFormat:@"%@,%@:%@", resStr, key, [dict objectForKey:key]];
//                        }
//                     }
//
//                    [self sendEventWithName:@"EventReminder" body:@{@"result": @true, @"resultResponse": resStr}];
                 }
            }];
        });

}

@end


