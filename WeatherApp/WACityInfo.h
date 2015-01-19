//
//  WACityInfo.h
//  WeatherApp
//
//  Created by Gowtham Parvataneni on 1/18/15.
//  Copyright (c) 2015 Gowtham Parvataneni. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WACityInfo : NSObject

@property(nonatomic, copy) NSString *city;
@property(nonatomic, copy) NSString *country;

+(instancetype)cityInfoWithCity:(NSString *)city country:(NSString *)country;

@end
