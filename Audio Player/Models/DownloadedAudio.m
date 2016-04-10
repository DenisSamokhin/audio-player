//
//  DownloadedAudio.m
//  Audio Player
//
//  Created by Denis on 4/10/16.
//  Copyright © 2016 ITLions. All rights reserved.
//

#import "DownloadedAudio.h"

@implementation DownloadedAudio

- (id)initWithDictionary:(NSDictionary *)dict {
    if (dict) {
        self.artist = dict[@"artist"];
        self.title = dict[@"title"];
        self.audioDetails = dict[@"auidoDetails"];
    }
    return self;
}

@end
