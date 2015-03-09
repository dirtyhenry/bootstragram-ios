//
//  BSDaddy.h
//  bootstragram
//
//  Created by Mickaël Floc'hlay on 19/03/2014.
//  Copyright (c) 2014 Bootstragram. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  This class helps to illustrate how to simulate protected methods in Objective-C.
 */
@interface BSDaddy : NSObject

/**
 *  This is a **public method** of the Dad.
 *
 *  @return an introduction for the dad.
 */
- (NSString *)introduction;

@end
