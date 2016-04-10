//
//  DownloadedAudio.h
//  Audio Player
//
//  Created by Denis on 4/10/16.
//  Copyright © 2016 ITLions. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DownloadedAudio : NSObject

@property(nonatomic, strong) NSString *artist;
@property(nonatomic, strong) NSString *title;
@property(nonatomic, strong) Audio *audioDetails;

- (id)initWithDictionary:(NSDictionary *)dict;

@end
