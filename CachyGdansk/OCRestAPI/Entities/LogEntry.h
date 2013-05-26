//
//  LogEntry.h
//  CachyGdansk
//
//  Created by Artur Rybak on 5/19/13.
//  Copyright (c) 2013 Kainos Software Polska. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LogEntry : NSObject
@property (nonatomic, strong) NSString *username;
@property (nonatomic, strong) NSString *date;
@property (nonatomic, strong) NSString *type;
@property (nonatomic, strong) NSString *comment;
@end
