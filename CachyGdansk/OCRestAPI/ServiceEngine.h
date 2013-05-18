//
//  ServiceEngine.h
//  CachyGdansk
//
//  Created by Artur Rybak on 5/18/13.
//  Copyright (c) 2013 Kainos Software Polska. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ServiceEngine : NSObject

- (void)callServiceWithUrl:(NSString *)detailedUrl
                parameters:(NSDictionary *)parameters
                   success:(void (^)(NSURLRequest *request, NSHTTPURLResponse *response, id JSON))successBlock
                   failure:(void (^)(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON))failureBlock;
@end
