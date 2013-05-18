//
//  AbstractService.h
//  CachyGdansk
//
//  Created by Artur Rybak on 5/18/13.
//  Copyright (c) 2013 Kainos Software Polska. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ServiceEngineFactory.h"
#import <CoreLocation/CoreLocation.h>

@interface AbstractService : NSObject    {
    ServiceEngine *_engine;
}

@end
