//
//  PlayerViewController.h
//  Audio Player
//
//  Created by Denis on 3/23/16.
//  Copyright © 2016 ITLions. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@interface PlayerViewController : UIViewController <AVAudioPlayerDelegate>{
    
    __weak IBOutlet UIView *audioIconView;
    __weak IBOutlet UIView *controlsView;
    __weak IBOutlet UIButton *playPauseButton;
    AVAudioPlayer *player;
    __weak IBOutlet UISlider *durationSlider;
    
    __weak IBOutlet UISlider *volumeSlider;
    __weak IBOutlet UILabel *currentTimePositionLabel;
    __weak IBOutlet UILabel *totalDurationLabel;
    NSTimer *timer;
}

@property (nonatomic, strong) Audio *selectedAudio;

- (IBAction)playPauseButtonClicked:(id)sender;
- (IBAction)volumeSliderDidChangeValue:(UISlider *)sender;
- (IBAction)durationSliderDidChangeValue:(UISlider *)sender;

@end
