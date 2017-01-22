//
//  VineListCell.h
//  PublicMinistry
//
//  Created by Shabir Jan on 19/12/2014.
//  Copyright (c) 2014 Shabir Jan. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface NotiCell : UITableViewCell

@property (nonatomic,weak)IBOutlet UILabel *lblTitle;
@property (nonatomic,weak)IBOutlet UILabel *lblDescription;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightContraintLabel;

@end
