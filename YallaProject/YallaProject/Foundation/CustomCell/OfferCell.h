//
//  VineListCell.h
//  PublicMinistry
//
//  Created by Shabir Jan on 19/12/2014.
//  Copyright (c) 2014 Shabir Jan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DemoTextField.h"


@interface OfferCell : UITableViewCell

@property (nonatomic,weak)IBOutlet UIView *offerView;
@property (nonatomic,weak)IBOutlet UIView *pinView;
@property (nonatomic,weak)IBOutlet UIView *errorView;
@property (nonatomic,weak)IBOutlet UIView *successView;
@property (nonatomic,weak)IBOutlet UILabel *lblTitle;
@property (nonatomic,weak)IBOutlet UILabel *lblSubTitle;
@property (nonatomic,weak)IBOutlet UIImageView *iconImg1;
@property (nonatomic,weak)IBOutlet UIImageView *iconImg2;
@property (nonatomic,weak)IBOutlet UIImageView *iconPlus;
@property (nonatomic,weak)IBOutlet UIButton *actionBtn;
@property (nonatomic,weak)IBOutlet UITextField *pin1;
@property (nonatomic,weak)IBOutlet UITextField *pin2;
@property (nonatomic,weak)IBOutlet UITextField *pin3;
@property (nonatomic,weak)IBOutlet UITextField *pin4;
@property (nonatomic,weak)IBOutlet UILabel *lblReturnCode;
@property (nonatomic,weak)IBOutlet UILabel *lblExpires;
@property (nonatomic,weak)IBOutlet UILabel *iconPlusLabel;

@property (nonatomic,weak)IBOutlet UIView *renewNow;
@property (nonatomic,weak)IBOutlet UIView *guzzleNow;
@property (nonatomic,weak)IBOutlet UIView *renewsIn;
@property (nonatomic,weak)IBOutlet UILabel *renewsInDays;
@property (nonatomic,weak)IBOutlet UIImageView *bg_image;

@property (nonatomic,assign) float xValue;
@property (nonatomic,weak)IBOutlet UIView *saveView;
@property (nonatomic,weak)IBOutlet UILabel *saveLbl;
@property (nonatomic,weak)IBOutlet UIView *expireView;



-(void)showErrorView;
-(void)showSuccessView;
-(void)showPinView;
-(void)showOfferView;
-(void)clearPins;

@end
