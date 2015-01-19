//
//  WACityWeatherDataController.m
//  WeatherApp
//
//  Created by Gowtham Parvataneni on 1/18/15.
//  Copyright (c) 2015 Gowtham Parvataneni. All rights reserved.
//

#import "WACityWeatherDataController.h"
#import "WACityInfo.h"
#import "WAAPIObjectManager.h"
#import "WACityWeatherData.h"
#import "WAWeatherInfo.h"

@interface WACityWeatherDataController ()
@property(nonatomic, strong)WACityInfo *cityInfo;
@property(nonatomic, strong)WACityWeatherData *weatherData;
@property(nonatomic, strong)RKObjectRequestOperation *requestOperation;

@end

@implementation WACityWeatherDataController

- (instancetype)initWithCityInfo:(WACityInfo *)cityInfo {
    if (self = [super init]) {
        self.cityInfo = cityInfo;
        
        [self fetchWeatherInfo];
    }
    return self;
}

- (void)dealloc {
    [self.requestOperation cancel];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationController.navigationBar.translucent = NO;
    self.title = [self locationString];
    
    self.currentTempLabel.text = nil;
    self.highTempLabel.text = nil;
    self.lowTempLabel.text = nil;
    [self.activityIndicatorView startAnimating];
}

- (void)fetchWeatherInfo {
    [[WAAPIObjectManager sharedObjectManager] getWeatherDataForLocation:[self locationString] success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
        self.weatherData = mappingResult.firstObject;
        [self updateUI];
    } failure:^(RKObjectRequestOperation *operation, NSError *error) {
        [self updateUI];
    }];
}

- (void)updateUI {
    WAWeatherInfo *weatherInfo = [self.weatherData.weatherInfo firstObject];
    if (weatherInfo) {
        self.currentTempLabel.text = [self.weatherData.temperature stringValue];
        self.highTempLabel.text = [self.weatherData.highTemperature stringValue];;
        self.lowTempLabel.text = [self.weatherData.lowTemperature stringValue];;
        self.mainTitleLabel.text = weatherInfo.longDescription;
        [self.activityIndicatorView stopAnimating];
        self.activityIndicatorView.hidden = YES;
    } else {
        self.mainTitleLabel.text = @"Weather Info not Available";
    }
    
}

- (NSString *)locationString {
    return [NSString stringWithFormat:@"%@, %@", self.cityInfo.city, self.cityInfo.country];
}

@end
