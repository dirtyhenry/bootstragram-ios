//
//  BSGeolocAlarmViewController.h
//  bootstragram
//
//  Created by Mickaël Floc'hlay on 27/11/2013.
//  Copyright (c) 2013 Bootstragram. All rights reserved.
//

@import UIKit;
@import MapKit;

@interface BSGeolocAlarmViewController : UIViewController

@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (weak, nonatomic) IBOutlet UIButton *startGeolocAlarmButton;
@property (weak, nonatomic) IBOutlet UIButton *startGeolocationButton;
@property (weak, nonatomic) IBOutlet UITableView *locationDetailsTableView;

- (IBAction)registerAlarm:(id)sender;
- (IBAction)startGeolocation:(id)sender;

@end
