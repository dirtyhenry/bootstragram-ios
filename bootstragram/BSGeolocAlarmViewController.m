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
#import "ArrayDataSource.h"

@interface BSGeolocAlarmViewController ()

@property (strong, nonatomic) CLLocation *targetLocation;
@property (strong, nonatomic) CLLocationManager *locationManager;
@property (strong, nonatomic) BSLocationManagerDelegate *locationDelegate;
@property (strong, nonatomic) BSMapAnnotation *targetLocationAnnotation;
@property (strong, nonatomic) MKDistanceFormatter *distanceFormatter;
@property (strong, nonatomic) BSMapAnnotation *mostRecentLocationAnnotation;
@property (nonatomic) BOOL didZoomAtStartup;
@property (nonatomic) BOOL didAlarmRing;
@property (nonatomic) CLLocationDistance lastDistance;
@property (nonatomic) CLLocationDistance minAltitude;
@property (nonatomic) CLLocationDistance maxAltitude;
@property (strong, nonatomic) ArrayDataSource *arrayDataSource;

@end


@implementation BSGeolocAlarmViewController


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];

    self.minAltitude = DBL_MAX;
    self.maxAltitude = DBL_MIN;

    self.didZoomAtStartup = NO;
    self.didAlarmRing = NO;

    // Round the map view
    self.mapView.layer.cornerRadius = fminf(self.mapView.frame.size.height, self.mapView.frame.size.width) / 4.0;
    self.mapView.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    self.mapView.layer.borderWidth = 3.0;
    
    self.targetLocationAnnotation = [[BSMapAnnotation alloc] initWithTitle:@"My Target" andLocation:nil];
    self.mostRecentLocationAnnotation = [[BSMapAnnotation alloc] initWithTitle:@"My Position" andLocation:nil];

    self.locationManager = [[CLLocationManager alloc] init];
    self.locationDelegate = [[BSLocationManagerDelegate alloc] init];
    self.locationManager.delegate = self.locationDelegate;
    self.distanceFormatter = [[MKDistanceFormatter alloc] init];
    self.distanceFormatter.units = MKDistanceFormatterUnitsMetric;

    self.arrayDataSource = [[ArrayDataSource alloc] initWithItems:@[@"latitude", @"longitude", @"altitude", @"floor", @"horizontalAccuracy", @"verticalAccuracy", @"timestamp", @"description", @"distanceToAlarm"] cellIdentifier:@"BSGeolocAlarmViewCell" configureCellBlock:^(id cell, id item) {
        UITableViewCell *myCell = (UITableViewCell *)cell;
        NSString *fieldName = (NSString *)item;

        myCell.textLabel.text = fieldName;
        if ([fieldName isEqualToString:@"latitude"]) {
            myCell.detailTextLabel.text = [NSString stringWithFormat:@"%f", self.locationDelegate.mostRecentLocation.coordinate.latitude];
        } else if ([fieldName isEqualToString:@"longitude"]) {
            myCell.detailTextLabel.text = [NSString stringWithFormat:@"%f", self.locationDelegate.mostRecentLocation.coordinate.longitude];
        } else if ([fieldName isEqualToString:@"altitude"]) {
            myCell.detailTextLabel.text = [NSString stringWithFormat:@"%.02f m (min: %.02f, max: %.02f)", self.locationDelegate.mostRecentLocation.altitude, self.minAltitude, self.maxAltitude];
        } else if ([fieldName isEqualToString:@"floor"]) {
            myCell.detailTextLabel.text = [NSString stringWithFormat:@"%ld", self.locationDelegate.mostRecentLocation.floor.level];
        } else if ([fieldName isEqualToString:@"horizontalAccuracy"]) {
            myCell.detailTextLabel.text = [NSString stringWithFormat:@"%f", self.locationDelegate.mostRecentLocation.horizontalAccuracy];
        } else if ([fieldName isEqualToString:@"verticalAccuracy"]) {
            myCell.detailTextLabel.text = [NSString stringWithFormat:@"%f", self.locationDelegate.mostRecentLocation.verticalAccuracy];
        } else if ([fieldName isEqualToString:@"timestamp"]) {
            myCell.detailTextLabel.text = [NSString stringWithFormat:@"%@", self.locationDelegate.mostRecentLocation.timestamp];
        } else if ([fieldName isEqualToString:@"description"]) {
            myCell.detailTextLabel.text = [NSString stringWithFormat:@"%@", self.locationDelegate.mostRecentLocation.description];
        } else if ([fieldName isEqualToString:@"distanceToAlarm"]) {
            if (self.targetLocation) {
                myCell.detailTextLabel.text = [NSString stringWithFormat:@"%@", [self.distanceFormatter stringFromDistance:self.lastDistance]];
            } else {
                myCell.detailTextLabel.text = @"Not set";
            }
        }
    }];
    self.locationDetailsTableView.dataSource = self.arrayDataSource;
}


