//
//  AppDelegate.m
//  SoapBox
//
//  Created by Josh Stern on 9/21/13.
//  Copyright (c) 2013 Josh. All rights reserved.
//

#import "AppDelegate.h"

#import "MasterViewController.h"
#import "MapViewController.h"
#import "MainMenuViewController.h"
#import "ViewController.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    //parse stuff
    [Parse setApplicationId:@"O2JrkM3f26Qa3otfbrtDHTnYlPDLptOvN76HAgEn"
                  clientKey:@"1G7S10E6ZAHg9lqDN2fjXum0rwnCEjpDZ34Hs69o"];
    [PFAnalytics trackAppOpenedWithLaunchOptions:launchOptions];
    
    //FB STUFF
    [PFFacebookUtils initializeFacebook];
    MasterViewController *master = [[MasterViewController alloc] init];
    [self.window setRootViewController:master];
  
  // main menu view controller
    MainMenuViewController *menu = [[MainMenuViewController alloc] init];

    UINavigationController *dummyTableNav = [[UINavigationController alloc] initWithRootViewController:menu];
    dummyTableNav.navigationBar.translucent = NO;
    [dummyTableNav.navigationItem setTitle:@"SoapBox"];
    master.parentController = dummyTableNav;
  
  // map view controller.
    MapViewController *map = [[MapViewController alloc] init];
    UINavigationController *mapNav = [[UINavigationController alloc] initWithRootViewController:map];
    mapNav.navigationBar.translucent = NO;
    master.childController = mapNav;
  
//    [[UINavigationBar appearance] setBarTintColor:[UIColor colorWithRed:19.0/255 green:19.0/255 blue:19.0/255 alpha:1.0]];
    [[UINavigationBar appearance] setBarTintColor:[UIColor colorWithRed:19.0/255 green:19.0/255 blue:19.0/255 alpha:1.0]];

  
    [self.window makeKeyAndVisible];
    
    // Override point for customization after application launch.
    return YES;
}

// for parse
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    
    return [PFFacebookUtils handleOpenURL:url];
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
