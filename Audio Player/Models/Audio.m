//
//  Audio.m
//  Audio Player
//
//  Created by Denis on 3/19/16.
//  Copyright © 2016 ITLions. All rights reserved.
//

#import "Audio.h"

@implementation Audio

- (id)initWithDictionary:(NSDictionary *)dict {
    if (dict) {
        self.artist = dict[@"artist"];
        self.duration = dict[@"duration"];
        self.genre_id = [dict[@"genre_id"] stringValue];
        self.audioId = [dict[@"id"] stringValue];
        self.owner_id = [dict[@"owner_id"] stringValue];
        self.title = dict[@"title"];
        self.url = dict[@"url"];
    }
    return self;
}

@end