- (IBAction)startGeolocation:(id)sender {
    CLAuthorizationStatus coreLocationAuthorizationStatus = [CLLocationManager authorizationStatus];
    if (coreLocationAuthorizationStatus == kCLAuthorizationStatusRestricted || coreLocationAuthorizationStatus == kCLAuthorizationStatusDenied) {
        NSLog(@"CL's authorization doesn't permit the app to use geolocation");
    } else {
        if (coreLocationAuthorizationStatus == kCLAuthorizationStatusNotDetermined) {
            [self.locationManager requestWhenInUseAuthorization];
        }

        NSLog(@"coreLocationAuthorizationStatus: %d", coreLocationAuthorizationStatus);
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        self.locationManager.distanceFilter = kCLDistanceFilterNone;
        NSLog(@"Starting to update location");

        [self.locationManager startUpdatingLocation];
    }
}


- (void)viewWillAppear:(BOOL)animated {
    [self.locationDelegate addObserver:self forKeyPath:@"mostRecentLocation" options:NSKeyValueObservingOptionNew context:nil];
}


- (void)viewWillDisappear:(BOOL)animated {
    [self.locationDelegate removeObserver:self forKeyPath:@"mostRecentLocation"];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    NSLog(@"Notification");
    [self updateViews];
}


- (void)updateViews {
    // Updating location on the map
    // - When we got a location for the first time
    // - or whenever we get an update, if the target location was set (otherwise it's going to
    // annoy the user if he moves the map to reach his target
    if (self.locationDelegate.mostRecentLocation && (!self.didZoomAtStartup || self.targetLocation)) {
        NSLog(@"Updating map on current's location");
        [self.mostRecentLocationAnnotation setCoordinate:self.locationDelegate.mostRecentLocation.coordinate];
        
        if (!self.didZoomAtStartup) {
            // It's the first time we know our position
            //[self.mapView addAnnotation:self.mostRecentLocationAnnotation];
            self.didZoomAtStartup = YES;
        }
        
        //[self.mapView setRegion:MKCoordinateRegionMake(self.locationDelegate.mostRecentLocation.coordinate, MKCoordinateSpanMake(0.01, 0.01)) animated:YES];
    }
    
    // We also want to update the distance if the target was set
    if (self.locationDelegate.mostRecentLocation) {
        if (self.locationDelegate.mostRecentLocation.altitude < self.minAltitude) {
            self.minAltitude = self.locationDelegate.mostRecentLocation.altitude;
        }

        if (self.locationDelegate.mostRecentLocation.altitude > self.maxAltitude) {
            self.maxAltitude = self.locationDelegate.mostRecentLocation.altitude;
        }

        if (self.targetLocation) {
        self.lastDistance = [self.locationDelegate.mostRecentLocation distanceFromLocation:self.targetLocation];

        if (self.lastDistance < 25000 && !self.didAlarmRing) {
            NSLog(@"LOCAL NOTIFICATION");
            UILocalNotification *notification = [[UILocalNotification alloc] init];
            notification.fireDate = [NSDate date];
            notification.alertBody = @"Wake up!";
            notification.alertAction = @"We're here";
            [[UIApplication sharedApplication] presentLocalNotificationNow:notification];
            self.didAlarmRing = YES;
        }
        }
    }

    [self.locationDetailsTableView reloadData];
}


- (IBAction)registerAlarm:(id)sender {
    CLLocationCoordinate2D alarmPosition = self.mapView.centerCoordinate;
    self.targetLocation = [[CLLocation alloc] initWithLatitude:alarmPosition.latitude longitude:alarmPosition.longitude];
    [self updateViews];
    self.startGeolocationButton.enabled = NO;
    [self.targetLocationAnnotation setCoordinate:alarmPosition];
    [self.mapView addAnnotation:self.targetLocationAnnotation];
}


- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskPortrait;
}


@end
