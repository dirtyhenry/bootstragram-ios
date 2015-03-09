//
//  BSFunkyView.h
//  bootstragram
//
//  Created by Mickaël Floc'hlay on 13/02/2014.
//  Copyright (c) 2014 Bootstragram. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 
 This class allows to draw a view with an integrated gradient and a *funky* border.
 
 ## The Gradient Layer
 
 The gradient layer is pretty straightforward, you need to supply two colors and two points in relative coordinates (ie between
 0.0 and 1.0) and you'll get the gradient.
 
 **There is a lot of possible improvements but it kind of works like this.**
 
 ## The Border Layer
 
 The border layer is more complicated. It is composed of a white layer with a border radius + a Bezier path.
 
 ## A graph to make it clear
 
 ![A funky graph explaining how properties are used to build the view.](../docs/doc-resources/funky graph.png)
 
 */
@interface BSFunkyView : UIView


/**
 *  The radius of the white border in each 4 corners (expressed in points).
 *
 *  cf. r in the graph
 *
 *  The border radius of the gradient layer is computed dynamically as the difference between r and bh.
 */
@property(nonatomic) CGFloat borderRadius;


/**
 *  The angle controlling the vertical border width (expressed in radians).
 *
 *  cf. α in the graph.
 */
@property(nonatomic) CGFloat borderVerticalAngle;


/**
 *  The angle controlling the horizontal border width (expressed in radians).
 *
 *  cf. β in the graph.
 */
@property(nonatomic) CGFloat borderHorizontalAngle;


/**
 *  The vertical border width between the white layer and the gradient layer (expressed in points).
 *
 *  cf. bv in the graph
 */
@property(nonatomic) CGFloat borderVertical;


/**
 *  The horizontal border width between the white layer and the gradient layer (expressed in points).
 *
 *  cf. bh in the graph
 */
@property(nonatomic) CGFloat borderHorizontal;


/**
 *  The gradient start color.
 */
@property(nonatomic, strong) UIColor *gradientStartColor;


/**
 *  The gradient end color.
 */
@property(nonatomic, strong) UIColor *gradientEndColor;


/**
 *  The gradient start point, expressed in relative coordinates. Defaults to (0.2, 0.2).
 */
@property(nonatomic) CGPoint gradientStartPoint;


/**
 *  The gradient end point, expressed in relative coordinates. Defaults to (0.8, 0.8).
 */
@property(nonatomic) CGPoint gradientEndPoint;


@end
