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


- (void)viewDidLayoutSubviews {
    self.funkyView.backgroundColor = [UIColor clearColor];
}


@end
