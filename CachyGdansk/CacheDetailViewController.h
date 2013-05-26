//
//  CacheDetailViewController.h
//  CachyGdansk
//
//  Created by Artur Rybak on 5/19/13.
//  Copyright (c) 2013 Kainos Software Polska. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Geocache.h"

@interface CacheDetailViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *subtitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *creatorLabel;
@property (weak, nonatomic) IBOutlet UILabel *sizeLabel;
@property (weak, nonatomic) IBOutlet UILabel *ratingLabel;
@property (weak, nonatomic) IBOutlet UIWebView *description;
@property (weak, nonatomic) IBOutlet UILabel *foundCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *notfoundCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *ratedCountLabel;
@property (strong, nonatomic) Geocache *geocache;
@end
