//
//  BSCoreGraphicsPlaygroundViewController.m
//  bootstragram
//
//  Created by Mickaël Floc'hlay on 13/02/2014.
//  Copyright (c) 2014 Bootstragram. All rights reserved.
//

#import "BSCoreGraphicsPlaygroundViewController.h"
#import "BSFunkyView.h"

@interface BSCoreGraphicsPlaygroundViewController ()

@property(nonatomic, weak) IBOutlet BSFunkyView *funkyView;

@end

@implementation BSCoreGraphicsPlaygroundViewController


- (void)viewWillAppear:(BOOL)animated {
    CGRect screen = self.view.bounds;
    CGFloat border = 40.0;
    
    BSFunkyView *view = [[BSFunkyView alloc] initWithFrame:CGRectMake(border, border, screen.size.width - 2 * border, screen.size.height - 2 * border)];
    view.backgroundColor = [UIColor clearColor];
    view.borderRadius = 40.0;
    view.borderVerticalAngle = (15.0 / 180.0 * M_PI);
    view.borderHorizontalAngle = (20.0 / 180.0 * M_PI);
    view.borderVertical = 20.0;
    view.borderHorizontal = 60.0;
    
    [self.view addSubview:view];
}


@end
