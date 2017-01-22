//
//  WebViewController.m
//  QueClub
//
//  Created by Muhammad Saad on 6/9/14.
//  Copyright (c) 2014 ETDUAE. All rights reserved.
//

#import "WebViewController.h"
#import "NJKWebViewProgressView.h"
#import "NJKWebViewProgress.h"

@interface WebViewController ()<UIWebViewDelegate,NJKWebViewProgressDelegate>
{
    
    NJKWebViewProgress *_progressProxy;
}
@property(nonatomic,strong)IBOutlet UIWebView *urlView;
@property(nonatomic,strong)IBOutlet UILabel *urlTitle;
@property(nonatomic,strong)IBOutlet NJKWebViewProgressView *progressView;
@property (strong, nonatomic) IBOutlet UIButton *letNav;
@property (weak, nonatomic) IBOutlet UIView *topView;

@end

@implementation WebViewController
@synthesize link,fileTitle;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = fileTitle;

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.urlTitle.text = fileTitle;
    NSURL *url = [NSURL URLWithString:link];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    //[_urlView setScalesPageToFit:YES];
    [_urlView loadRequest:request];
    _progressProxy = [[NJKWebViewProgress alloc] init];
    _urlView.delegate = _progressProxy;
    _progressProxy.webViewProxyDelegate = self;
    _progressProxy.progressDelegate = self;
    
    [self.letNav setImage:[UIImage imageNamed:[self guzzleImageName:@"back"] cache:YES] forState:UIControlStateNormal];

    if([self isPremiumUser])
    {
        self.urlTitle.textColor = UIColorFromRGB(guzzle_yellow);
    }
    else
    {
        self.urlTitle.textColor = [UIColor whiteColor];
    }
    [self.topView setBackgroundColor:UIColorFromRGB(guzzle_purple)];
    // Do any additional setup after loading the view from its nib.
}

#pragma mark - NJKWebViewProgressDelegate
-(void)webViewProgress:(NJKWebViewProgress *)webViewProgress updateProgress:(float)progress
{
    [_progressView setProgress:progress animated:YES];
}

-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    //Start the progressbar..
    return YES;
}

-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    _progressView.hidden=YES;
    //Stop or remove progressbar
}

-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    //Stop or remove progressbar and show error
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
