//
//  HelloViewController.m
//  Audio Player
//
//  Created by Denis on 3/18/16.
//  Copyright © 2016 ITLions. All rights reserved.
//

#import "HelloViewController.h"

@interface HelloViewController ()

@end

@implementation HelloViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    spinner = [[FeEqualize alloc] initWithView:self.view title:@"Loading"];
    [self.view addSubview:spinner];
    [spinner show];
    [self registerVkSDK];
    [self checkPreviousSession];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)buttonClicked:(id)sender {
    [self authorize];
}

- (IBAction)continueButtonClicked:(id)sender {
}

- (IBAction)logoutButtonClicked:(id)sender {
    [VKSdk forceLogout];
    [UIView animateWithDuration:1 animations:^{
        vkAuthView.alpha = 1;
        authorizedView.alpha = 0;
        vkAuthView.hidden = NO;
        authorizedView.hidden = YES;
    }];
}

- (void)registerVkSDK {
    VKSdk *sdkInstance = [VKSdk initializeWithAppId:VKAPPID];
    [sdkInstance registerDelegate:self];
    [sdkInstance setUiDelegate:self];
}

- (void)authorize {
    NSArray *SCOPE = @[@"friends", @"email", @"audio"];
    [VKSdk authorize:SCOPE];
}

- (void)getVKUserInfo {
    VKRequest *request = [[VKApi users] get];
    request.attempts = 5;
    [AppDelegate showStatusBarActivityIndicator];
    [request executeWithResultBlock:^(VKResponse *response) {
        [AppDelegate hideStatusBarActivityIndicator];
        NSLog(@"Json result: %@", response.json);
        VKUser *u = [response.parsedModel firstObject];
        [AppDelegate saveUserID:[u.id stringValue]];
        [AppDelegate saveUserFirstName:u.first_name];
        [AppDelegate saveUserLastName:u.last_name];
        [self getUsersPhoto];
    } errorBlock:^(NSError * error) {
        [AppDelegate hideStatusBarActivityIndicator];
        if (error.code != VK_API_ERROR) {
            [error.vkError.request repeat];
        } else {
            NSLog(@"VK error: %@", error);
        }
    }];
}

- (void)getUsersPhoto {
    User *user = [AppDelegate getUserInfo];
    VKRequest *request = [[VKApi users] get:@{@"user_ids":user.userID,@"fields":@"photo_200_orig"}];
    request.attempts = 5;
    [AppDelegate showStatusBarActivityIndicator];
    [request executeWithResultBlock:^(VKResponse *response) {
        [AppDelegate hideStatusBarActivityIndicator];
        NSLog(@"Json result: %@", response.json);
        VKUser *u = [response.parsedModel firstObject];
        [self downloadImage:u.photo_200_orig];
        [UIView animateWithDuration:1 animations:^{
            [self updateAuthorizedView];
            [spinner dismiss];
            [spinner removeFromSuperview];
            vkAuthView.alpha = 0;
            authorizedView.alpha = 1;
            vkAuthView.hidden = YES;
            authorizedView.hidden = NO;
        }];
    } errorBlock:^(NSError * error) {
        [AppDelegate hideStatusBarActivityIndicator];
        if (error.code != VK_API_ERROR) {
            [error.vkError.request repeat];
        } else {
            NSLog(@"VK error: %@", error);
        }
    }];
}

- (void)downloadImage:(NSString *)imageURL {
    UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:imageURL]]];
    if (image) {
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsPath = [paths objectAtIndex:0];
        NSData *imageData = UIImageJPEGRepresentation(image, 1);
        NSString *imageName = [NSString stringWithFormat:@"user_id%@_avatar.jpg", [AppDelegate getUserInfo].userID];
        NSString *imagePath = [documentsPath stringByAppendingPathComponent:imageName];
        [imageData writeToFile:imagePath atomically:YES];
        UIImage *imageNew = [UIImage imageWithContentsOfFile:imagePath];
        [AppDelegate saveUserPhotoImage:imageName];
        userPhotoImageView.image = image;
    }else {
        // Set default "No Icon" image
    }
    
    
}

- (void)updateAuthorizedView {
    User *user = [AppDelegate getUserInfo];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsPath = [paths objectAtIndex:0];
    NSString *imagePath = [documentsPath stringByAppendingPathComponent:user.photo_200_image_path];
    UIImage *image = [UIImage imageWithContentsOfFile:imagePath];
    userPhotoImageView.image = image;
    userFullNameLabel.text = [NSString stringWithFormat:@"%@ %@", user.firstName, user.lastName];
}

- (void)checkPreviousSession {
    NSArray *SCOPE = @[@"friends", @"email", @"audio"];
    [AppDelegate showStatusBarActivityIndicator];
    [VKSdk wakeUpSession:SCOPE completeBlock:^(VKAuthorizationState state, NSError *error) {
        [AppDelegate hideStatusBarActivityIndicator];
        if (state == VKAuthorizationAuthorized) {
            if ([AppDelegate getUserInfo].userID) {
                [UIView animateWithDuration:1 animations:^{
                    [self updateAuthorizedView];
                    [spinner dismiss];
                    [spinner removeFromSuperview];
                    vkAuthView.alpha = 0;
                    authorizedView.alpha = 1;
                    vkAuthView.hidden = YES;
                    authorizedView.hidden = NO;
                }];
            }else {
              [self getVKUserInfo];
            }
        } else if (error) {
            [UIView animateWithDuration:1 animations:^{
                [spinner dismiss];
                [spinner removeFromSuperview];
                vkAuthView.alpha = 1;
                authorizedView.alpha = 0;
                vkAuthView.hidden = NO;
                authorizedView.hidden = YES;
            }];
            [self authorize];
        }else if (state == VKAuthorizationInitialized) {
            [UIView animateWithDuration:1 animations:^{
                [spinner dismiss];
                [spinner removeFromSuperview];
                vkAuthView.alpha = 1;
                authorizedView.alpha = 0;
                vkAuthView.hidden = NO;
                authorizedView.hidden = YES;
            }];
        }
    }];
}

#pragma mark - VKSDK delegate

- (void)vkSdkAccessAuthorizationFinishedWithResult:(VKAuthorizationResult *)result {
    if (result.state != VKAuthorizationUnknown && result.state != VKAuthorizationError) {
        [self getVKUserInfo];
    }
}

- (void)vkSdkUserAuthorizationFailed {
    
}

- (void)vkSdkShouldPresentViewController:(UIViewController *)controller {
    [self presentViewController:controller animated:YES completion:nil];
}

- (void)vkSdkNeedCaptchaEnter:(VKError *)captchaError {
    
}

@end
