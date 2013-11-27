//
//  BSMyContactViewController.h
//  bootstragram
//
//  Created by Mickaël Floc'hlay on 19/11/2013.
//  Copyright (c) 2013 Bootstragram. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BSMyContactViewController : UIViewController

@property(nonatomic, weak) IBOutlet UITextField *textField;

- (IBAction)validateMail:(id)sender;

@end
