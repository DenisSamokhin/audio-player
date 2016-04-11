//
//  DownloadQueue.h
//  Audio Player
//
//  Created by Denis on 4/10/16.
//  Copyright © 2016 ITLions. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DownloadAudioOperation.h"

@protocol DownloaderDelegate <NSObject>

- (void)audioDidFinishDownloading:(DownloadedAudio *)downloadedAudio;

@end

@interface DownloadQueue : NSOperationQueue {
    id <DownloaderDelegate> delegate;
}

@property (nonatomic, assign) id <DownloaderDelegate> delegate;

+ (id)shared;
- (id)init;
- (void)downloadAudio:(Audio *)audio;
- (void)audioLoaded:(DownloadedAudio *)downloadedAudio;

@end
