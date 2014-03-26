//
//  BSFacebookViewController.h
//  bootstragram
//
//  Created by Mickaël Floc'hlay on 26/03/2014.
//  Copyright (c) 2014 Bootstragram. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FacebookSDK/FacebookSDK.h>


@interface BSFacebookViewController : UIViewController<FBLoginViewDelegate>

- (IBAction)shareAction:(id)sender;

@end
