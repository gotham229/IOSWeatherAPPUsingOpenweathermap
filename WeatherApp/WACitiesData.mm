//
//  WACitiesData.m
//  WeatherApp
//
//  Created by Gowtham Parvataneni on 1/18/15.
//  Copyright (c) 2015 Gowtham Parvataneni. All rights reserved.
//

#import "WACitiesData.h"
#import "WACityInfo.h"
#include <vector>
#include <iostream>
#include <fstream>
#include <sstream>

@interface WACitiesData()

@property(nonatomic, copy) NSArray *worldCities;

@end

@implementation WACitiesData

+(instancetype)sharedObject {
    static dispatch_once_t onceToken;
    static WACitiesData *sharedInstance = nil;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
        sharedInstance.worldCities = loadCSVfile();
    });
    
    return sharedInstance;
}

-(NSArray *)cityInfoForCity:(NSString *)city {
    NSPredicate *bPredicate = [NSPredicate predicateWithFormat:@"SELF.city contains[cd] %@",city];
    return  [self.worldCities filteredArrayUsingPredicate:bPredicate];
}

NSString * stringByReplacingQuotes(NSString *string) {
    NSCharacterSet *chars = [NSCharacterSet characterSetWithCharactersInString:@"\""];
    return [[string componentsSeparatedByCharactersInSet: chars] componentsJoinedByString: @""];
}


NSArray * loadCSVfile() {
    using namespace std;
    
    NSMutableArray *records = [NSMutableArray new];
    
    NSString *csvFile = [[NSBundle mainBundle] pathForResource:@"World_Cities_Location_table" ofType:@"csv"];
    ifstream input([csvFile cStringUsingEncoding:NSUTF8StringEncoding]);
    char const row_delim = '\n';
    char const field_delim = ';';
    
    string row;
    
    for (string row; getline(input, row, row_delim); ) {
        @autoreleasepool {
            std::istringstream ss(row);
            
            string field;
            std::vector<string> vect;
            for (string field; getline(ss, field, field_delim); ) {
                vect.push_back(field);
            }
            
            if (vect.size() > 3) {
                NSString *city = [NSString stringWithCString:vect.at(2).c_str()
                                                    encoding:[NSString defaultCStringEncoding]];
                NSString *country = [NSString stringWithCString:vect.at(1).c_str()
                                                       encoding:[NSString defaultCStringEncoding]];
                [records addObject:[WACityInfo cityInfoWithCity:stringByReplacingQuotes(city) country:stringByReplacingQuotes(country)]];
            }
        }
    }
    
    return records;
}

@end
