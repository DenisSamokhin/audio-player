//
//  AppDelegate.m
//  Audio Player
//
//  Created by Denis on 3/18/16.
//  Copyright © 2016 ITLions. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    return YES;
}

- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString *,id> *)options {
    [VKSdk processOpenURL:url fromApplication:options[UIApplicationOpenURLOptionsSourceApplicationKey]];
    return YES;
}

-(BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    [VKSdk processOpenURL:url fromApplication:sourceApplication];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void)wtf {
    
}

// Public methods

+ (void)saveUserID:(NSString *)userID {
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    [ud setObject:userID forKey:UserIDKey];
    [ud synchronize];
}

+ (void)saveUserToken:(NSString *)token {
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    [ud setObject:token forKey:UserTokenKey];
    [ud synchronize];
}

+ (void)saveUserFirstName:(NSString *)firstName {
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    [ud setObject:firstName forKey:UserFirstNameKey];
    [ud synchronize];
}

+ (void)saveUserLastName:(NSString *)lastName {
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    [ud setObject:lastName forKey:UserLastNameKey];
    [ud synchronize];
}

+ (void)saveUserPhotoImage:(NSString *)filePath {
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    [ud setObject:filePath forKey:UserPhotoKey];
    [ud synchronize];
}

+ (User *)getUserInfo {
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    User *user = [[User alloc] init];
    user.userID = [ud objectForKey:UserIDKey];
    user.firstName = [ud objectForKey:UserFirstNameKey];
    user.lastName = [ud objectForKey:UserLastNameKey];
    user.token = [ud objectForKey:UserTokenKey];
    user.photo_200_image_path = [ud objectForKey:UserPhotoKey];
    return user;
}

+ (void)showStatusBarActivityIndicator {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
}

+ (void)hideStatusBarActivityIndicator {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}

@end
