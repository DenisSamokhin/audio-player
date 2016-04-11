//
//  DownloadAudioOperation.m
//  Audio Player
//
//  Created by Denis on 4/10/16.
//  Copyright © 2016 ITLions. All rights reserved.
//

#import "DownloadAudioOperation.h"

@implementation DownloadAudioOperation

- (id)initWithURL:(NSURL*)url andAudio:(Audio *)audio {
    if (![super init]) return nil;
    [self setTargetURL:url];
    [self setAudio:audio];
    return self;
}

- (void)main {
    NSURLSessionDownloadTask *downloadAudioTask = [[NSURLSession sharedSession]
                                                   downloadTaskWithURL:self.targetURL completionHandler:^(NSURL *location, NSURLResponse *response, NSError *error) {
                                                       //Find a cache directory. You could consider using documenets dir instead (depends on the data you are fetching)
                                                       NSData *data = [NSData dataWithContentsOfURL:location];
                                                       NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
                                                       NSString *path = [paths  objectAtIndex:0];
                                                       NSString *filename = [NSString stringWithFormat:@"%@.mp3", self.audio.audioId];
                                                       NSString *dataPath = [path stringByAppendingPathComponent:filename];
                                                       //dataPath = [dataPath stringByAppendingPathComponent:self.audio.audioId];
                                                       dataPath = [dataPath stringByStandardizingPath];
                                                       BOOL success = [data writeToFile:dataPath atomically:YES];
                                                       DownloadedAudio *downloadedAudio = [[DownloadedAudio alloc] initWithDictionary:@{@"filename":filename, @"audioDetails":self.audio}];
                                                       NSLog(@"Audio with name '%@' has been downloaded", downloadedAudio.audioDetails.title);
                                                       [[DownloadQueue shared] audioLoaded:downloadedAudio];
                                                   }];
    
    [downloadAudioTask resume];
    
}

@end
