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

- (void)registerVkSDK {
    VKSdk *sdkInstance = [VKSdk initializeWithAppId:VKAPPID];
    [sdkInstance registerDelegate:self];
    [sdkInstance setUiDelegate:self];
}

- (void)authorize {
    NSArray *SCOPE = @[@"friends", @"email", @"audio"];
    [VKSdk authorize:SCOPE];
}

- (void)checkPreviousSession {
    NSArray *SCOPE = @[@"friends", @"email", @"audio"];
    
    [VKSdk wakeUpSession:SCOPE completeBlock:^(VKAuthorizationState state, NSError *error) {
        if (state == VKAuthorizationAuthorized) {
            // Authorized and ready to go
        } else if (error) {
            [self authorize];
        }
    }];
}

#pragma mark - VKSDK delegate

- (void)vkSdkAccessAuthorizationFinishedWithResult:(VKAuthorizationResult *)result {
    
}

- (void)vkSdkUserAuthorizationFailed {
    
}

- (void)vkSdkShouldPresentViewController:(UIViewController *)controller {
    [self presentViewController:controller animated:YES completion:nil];
}

- (void)vkSdkNeedCaptchaEnter:(VKError *)captchaError {
    
}

@end
