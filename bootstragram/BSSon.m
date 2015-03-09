//
//  BSSon.m
//  bootstragram
//
//  Created by Mickaël Floc'hlay on 19/03/2014.
//  Copyright (c) 2014 Bootstragram. All rights reserved.
//

#import "BSSon.h"
#import "BSDaddySubclass.h"

@implementation BSSon

- (NSString *)introduction {
    // Property 'secretSexFantasy' not found on object of type 'BSSon *'
    //NSString *myDadSecretFantasy = self.secretSexFantasy;

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wundeclared-selector"

    NSString *myDadSecretFantasy = nil;
    NSNumber *creditCardPinNumber = nil;
    if ([self respondsToSelector:@selector(secretSexFantasy)]) {
        myDadSecretFantasy = [self performSelector:@selector(secretSexFantasy) withObject:nil];
    }

    if ([self respondsToSelector:@selector(creditCardPinNumber)]) {
        creditCardPinNumber = [self performSelector:@selector(creditCardPinNumber) withObject:nil];
    }

#pragma clang diagnostic pop

    return [NSString stringWithFormat:@"Hi! I'm Marty. My dad says: “%@”. He'll be mad cause I'm making public that we live in %@ and his health insurance ID is %@. He'll be even madder after I tell you his secret sex fantasy is %@, and that his credit card PIN number is %@.", [super introduction], self.protectedAddress, [self healthInsuranceId], myDadSecretFantasy, creditCardPinNumber];
}

@end
