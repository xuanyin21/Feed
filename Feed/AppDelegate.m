//
//  AppDelegate.m
//  Feed
//
//  Created by ACTON Software Develop on 3/29/18.
//  Copyright © 2018 Shawn Yin. All rights reserved.
//

#import "AppDelegate.h"
#import "FeedViewController.h"
#import "ArticleWebViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc] initWithFrame: [UIScreen mainScreen].bounds];
    
    FeedViewController *feedVC = [FeedViewController new];
    UINavigationController *rootVC = [[UINavigationController alloc] initWithRootViewController:feedVC];
    rootVC.navigationBar.barTintColor = [UIColor colorWithRed:54.0/255.0 green:126.0/255.0 blue:188.0/255.0 alpha:1];
    rootVC.navigationBar.translucent = NO;
    rootVC.navigationBar.tintColor = [UIColor whiteColor];
    self.window.rootViewController = rootVC;
    
    [self.window makeKeyAndVisible];
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
