//
//  MapViewController.m
//  CachyGdansk
//
//  Created by Artur Rybak on 5/18/13.
//  Copyright (c) 2013 Kainos Software Polska. All rights reserved.
//

#define METERS_PER_MILE 1609.344
#define METERS_PER_KM 1000.0

#import "MapViewController.h"
#import "AFNetworking.h"
#import "CachesService.h"

@interface MapViewController ()
@property CLLocationManager *locationManager;
@property CLLocation *startLocation;
@property CachesService *cachesService;
@end

@implementation MapViewController
@synthesize locationManager = _locationManager, startLocation = _startLocation, cachesService = _cachesService;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    if(self.mapView && !self.startLocation) {
        self.startLocation = [locations lastObject];
        [self centerMapToCoordinate:self.startLocation.coordinate];
    }
    
    CLLocation *newLocation = [locations lastObject];
//    NSLog(@"NewLocation %f %f", newLocation.coordinate.latitude, newLocation.coordinate.longitude);
}

- (void)mockStartLocation {
    self.startLocation = [[CLLocation alloc] initWithLatitude:54.403246 longitude:18.57213];
    [self centerMapToCoordinate:self.startLocation.coordinate];
}

- (void)setUpServices {
    _cachesService = [CachesService new];
}

- (void)mockHackatonPin {
    // Add an annotation
    MKPointAnnotation *point = [[MKPointAnnotation alloc] init];
    point.coordinate = self.startLocation.coordinate;
    point.title = @"Hackaton pin";
    point.subtitle = @"Jest zabawa!!!";
    
    [self.mapView addAnnotation:point];
}

- (void)centerMapToCoordinate:(CLLocationCoordinate2D)coordinate {
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(coordinate, 0.5*METERS_PER_KM, 0.5*METERS_PER_KM);
    
    [self.mapView setRegion:region animated:YES];
}

- (void)registerForLocationUpdates {
    
    self.locationManager = [CLLocationManager new];
    self.locationManager.delegate = self;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    [self.locationManager startUpdatingLocation];
}

- (void)fetchNearestCachesFromLocation:(CLLocation *)location {
    [self.cachesService nearestCachesWithCenter:location.coordinate];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setUpServices];
    [self mockStartLocation];
    [self mockHackatonPin];
    [self registerForLocationUpdates];
    
    [self fetchNearestCachesFromLocation:self.startLocation];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
