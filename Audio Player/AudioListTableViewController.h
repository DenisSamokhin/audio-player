//
//  AudioListTableViewController.h
//  Audio Player
//
//  Created by Denis on 3/19/16.
//  Copyright © 2016 ITLions. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AudioListTableViewCell.h"
#import "DownloadedAudioListTableViewCell.h"

@interface AudioListTableViewController : UITableViewController <DownloaderDelegate> {
    NSMutableArray *tableViewDataSource;
    __weak IBOutlet UISegmentedControl *segmentControl;
    IBOutlet UITableView *listTableView;
    NSMutableArray *downloadedAudioListArray;
    DownloadQueue *dq;
}

- (IBAction)segmentControlValueChanged:(id)sender;
- (IBAction)downloadButtonClicked:(id)sender;

@end
