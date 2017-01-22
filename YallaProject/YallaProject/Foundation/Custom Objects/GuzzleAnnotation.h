//
//  GuzzleAnnotation.h
//  guzzle
//
//  Created by guzzle developer on 1/5/17.
//  Copyright © 2017 guzzle developer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MKAnnotation.h>

@interface GuzzleAnnotation : NSObject <MKAnnotation> {
    
    CLLocationCoordinate2D coordinate;
    NSString *title;
    NSString *subtitle;
    NSString *tagValue;

}
@property (nonatomic, assign) CLLocationCoordinate2D coordinate;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *subtitle;
@property (nonatomic, copy) NSString *tagValue;

@end
