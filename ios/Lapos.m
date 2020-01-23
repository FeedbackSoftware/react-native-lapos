#import "Lapos.h"
#import <React/RCTLog.h>
#import <LaPosSDK/LaPosSDK.h>
#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "ViewController.h"

#define API_KEY @"dt_7635070623c3685bfa18a8b85cb5817959334ff248d511c9832b788d94985fc4"

// #define API_KEY @"INSERT API KEY HERE"

#define USER_TOKEN @"st_cac12c02749d670616eede73a18aedfd44a3185ea1f4500c75206c9fdf83a3d2"

// @interface Lapos () < UIPickerViewDelegate, UINavigationControllerDelegate, UIDocumentInteractionControllerDelegate>

// @property NSArray* commands;

// @end
// @interface Lapos ()
//
// @end
// @interface Lapos()
//
// // keep a reference to the React Native VC
// @property (nonatomic, strong) UIViewController *reactNativeViewController;
//
// @end

@implementation Lapos



// - (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
//     if ([API_KEY isEqualToString:@"INSERT API KEY HERE"]) {
//         [NSException raise:@"API Key missing" format:@"You shuld add your API KEY at the top of AppDelegate.m. Line 12."];
//     } else {
//         [[LaPosSDK sharedSDK] startWithAPIKey:API_KEY];
//     }
//
//     if ([USER_TOKEN isEqualToString:@"INSERT USER TOKEN HERE"]) {
//         [NSException raise:@"User Token missing" format:@"You shuld add your USER TOKEN at the top of AppDelegate.m. Line 13."];
//     } else {
//         [[LaPosSDK sharedSDK] setUserToken:USER_TOKEN];
//     }
//
//     return YES;
// }
// - (void)viewDidLoad
// {
//     [super viewDidLoad];
//
//   // [self.view addSubview: navigationViewController.view];
//   // [self addChildViewController: navigationViewController];
//
// }

// - (void)viewDidLoad {
//     [super viewDidLoad];
//
// //     self.commands = @[@"chargeAmount:", @"retrievePaymentInfoForOperationID:", @"retrievePaymentInfoForReference:", @"sendReceiptForOperationID:", @"getPDFReceiptForOperationID:", @"refundOperationID:", @"setMainColor:"];
// //     [self pickerView:self.picker didSelectRow:[self.picker selectedRowInComponent:0] inComponent:0];
// //
// //     [self.view addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self.view action:@selector(endEditing:)]];
// }

// - (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
//
//     //LaPosSDK* sdk = [LaPosSDK sharedSDK];
//
//     if ([API_KEY isEqualToString:@"INSERT API KEY HERE"]) {
//       RCTLogInfo(@"Pretending to create an event %@ at %@", 'sss', 'ggg');
//
//         [NSException raise:@"API Key missing" format:@"You shuld add your API KEY at the top of AppDelegate.m. Line 12."];
//     } else {
//        [[LaPosSDK sharedSDK] startWithAPIKey:API_KEY];
//     }
//
//     if ([USER_TOKEN isEqualToString:@"INSERT USER TOKEN HERE"]) {
//         [NSException raise:@"User Token missing" format:@"You shuld add your USER TOKEN at the top of AppDelegate.m. Line 13."];
//     } else {
//         [[LaPosSDK sharedSDK] setUserToken:USER_TOKEN];
//     }
//
//     return YES;
// }


RCT_EXPORT_MODULE();

- (NSArray<NSString *> *)supportedEvents
{
  return @[@"EventReminder"];
}

//
// - (instancetype)init {
//     self = [super init];
//     if ( self ) {
//         NSLog(@"color picker manager init");
//     self.lapos = [[Lapos alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
//     }
//     return self;
// }
//
// - (UIView *)view {
//     NSLog(@"color picker manager -view method");
//     return self.lapos;
// }

//RCT_EXPORT_METHOD(sampleMethod:(NSString *)stringArgument numberParameter:(nonnull NSNumber *)numberArgument callback:(RCTResponseSenderBlock)callback)
//{
//    // TODO: Implement some actually useful functionality
//    callback(@[[NSString stringWithFormat: @"numberArgument: %@ stringArgument: %@", numberArgument, stringArgument]]);
//}

RCT_EXPORT_METHOD(initSdk:(NSString *)name)
{
     // RCTLogInfo(@"You shuld add your API KEY at the top of AppDelegate.m. Line 12.");
//
//     if ([API_KEY isEqualToString:@"INSERT API KEY HERE"]) {
//         RCTLogInfo(@"You shuld add your API KEY at the top of AppDelegate.m. Line 12.");
//         [NSException raise:@"API Key missing" format:@"You shuld add your API KEY at the top of AppDelegate.m. Line 12."];
//     }
//     else {
//         [[LaPosSDK sharedSDK] startWithAPIKey:API_KEY];
//     }

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
}

