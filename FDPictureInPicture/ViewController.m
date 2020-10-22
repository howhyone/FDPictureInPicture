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
    
    #warning 在此处添加AVPictureInPictureController会有问题：正在播放视频时，APP进入后台后画中画会自动弹出
//    if ([AVPictureInPictureController isPictureInPictureSupported]) {
//        self.pipController = [[AVPictureInPictureController alloc] initWithPlayerLayer:playerManager.playerLayer];
//        self.pipController.delegate = self;
//    }
    [self.view bringSubviewToFront:self.pipBtn];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
}

#pragma mark ------- 画中画代理，和画中画状态有关的逻辑 在代理中处理
// 将开启画中画
- (void)pictureInPictureControllerWillStartPictureInPicture:(AVPictureInPictureController *)pictureInPictureController {
    // 处理 pipBtn 的选中状态、储存当前控制器
}

// 将关闭画中画
- (void)pictureInPictureControllerWillStopPictureInPicture:(AVPictureInPictureController *)pictureInPictureController {
    //
}

// 已经关闭画中画
- (void)pictureInPictureControllerDidStopPictureInPicture:(AVPictureInPictureController *)pictureInPictureController {
    // 处理 pipBtn 的选中状态、当前控制器置空
}

// 点击视频悬浮窗的复原按钮打开控制器
- (void)pictureInPictureController:(AVPictureInPictureController *)pictureInPictureController restoreUserInterfaceForPictureInPictureStopWithCompletionHandler:(void (^)(BOOL))completionHandler {
    // 处理控制器的跳转等
}

- (void)clickPipBtn:(UIButton *)sender {
    if ([AVPictureInPictureController isPictureInPictureSupported]) {
        if (self.pipController.isPictureInPictureActive) {
            [self.pipController stopPictureInPicture];
            sender.selected = NO;
        } else {
            ZFAVPlayerManager *playerManager = (ZFAVPlayerManager *)self.player.currentPlayerManager;
            self.pipController = [[AVPictureInPictureController alloc] initWithPlayerLayer:playerManager.playerLayer];
            self.pipController.delegate = self;
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self.pipController startPictureInPicture];
            });
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
