//
//  DownloadAudioOperation.h
//  Audio Player
//
//  Created by Denis on 4/10/16.
//  Copyright © 2016 ITLions. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DownloadAudioOperation : NSOperation {

}

@property(retain) NSURL *targetURL;
@property(retain) Audio *audio;

- (id)initWithURL:(NSURL*)url andAudio:(Audio *)audio;

@end
