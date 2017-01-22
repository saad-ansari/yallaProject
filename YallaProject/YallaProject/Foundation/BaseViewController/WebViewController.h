//
//  WebViewController.h
//  QueClub
//
//  Created by Muhammad Saad on 6/9/14.
//  Copyright (c) 2014 ETDUAE. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

@interface WebViewController : BaseViewController
{
    NSString *link;
    NSString *fileTitle;
}
@property(nonatomic,strong)NSString *link;
@property(nonatomic,strong)NSString *fileTitle;

@end
