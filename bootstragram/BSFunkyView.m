//
//  BSFunkyView.m
//  bootstragram
//
//  Created by Mickaël Floc'hlay on 13/02/2014.
//  Copyright (c) 2014 Bootstragram. All rights reserved.
//

#import "BSFunkyView.h"
#import <QuartzCore/QuartzCore.h>

@implementation BSFunkyView

- (id)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        self.borderRadius = 14.0;
        self.borderHorizontal = 2.0;
        self.borderVertical = 1.5;
        self.borderAngle = (1.5 / 180.0 * M_PI);
        
        self.gradientStartPoint = CGPointMake(0.2f, 0.2f);
        self.gradientEndPoint = CGPointMake(0.8f, 0.8f);
    }
    return self;
}

// 108.0
// 144.0

- (void)drawRect:(CGRect)rect {
    self.layer.masksToBounds = YES;
    self.backgroundColor = [UIColor yellowColor];

    CGRect ref = self.bounds;
    CGFloat xDelta = tan(self.borderAngle) * ref.size.height / 2.0;
    
    CALayer *whiteLayer = [CALayer layer];
    whiteLayer.frame = CGRectMake(xDelta, 0, ref.size.width - 2 * xDelta, ref.size.height);
    whiteLayer.cornerRadius = self.borderRadius;
    whiteLayer.backgroundColor = [UIColor whiteColor].CGColor;
    [self.layer insertSublayer:whiteLayer atIndex:0];
    
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame = CGRectMake(xDelta + self.borderVertical, self.borderHorizontal, ref.size.width - 2.0 * (xDelta + self.borderVertical), ref.size.height - 2.0 * self.borderHorizontal);
    gradient.colors = [NSArray arrayWithObjects:
                       (id)[UIColor colorWithRed:(245.0f / 255.0f) green:(165.0f / 255.0f) blue:(44.0f / 255.0f) alpha:1.0].CGColor,
                       (id)[UIColor colorWithRed:(227.0f / 255.0f) green:(68.0f / 255.0f) blue:(24.0f / 255.0f) alpha:1.0].CGColor,
                       nil];
    gradient.startPoint = self.gradientStartPoint;
    gradient.endPoint = self.gradientEndPoint;
    gradient.cornerRadius = self.borderRadius - self.borderHorizontal;
    [self.layer insertSublayer:gradient above:whiteLayer];
    DDLogDebug(@"Number of sublayers: %ld", (long)[self.layer.sublayers count]);

    CGContextRef myContext = UIGraphicsGetCurrentContext();
    
    CGContextBeginPath(myContext);
    
    CGPoint p1 = CGPointMake(xDelta, self.borderHorizontal + self.borderRadius);
    CGPoint p2 = CGPointMake(p1.x, ref.size.height - self.borderHorizontal - self.borderRadius);
    CGPoint p3 = CGPointMake(ref.size.width - xDelta, p2.y);
    CGPoint p4 = CGPointMake(p3.x, p1.y);

    
    CGPoint controlPoint1 = CGPointMake(((p1.x + p2.x) / 2.0) - xDelta, (p1.y + p2.y) / 2.0);
    CGPoint controlPoint2 = CGPointMake(((p3.x + p4.x) / 2.0) + xDelta, (p3.y + p4.y) / 2.0);
    
    DDLogDebug(@"p1: %@", NSStringFromCGPoint(p1));
    DDLogDebug(@"p2: %@", NSStringFromCGPoint(p2));
    DDLogDebug(@"p3: %@", NSStringFromCGPoint(p3));
    DDLogDebug(@"p4: %@", NSStringFromCGPoint(p4));
    DDLogDebug(@"controlPoint1: %@", NSStringFromCGPoint(controlPoint1));
    DDLogDebug(@"controlPoint2: %@", NSStringFromCGPoint(controlPoint2));
    
    CGContextMoveToPoint(myContext, p1.x, p1.y);
    CGContextAddQuadCurveToPoint(myContext, controlPoint1.x, controlPoint1.y, p2.x, p2.y);
    CGContextAddLineToPoint(myContext, p3.x, p3.y);
    CGContextAddQuadCurveToPoint(myContext, controlPoint2.x, controlPoint2.y, p4.x, p4.y);
    CGContextClosePath(myContext);
    
    CGContextSetRGBFillColor(myContext, 1.0, 1.0, 1.0, 1.0);
    CGContextSetRGBStrokeColor(myContext, 1.0, 1.0, 1.0, 1.0);
    
    CGContextFillPath(myContext);
}

@end
