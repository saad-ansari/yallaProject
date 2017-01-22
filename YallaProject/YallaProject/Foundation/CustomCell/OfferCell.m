//
//  VineListCell.m
//  PublicMinistry
//
//  Created by Shabir Jan on 19/12/2014.
//  Copyright (c) 2014 Shabir Jan. All rights reserved.
//

#import "OfferCell.h"

@implementation OfferCell
@synthesize xValue;
- (void)awakeFromNib {
    // Initialization code
    [super awakeFromNib];
}

-(void)clearPins
{
    [self.pin1 setText:@""];
    [self.pin2 setText:@""];
    [self.pin3 setText:@""];
    [self.pin4 setText:@""];
}
-(void)showErrorView
{
    [self.errorView setHidden:NO];
    [self.successView setHidden:YES];
    [self.offerView setHidden:YES];
    [self.pinView setHidden:YES];
}
-(void)showSuccessView
{
    [self.errorView setHidden:YES];
    [self.successView setHidden:NO];
    [self.offerView setHidden:YES];
    [self.pinView setHidden:YES];
}
-(void)showPinView
{
    [self.errorView setHidden:YES];
    [self.successView setHidden:YES];
    [self.offerView setHidden:YES];
    [self.pinView setHidden:NO];
}
-(void)showOfferView
{
    [self.errorView setHidden:YES];
    [self.successView setHidden:YES];
    [self.offerView setHidden:NO];
    [self.pinView setHidden:YES];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
