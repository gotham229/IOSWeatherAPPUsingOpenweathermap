//
//  WACityWeatherData.h
//  WeatherApp
//
//  Created by Gowtham Parvataneni on 1/18/15.
//  Copyright (c) 2015 Gowtham Parvataneni. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Restkit.h"
@interface WACityWeatherData : NSObject

@property(nonatomic, copy) NSString *lattitude;
@property(nonatomic, copy) NSString *longitude;
@property(nonatomic, copy) NSArray *weatherInfo;
@property(nonatomic, copy) NSNumber *temperature;
@property(nonatomic, copy) NSNumber *lowTemperature;
@property(nonatomic, copy) NSNumber *highTemperature;
@property(nonatomic, copy) NSNumber *humidity;
@property(nonatomic, strong) NSDate *date;
@property(nonatomic, copy) NSString *cityName;


+(RKResponseDescriptor *)responseDescriptor;

@end
