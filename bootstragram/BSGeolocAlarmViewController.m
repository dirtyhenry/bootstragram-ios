//
//  BSGeolocAlarmViewController.m
//  bootstragram
//
//  Created by Mickaël Floc'hlay on 27/11/2013.
//  Copyright (c) 2013 Bootstragram. All rights reserved.
//

#import "BSGeolocAlarmViewController.h"
#import "BSLocationManagerDelegate.h"

@interface BSGeolocAlarmViewController ()

@property (strong, nonatomic) CLLocation *targetLocation;
@property (strong, nonatomic) CLLocationManager *locationManager;
@property (strong, nonatomic) BSLocationManagerDelegate *locationDelegate;
@property (nonatomic) BOOL zoomedAtStartup;

@end

@implementation BSGeolocAlarmViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.zoomedAtStartup = NO;
    
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationDelegate = [[BSLocationManagerDelegate alloc] init];
    self.locationManager.delegate = self.locationDelegate;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters;
    self.locationManager.distanceFilter = 5;
    DDLogDebug(@"Starting to update location");
    
    [self.locationDelegate addObserver:self forKeyPath:@"mostRecentLocation" options:NSKeyValueObservingOptionNew context:nil];
    
    [self.locationManager startUpdatingLocation];
    
}


- (void)viewWillDisappear:(BOOL)animated {
    [self.locationDelegate removeObserver:self forKeyPath:@"mostRecentLocation"];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    [self updateLabel];
}


- (void)updateLabel {
    if ((self.locationDelegate.mostRecentLocation && !self.zoomedAtStartup) || self.targetLocation) {
        DDLogDebug(@"ZoomingIn");
        [self.mapView setRegion:MKCoordinateRegionMake(self.locationDelegate.mostRecentLocation.coordinate, MKCoordinateSpanMake(0.01, 0.01)) animated:YES];
        self.zoomedAtStartup = YES;
    }
    if (self.locationDelegate.mostRecentLocation && self.targetLocation) {
        CLLocationDistance distance = [self.locationDelegate.mostRecentLocation distanceFromLocation:self.targetLocation];
        MKDistanceFormatter *formatter = [[MKDistanceFormatter alloc] init];
        formatter.units = MKDistanceFormatterUnitsMetric;
        self.distance.text = [formatter stringFromDistance:distance];
        
        if (distance < 100) {
            [[[UIAlertView alloc] initWithTitle:@"THERE" message:nil delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
        }
    }
}



- (IBAction)registerAlarm:(id)sender {
    CLLocationCoordinate2D alarmPosition = self.mapView.centerCoordinate;
    self.targetLocation = [[CLLocation alloc] initWithLatitude:alarmPosition.latitude longitude:alarmPosition.longitude];
    [self updateLabel];
}

@end
