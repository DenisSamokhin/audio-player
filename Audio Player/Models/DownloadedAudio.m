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
        self.path = dict[@"path"];
        self.audioDetails = dict[@"audioDetails"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder{
    [encoder encodeObject:self.path forKey:@"path"];
    [encoder encodeObject:self.audioDetails forKey:@"audioDetails"];
}

- (id)initWithCoder:(NSCoder *)decoder {
    if (self = [super init]) {
        self.path = [decoder decodeObjectForKey:@"path"];
        self.audioDetails = [decoder decodeObjectForKey:@"audioDetails"];
    }
    return self;
}

@end
