//
//  WACitiesData.h
//  WeatherApp
//
//  Created by Gowtham Parvataneni on 1/18/15.
//  Copyright (c) 2015 Gowtham Parvataneni. All rights reserved.
//

#import <Foundation/Foundation.h>

@class WACityInfo;
@interface WACitiesData : NSObject

+(instancetype)sharedObject;

-(NSArray *)cityInfoForCity:(NSString *)city;

@end
