//
//  LogService.m
//  CachyGdansk
//
//  Created by Artur Rybak on 5/19/13.
//  Copyright (c) 2013 Kainos Software Polska. All rights reserved.
//

#import "LogService.h"

@implementation LogService

// logs/userlogs
// http://opencaching.pl/okapi/services/logs/userlogs.html
- (void)userLogswithSuccessBlock:(void (^)(id result))successBlock failureBlock:(void (^)(id result))failureBlock {
    
    NSDictionary *parameters = @{@"user_uuid": @"2513FD01-A606-42F7-581C-92E3B23BF470"};
    
    [_engine callServiceWithUrl:@"logs/userlogs" parameters:parameters success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
        successBlock(JSON);
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON){
        failureBlock(JSON);
    }];
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

@end
