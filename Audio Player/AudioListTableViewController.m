//
//  AudioListTableViewController.m
//  Audio Player
//
//  Created by Denis on 3/19/16.
//  Copyright © 2016 ITLions. All rights reserved.
//

#import "AudioListTableViewController.h"

@interface AudioListTableViewController ()

@end

@implementation AudioListTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    dq = [DownloadQueue shared];
    dq.delegate = self;
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    tableViewDataSource = [NSMutableArray new];
    downloadedAudioListArray = [AppDelegate getListOfDownloadedAudios];
    if (!downloadedAudioListArray) {
        downloadedAudioListArray = [NSMutableArray new];
    }
    self.title = @"My Audios";
    [self getAudioList];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)segmentControlValueChanged:(id)sender {
    if ([sender isKindOfClass:[UISegmentedControl class]] && sender == segmentControl) {
        NSInteger index = [segmentControl selectedSegmentIndex];
        if (index == 0) {
            // My audios
        }else if (index == 1) {
            // Downloaded
        }
        [listTableView reloadData];
    }
    
    // Refresh tableView
}

- (IBAction)downloadButtonClicked:(id)sender {
    UIButton *downloadButton = sender;
    CGPoint buttonPosition = [sender convertPoint:CGPointZero
                                           toView:listTableView];
    NSIndexPath *highlightedIndexPath = [listTableView indexPathForRowAtPoint:buttonPosition];
    Audio *audio = tableViewDataSource[highlightedIndexPath.row];
    audio.state = Downloading;
    [tableViewDataSource replaceObjectAtIndex:highlightedIndexPath.row withObject:audio];
    [self setButtonDownloadingState:downloadButton];
    [dq downloadAudio:audio];
}

- (void)setButtonDownloadingState:(UIButton *)button {
    [button setTitle:@"Downloading" forState:UIControlStateNormal];
    button.enabled = NO;
}

- (void)setButtonDownloadedState:(UIButton *)button {
    [button setTitle:@"Downloaded" forState:UIControlStateNormal];
    button.enabled = NO;
}

- (void)setButtonNotDownloadedState:(UIButton *)button {
    [button setTitle:@"Download" forState:UIControlStateNormal];
    button.enabled = YES;
}

#pragma mark - Downloader Delegate

- (void)audioDidFinishDownloading:(DownloadedAudio *)downloadedAudio {
    [downloadedAudioListArray insertObject:downloadedAudio atIndex:0];
    NSInteger index = 0;
    for (Audio *audio in tableViewDataSource) {
        if ([audio.audioId isEqualToString:downloadedAudio.audioDetails.audioId]) {
            index = [tableViewDataSource indexOfObject:audio];
        }
    }
    Audio *audio = tableViewDataSource[index];
    audio.state = Downloaded;
    [tableViewDataSource replaceObjectAtIndex:Downloaded withObject:audio];
    if (segmentControl.selectedSegmentIndex == 1) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [listTableView reloadData];
        });
    }else {
        dispatch_async(dispatch_get_main_queue(), ^{
            AudioListTableViewCell *cell = [listTableView cellForRowAtIndexPath:[NSIndexPath indexPathForItem:index inSection:0]];
            [self setButtonDownloadedState:cell.downloadButton];
        });
    }
    [AppDelegate saveListOfDownloadedAudios:downloadedAudioListArray];
    NSLog(@"Audio with name '%@' has been downloaded", downloadedAudio.audioDetails.title);
}

#pragma mark - Data Source 

- (void)getAudioList {
    VKRequest *request = [VKApi requestWithMethod:@"audio.get" andParameters:@{@"owner_id":[AppDelegate getUserInfo].userID,@"count":@"100"}];
    [AppDelegate showStatusBarActivityIndicator];
    [request executeWithResultBlock:^(VKResponse *response) {
        [AppDelegate hideStatusBarActivityIndicator];
        NSDictionary *jsonDictionary = response.json;
        [self prepareDataSource:jsonDictionary[@"items"]];
    } errorBlock:^(NSError * error) {
        [AppDelegate hideStatusBarActivityIndicator];
        if (error.code != VK_API_ERROR) {
            [error.vkError.request repeat];
        } else {
            NSLog(@"VK error: %@", error);
        }
    }];
}

- (void)prepareDataSource:(NSArray *)audioListArray {
    for (NSDictionary *audioDictionary in audioListArray) {
        Audio *audio = [[Audio alloc] initWithDictionary:audioDictionary];
        [tableViewDataSource addObject:audio];
    }
    [self.tableView reloadData];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSInteger rowCount;
    if (segmentControl.selectedSegmentIndex == 0) {
        rowCount = [tableViewDataSource count];
    }else {
        rowCount = [downloadedAudioListArray count];
    }
    return rowCount;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (segmentControl.selectedSegmentIndex == 0) {
        AudioListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AudioListCell" forIndexPath:indexPath];
        Audio *audio = tableViewDataSource[indexPath.row];
        cell.titleLabel.text = audio.title;
        cell.artistLabel.text = audio.artist;
        if (audio.state == NotDownloaded) {
            [self setButtonNotDownloadedState:cell.downloadButton];
        }else if (audio.state == Downloading) {
            [self setButtonDownloadingState:cell.downloadButton];
        }else if (audio.state == Downloaded) {
            [self setButtonDownloadedState:cell.downloadButton];
        }
        return cell;
    }else {
        DownloadedAudioListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DownloadedAudioListCell" forIndexPath:indexPath];
        DownloadedAudio *audio = downloadedAudioListArray[indexPath.row];
        cell.titleLabel.text = audio.audioDetails.title;
        cell.artistLabel.text = audio.audioDetails.artist;
        
        return cell;
    }
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (segmentControl.selectedSegmentIndex == 0) {
        Audio *audio = tableViewDataSource[indexPath.row];
        AudioListTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
//        PlayerViewController *playerVC = [[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"playerVC"];
//        playerVC.selectedAudio = audio;
//        [self.navigationController pushViewController:playerVC animated:YES];
        if (audio.state == NotDownloaded) {
            [self downloadButtonClicked:cell.downloadButton];
        }
    }else {
        DownloadedAudio *audio = downloadedAudioListArray[indexPath.row];
        PlayerViewController *playerVC = [[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"playerVC"];
        playerVC.selectedDownloadedAudio = audio;
        [self.navigationController pushViewController:playerVC animated:YES];
    }
    
}




/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
