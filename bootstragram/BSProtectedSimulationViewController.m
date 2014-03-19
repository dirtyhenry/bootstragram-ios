//
//  BSProtectedSimulationViewController.m
//  bootstragram
//
//  Created by Mickaël Floc'hlay on 19/03/2014.
//  Copyright (c) 2014 Bootstragram. All rights reserved.
//

#import "BSProtectedSimulationViewController.h"
#import "BSDaddy.h"
#import "BSSon.h"

@interface BSProtectedSimulationViewController ()

@property(weak, nonatomic) IBOutlet UILabel *whatTheSonSays;
@property(weak, nonatomic) IBOutlet UILabel *whatTheDadSays;

@end

@implementation BSProtectedSimulationViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.whatTheDadSays.text = [[[BSDaddy alloc] init] introduction];
    self.whatTheSonSays.text = [[[BSSon alloc] init] introduction];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
