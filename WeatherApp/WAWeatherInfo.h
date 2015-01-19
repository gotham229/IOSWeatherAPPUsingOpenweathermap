//
//  WAWeatherInfo.h
//  WeatherApp
//
//  Created by Gowtham Parvataneni on 1/18/15.
//  Copyright (c) 2015 Gowtham Parvataneni. All rights reserved.
//

#import <Foundation/Foundation.h>
@class RKObjectMapping;

@interface WAWeatherInfo : NSObject

@property(nonatomic, copy) NSString *mainDesription;
@property(nonatomic, copy) NSString *longDescription;

+ (RKObjectMapping *)mappingObject;

@end
