//
//  BSLocationManagerDelegate.h
//  bootstragram
//
//  Created by Mickaël Floc'hlay on 27/11/2013.
//  Copyright (c) 2013 Bootstragram. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>


@interface BSLocationManagerDelegate : NSObject<CLLocationManagerDelegate>

@property (strong, nonatomic) CLLocation *mostRecentLocation;

@end
