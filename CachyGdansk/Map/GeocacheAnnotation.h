//
//  GeocacheAnnotation.h
//  CachyGdansk
//
//  Created by Artur Rybak on 5/18/13.
//  Copyright (c) 2013 Kainos Software Polska. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
#import "Geocache.h"

@interface GeocacheAnnotation : NSObject <MKAnnotation>

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *subtitle;
@property (nonatomic, retain) Geocache *geocache;
@property (nonatomic, assign) CLLocationCoordinate2D coordinate;
@property (nonatomic, copy) NSString *previewImageUrl;

- (id)initWithGeocache:(Geocache *)geocache;

@end
