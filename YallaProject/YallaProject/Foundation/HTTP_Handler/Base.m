//
//  Base.m
//  Cisco
//
//  Created by msaad on 7/7/13.
//  Copyright (c) 2013 UCS. All rights reserved.
//

#import "Base.h"
#import "HttpClient.h"
#import "Defines.h"
#import "Reachability.h"
#import "ISMessages.h"
@implementation Base

- (void )callGetService:(id)_delegate withName:(NSString *)service
{
    if([self isConnectionAvailable])
    {
        NSLog(@"%@%@",APIBaseURLString,service);
        HttpClient *client = [HttpClient sharedClient];
        [client GET:service parameters:nil success:^(NSURLSessionDataTask *task, id responseObject)
        {
            if([_delegate respondsToSelector:@selector(didReceiveResponse:)])
            {
                [_delegate didReceiveResponse:responseObject];
            }
            
        } failure:^(NSURLSessionDataTask *task, NSError *error)
        {
            if([_delegate respondsToSelector:@selector(didFailWithError:)])
            {
                [_delegate didFailWithError:error];
            }
        }];
    }
    else
    {
        Log(@"No Internet Connection");
        [self showErrorAlert:ConnectionLostTitle andMessage:ConnectionLost];

    }
}

- (void )callPostService:(id)_delegate withName:(NSString *)service withParameter:(NSDictionary*)param
{
    if([self isConnectionAvailable])
    {
        NSLog(@"%@%@",APIBaseURLString,service);
        PostHttpClient *manager = [PostHttpClient sharedClient];
        [manager POST:service parameters:param success:^(AFHTTPRequestOperation *operation, id responseObject)
         {
             if([_delegate respondsToSelector:@selector(didReceiveResponse:)])
             {
                 [_delegate didReceiveResponse:responseObject];
             }
         }
              failure:^(AFHTTPRequestOperation *operation, NSError *error)
         {
             if([_delegate respondsToSelector:@selector(didFailWithError:)])
             {
                 [_delegate didFailWithError:error];
             }
         }];
    }
    else
    {
        Log(@"No Internet Connection");
        [self showErrorAlert:ConnectionLostTitle andMessage:ConnectionLost];

    }
}

-(void)showErrorAlert :(NSString *)title andMessage:(NSString *)message
{
    [ISMessages showCardAlertWithTitle:title
                               message:message
                              duration:120.f
                           hideOnSwipe:YES
                             hideOnTap:YES
                             alertType:ISAlertTypeError alertPosition:0 didHide:nil];
}

- (BOOL)isNetworkAvailable
{
    Reachability *reachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus networkStatus = [reachability currentReachabilityStatus];
    return networkStatus != NotReachable;
}
-(BOOL)isConnectionAvailable
{
    char *hostname;
    struct hostent *hostinfo;
    hostname = "google.com";
    hostinfo = gethostbyname (hostname);
    if (hostinfo == NULL){
        NSLog(@"-> no connection!\n");
        return NO;
    }
    else{
        NSLog(@"-> connection established!\n");
        return YES;
    }
}
@end
