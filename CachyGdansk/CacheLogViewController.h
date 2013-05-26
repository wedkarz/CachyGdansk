//
//  CacheLogViewController.h
//  CachyGdansk
//
//  Created by Artur Rybak on 5/19/13.
//  Copyright (c) 2013 Kainos Software Polska. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Geocache.h"

@interface CacheLogViewController : UITableViewController
@property (nonatomic, weak) Geocache *geocache;
@end
