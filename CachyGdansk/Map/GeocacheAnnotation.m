//
//  GeocacheAnnotation.m
//  CachyGdansk
//
//  Created by Artur Rybak on 5/18/13.
//  Copyright (c) 2013 Kainos Software Polska. All rights reserved.
//

#import "GeocacheAnnotation.h"

@implementation GeocacheAnnotation

@synthesize geocache = _geocache, coordinate = _coordinate, title = _title, subtitle = _subtitle, previewImageUrl = _previewImageUrl;

- (id)initWithGeocache:(Geocache *)geocache {
    self = [super init];
    if (self) {
        self.geocache = geocache;
        self.coordinate = geocache.coordinate;
        self.title = geocache.name;
        self.subtitle = geocache.code;
        self.previewImageUrl = geocache.previewImageUrl;
    }
    return self;
}

@end
