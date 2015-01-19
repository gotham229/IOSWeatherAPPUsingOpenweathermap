//
//  AppDelegate.m
//  WeatherApp
//
//  Created by Gowtham Parvataneni on 1/18/15.
//  Copyright (c) 2015 Gowtham Parvataneni. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"

@interface AppDelegate ()
@property(nonatomic, strong)UIWindow *mainWindow;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.mainWindow = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    ViewController *mainController = [[ViewController alloc] init];
    mainController.view.frame = self.mainWindow.frame;
    
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:mainController];
    navigationController.navigationBar.translucent = NO;

    self.mainWindow.rootViewController = navigationController;
    [self.mainWindow makeKeyAndVisible];
    return YES;
}

@end
