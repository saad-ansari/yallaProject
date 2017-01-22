//
//  BaseViewController.m
//  AWR-CMS
//
//  Created by Saad Ansari on 12/22/13.
//  Copyright (c) 2013 Saad Ansari. All rights reserved.
//

#import "BaseViewController.h"
#import "HttpClient.h"

#define kLGRefreshViewMainScreenSideMax         MAX(UIScreen.mainScreen.bounds.size.width, UIScreen.mainScreen.bounds.size.height)
#define kLGRefreshViewDeviceIsOld               (NSProcessInfo.processInfo.activeProcessorCount < 2)
#define kLGRefreshViewDegreesToRadians(d)       ((d) * M_PI / 180)
#define kLGRefreshViewCircleOutMaxProgress      0.93
#define kLGRefreshViewCircleInMaxProgress       0.9
#define kLGRefreshViewHeight                    64.f
#define kLGRefreshViewCircleOutSize             (kLGRefreshViewHeight * 0.5)
#define kLGRefreshViewCircleInSize              (kLGRefreshViewHeight * 0.3)
#define kLGRefreshViewCircleOutThicknessRatio   0.2
#define kLGRefreshViewCircleInThicknessRatio    0.25

@interface BaseViewController ()
{
    MBProgressHUD *progressHUD;
    DGActivityIndicatorView *activityIndicatorView;
    Reachability *reachability;
    UIAlertController *alertController;
}

@end

@implementation BaseViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    httpManager = [Base new];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    self.navigationController.navigationBar.barTintColor = UIColorFromRGB(guzzle_purple);
    [ISMessages hideAlertAnimated:YES];
}
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];
}
#pragma mark - gestureRecognizer Delegate

- (void)handleTap:(UITapGestureRecognizer *)gestureRecognizer
{
    NSLog(@"Tapped");
    [ISMessages hideAlertAnimated:YES];
}
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldBeRequiredToFailByGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return YES;
}
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return YES;
}

-(void)checkForLocationService
{
    if(![CLLocationManager locationServicesEnabled] || [CLLocationManager authorizationStatus]== kCLAuthorizationStatusDenied)
    {
        
        alertController = nil;
        alertController = [UIAlertController alertControllerWithTitle:@"Location Not Available" message:@"Enable location services in your phone settings." preferredStyle:UIAlertControllerStyleAlert];
        
        [alertController addAction:[UIAlertAction actionWithTitle:@"Enable now" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action)
                                    {
                                        [[UIApplication sharedApplication] openURL:[NSURL  URLWithString:UIApplicationOpenSettingsURLString]];
                                    }]];
        
        dispatch_async(dispatch_get_main_queue(), ^ {
            [self presentViewController:alertController animated:YES completion:nil];
        });
    }
    else
    {
        dispatch_async(dispatch_get_main_queue(), ^ {
            [self dismissViewControllerAnimated:alertController completion:nil];
        });
    }
}



-(void)showMenu
{
    // Dismiss keyboard (optional)
    //
    [self.view endEditing:YES];
    [self.frostedViewController.view endEditing:YES];
    
    // Present the view controller
    //
    [self.frostedViewController presentMenuViewController];
}

-(void)hideMenu
{
    // Dismiss keyboard (optional)
    //
    [self.view endEditing:YES];
    [self.frostedViewController.view endEditing:YES];
    
    // Present the view controller
    //
    [self.frostedViewController hideMenuViewController];
}

-(void)setBorderColor:(UIView *)viewColor
{
//    viewColor.layer.borderColor = UIColorFromRGB(list_divider).CGColor;
    viewColor.layer.borderColor = [UIColor colorWithWhite:0.1 alpha:0.2].CGColor;
//    viewColor.layer.borderColor = [UIColor lightTextColor].CGColor;
    viewColor.layer.borderWidth = 0.8f;
}

-(void)makeCurveCorner:(UIView*)view
{
        view.layer.cornerRadius=5.0;
        view.clipsToBounds=YES;
}

-(void)makeRoundCorner:(UIView*)view
{
//    view.layer.cornerRadius=8.0;
//    view.clipsToBounds=YES;
    
    view.clipsToBounds = YES;
    view.layer.cornerRadius = view.layer.frame.size.width/2;
}

