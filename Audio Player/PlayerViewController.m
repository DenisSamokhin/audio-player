//
//  PlayerViewController.m
//  Audio Player
//
//  Created by Denis on 3/23/16.
//  Copyright © 2016 ITLions. All rights reserved.
//

#import "PlayerViewController.h"

@interface PlayerViewController ()

@end

@implementation PlayerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = self.selectedAudio.title;
    // Do any additional setup after loading the view.
    NSString *path = [NSString stringWithFormat:@"%@/HU-levitate.mp3",[[NSBundle mainBundle] resourcePath]];
    NSURL *url = [NSURL fileURLWithPath:path];
    NSError *error = nil;
    player = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:&error];
    if (error) {
        NSLog(@"%@", error);
    }
    
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self updateControls];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [player pause];
    [self stopTimer];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag {
    [playPauseButton setTitle:@"Play" forState:UIControlStateNormal];
    [self stopTimer];
}

- (IBAction)playPauseButtonClicked:(id)sender {
    if (player.playing) {
        [player pause];
        [playPauseButton setTitle:@"Play" forState:UIControlStateNormal];
        [self stopTimer];
    }else {
        [player play];
        [playPauseButton setTitle:@"Pause" forState:UIControlStateNormal];
        [self startTimer];
    }
}

- (IBAction)volumeSliderDidChangeValue:(UISlider *)sender {
    player.volume = volumeSlider.value;
}

- (IBAction)durationSliderDidChangeValue:(UISlider *)sender {
    if ([player isPlaying]) {
        [player playAtTime:player.duration * durationSlider.value];
    }else {
        
    }
    currentTimePositionLabel.text = [self convertTimeIntervalToString:player.currentTime];
    
}

- (void)updateControls {
    totalDurationLabel.text = [self convertTimeIntervalToString:player.duration];
    currentTimePositionLabel.text = [self convertTimeIntervalToString:player.currentTime];
    volumeSlider.value = player.volume;
    [self updateDurationSlider];
}

- (NSString *)convertTimeIntervalToString:(NSTimeInterval)timeInterval {
    // Convert from NSTimeInterval to e.g. "2:32:00"
    long seconds = lroundf(timeInterval); // Since modulo operator (%) below needs int or long
    int hour = seconds / 3600;
    int mins = (seconds % 3600) / 60;
    int secs = seconds % 60;
    NSString *resultString;
    if (hour == 0) {
        resultString = [NSString stringWithFormat:@"%d:%0.2d", mins, secs];
    }else {
        resultString = [NSString stringWithFormat:@"%d:%0.2d:%0.2d", hour, mins, secs];
    }
    return resultString;
}

- (void)startTimer {
    timer = [NSTimer scheduledTimerWithTimeInterval:1.0
                                             target:self
                                           selector:@selector(updateDurationSlider)
                                           userInfo:nil
                                            repeats:YES];
}

- (void)stopTimer {
    [timer invalidate];
}

- (void)updateDurationSlider {
    durationSlider.value = player.currentTime / player.duration;
    currentTimePositionLabel.text = [self convertTimeIntervalToString:player.currentTime];
}

@end
