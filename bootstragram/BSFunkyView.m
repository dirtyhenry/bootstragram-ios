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
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self initProperties];
    }
    return self;
}


- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initProperties];        
    }
    return self;
}


- (void)initProperties {
    self.borderRadius = 14.0;
    self.borderHorizontal = 2.0;
    self.borderHorizontalAngle = (0 / 180.0 * M_PI);
    self.borderVertical = 1.5;
    self.borderVerticalAngle = (1.5 / 180.0 * M_PI);
    
    self.gradientStartColor = [UIColor colorWithRed:(181.0f / 255.0f) green:(199.0f / 255.0f) blue:(167.0f / 255.0f) alpha:1.0];
    self.gradientEndColor = [UIColor colorWithRed:(167.0f / 255.0f) green:(227.0f / 255.0f) blue:(131.0f / 255.0f) alpha:1.0];
    self.gradientStartPoint = CGPointMake(0.2f, 0.2f);
    self.gradientEndPoint = CGPointMake(0.8f, 0.8f);
}


- (void)drawRect:(CGRect)rect {
    self.layer.masksToBounds = NO;
    self.backgroundColor = [UIColor clearColor];
    
    CGRect ref = self.bounds;
    CGFloat xDelta = tan(self.borderVerticalAngle) * ref.size.height / 2.0;
    CGFloat yDelta = tan(self.borderHorizontalAngle) * ref.size.width / 2.0;
    
    // Add a radius-bordered white layer
    CALayer *whiteLayer = [CALayer layer];
    whiteLayer.frame = CGRectMake(xDelta, yDelta, ref.size.width - 2 * xDelta, ref.size.height - 2 * yDelta);
    whiteLayer.cornerRadius = self.borderRadius;
    whiteLayer.backgroundColor = [UIColor colorWithRed:(100.0f / 255.0f) green:(86.0f / 255.0f) blue:(118.0f/255.0f) alpha:1.0].CGColor;
    [self.layer insertSublayer:whiteLayer atIndex:0];
    
    // Add the gradient layer
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame = CGRectMake(xDelta + self.borderVertical, yDelta + self.borderHorizontal, ref.size.width - 2.0 * (xDelta + self.borderVertical), ref.size.height - 2.0 * (yDelta + self.borderHorizontal));
    gradient.colors = [NSArray arrayWithObjects:
                       (id)self.gradientStartColor.CGColor,
                       (id)self.gradientEndColor.CGColor,
                       nil];
    gradient.startPoint = self.gradientStartPoint;
    gradient.endPoint = self.gradientEndPoint;
    gradient.cornerRadius = self.borderRadius * gradient.frame.size.width / whiteLayer.frame.size.width;
    [self.layer insertSublayer:gradient above:whiteLayer];
    
    // Drawing the path
    CGContextRef myContext = UIGraphicsGetCurrentContext();
    
    CGContextBeginPath(myContext);
    
    CGPoint p1 = CGPointMake(xDelta, yDelta + self.borderRadius);
    CGPoint p2 = CGPointMake(p1.x, ref.size.height - p1.y);
    CGPoint p3 = CGPointMake(xDelta + self.borderRadius, ref.size.height - yDelta);
    CGPoint p4 = CGPointMake(ref.size.width - p3.x, p3.y);
    CGPoint p5 = CGPointMake(ref.size.width - p1.x, p2.y);
    CGPoint p6 = CGPointMake(p5.x, p1.y);
    CGPoint p7 = CGPointMake(p4.x, yDelta);
    CGPoint p8 = CGPointMake(p3.x, p7.y);
    
    CGPoint controlPoint1 = CGPointMake(((p1.x + p2.x) / 2.0) - xDelta, (p1.y + p2.y) / 2.0);
    CGPoint controlPoint2 = CGPointMake(((p3.x + p4.x) / 2.0), ((p3.y + p4.y) / 2.0) + yDelta);
    CGPoint controlPoint3 = CGPointMake(((p5.x + p6.x) / 2.0) + xDelta, (p5.y + p6.y) / 2.0);
    CGPoint controlPoint4 = CGPointMake(((p7.x + p8.x) / 2.0), ((p7.y + p8.y) / 2.0) - yDelta);
    
    CGContextMoveToPoint(myContext, p1.x, p1.y);
    CGContextAddQuadCurveToPoint(myContext, controlPoint1.x, controlPoint1.y, p2.x, p2.y);
    CGContextAddLineToPoint(myContext, p3.x, p3.y);
    CGContextAddQuadCurveToPoint(myContext, controlPoint2.x, controlPoint2.y, p4.x, p4.y);
    CGContextAddLineToPoint(myContext, p5.x, p5.y);
    CGContextAddQuadCurveToPoint(myContext, controlPoint3.x, controlPoint3.y, p6.x, p6.y);
    CGContextAddLineToPoint(myContext, p7.x, p7.y);
    CGContextAddQuadCurveToPoint(myContext, controlPoint4.x, controlPoint4.y, p8.x, p8.y);
    CGContextClosePath(myContext);
    
    CGContextSetRGBFillColor(myContext, 1.0, 1.0, 1.0, 1.0);
    CGContextSetRGBStrokeColor(myContext, 1.0, 1.0, 1.0, 1.0);
    
    CGContextFillPath(myContext);
}


@end
