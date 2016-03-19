//
//  HelloViewController.h
//  Audio Player
//
//  Created by Denis on 3/18/16.
//  Copyright © 2016 ITLions. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HelloViewController : UIViewController <VKSdkDelegate, VKSdkUIDelegate> {
    
    __weak IBOutlet UILabel *label;
    __weak IBOutlet UIButton *button;
    __weak IBOutlet UIView *vkAuthView;
    __weak IBOutlet UIView *authorizedView;
    __weak IBOutlet UIImageView *userPhotoImageView;
    __weak IBOutlet UILabel *userFullNameLabel;
    __weak IBOutlet UIButton *continueButton;
    __weak IBOutlet UIButton *logoutButton;
    FeEqualize *spinner;
}

- (IBAction)buttonClicked:(id)sender;
- (IBAction)continueButtonClicked:(id)sender;
- (IBAction)logoutButtonClicked:(id)sender;

@end
