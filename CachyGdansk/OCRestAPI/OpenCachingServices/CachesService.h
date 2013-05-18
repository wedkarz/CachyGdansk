//
//  CachesService.h
//  CachyGdansk
//
//  Created by Artur Rybak on 5/18/13.
//  Copyright (c) 2013 Kainos Software Polska. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AbstractService.h"

@interface CachesService : AbstractService
- (void)nearestCachesWithCenter:(CLLocationCoordinate2D)centerCoordinate;
@end
