//
//  BSMapAnnotation.m
//  bootstragram
//
//  Created by Mickaël Floc'hlay on 29/11/2013.
//  Copyright (c) 2013 Bootstragram. All rights reserved.
//

#import "BSMapAnnotation.h"

@interface BSMapAnnotation (private)

@property (weak, nonatomic) CLLocation *referenceLocation;

@end

@implementation BSMapAnnotation


- (id)initWithTitle:(NSString *)title andLocation:(CLLocation *)referenceLocation {
    self = [super init];
    if (self) {
        _title = title;
        if (referenceLocation) {
            self.referenceLocation = referenceLocation;
            [self addObserver:referenceLocation forKeyPath:@"coordinate" options:NSKeyValueObservingOptionNew context:nil];
        }
    }
    return self;
}


- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    [self setCoordinate:self.referenceLocation.coordinate];
}


- (void)setCoordinate:(CLLocationCoordinate2D)newCoordinate {
    _coordinate = newCoordinate;
}


@end
