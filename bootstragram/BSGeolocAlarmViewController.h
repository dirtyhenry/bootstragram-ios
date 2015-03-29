//
//  BSGeolocAlarmViewController.h
//  bootstragram
//
//  Created by Mickaël Floc'hlay on 27/11/2013.
//  Copyright (c) 2013 Bootstragram. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <Mapbox-iOS-SDK/Mapbox.h>


@interface BSGeolocAlarmViewController : UIViewController

@property (weak, nonatomic) IBOutlet RMMapView *mapView;
@property (weak, nonatomic) IBOutlet UIButton *startGeolocAlarmButton;
@property (weak, nonatomic) IBOutlet UIButton *startGeolocationButton;
@property (weak, nonatomic) IBOutlet UITableView *locationDetailsTableView;

- (IBAction)registerAlarm:(id)sender;
- (IBAction)startGeolocation:(id)sender;

@end
