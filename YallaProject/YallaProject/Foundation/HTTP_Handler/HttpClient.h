//
//  HttpClient.h
//  Cisco
//
//  Created by msaad on 7/8/13.
//  Copyright (c) 2013 Jibran Ahmed. All rights reserved.
//

#import "AFNetworking.h"
@interface HttpClient : AFHTTPSessionManager

+ (instancetype)sharedClient;

@end

@interface PostHttpClient : AFHTTPRequestOperationManager

+ (instancetype)sharedClient;

@end