RCT_EXPORT_METHOD(payEvent: (double)amount description:(NSString *)description)
    {
        //AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        //UINavigationController *nav = (UINavigationController *) share.window.rootViewController;

       // [delegate.rootViewController presentViewController:self.window animated:YES completion:nil];

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

        [[LaPosSDK sharedSDK] chargeAmount:amount reference:@"12345" description:description presentFromViewController:nav  completion:^(NSDictionary * _Nullable resultInfo, BOOL success) {
             if (success) {
               //[NSException raise:@"User Token missing" format:@"You shuld add your USER TOKEN at the top of AppDelegate.m. Line 13."];
                 //Transacción exitosa. En resultInfo se encuentran los datos de la transacción.
               RCTLogInfo(@"Transacción exitosa. En resultInfo se encuentran los datos de la transacción");
               [self sendEventWithName:@"EventReminder" body:@{@"name": @"Alguna respuesta"}];
             } else {
               //[NSException raise:@"User Token missing" format:@"You shuld add your USER TOKEN at the top of AppDelegate.m. Line 13."];
               RCTLogInfo(@"No se pudo completar la transacción. En [resultInfo objectForKey puede encontrarse un NSError describiendo el error. ");
                 //No se pudo completar la transacción. En [resultInfo objectForKey:@"error"] puede encontrarse un NSError describiendo el error.
               [self sendEventWithName:@"EventReminder" body:@{@"name": @"Alguna respuesta"}];
             }
         }];
    });

//     dispatch_async(dispatch_get_main_queue(), ^{
//
//
//
//         [[LaPosSDK sharedSDK] chargeAmount:3.5 reference:@"12345" description:@"Zapatillas" presentFromViewController:self  completion:^(NSDictionary * _Nullable resultInfo, BOOL success) {
//              if (success) {
//                //[NSException raise:@"User Token missing" format:@"You shuld add your USER TOKEN at the top of AppDelegate.m. Line 13."];
//                  //Transacción exitosa. En resultInfo se encuentran los datos de la transacción.
//                //RCTLogInfo(@"PTransacción exitosa. En resultInfo se encuentran los datos de la transacción");
//
//              } else {
//                //[NSException raise:@"User Token missing" format:@"You shuld add your USER TOKEN at the top of AppDelegate.m. Line 13."];
//                //RCTLogInfo(@"No se pudo completar la transacción. En [resultInfo objectForKey puede encontrarse un NSError describiendo el error. ");
//                  //No se pudo completar la transacción. En [resultInfo objectForKey:@"error"] puede encontrarse un NSError describiendo el error.
//              }
//          }];
//     });
}

@end

//
// #import "Lapos.h"
// #import "AppDelegate.h"
//
//
// @implementation MediaController
//
// RCT_EXPORT_MODULE();
//
// @synthesize bridge = _bridge;
//
//
// -(void)showMediaPicker {
//   if(self.mediaPicker == nil) {
//     self.mediaPicker = [[MPMediaPickerController alloc] initWithMediaTypes:MPMediaTypeAnyAudio];
//
//     [self.mediaPicker setDelegate:self];
//     [self.mediaPicker setAllowsPickingMultipleItems:NO];
//     [self.mediaPicker setShowsCloudItems:NO];
//     self.mediaPicker.prompt = @"Select song";
//   }
//
//   AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
//   [delegate.rootViewController presentViewController:self.mediaPicker animated:YES completion:nil];
// }
//
//
// -(void) mediaPicker:(MPMediaPickerController *)mediaPicker didPickMediaItems:(MPMediaItemCollection *)mediaItemCollection {
//   MPMediaItem *mediaItem = mediaItemCollection.items[0];
//   NSURL *assetURL = [mediaItem valueForProperty:MPMediaItemPropertyAssetURL];
//
//   [self.bridge.eventDispatcher sendAppEventWithName:@"SongPlaying" body:[mediaItem valueForProperty:MPMediaItemPropertyTitle]];
//
//   NSError *error;
//
//   self.player = [[AVAudioPlayer alloc] initWithContentsOfURL:assetURL error:&error];
//   [self.player setDelegate:self];
//
//   if (error) {
//     NSLog(@"%@", [error localizedDescription]);
//   } else {
//     [self.player play];
//   }
//
//   hideMediaPicker();
//
// }
//
// -(void) mediaPickerDidCancel:(MPMediaPickerController *)mediaPicker {
//   hideMediaPicker();
// }
//
// #pragma mark RCT_EXPORT
//
// RCT_EXPORT_METHOD(showSongs) {
//   [self showMediaPicker];
// }
//
// #pragma mark private-methods
//
// void hideMediaPicker() {
//   AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
//   [delegate.rootViewController dismissViewControllerAnimated:YES completion:nil];
// }
// @end
