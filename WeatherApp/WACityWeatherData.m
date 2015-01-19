//
//  WACityWeatherData.m
//  WeatherApp
//
//  Created by Gowtham Parvataneni on 1/18/15.
//  Copyright (c) 2015 Gowtham Parvataneni. All rights reserved.
//

#import "WACityWeatherData.h"
#import "Restkit.h"
#import "WAWeatherInfo.h"


@implementation WACityWeatherData

+ (RKObjectMapping *)mappingObject {
    RKObjectMapping *mapping = [RKObjectMapping mappingForClass:self.class];
    NSDictionary *selfMappings = @{ @"coord.lat" : @"lattitude",
                                          @"coord.lon" : @"longitude",
                                          @"main.temp" : @"temperature",
                                          @"main.temp_min" : @"lowTemperature",
                                          @"main.temp_max" : @"highTemperature",
                                          @"main.humidity" : @"humidity",
                                          @"dt" : @"date",
                                          @"name" : @"cityName",
                                          };
    
    
    
    [mapping addAttributeMappingsFromDictionary:selfMappings];
    [mapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"weather" toKeyPath:@"weatherInfo" withMapping:[WAWeatherInfo mappingObject]]];

    
    return mapping;
}

+(RKResponseDescriptor *)responseDescriptor {
    return [RKResponseDescriptor responseDescriptorWithMapping:[WACityWeatherData mappingObject] method:RKRequestMethodGET pathPattern:nil keyPath:nil statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
}


@end
