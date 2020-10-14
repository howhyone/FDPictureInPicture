//
//  AppDelegate.m
//  FDPictureInPicture
//
//  Created by fd-macmini on 2020/10/9.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import <AVFoundation/AVFoundation.h>
#import <AVKit/AVKit.h>
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
//    if ([AVPictureInPictureController isPictureInPictureSupported]) {
//        @try {
//            NSError *error = nil;
//            [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback error:&error];
//            [[AVAudioSession sharedInstance] setActive:YES error:&error];
//        } @catch (NSException *exception) {
//            NSLog(@"AVAudioSession发生错误");
//        }
//    }
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.rootViewController = [ViewController new];
    [self.window makeKeyAndVisible];
    return YES;
}


@end
