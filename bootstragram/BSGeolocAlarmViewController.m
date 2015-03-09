//
//  BSGeolocAlarmViewController.m
//  bootstragram
//
//  Created by Mickaël Floc'hlay on 27/11/2013.
//  Copyright (c) 2013 Bootstragram. All rights reserved.
//

#import "BSGeolocAlarmViewController.h"
#import "BSLocationManagerDelegate.h"
#import "BSMapAnnotation.h"

@interface BSGeolocAlarmViewController ()

@property (strong, nonatomic) CLLocation *targetLocation;
@property (strong, nonatomic) CLLocationManager *locationManager;
@property (strong, nonatomic) BSLocationManagerDelegate *locationDelegate;
@property (strong, nonatomic) BSMapAnnotation *targetLocationAnnotation;
@property (strong, nonatomic) BSMapAnnotation *mostRecentLocationAnnotation;
@property (nonatomic) BOOL didZoomAtStartup;
@property (nonatomic) BOOL didAlarmRing;

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
    
    self.didZoomAtStartup = NO;
    self.didAlarmRing = NO;
    
    self.mapView.layer.cornerRadius = self.mapView.frame.size.height / 2.0;
    self.mapView.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    self.mapView.layer.borderWidth = 3.0;
    
    self.targetLocationAnnotation = [[BSMapAnnotation alloc] initWithTitle:@"My Target" andLocation:nil];
    self.mostRecentLocationAnnotation = [[BSMapAnnotation alloc] initWithTitle:@"My Position" andLocation:nil];
    
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationDelegate = [[BSLocationManagerDelegate alloc] init];
    self.locationManager.delegate = self.locationDelegate;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyKilometer;
    self.locationManager.distanceFilter = 100;
    DDLogDebug(@"Starting to update location");
    
    [self.locationManager startUpdatingLocation];
}

- (void)viewWillAppear:(BOOL)animated {
    [self.locationDelegate addObserver:self forKeyPath:@"mostRecentLocation" options:NSKeyValueObservingOptionNew context:nil];
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
    DDLogDebug(@"Notification");
    self.feedback.text = [NSString stringWithFormat:@"%@", self.locationDelegate.mostRecentLocation];
    [self updateViews];
}


- (void)updateViews {
    // Updating location on the map
    // - When we got a location for the first time
    // - or whenever we get an update, if the target location was set (otherwise it's going to
    // annoy the user if he moves the map to reach his target
    if (self.locationDelegate.mostRecentLocation && (!self.didZoomAtStartup || self.targetLocation)) {
        DDLogDebug(@"Updating map on current's location");
        [self.mostRecentLocationAnnotation setCoordinate:self.locationDelegate.mostRecentLocation.coordinate];
        
        if (!self.didZoomAtStartup) {
            // It's the first time we know our position
            [self.mapView addAnnotation:self.mostRecentLocationAnnotation];
            self.didZoomAtStartup = YES;
        }
        
        [self.mapView setRegion:MKCoordinateRegionMake(self.locationDelegate.mostRecentLocation.coordinate, MKCoordinateSpanMake(0.01, 0.01)) animated:YES];
    }
    
    // We also want to update the distance if the target was set
    if (self.locationDelegate.mostRecentLocation && self.targetLocation) {
        CLLocationDistance distance = [self.locationDelegate.mostRecentLocation distanceFromLocation:self.targetLocation];
        DDLogDebug(@"Update %f", distance);
        MKDistanceFormatter *formatter = [[MKDistanceFormatter alloc] init];
        formatter.units = MKDistanceFormatterUnitsMetric;
        self.distance.text = [formatter stringFromDistance:distance];
        
        if (distance < 25000 && !self.didAlarmRing) {
            DDLogInfo(@"LOCAL NOTIFICATION");
            UILocalNotification *notification = [[UILocalNotification alloc] init];
            notification.fireDate = [NSDate date];
            notification.alertBody = @"Wake up!";
            notification.alertAction = @"We're here";
            [[UIApplication sharedApplication] presentLocalNotificationNow:notification];
            self.didAlarmRing = YES;
        }
    }
}


- (IBAction)registerAlarm:(id)sender {
    CLLocationCoordinate2D alarmPosition = self.mapView.centerCoordinate;
    self.targetLocation = [[CLLocation alloc] initWithLatitude:alarmPosition.latitude longitude:alarmPosition.longitude];
    [self updateViews];
    self.targetButton.enabled = NO;
    [self.targetLocationAnnotation setCoordinate:alarmPosition];
    [self.mapView addAnnotation:self.targetLocationAnnotation];
}

@end