-(IBAction)backAction:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES ];
}
-(IBAction)dismissBackButton:(id)sender
{
//    [self dismissViewControllerAnimated:YES completion:nil];
    [self.navigationController popViewControllerAnimated:YES ];

}



#pragma mark
#pragma mark - Indicator Method
- (void)showCustomLoadingIndicator:(UIView*)loadingView{
	
    /*
     
     DGActivityIndicatorView *activityIndicatorView = [[DGActivityIndicatorView alloc] initWithType:DGActivityIndicatorAnimationTypeDoubleBounce tintColor:[UIColor whiteColor] size:20.0f];
     activityIndicatorView.frame = CGRectMake(0.0f, 0.0f, 50.0f, 50.0f);
     [self.view addSubview:activityIndicatorView];
     [activityIndicatorView startAnimating];
     
     */
    if(progressHUD){
        [progressHUD removeFromSuperview];
    }
    progressHUD=nil;
    progressHUD = [[MBProgressHUD alloc] initWithView:loadingView];
    progressHUD.center = CGPointMake(self.view.frameWidth/2, (self.view.frameHeight/2) + 20.0 );

    progressHUD.color = [UIColor clearColor];
    progressHUD.tintColor = [UIColor clearColor];
    [loadingView addSubview:progressHUD];
//    [progressHUD show:YES];
    
//    if(activityIndicatorView)
//    {
//        [activityIndicatorView removeFromSuperview];
//    }
//    activityIndicatorView=nil;
//    activityIndicatorView = [[DGActivityIndicatorView alloc] initWithType:DGActivityIndicatorAnimationTypeTripleRings tintColor:UIColorFromRGB(guzzle_purple) size:80.0f];
//    activityIndicatorView.frame = CGRectMake(0.0f, 0.0f, [loadingView frameWidth], [loadingView frameHeight]);
//    activityIndicatorView.center = self.view.center;
//	[loadingView addSubview:activityIndicatorView];
//    [activityIndicatorView startAnimating];
    
    if(_circleViewOut)
    {
        [_circleViewOut removeFromSuperview];
    }
    _circleViewOut = nil;
    _circleViewOut = [DACircularProgressView new];
    _circleViewOut.backgroundColor = [UIColor clearColor];
    _circleViewOut.trackTintColor = [UIColor clearColor];
    _circleViewOut.progressTintColor = UIColorFromRGB(guzzle_purple);
    _circleViewOut.roundedCorners = 3;
    _circleViewOut.layer.anchorPoint = CGPointMake(0.5, 0.5);
    _circleViewOut.thicknessRatio = kLGRefreshViewCircleOutThicknessRatio;
    _circleViewOut.center = CGPointMake(self.view.frameWidth/2, (self.view.frameHeight/2) + 20.0 );
    [loadingView addSubview:_circleViewOut];
    
    if(_circleViewIn)
    {
        [_circleViewIn removeFromSuperview];
    }
    _circleViewIn = nil;
    _circleViewIn = [DACircularProgressView new];
    _circleViewIn.backgroundColor = [UIColor clearColor];
    _circleViewIn.trackTintColor = [UIColor clearColor];
    _circleViewIn.progressTintColor = UIColorFromRGB(guzzle_purple);
    _circleViewIn.roundedCorners = 3;
    _circleViewIn.layer.anchorPoint = CGPointMake(0.5, 0.5);
    _circleViewIn.center = CGPointMake(self.view.frameWidth/2, (self.view.frameHeight/2) + 20.0 );
    _circleViewIn.transform = CGAffineTransformScale(_circleViewIn.transform, -0.7, 0.7);
    _circleViewIn.thicknessRatio = kLGRefreshViewCircleInThicknessRatio;
    [loadingView addSubview:_circleViewIn];
    
    NSTimeInterval duration = 0.2;
    
    CABasicAnimation *animation;
    animation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    animation.duration = duration;
    animation.fromValue = [NSNumber numberWithFloat:1.f];
    animation.removedOnCompletion = NO;
    
    [_circleViewIn.layer addAnimation:animation forKey:@"opacityAnimation"];
    [_circleViewOut.layer addAnimation:animation forKey:@"opacityAnimation"];

    [_circleViewOut setProgress:kLGRefreshViewCircleOutMaxProgress animated:NO];
    [_circleViewIn setProgress:kLGRefreshViewCircleInMaxProgress animated:NO];
    
    if (![_circleViewOut.layer.animationKeys containsObject:@"rotationAnimation"])
    {
        CGFloat multiplier = 1000000.f;
        NSTimeInterval duration = 0.7 * multiplier;
        CGFloat rotations = 1.f * multiplier;
        
        float value = (M_PI * 2.0 * rotations);
        
        CABasicAnimation *rotationAnimation;
        rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
        rotationAnimation.duration = duration;
        rotationAnimation.cumulative = YES;
        rotationAnimation.repeatCount = 1;
        
        rotationAnimation.toValue = [NSNumber numberWithFloat:value];
        
        [_circleViewOut.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
        
        rotationAnimation.toValue = [NSNumber numberWithFloat:-value];
        
        [_circleViewIn.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
    }
}
- (void)hideCustomIndicator
{
	[progressHUD hide:YES];
    [_circleViewIn removeFromSuperview];
    [_circleViewOut removeFromSuperview];
}

- (BOOL)isNetworkAvailable
{
    [[NSNotificationCenter defaultCenter] addObserver: self selector: @selector(handleNetworkChange:) name: kReachabilityChangedNotification object: nil];
    
    reachability = [Reachability reachabilityForInternetConnection];
    
    [reachability startNotifier];
    
    BOOL hasInet;
    NetworkStatus remoteHostStatus = [reachability currentReachabilityStatus];
    
    if          (remoteHostStatus == NotReachable)      {NSLog(@"no");      hasInet-=NO;   }
    else if     (remoteHostStatus == ReachableViaWiFi)  {NSLog(@"wifi");    hasInet-=YES;  }
    else if     (remoteHostStatus == ReachableViaWWAN)  {NSLog(@"cell");    hasInet-=YES;  }
    
    return hasInet;
}
- (void) handleNetworkChange:(NSNotification *)notice
{
    BOOL hasInet;
    NetworkStatus remoteHostStatus = [reachability currentReachabilityStatus];
    
    if          (remoteHostStatus == NotReachable)      {NSLog(@"no");      hasInet-=NO;   }
    else if     (remoteHostStatus == ReachableViaWiFi)  {NSLog(@"wifi");    hasInet-=YES;  }
    else if     (remoteHostStatus == ReachableViaWWAN)  {NSLog(@"cell");    hasInet-=YES;  }
    
    if (hasInet)
    {
        [self showErrorAlert:ConnectionLostTitle andMessage:ConnectionLost];
    }
    else
    {
//        [self showSuccessAlert:ConnectionLostTitle andMessage:ConnectionLost];
    }
}



- (int) timeInMiliSeconds
{
    NSDate *date = [NSDate date];
//    date = [date dateByAddingDays:1];
    NSTimeInterval timeInterval  = [date timeIntervalSince1970];

//    todayTimeStamp = [NSString stringWithFormat:@"%lld", [@(floor([date timeIntervalSince1970])) longLongValue]];
    return (int)timeInterval;
}

- (int) todayDateInMiliSeconds
{
    NSDate *date = [self strictDateFromDate:[NSDate date]];
    NSTimeInterval timeInterval  = [date timeIntervalSince1970];

//    todayTimeStamp = [NSString stringWithFormat:@"%lld", [@(floor([date timeIntervalSince1970])) longLongValue]];
    return (int)timeInterval;
}

- (int) tomorrowDateInMiliSeconds
{
    NSDate *date = [self strictDateFromDate:[NSDate dateTomorrow]];
    
    NSTimeInterval timeInterval  = [date timeIntervalSince1970];

//    todayTimeStamp = [NSString stringWithFormat:@"%lld", [@(floor([date timeIntervalSince1970])) longLongValue]];
    return (int)timeInterval;
}

- (NSDate *)strictDateFromDate:(NSDate *)date
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSInteger comps = (NSCalendarUnitYear | NSCalendarUnitMonth |  NSCalendarUnitDay);

//    NSInteger comps = (NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit);
    NSDateComponents *date2Components = [calendar components:comps fromDate: date];
    date = [calendar dateFromComponents:date2Components];
    
//    NSComparisonResult result = [date1 compare:date2];
//    if (result == NSOrderedAscending) {
//    } else if (result == NSOrderedDescending) {
//    }  else {
//        //the same
//    }
    return date;
}
-(int)timeStampFromDateString:(NSString*)dateString WithFormate:(NSString*)formate
{
    NSDate *tempDate = [NSDate dateFromString:dateString withFormat:formate];
    NSTimeInterval timeInterval  = [tempDate timeIntervalSince1970];

//    NSString *tempTimeStamp = [NSString stringWithFormat:@"%lld", [@(floor([tempDate timeIntervalSince1970])) longLongValue]];
    return (int)timeInterval;
}

-(int)timeStampFromDate:(NSDate*)dateString
{
    NSTimeInterval timeInterval  = [dateString timeIntervalSince1970];
    return (int)timeInterval;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark Gesture recognizer

- (void)panGestureRecognized:(UIPanGestureRecognizer *)sender
{
    // Dismiss keyboard (optional)
    [self.view endEditing:YES];
    [self.frostedViewController.view endEditing:YES];
    
    // Present the view controller
    [self.frostedViewController panGestureRecognized:sender];
}

-(NSMutableArray *)sortArray:(NSArray *)arrayForSort forKey:(NSString *)key Ascending:(BOOL)asc
{
    NSSortDescriptor *sortDescriptor  = [[NSSortDescriptor alloc] initWithKey:key ascending:asc];
    return [[arrayForSort sortedArrayUsingDescriptors:@[sortDescriptor]] mutableCopy];
}

-(void)showSuccessAlert :(NSString *)title andMessage:(NSString *)message
{
    [self hideCustomIndicator];
    [ISMessages showCardAlertWithTitle:title
                               message:message
                              duration:120.f
                           hideOnSwipe:YES
                             hideOnTap:YES
                             alertType:ISAlertTypeSuccess alertPosition:0 didHide:nil];
}
-(void)showErrorAlert :(NSString *)title andMessage:(NSString *)message
{
    [self hideCustomIndicator];
    [ISMessages showCardAlertWithTitle:title
                               message:message
                              duration:120.f
                           hideOnSwipe:YES
                             hideOnTap:YES
                             alertType:ISAlertTypeError alertPosition:0 didHide:nil];
}
-(void)showWarnningAlert :(NSString *)title andMessage:(NSString *)message
{
    [self hideCustomIndicator];
    [ISMessages showCardAlertWithTitle:title
                               message:message
                              duration:120.f
                           hideOnSwipe:YES
                             hideOnTap:YES
                             alertType:ISAlertTypeWarning alertPosition:0 didHide:nil];
}
-(void)showInfoAlert :(NSString *)title andMessage:(NSString *)message
{
    [self hideCustomIndicator];
    [ISMessages showCardAlertWithTitle:title
                               message:message
                              duration:120.f
                           hideOnSwipe:YES
                             hideOnTap:YES
                             alertType:ISAlertTypeInfo alertPosition:0 didHide:nil];
}
-(BOOL)isProfileComplete
{
    NSString *genderStr = [NSString stringWithFormat:@"%@",[SWDefaults userProfile][@"gender"]];
    NSString *cityStr = [NSString stringWithFormat:@"%@",[SWDefaults userProfile][@"city"]];
    NSString *nationalityStr = [NSString stringWithFormat:@"%@",[SWDefaults userProfile][@"nationality"]];
    
    NSString *nameStr = [NSString stringWithFormat:@"%@",[SWDefaults userProfile][@"name"]];
    NSString *countryStr = [NSString stringWithFormat:@"%@",[SWDefaults userProfile][@"country"]];
    NSString *mobileStr = [NSString stringWithFormat:@"%@",[SWDefaults userProfile][@"mobile"]];
    
    if (genderStr.length >1 && cityStr.length>1 && nationalityStr.length>1 && nameStr.length >1 && countryStr.length>1 && mobileStr.length>1)
    {
        return true;
    }
    else
    {
        return false;
    }
}

-(NSString*)deviceUDID
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *uuidUserDefaults = [defaults objectForKey:@"uuid"];
    NSString *uuid = [UICKeyChainStore stringForKey:@"uuid"];
    if ( uuid && !uuidUserDefaults)
    {
        [defaults setObject:uuid forKey:@"uuid"];
        [defaults synchronize];
    }
    else if ( !uuid && !uuidUserDefaults )
    {
        NSString *uuidString = [[NSUUID UUID] UUIDString];
        [UICKeyChainStore setString:uuidString forKey:@"uuid"];
        [defaults setObject:uuidString forKey:@"uuid"];
        [defaults synchronize];
        uuid = [UICKeyChainStore stringForKey:@"uuid"];
    }
    else if ( ![uuid isEqualToString:uuidUserDefaults] )
    {
        [UICKeyChainStore setString:uuidUserDefaults forKey:@"uuid"];
        uuid = [UICKeyChainStore stringForKey:@"uuid"];
    }
    return uuid;
}

-(BOOL)isUserLoggedIn
{
    if([[SWDefaults userProfile] objectForKey:@"email"] && [[SWDefaults userProfile][@"active"] isEqualToString:@"ACTIVE"])
    {
        return true;
    }
    else
    {
        return false;
    }
}

-(BOOL)isPremiumUser
{
    BOOL isPremium = true;

    if([[SWDefaults userProfile] objectForKey:@"email"] && [[SWDefaults userProfile][@"active"] isEqualToString:@"ACTIVE"])
    {
        if ([[SWDefaults userProfile][@"subs"] isEqualToString:@"not_subscribed"] || [[SWDefaults userProfile][@"subs"] isEqualToString:@""])
        {
            isPremium = false;
        }
        else
        {
            isPremium = true;
            
        }
        
        if ([[SWDefaults userProfile][@"freeuser"] isEqualToString: @"YES"])
        {
            isPremium = true;
        }
    }
    else
    {
       isPremium = false;

    }

    return  isPremium;
}


-(NSMutableDictionary *)makeUserObject:(NSMutableDictionary *)dic
{
    NSMutableDictionary *userDict = [NSMutableDictionary new];
    [userDict setObject:dic[@"entry_id"] forKey:@"entry_id"];
    [userDict setObject:dic[@"entry_date"] forKey:@"entry_date"];
    [userDict setObject:dic[@"field_id_2"] forKey:@"gender"];
    [userDict setObject:dic[@"field_id_3"] forKey:@"mobile"];
    [userDict setObject:dic[@"field_id_4"] forKey:@"birthday"];
    [userDict setObject:dic[@"field_id_5"] forKey:@"city"];
    [userDict setObject:dic[@"field_id_6"] forKey:@"country"];
    [userDict setObject:dic[@"field_id_24"] forKey:@"nationality"];
    [userDict setObject:dic[@"field_id_73"] forKey:@"email"];
    [userDict setObject:dic[@"field_id_85"] forKey:@"device_id"];
    [userDict setObject:dic[@"field_id_95"] forKey:@"name"];
    [userDict setObject:dic[@"field_id_109"] forKey:@"profil_img"];
    [userDict setObject:dic[@"field_id_117"] forKey:@"subs"];
    [userDict setObject:dic[@"field_id_118"] forKey:@"subs_date"];
    [userDict setObject:dic[@"field_id_132"] forKey:@"freeuser"];
    [userDict setObject:dic[@"field_id_195"] forKey:@"due_date"];
    [userDict setObject:dic[@"field_id_208"] forKey:@"cancel_reason"];
    [userDict setObject:dic[@"field_id_211"] forKey:@"active"];
    [userDict setObject:dic[@"field_id_233"] forKey:@"expiry_date"];
    
    [SWDefaults setUserProfile:userDict];
    return userDict;
}

- (NSMutableArray*)showCountryList
{
    NSData *data = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"countries" ofType:@"json"]];
    NSError *localError = nil;
    NSDictionary *parsedObject = [NSJSONSerialization JSONObjectWithData:data options:0 error:&localError];
    if (localError != nil)
    {
        NSLog(@"%@", [localError userInfo]);
    }
    NSMutableArray *countriesList = (NSMutableArray *)parsedObject;
    return countriesList;
}
- (BOOL)validateInputInView:(UIView*)view
{
    for(UIView *subView in view.subviews)
    {
        if ([subView isKindOfClass:[UIScrollView class]])
            return [self validateInputInView:subView];
        
        if ([subView isKindOfClass:[DemoTextField class]])
        {
            if (![(MHTextField*)subView validate])
            {
                return NO;
            }
        }
    }
    return YES;
}
- (void)shakeView:(UIView *)view
{
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"position.x"];
    animation.duration = 0.1;
    animation.byValue = @(20);
    animation.autoreverses = YES;
    animation.repeatCount = 10;
    [view.layer addAnimation:animation forKey:@"Shake"];
}
- (NSInteger)calculateAgeFromDate:(NSDate*)birthdate
{
    NSDateComponents* ageComponents = [[NSCalendar currentCalendar]
                                       components:NSCalendarUnitYear
                                       fromDate:birthdate
                                       toDate:[NSDate date]
                                       options:0];
    return [ageComponents year];
}
- (NSString*)dateStringFromTimeStamp:(NSString*)birthdate
{
    NSDate * myDate = [NSDate dateWithTimeIntervalSince1970:[birthdate integerValue]];
    NSString *dateString = [NSDate stringFromDate:myDate withFormat:guzzleFormate];
    return dateString;
}

