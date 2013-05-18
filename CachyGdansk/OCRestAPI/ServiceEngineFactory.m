//
//  ServiceEngineFactory.m
//  CachyGdansk
//
//  Created by Artur Rybak on 5/18/13.
//  Copyright (c) 2013 Kainos Software Polska. All rights reserved.
//

#import "ServiceEngineFactory.h"

@interface ServiceEngineFactory() {
    ServiceEngine *_engine;
}

@end

@implementation ServiceEngineFactory

- (ServiceEngine *)openCachingEngine {
    if(!_engine)
        _engine = [ServiceEngine new];
    
    return _engine;
}
@end
