//
//  WAWeatherInfo.m
//  WeatherApp
//
//  Created by Gowtham Parvataneni on 1/18/15.
//  Copyright (c) 2015 Gowtham Parvataneni. All rights reserved.
//

#import "WAWeatherInfo.h"
#import "Restkit.h"

@implementation WAWeatherInfo

+ (RKObjectMapping *)mappingObject {
    RKObjectMapping *mapping = [RKObjectMapping mappingForClass:self.class];
    NSDictionary *selfMappings = @{ @"main" : @"mainDesription",
                                    @"description" : @"longDescription",};
    [mapping addAttributeMappingsFromDictionary:selfMappings];
    return mapping;
}


@end
