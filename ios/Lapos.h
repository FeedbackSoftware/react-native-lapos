#import <React/RCTBridgeModule.h>
#import <React/RCTEventEmitter.h>

//#import <UIKit/UIKit.h>
//
//@interface Lapos : UIResponder <RCTBridgeModule>
//
//@end

#import <React/RCTViewManager.h>

#import <UIKit/UIKit.h>

@interface Lapos : RCTEventEmitter  <UIPageViewControllerDelegate, RCTBridgeModule>

@property (nonatomic, strong) UIViewController *window;

@end

//
//#import <Foundation/Foundation.h>
////#import "RCTBridge.h"
//#import "RCTEventDispatcher.h"
//
//#import <MediaPlayer/MediaPlayer.h>
//
//@import AVFoundation;
//
//@interface MediaController : NSObject<RCTBridgeModule,MPMediaPickerControllerDelegate, AVAudioPlayerDelegate>
//
//@property (nonatomic, retain) AVAudioPlayer *player;
//@property (nonatomic, retain) MPMediaPickerController *mediaPicker;
//
//- (void) showMediaPicker;
//
//@end
