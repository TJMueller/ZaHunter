//
//  Pizzeria.m
//  ZaHunter
//
//  Created by Timothy Mueller on 3/25/15.
//  Copyright (c) 2015 Timothy Mueller. All rights reserved.
//

#import "Pizzeria.h"
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>

@implementation Pizzeria




-(void)getUserLocationAndReverseGeocode:(CLLocation *)location{
    CLGeocoder *geoCoder = [CLGeocoder new];
    [geoCoder reverseGeocodeLocation:location completionHandler:^(NSArray *placemarks, NSError *error) {
        CLPlacemark *placemark = placemarks.firstObject;
        NSString *address = [NSString stringWithFormat:@"Your Location : %@ %@ %@",
                             placemark.subThoroughfare,
                             placemark.thoroughfare,
                             placemark.locality];
//        self.myTextView.text = [NSString stringWithFormat:@"%@", address];
        [self findPizzaNear:placemark.location];
    }];
}

-(void)findPizzaNear:(CLLocation *)location {
    MKLocalSearchRequest *request = [MKLocalSearchRequest new];
    request.naturalLanguageQuery = @"pizzeria";
    request.region = MKCoordinateRegionMake(location.coordinate, MKCoordinateSpanMake(1, 1));
    MKLocalSearch *search = [[MKLocalSearch alloc]initWithRequest:request];
    [search startWithCompletionHandler:^(MKLocalSearchResponse *response, NSError *error) {
        //self.pizzeriasArray = response.mapItems;
        
        [self.delegate gotUserLocation:response.mapItems];
        //MKMapItem *mapItem = response.mapItems.firstObject;
//        self.myTextView.text = [NSString stringWithFormat:@"%@\n \n you should go to %@",self.myTextView.text, mapItem.name];
        //[self getDirectionsTo:mapItem];
    }];

}

//-(void)getDirectionsTo:(MKMapItem *)destinationItem {
//    MKDirectionsRequest *request = [MKDirectionsRequest new];
//    request.source = [MKMapItem mapItemForCurrentLocation];
//    request.destination = destinationItem;
//    MKDirections *directions = [[MKDirections alloc]initWithRequest:request];
//    [directions calculateDirectionsWithCompletionHandler:^(MKDirectionsResponse *response, NSError *error) {
//        MKRoute *route = response.routes.firstObject;
//        NSMutableString *directionsString = [NSMutableString new];
//        int counter =1;
//
//        for (MKRouteStep *step in route.steps) {
//            NSLog(@"%@",step.instructions);
//            //self.myTextView.text = [NSString stringWithFormat:@"%@\n\n %@", self.myTextView.text, step.instructions];
//            [directionsString appendFormat:@"%d %@\n", counter, step.instructions];
//            counter ++;
//        }
////        self.myTextView.text = directionsString;
//    }];
//}




@end
