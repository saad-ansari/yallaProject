//
//  ViewController.m
//  YallaProject
//
//  Created by guzzle developer on 1/22/17.
//  Copyright © 2017 Yalla Developer. All rights reserved.
//

#import "ViewController.h"
#import <AVFoundation/AVFoundation.h>

static const float PLAYER_VOLUME = 0.0;

@interface ViewController ()
@property (nonatomic) AVPlayer *player;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self createVideoPlayer];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)createVideoPlayer {
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"splash_vdo" ofType:@"mp4"];
    NSURL *url = [NSURL fileURLWithPath:filePath];
    
    AVPlayerItem *playerItem = [AVPlayerItem playerItemWithURL:url];
    
    self.player = [AVPlayer playerWithPlayerItem:playerItem];
    self.player.volume = PLAYER_VOLUME;
    
    AVPlayerLayer *playerLayer = [AVPlayerLayer playerLayerWithPlayer:self.player];
    playerLayer.videoGravity = UIViewContentModeScaleToFill;
    playerLayer.frame = self.view.layer.bounds;
    [self.view.layer addSublayer:playerLayer];
    
    [self.player play];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(moviePlayDidEnd:) name:AVPlayerItemDidPlayToEndTimeNotification object:self.player.currentItem];
}

#pragma mark - observer of player

// 视频循环播放
- (void)moviePlayDidEnd:(NSNotification*)notification{
    
//    AVPlayerItem *item = [notification object];
//    [item seekToTime:kCMTimeZero];
//    [self.player play];
    NSLog(@"finished");
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
