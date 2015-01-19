//
//  WACityInfo.m
//  WeatherApp
//
//  Created by Gowtham Parvataneni on 1/18/15.
//  Copyright (c) 2015 Gowtham Parvataneni. All rights reserved.
//

#import "WACityInfo.h"

@implementation WACityInfo


+(instancetype)cityInfoWithCity:(NSString *)city country:(NSString *)country {
    WACityInfo *cityInfo = [WACityInfo new];
    cityInfo.city = city;
    cityInfo.country = country;
    return cityInfo;
}

@end