-(int)renewsInDays:(NSString*)expiryDate
{
    NSDate * myDate = [NSDate dateWithTimeIntervalSince1970:[expiryDate integerValue]];
    Log(@"%@",myDate);
    NSDateComponents* ageComponents = [[NSCalendar currentCalendar]
                                       components:NSCalendarUnitDay
                                       fromDate:[NSDate date]
                                       toDate:myDate
                                       options:0];
    
    return (int)[ageComponents day];

}

- (NSString *)getExpiryDateFromTimeStamp:(NSString*)expiry
{
    NSDate * myDate = [NSDate dateWithTimeIntervalSince1970:[expiry integerValue]];
    myDate = [myDate dateBySubtractingDays:1];
    NSString *dateString = [NSDate stringFromDate:myDate withFormat:guzzleFormate];
    return dateString;
}

-(NSMutableArray*)nationalityList
{
    NSData *data = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"natioanalities" ofType:@"json"]];
    NSError *localError = nil;
    NSDictionary *parsedObject = [NSJSONSerialization JSONObjectWithData:data options:0 error:&localError];
    if (localError != nil)
    {
        NSLog(@"%@", [localError userInfo]);
    }
    NSMutableArray *countriesList = (NSMutableArray *)parsedObject;
    return countriesList;
}

-(BOOL)isConnectionAvailable
{
    char *hostname;
    struct hostent *hostinfo;
    hostname = "google.com";
    hostinfo = gethostbyname (hostname);
    if (hostinfo == NULL){
        NSLog(@"-> no connection!\n");
        return NO;
    }
    else{
        NSLog(@"-> connection established!\n");
        return YES;
    }
}

//- (CLLocationCoordinate2D)showCurrentLocation
//{
//    locationManager = [[CLLocationManager alloc] init];
//    locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters;
//    locationManager.distanceFilter = kCLDistanceFilterNone;
//    [locationManager requestWhenInUseAuthorization];
//    [locationManager startUpdatingLocation];
//    location = [locationManager location];
//    CLLocationCoordinate2D coordinate = [location coordinate];
//    NSString *latitude = [NSString stringWithFormat:@"%f", coordinate.latitude];
//    NSString *longitude = [NSString stringWithFormat:@"%f", coordinate.longitude];
//    Log(@"%@,%@",latitude,longitude)
//    locationManager=nil;
//    return coordinate;
//}

- (NSString*)guzzleImageName:(NSString*)image
{
    
    if ([self isPremiumUser])
    {
        image = [@"y_" stringByAppendingString:image];
    }
    return image;
}



@end
