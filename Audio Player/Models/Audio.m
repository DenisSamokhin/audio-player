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
        if ([AppDelegate checkIfFileExists:self.audioId]) {
            self.state = Downloaded;
        }else {
            self.state = NotDownloaded;
        }
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder{
    [encoder encodeObject:self.artist forKey:@"artist"];
    [encoder encodeObject:self.duration forKey:@"duration"];
    [encoder encodeObject:self.genre_id forKey:@"genre_id"];
    [encoder encodeObject:self.audioId forKey:@"audioId"];
    [encoder encodeObject:self.owner_id forKey:@"owner_id"];
    [encoder encodeObject:self.title forKey:@"title"];
    [encoder encodeObject:self.url forKey:@"url"];
    [encoder encodeInteger:self.state forKey:@"state"];
}

- (id)initWithCoder:(NSCoder *)decoder {
    if (self = [super init]) {
        self.artist = [decoder decodeObjectForKey:@"artist"];
        self.duration = [decoder decodeObjectForKey:@"duration"];
        self.genre_id = [decoder decodeObjectForKey:@"genre_id"];
        self.audioId = [decoder decodeObjectForKey:@"audioId"];
        self.owner_id = [decoder decodeObjectForKey:@"owner_id"];
        self.title = [decoder decodeObjectForKey:@"title"];
        self.url = [decoder decodeObjectForKey:@"url"];
        self.state = [decoder decodeIntegerForKey:@"state"];
    }
    return self;
}

@end
