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
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    tableViewDataSource = [NSMutableArray new];
    self.title = @"My Audios";
    [self getAudioList];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    return [tableViewDataSource count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"AudioListCell";
    AudioListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    Audio *audio = tableViewDataSource[indexPath.row];
    cell.titleLabel.text = audio.title;
    cell.artistLabel.text = audio.artist;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
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
