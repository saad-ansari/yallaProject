//
//  VineListCell.h
//  PublicMinistry
//
//  Created by Shabir Jan on 19/12/2014.
//  Copyright (c) 2014 Shabir Jan. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface OutletCell : UITableViewCell

@property (nonatomic,weak)IBOutlet UILabel *lblTitle;
@property (nonatomic,weak)IBOutlet UILabel *lblAddress;
@property (nonatomic,weak)IBOutlet UILabel *lblType;
@property (nonatomic,weak)IBOutlet UILabel *lblDistance;
@property (nonatomic,weak)IBOutlet UIImageView *imgUpdate;
@property (nonatomic,weak)IBOutlet UIImageView *imgNew;
@property (nonatomic,weak)IBOutlet UIImageView *imgThumbnail;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leadingOutletTypeContraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leadingBrunchContraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leadingLeisureContraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *foodWidthContraint;


@property (nonatomic,weak)IBOutlet UIImageView *imgDrinks;
@property (nonatomic,weak)IBOutlet UIImageView *imgFood;
@property (nonatomic,weak)IBOutlet UIImageView *imgLeisure;
@property (nonatomic,weak)IBOutlet UIImageView *imgBrunch;
@end
