//
//  CacheDetailViewController.m
//  CachyGdansk
//
//  Created by Artur Rybak on 5/19/13.
//  Copyright (c) 2013 Kainos Software Polska. All rights reserved.
//

#import "CacheDetailViewController.h"
#import "CacheLogViewController.h"

@interface CacheDetailViewController ()

@end

@implementation CacheDetailViewController
@synthesize geocache = _geocache;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
	// Do any additional setup after loading the view.
    self.title = self.geocache.code;
    self.subtitleLabel.text = self.geocache.name;
    self.creatorLabel.text = self.geocache.owner;
    self.sizeLabel.text = [self convertSize:self.geocache.size];

    if(self.geocache.rating != NULL)
        self.ratingLabel.text = [NSString stringWithFormat:@"%d/%d", [self.geocache.rating intValue] , 5];
    else
        self.ratingLabel.text = @"brak";
    
    [self.description loadHTMLString:self.geocache.description baseURL:nil];
    
    self.foundCountLabel.text = [NSString stringWithFormat:@"%d", [self.geocache.founds intValue]];
    self.notfoundCountLabel.text = [NSString stringWithFormat:@"%d", [self.geocache.notfounds intValue]];
    self.ratedCountLabel.text = [NSString stringWithFormat:@"%d", [self.geocache.ratingVotes intValue]];
}

- (NSString *)convertSize:(NSString *)size {
    NSDictionary *sizeDictionary = @{@"none": @"brak",
                                     @"nano": @"ekstra mała",
                                     @"micro": @"bardzo mała",
                                     @"small": @"mała",
                                     @"regular": @"średnia",
                                     @"large": @"duża",
                                     @"xlarge": @"bardzo duża",
                                     @"other": @"niestandardowa"};
    
    return sizeDictionary[size];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"LogSegue"]) {
        //        UINavigationController *cacheDetailNavVC = segue.destinationViewController;
        //        CacheDetailViewController *cacheDetailVC = (CacheDetailViewController *)[cacheDetailNavVC.childViewControllers lastObject];
        CacheLogViewController *cacheLogVC = segue.destinationViewController;
        
        cacheLogVC.geocache = self.geocache;
    }
}

@end
