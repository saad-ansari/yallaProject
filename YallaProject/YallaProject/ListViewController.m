//
//  ListViewController.m
//  YallaProject
//
//  Created by guzzle developer on 1/22/17.
//  Copyright © 2017 Yalla Developer. All rights reserved.
//

#import "ListViewController.h"
#import "LocationViewController.h"
#import <AVFoundation/AVFoundation.h>

static const float PLAYER_VOLUME = 0.0;
@interface ListViewController ()
@property (strong, nonatomic) IBOutlet UIView *playerView;
@property (nonatomic) AVPlayer *player;

@end

@implementation ListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createVideoPlayer];

    // Do any additional setup after loading the view.
}

-(void)showLocationView
{
    LocationViewController *newView = [self.storyboard instantiateViewControllerWithIdentifier:@"LocationViewController"];
    [self.navigationController pushViewController:newView animated:YES];
}

- (IBAction)showMenu:(id)sender
{
    [self showMenu];
}

- (void)createVideoPlayer {
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"splash_vdo" ofType:@"mp4"];
    NSURL *url = [NSURL fileURLWithPath:filePath];
    
    AVPlayerItem *playerItem = [AVPlayerItem playerItemWithURL:url];
    
    self.player = [AVPlayer playerWithPlayerItem:playerItem];
    self.player.volume = PLAYER_VOLUME;
    
    AVPlayerLayer *playerLayer = [AVPlayerLayer playerLayerWithPlayer:self.player];
    playerLayer.videoGravity = UIViewContentModeScaleToFill;
    playerLayer.frame = self.playerView.layer.bounds;
    [self.playerView.layer addSublayer:playerLayer];
    
    [self.player play];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(moviePlayDidEnd:) name:AVPlayerItemDidPlayToEndTimeNotification object:self.player.currentItem];
}

#pragma mark - observer of player

// 视频循环播放
- (void)moviePlayDidEnd:(NSNotification*)notification
{
    
    //    AVPlayerItem *item = [notification object];
    //    [item seekToTime:kCMTimeZero];
    //    [self.player play];
    NSLog(@"finished");
    [self.playerView setHidden:YES];
    if([SWDefaults firstInstallation].length==0)
    {
        
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
