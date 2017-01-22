//
//  ClipItem.h
//  QueClub
//
//  Created by Muhammad Saad on 6/4/14.
//  Copyright (c) 2014 ETDUAE. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VineItem : NSObject
{
    NSString *title;
    NSString *detail;
    NSString *image;
    NSString *link;
}
@property(nonatomic,strong)NSString *title;
@property(nonatomic,strong)NSString *detail;
@property(nonatomic,strong)NSString *image;
@property(nonatomic,strong)NSString *link;


- (id)initWithTitle:(NSString *)aTitle andDetail:(NSString *)aDetail andImage:(NSString *)aImage andLink:(NSString *)aLink;

@end
