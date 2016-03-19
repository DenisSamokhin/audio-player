//
//  AppDelegate.h
//  Audio Player
//
//  Created by Denis on 3/18/16.
//  Copyright © 2016 ITLions. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

+ (void)saveUserID:(NSString *)userID;
+ (void)saveUserToken:(NSString *)token;
+ (void)saveUserFirstName:(NSString *)firstName;
+ (void)saveUserLastName:(NSString *)lastName;
+ (void)saveUserPhotoImage:(NSString *)filePath;
+ (User *)getUserInfo;
+ (void)showStatusBarActivityIndicator;
+ (void)hideStatusBarActivityIndicator;

@end

