//
//  ClipItem.m
//  QueClub
//
//  Created by Muhammad Saad on 6/4/14.
//  Copyright (c) 2014 ETDUAE. All rights reserved.
//

#import "VineItem.h"

@implementation VineItem
@synthesize title,image,detail,link;

- (id)initWithTitle:(NSString *)aTitle andDetail:(NSString *)aDetail andImage:(NSString *)aImage andLink:(NSString *)aLink
{
    if( self = [super init] )
    {
        self.title = aTitle;
        self.detail= aDetail;
        self.image= aImage;
        self.link= aLink;
    }
    
    return self;
}

@end
