//
//  ClipItem.h
//  QueClub
//
//  Created by Muhammad Saad on 6/4/14.
//  Copyright (c) 2014 ETDUAE. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ClipItem : NSObject
{
    NSString *clipId;
    NSString *clipPath;
    NSString *vineId;
    NSString *duration;
    NSString *clipName;
}
@property(nonatomic,strong)NSString *title;
@property(nonatomic,strong)NSString *price;

- (id)initWithTitle:(NSString *)aTitle andPrice:(NSString *)aPrice;


@end
