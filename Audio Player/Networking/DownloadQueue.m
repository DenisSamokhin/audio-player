//
//  DownloadQueue.m
//  Audio Player
//
//  Created by Denis on 4/10/16.
//  Copyright © 2016 ITLions. All rights reserved.
//

#import "DownloadQueue.h"

static DownloadQueue *shared;

@implementation DownloadQueue

- (id)init {
    if (shared) {
        return shared;
    }
    if (![super init]) return nil;
    shared = self;
    return self;
}

+ (id)shared {
    if (!shared) {
        shared = [[DownloadQueue alloc] init];
    }
    return shared;
}

- (void)downloadAudio:(Audio *)audio {
    NSURL *url = [NSURL URLWithString:audio.url];
    DownloadAudioOperation *operation = [[DownloadAudioOperation alloc] initWithURL:url andAudio:audio];
    [self addOperation:operation];
}

- (void)audioLoaded:(DownloadedAudio *)downloadedAudio {
    [self.delegate audioDidFinishDownloading:downloadedAudio];
}

@end
