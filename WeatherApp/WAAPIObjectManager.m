//
//  WAAPIObjectManager.m
//  WeatherApp
//
//  Created by Gowtham Parvataneni on 1/18/15.
//  Copyright (c) 2015 Gowtham Parvataneni. All rights reserved.
//

#import "WAAPIObjectManager.h"
#import "WACityWeatherData.h"

static NSString * const WAOpenWeatherMapApiKey = @"601d47eeee29e311d6ed5a5816fc21a7";

@implementation WAAPIObjectManager

+(instancetype)sharedObjectManager {
    static dispatch_once_t onceToken;
    static WAAPIObjectManager *sharedInstance = nil;
    dispatch_once(&onceToken, ^{

        sharedInstance = [[self alloc] initWithHTTPClient:[[AFHTTPClient alloc] initWithBaseURL:[NSURL URLWithString:@"http://api.openweathermap.org"]]];
    });
    
    return sharedInstance;
}

- (NSMutableURLRequest *)urlRequestWithPath:(NSString *)path params:(NSDictionary *)params {
    NSMutableString *requestString = [[NSMutableString alloc] initWithString:[NSString stringWithFormat:@"%@/%@", self.baseURL, path]];
    if (params.count) {
        [requestString appendString:@"?"];
    }
    
    [params enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        @autoreleasepool {
            NSString *escapedString = [(NSString *)obj stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            [requestString appendString:[NSString stringWithFormat:@"&%@=%@",(NSString *)key, escapedString]];
        }
    }];
    
    return [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:requestString]];
    
}

-(RKObjectRequestOperation *)getWeatherDataForLocation:(NSString *)location success:(WARequestSuccessCallbackBlock)successBlock failure:(WARequestFailureCallbackBlock)failureBlock {
    
    NSMutableURLRequest* URLRequest = [self urlRequestWithPath:@"data/2.5/weather" params:@{
                                                                                            @"q" : location,
                                                                                            @"units" : @"metric"
                                                                                            }];
    
    [URLRequest setValue:WAOpenWeatherMapApiKey forHTTPHeaderField:@"x-api-key"];
    
    RKObjectRequestOperation* request = [[RKObjectRequestOperation alloc] initWithRequest:URLRequest responseDescriptors:@[[WACityWeatherData responseDescriptor]]];
    
    [request setCompletionBlockWithSuccess:successBlock failure:failureBlock];
    [self enqueueObjectRequestOperation:request];
    return request;
}


@end
