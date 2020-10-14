//
//  ViewController.m
//  FDPictureInPicture
//
//  Created by fd-macmini on 2020/10/9.
//

#import "ViewController.h"
#import <AVKit/AVKit.h>
#import "ZFPlayer.h"
#import "ZFAVPlayerManager.h"
#import "ZFPlayerControlView.h"

@interface ViewController ()<AVPictureInPictureControllerDelegate>

@property (nonatomic, strong) ZFPlayerController *player;
@property (nonatomic, strong) ZFPlayerControlView *controlView;
@property (nonatomic, strong) AVPictureInPictureController *pipController;
@property (nonatomic, strong) NSString *playUrlString, *coverUrlString;
@property (nonatomic, strong) UIButton *pipBtn;   ///< 画中画按钮


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.pipBtn];
  
    _playUrlString = @"https://fileoss.fdzq.com/go_fd_co/fd-1587373158-9t0y5n.mp4";
    ZFAVPlayerManager *playerManager = [[ZFAVPlayerManager alloc] init];
    self.player = [ZFPlayerController playerWithPlayerManager:playerManager containerView:self.view];
    self.player.controlView = self.controlView;
    self.player.assetURL = [NSURL URLWithString:_playUrlString];

    if ([AVPictureInPictureController isPictureInPictureSupported]) {
//        @try {
//            NSError *error = nil;
//            [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback error:&error];
////            [[AVAudioSession sharedInstance] setActive:YES error:&error];
//        } @catch (NSException *exception) {
//            DDLogDebug(@"-------- AVAudioSession发生错误");
//        }
        self.pipController = [[AVPictureInPictureController alloc] initWithPlayerLayer:playerManager.playerLayer];
//        DDLogDebug(@"----playerManager.playerLayer---- %@", playerManager.playerLayer);
        self.pipController.delegate = self;
    }
    [self.view bringSubviewToFront:self.pipBtn];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
}

- (void)clickPipBtn:(UIButton *)sender {
    if ([AVPictureInPictureController isPictureInPictureSupported]) {
        if (self.pipController.isPictureInPictureActive) {
            [self.pipController stopPictureInPicture];
            sender.selected = NO;
        } else {
            [self.pipController startPictureInPicture];
            sender.selected = YES;
        }
    }
}

- (ZFPlayerControlView *)controlView {
    if (!_controlView) {
        _controlView = [ZFPlayerControlView new];
        _controlView.fastViewAnimated = YES;
        _controlView.autoHiddenTimeInterval = 5;
        _controlView.autoFadeTimeInterval = 0.5;
        _controlView.prepareShowLoading = YES;
        _controlView.prepareShowControlView = YES;
    }
    return _controlView;
}

- (UIButton *)pipBtn {
    if (!_pipBtn) {
        if (@available(iOS 14.0, *)) {
            UIImage *openImage = AVPictureInPictureController.pictureInPictureButtonStartImage;
            UIGraphicsBeginImageContextWithOptions(openImage.size, false, 0);
            [UIColor.blueColor setFill];
            UIRectFill(CGRectMake(0, 0, openImage.size.width, openImage.size.height));
            [openImage drawInRect:CGRectMake(0, 0, openImage.size.width, openImage.size.height) blendMode:kCGBlendModeDestinationIn alpha:1];
            openImage = UIGraphicsGetImageFromCurrentImageContext();
            UIGraphicsEndImageContext();
            openImage = [openImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];

            UIImage *closeImage = AVPictureInPictureController.pictureInPictureButtonStopImage;
            UIGraphicsBeginImageContextWithOptions(closeImage.size, false, 0);
            [UIColor.blueColor setFill];
            UIRectFill(CGRectMake(0, 0, closeImage.size.width, closeImage.size.height));
            [closeImage drawInRect:CGRectMake(0, 0, closeImage.size.width, closeImage.size.height) blendMode:kCGBlendModeDestinationIn alpha:1];
            closeImage = UIGraphicsGetImageFromCurrentImageContext();
            UIGraphicsEndImageContext();
            closeImage = [closeImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];

            _pipBtn = [[UIButton alloc] init];
            _pipBtn.frame = CGRectMake(10, 64, 20, 20);
            [_pipBtn setImage:openImage forState:UIControlStateNormal];
            [_pipBtn setImage:closeImage forState:UIControlStateSelected];
            [_pipBtn addTarget:self action:@selector(clickPipBtn:) forControlEvents:UIControlEventTouchUpInside];
        } else {
        }
    }
    return _pipBtn;
}
@end
