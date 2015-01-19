//
//  WAAPIObjectManager.h
//  WeatherApp
//
//  Created by Gowtham Parvataneni on 1/18/15.
//  Copyright (c) 2015 Gowtham Parvataneni. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Restkit.h"

typedef void (^WARequestSuccessCallbackBlock)(RKObjectRequestOperation *operation, RKMappingResult *mappingResult);
typedef void (^WARequestFailureCallbackBlock)(RKObjectRequestOperation *operation, NSError *error);

@interface WAAPIObjectManager : RKObjectManager

+(instancetype)sharedObjectManager;

-(RKObjectRequestOperation *)getWeatherDataForLocation:(NSString *)location success:(WARequestSuccessCallbackBlock)successBlock failure:(WARequestFailureCallbackBlock)failureBlock;

@end
