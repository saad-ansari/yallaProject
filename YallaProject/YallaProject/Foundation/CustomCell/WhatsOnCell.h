//
//  VineListCell.h
//  PublicMinistry
//
//  Created by Shabir Jan on 19/12/2014.
//  Copyright (c) 2014 Shabir Jan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MMCollapsibleLabel.h"
@interface WhatsOnCell : UITableViewCell

@property (nonatomic,weak)IBOutlet UILabel *lblTitle;
@property (nonatomic,weak)IBOutlet UILabel *lblOutlet;
@property (nonatomic,weak)IBOutlet UILabel *lblDate;
@property (nonatomic,weak)IBOutlet UILabel *lblDistance;
@property (nonatomic,weak)IBOutlet UILabel *lblTime;
@property (nonatomic,weak)IBOutlet UIImageView *imgThumbnail;
@property (nonatomic,weak)IBOutlet UILabel *lblDescription;
@property (nonatomic,weak)IBOutlet UIView *mainView;
@property (nonatomic,weak)IBOutlet UIView *adsView;
@property (nonatomic,weak)IBOutlet UIImageView *imgAds;
@property (nonatomic,weak)IBOutlet UIButton *btnOffer;
@property (nonatomic,weak)IBOutlet UIButton *readMore;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightContraintLabel;

@end
