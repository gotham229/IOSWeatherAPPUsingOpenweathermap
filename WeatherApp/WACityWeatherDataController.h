//
//  WACityWeatherDataController.h
//  WeatherApp
//
//  Created by Gowtham Parvataneni on 1/18/15.
//  Copyright (c) 2015 Gowtham Parvataneni. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WACityInfo;
@interface WACityWeatherDataController : UIViewController

@property(nonatomic, weak) IBOutlet UILabel *mainTitleLabel;
@property(nonatomic, weak) IBOutlet UILabel *currentTempLabel;
@property(nonatomic, weak) IBOutlet UILabel *highTempLabel;
@property(nonatomic, weak) IBOutlet UILabel *lowTempLabel;
@property(nonatomic, weak) IBOutlet UIActivityIndicatorView *activityIndicatorView;

- (instancetype)initWithCityInfo:(WACityInfo *)cityInfo;

@end
