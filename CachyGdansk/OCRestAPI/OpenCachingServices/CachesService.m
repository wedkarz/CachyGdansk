//
//  CachesService.m
//  CachyGdansk
//
//  Created by Artur Rybak on 5/18/13.
//  Copyright (c) 2013 Kainos Software Polska. All rights reserved.
//

#import "CachesService.h"
#import "Geocache.h"

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
- (void)nearestCacheCodesWithCenter:(CLLocationCoordinate2D)centerCoordinate successBlock:(void (^)(id result))successBlock failureBlock:(void (^)(id result))failureBlock {
    
    NSDictionary *parameters = @{// coorindates
                                 @"center": [NSString stringWithFormat:@"%f|%f", centerCoordinate.latitude, centerCoordinate.longitude],
                                 
                                 // in kilometers
                                 @"radius": @(5.0)
                                 };
    
    [_engine callServiceWithUrl:@"caches/search/nearest"
                     parameters:parameters
                        success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON){
                            NSLog(@"SUCCES: %@", JSON);
                            successBlock(JSON);
                            
                        } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON){
                            NSLog(@"FAILURE: %@", JSON);
                            failureBlock(JSON);
                        }];
}

// calls caches/search/nearest
// then caches/geocaches with results of previous
- (void)nearestCachesWithCenter:(CLLocationCoordinate2D)centerCoordinate successBlock:(void (^)(id result))successBlock failureBlock:(void (^)(id result))failureBlock {
    [self nearestCacheCodesWithCenter:centerCoordinate successBlock:^(id result) {
        NSArray *nearestCacheCodes = [result valueForKey:@"results"];
        
        [self fullCashDescriptionsForCachesWithCodes:nearestCacheCodes successBlock:^(id result){
            NSArray *nearestCachesFullDescriptions = result;
            successBlock(result);
        } failureBlock:^(id result){
            failureBlock(nil);
        }];
    } failureBlock:^(id result) {
        failureBlock(nil);
    }];
}

// caches/geocaches
// http://opencaching.pl/okapi/services/caches/geocaches.html
- (void)fullCashDescriptionsForCachesWithCodes:(NSArray *)cacheCodes successBlock:(void (^)(id result))successBlock failureBlock:(void (^)(id result))failureBlock {
    NSDictionary *parameters = @{// REQUIRED
                                 // coorindates
                                 @"cache_codes": [cacheCodes componentsJoinedByString:@"|"],
                                 
                                 // OPTIONAL
                                 @"langpref": @"pl",
                                 
                                 @"fields": @"code|name|location|type|status|url|owner|gc_code|founds|notfounds|willattends|size2|oxsize|difficulty|terrain|trip_time|rating|rating_votes|recommendations|req_passwd|descriptions|hints|images|preview_image|attrnames|attribution_note|latest_logs|trackables_count|trackables|alt_wpts|country|state|last_found|last_modified|date_created|date_hidden|internal_id"
                                 
                                 };
    
    [_engine callServiceWithUrl:@"caches/geocaches"
                     parameters:parameters
                        success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON){
                            NSLog(@"SUCCES: %@", JSON);
                            successBlock(JSON);
                        } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON){
                            NSLog(@"FAILURE: %@", JSON);
                            failureBlock(JSON);
                        }];
}
@end
