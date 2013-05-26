//
//  ServiceEngine.m
//  CachyGdansk
//
//  Created by Artur Rybak on 5/18/13.
//  Copyright (c) 2013 Kainos Software Polska. All rights reserved.
//

#import "ServiceEngine.h"
#import "AFNetworking.h"

#define OPENCACHING_CONSUMER_KEY @"yFLNCjsYwydcBpCHwQgt"

@interface ServiceEngine() {
    NSString *_serviceURL;
}

@end


@implementation ServiceEngine



- (id)init
{
    self = [super init];
    if (self) {
        _serviceURL = @"http://opencaching.pl/okapi/services";
    }
    return self;
}

- (void)callServiceWithUrl:(NSString *)detailedUrl
                parameters:(NSDictionary *)parameters
                   success:(void (^)(NSURLRequest *request, NSHTTPURLResponse *response, id JSON))successBlock
                   failure:(void (^)(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON))failureBlock {
    NSMutableDictionary *requestParameters = [parameters mutableCopy];
    [requestParameters addEntriesFromDictionary:@{@"consumer_key" : OPENCACHING_CONSUMER_KEY}];
    
    NSURL *fullURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@/%@?%@", _serviceURL, detailedUrl, AFQueryStringFromParametersWithEncoding(requestParameters, NSASCIIStringEncoding)]];
    
    NSMutableURLRequest *request = [NSURLRequest requestWithURL:fullURL];
    

    
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
        NSLog(@"SUCCESSFULL: %@", fullURL);
        successBlock(request, response, JSON);
        
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
        NSLog(@"FAILING: %@", fullURL);
        failureBlock(request, response, error, JSON);
    }];
    
    [operation start];
}


@end
