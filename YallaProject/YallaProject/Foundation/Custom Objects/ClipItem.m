//
//  ClipItem.m
//  QueClub
//
//  Created by Muhammad Saad on 6/4/14.
//  Copyright (c) 2014 ETDUAE. All rights reserved.
//

#import "ClipItem.h"

@implementation ClipItem
@synthesize title,price;

- (id)initWithTitle:(NSString *)aTitle andPrice:(NSString *)aPrice
{
    if( self = [super init] )
    {
        self.title = aTitle;
        self.price = aPrice;
    }
    
    return self;
}

@end
