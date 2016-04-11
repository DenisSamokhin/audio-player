//
//  Audio.h
//  Audio Player
//
//  Created by Denis on 3/19/16.
//  Copyright © 2016 ITLions. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    NotDownloaded = 0,
    Downloading = 1,
    Downloaded = 2
} DownloadingState;

@interface Audio : NSObject <NSCoding>

@property(nonatomic, strong) NSString *audioId;
@property(nonatomic, strong) NSString *owner_id;
@property(nonatomic, strong) NSString *artist;
@property(nonatomic, strong) NSString *title;
@property(nonatomic, strong) NSNumber *duration;
@property(nonatomic, strong) NSString *url;
@property(nonatomic, strong) NSString *lyrics_id;
@property(nonatomic, strong) NSString *album_id;
@property(nonatomic, strong) NSString *genre_id;
@property (nonatomic) DownloadingState state;

- (id)initWithDictionary:(NSDictionary *)dict;

@end
