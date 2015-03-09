//
//  BSLocationManagerDelegate.m
//  bootstragram
//
//  Created by Mickaël Floc'hlay on 27/11/2013.
//  Copyright (c) 2013 Bootstragram. All rights reserved.
//

#import "BSLocationManagerDelegate.h"

@implementation BSLocationManagerDelegate


- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    self.mostRecentLocation = [locations lastObject];
    DDLogInfo(@"Most recent location is: %@", self.mostRecentLocation);
}

- (void)locationManager:(CLLocationManager *)manager monitoringDidFailForRegion:(CLRegion *)region withError:(NSError *)error {
    DDLogError(@"Location error: %@", error);
}

- (void)locationManager:(CLLocationManager *)manager didFinishDeferredUpdatesWithError:(NSError *)error {
    DDLogError(@"Location error: %@", error);
}

@end
