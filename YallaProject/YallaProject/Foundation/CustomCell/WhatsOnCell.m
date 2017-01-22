//
//  VineListCell.m
//  PublicMinistry
//
//  Created by Shabir Jan on 19/12/2014.
//  Copyright (c) 2014 Shabir Jan. All rights reserved.
//

#import "WhatsOnCell.h"

@implementation WhatsOnCell
- (void)awakeFromNib {
    // Initialization code
    [super awakeFromNib];

}
- (void)layoutSubviews
{
    [super layoutSubviews];
    [self.contentView layoutIfNeeded];
    [self layoutIfNeeded];

    // in my case i only had set frame here while my other
    // declarations were in init function, so it solve my problem
    
}
-(void)didMoveToSuperview {
    [self layoutIfNeeded];
    [self.contentView layoutIfNeeded];
    [self layoutIfNeeded];

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


@end
