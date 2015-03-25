//
//  ViewController.m
//  ZaHunter
//
//  Created by Timothy Mueller on 3/25/15.
//  Copyright (c) 2015 Timothy Mueller. All rights reserved.
//

#import "ViewController.h"
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import "Pizzeria.h"


@interface ViewController ()<CLLocationManagerDelegate,PizzeriaDelegate>
@property CLLocationManager *locationManager;
//@property CLLocation *currentLocation;
@property NSArray *pizzeriasArray;
@property NSMutableArray *pizzeriasNameArray;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.locationManager = [CLLocationManager new];
    [self.locationManager requestWhenInUseAuthorization];
    self.locationManager.delegate = self;
    [self.locationManager startUpdatingLocation];
    NSLog(@"view did load\n");
}

#pragma mark - Location Delegates

-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    NSLog(@"%@", error);
}

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations{
    NSLog(@"locations manager before for loop \n");
    for (CLLocation *location in locations) {
        if (location.horizontalAccuracy < 1000 && location.verticalAccuracy < 1000) {
                        NSLog(@"location accuracy confirmed");
            [self.locationManager stopUpdatingLocation];
            //[self reverseGeocode:location];
            Pizzeria * p = [Pizzeria new];
            p.delegate = self;
//            self.currentLocation = location;
            [p getUserLocationAndReverseGeocode:location];
            break;
        }
    }
}

-(void)gotUserLocation:(NSArray *)pizzerias {
    self.pizzeriasArray = pizzerias;
    for (MKMapItem *mapItem in pizzerias) {
        [self.pizzeriasNameArray addObject:mapItem.name];
        NSLog(@"%@",mapItem.name);
    }
    NSLog(@"%lu",(unsigned long)self.pizzeriasArray.count);
}


@end
