//
//  CachesService.m
//  CachyGdansk
//
//  Created by Artur Rybak on 5/18/13.
//  Copyright (c) 2013 Kainos Software Polska. All rights reserved.
//

#import "CachesService.h"

@implementation CachesService

- (id)init
{
    self = [super init];
    if (self) {

    }
    return self;
}

// caches/search/nearest
// http://opencaching.pl/okapi/services/caches/search/nearest.html
- (void)nearestCachesWithCenter:(CLLocationCoordinate2D)centerCoordinate {
    NSDictionary *parameters = @{// coorindates
                                 @"center": [NSString stringWithFormat:@"%f|%f", centerCoordinate.latitude, centerCoordinate.longitude],
                                 
                                 // in kilometers
                                 @"radius": @(1.0)
                                 };
    
    [_engine callServiceWithUrl:@"caches/search/nearest"
                     parameters:parameters
                        success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON){
                            NSLog(@"SUCCES: %@", JSON);
                        } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON){
                            NSLog(@"FAILURE: %@", JSON);
                        }];
}
@end
