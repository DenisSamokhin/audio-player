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
}

- (IBAction)buttonClicked:(id)sender;

@end
