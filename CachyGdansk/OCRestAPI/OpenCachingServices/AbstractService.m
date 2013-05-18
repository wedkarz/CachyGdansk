//
//  AbstractService.m
//  CachyGdansk
//
//  Created by Artur Rybak on 5/18/13.
//  Copyright (c) 2013 Kainos Software Polska. All rights reserved.
//

#import "AbstractService.h"

@implementation AbstractService

- (id)init
{
    self = [super init];
    if (self) {
        ServiceEngineFactory *serviceEngineFactory = [ServiceEngineFactory new];
        _engine = [serviceEngineFactory openCachingEngine];
    }
    return self;
}

@end
