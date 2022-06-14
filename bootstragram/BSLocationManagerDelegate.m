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
    NSLog(@"Most recent location is: %@", self.mostRecentLocation);
    NSLog(@"Altitude: %f", self.mostRecentLocation.altitude);
}

- (void)locationManager:(CLLocationManager *)manager monitoringDidFailForRegion:(CLRegion *)region withError:(NSError *)error {
    NSLog(@"Location error: %@", error);
}

- (void)locationManager:(CLLocationManager *)manager didFinishDeferredUpdatesWithError:(NSError *)error {
    NSLog(@"Location error: %@", error);
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    NSLog(@"Location error: %@", error);
}

- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status {
    NSLog(@"New authorization status: %d", status);
}

@end
