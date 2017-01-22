//
//  BaseViewController.h
//  AWR-CMS
//
//  Created by Saad Ansari on 12/22/13.
//  Copyright (c) 2013 Saad Ansari. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Defines.h"
#import "NSString+Additions.h"
#import "NSDictionary+Additions.h"
#import "txtFldCategory.h"
#import "SWDefaults.h"
#import "UIView+Visuals.h"
#import "Base.h"
#import "SWDefaults.h"
#import "MBProgressHUD.h"
#import "Reachability.h"
#import "REFrostedViewController.h"
#import "Singleton.h"
#import <CoreLocation/CoreLocation.h>
#import "UIImageView+AFNetworking.h"
#import "NSDate+Helper.h"
#import "NSDate+Utilities.h"
#import "UICKeyChainStore.h"
#import "DemoTextField.h"
#import "ISMessages.h"
#import "DGActivityIndicatorView.h"
#import "HttpClient.h"
#import "DACircularProgressView.h"
//#import <FBSDKCoreKit/FBSDKCoreKit.h>

@interface BaseViewController : UIViewController
{
    Base *httpManager;
    Singleton *single;
    CLLocationManager *locationManager;
    CLLocation *currentLocation;
    CLLocationCoordinate2D currentCoordinate;
    NSString *myLat;
    NSString *myLong;
    NSString * todayTimeStamp;
    

}
@property (strong, nonatomic) DACircularProgressView    *circleViewOut;
@property (strong, nonatomic) DACircularProgressView    *circleViewIn;
- (void)    setBorderColor:(UIView *)viewColor;
- (void)    makeRoundCorner:(UIView*)view;
- (void)    showCustomLoadingIndicator:(UIView*)loadingView;
- (void)    hideCustomIndicator;
- (BOOL)    isNetworkAvailable;
- (void)    showMenu;
- (void)    hideMenu;
- (NSString *)  deviceUDID;
- (int)  timeInMiliSeconds;
- (int) todayDateInMiliSeconds;
- (int) tomorrowDateInMiliSeconds;
- (NSMutableArray *)sortArray:(NSArray *)arrayForSort forKey:(NSString *)key Ascending:(BOOL)asc;
- (int)timeStampFromDateString:(NSString*)dateString WithFormate:(NSString*)formate;
- (int)timeStampFromDate:(NSDate*)dateString;
- (void)showSuccessAlert     :(NSString *)title andMessage:(NSString *)message;
- (void)showErrorAlert       :(NSString *)title andMessage:(NSString *)message;
- (void)showWarnningAlert    :(NSString *)title andMessage:(NSString *)message;
- (void)showInfoAlert        :(NSString *)title andMessage:(NSString *)message;
- (BOOL)isUserLoggedIn;
- (BOOL)isPremiumUser;
- (NSMutableDictionary *)makeUserObject:(NSMutableDictionary *)dic;
- (BOOL)validateInputInView:(UIView*)view;
- (NSMutableArray*)showCountryList;
- (void)shakeView:(UIView *)view;
- (NSInteger)calculateAgeFromDate:(NSDate*)birthdate;
- (NSString*)dateStringFromTimeStamp:(NSString*)birthdate;
- (NSMutableArray*)nationalityList;
- (NSString *)getExpiryDateFromTimeStamp:(NSString*)expiry;
- (int)renewsInDays:(NSString*)expiryDate;
- (BOOL)isConnectionAvailable;
- (void)roundButtonDidTap:(UIButton*)tappedButton;
- (NSString*)guzzleImageName:(NSString*)image;
- (void)makeCurveCorner:(UIView*)view;
- (void)checkForLocationService;
- (BOOL)isProfileComplete;

@end
