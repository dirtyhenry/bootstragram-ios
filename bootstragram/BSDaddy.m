//
//  BSDaddy.m
//  bootstragram
//
//  Created by Mickaël Floc'hlay on 19/03/2014.
//  Copyright (c) 2014 Bootstragram. All rights reserved.
//

#import "BSDaddy.h"
#import "BSDaddySubclass.h"

/**
 *  This stuff is private. Daddy doesn't want to share this with his son.
 */
@interface BSDaddy ()

@property(weak, nonatomic) NSString *secretSexFantasy;

- (NSNumber *)creditCardPinNumber;

@end

@implementation BSDaddy

- (id)init {
    self = [super init];
    if (self) {
        self.protectedAddress = @"Hill Valley";
        self.secretSexFantasy = @"being disguised as an alien";
    }
    return self;
}


- (NSNumber *)creditCardPinNumber {
    return [NSNumber numberWithInteger:1234];
}


- (NSString *)introduction {
    return @"Hi! My name is George McFly!";
}


- (NSString *)healthInsuranceId {
    return @"123456789";
}


@end
