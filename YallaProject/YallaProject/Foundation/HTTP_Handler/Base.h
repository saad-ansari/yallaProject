//
//  Base.h
//  Cisco
//
//  Created by msaad on 7/7/13.
//  Copyright (c) 2013 UCS. All rights reserved.
//

#import "AFNetworking.h"


@protocol RequestDelegate <NSObject>

- (void) didReceiveResponse:(id) data;
- (void) didFailWithError:(NSError *)error;

@end

@interface Base : NSObject
{
    id <RequestDelegate>delegate;
}

- (void)callGetService:(id)_delegate withName:(NSString *)service;
- (void)callPostService:(id)_delegate withName:(NSString *)service withParameter:(NSDictionary*)param;



@end
    
