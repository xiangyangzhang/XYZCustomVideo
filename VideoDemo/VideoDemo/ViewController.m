//
//  ViewController.m
//  VideoDemo
//
//  Created by XYZ on 15/11/10.
//  Copyright (c) 2015年 XYZ. All rights reserved.
//

#import "ViewController.h"
#import <MediaPlayer/MediaPlayer.h>
#import "KrVideoPlayerController.h"
#define kURL @"http://video.chinanews.com/flv/2015/11/10/328/48830.m3u8"
//设置 全局 支持竖屏
@interface ViewController ()
@property (nonatomic, strong) KrVideoPlayerController  *videoController;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    self.navigationController.navigationBar.barTintColor = [UIColor redColor];
    
    [self playVideo];
}
- (void)playVideo
{
    NSURL *url = [NSURL URLWithString:kURL];
    [self addVideoPlayerWithURL:url];
    
}
- (void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBarHidden = NO;
    
}

- (void)viewWillDisappear:(BOOL)animated
{
    
    [self.videoController stop];
}
- (void)addVideoPlayerWithURL:(NSURL *)url
{
    if (!self.videoController) {
        
        CGFloat width = [UIScreen mainScreen].bounds.size.width;
        
        self.videoController = [[KrVideoPlayerController alloc] initWithFrame:CGRectMake(0, 64, width, width*(9.0/16.0))];
        
        __weak typeof(self)weakSelf = self;
        
        [self.videoController setDimissCompleteBlock:^{
            
            weakSelf.videoController = nil;
        }];
        
        [self.videoController setWillBackOrientationPortrait:^{
            [weakSelf toolbarHidden:NO];
        }];
        
        [self.videoController setWillChangeToFullscreenMode:^{
            
            [weakSelf toolbarHidden:YES];
        }];
        
        [self.view addSubview:self.videoController.view];
    }
    self.videoController.contentURL = url;
    
}

//隐藏navigation tabbar 电池栏
- (void)toolbarHidden:(BOOL)Bool
{
    self.navigationController.navigationBarHidden = Bool;
    
    self.tabBarController.tabBar.hidden = Bool;
    
    [[UIApplication sharedApplication] setStatusBarHidden:Bool withAnimation:UIStatusBarAnimationFade];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
