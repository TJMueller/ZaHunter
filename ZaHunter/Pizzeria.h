//
//  Pizzeria.h
//  ZaHunter
//
//  Created by Timothy Mueller on 3/25/15.
//  Copyright (c) 2015 Timothy Mueller. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@protocol PizzeriaDelegate <NSObject>

@optional

-(void)gotUserLocation:(NSArray *)pizzerias;

@end


@interface Pizzeria : NSObject

@property (nonatomic, assign) id <PizzeriaDelegate> delegate;

@property NSArray *pizzeriasArray;

-(void)getUserLocationAndReverseGeocode:(CLLocation *)location;

@end
