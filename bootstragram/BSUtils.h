//
//  BSUtils.h
//  bootstragram
//
//  Created by Mickaël Floc'hlay on 26/03/2014.
//  Copyright (c) 2014 Bootstragram. All rights reserved.
//

#import <Foundation/Foundation.h>

// Returns the NSString representation of the specified BOOL value
static inline NSString * NSStringFromBOOL(BOOL value) {
    return value ? @"YES" : @"NO";
}

@interface BSUtils : NSObject

@end
