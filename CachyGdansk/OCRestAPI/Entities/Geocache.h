//
//  Geocache.h
//  CachyGdansk
//
//  Created by Artur Rybak on 5/18/13.
//  Copyright (c) 2013 Kainos Software Polska. All rights reserved.
//

#import <Parse/Parse.h>

@interface Geocache : NSObject

@property (nonatomic, assign) CLLocationCoordinate2D coordinate;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *code;
@property (nonatomic, strong) NSString *previewImageUrl;
@property (nonatomic, strong) NSString *status;
@property (nonatomic, strong) NSString *type;
@property (nonatomic, strong) NSString *owner;
@property (nonatomic, strong) NSString *distance;
@property (nonatomic, strong) NSNumber *founds;
@property (nonatomic, strong) NSNumber *notfounds;
@property (nonatomic, strong) NSNumber *willattends;
@property (nonatomic, strong) NSString *size;
@property (nonatomic, strong) NSNumber *rating;
@property (nonatomic, strong) NSString *description;
@property (nonatomic, strong) NSNumber *ratingVotes;
@property (nonatomic, strong) NSArray *latestLogs;
@end
