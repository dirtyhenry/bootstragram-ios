//
//  BSMapAnnotation.h
//  bootstragram
//
//  Created by Mickaël Floc'hlay on 29/11/2013.
//  Copyright (c) 2013 Bootstragram. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface BSMapAnnotation : NSObject<MKAnnotation>

@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;
@property (nonatomic, readonly, copy) NSString *title;
@property (nonatomic, readonly, copy) NSString *subtitle;

- (id)initWithTitle:(NSString *)title andLocation:(CLLocation *)referenceLocation;

@end
