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
        self.filename = dict[@"filename"];
        self.audioDetails = dict[@"audioDetails"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder{
    [encoder encodeObject:self.filename forKey:@"filename"];
    [encoder encodeObject:self.audioDetails forKey:@"audioDetails"];
}

- (id)initWithCoder:(NSCoder *)decoder {
    if (self = [super init]) {
        self.filename = [decoder decodeObjectForKey:@"filename"];
        self.audioDetails = [decoder decodeObjectForKey:@"audioDetails"];
    }
    return self;
}

@end
