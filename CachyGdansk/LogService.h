//
//  LogService.h
//  CachyGdansk
//
//  Created by Artur Rybak on 5/19/13.
//  Copyright (c) 2013 Kainos Software Polska. All rights reserved.
//

#import "AbstractService.h"

@interface LogService : AbstractService

- (void)userLogswithSuccessBlock:(void (^)(id result))successBlock failureBlock:(void (^)(id result))failureBlock;

@end
