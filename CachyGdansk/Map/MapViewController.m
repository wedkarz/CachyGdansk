//
//  MapViewController.m
//  CachyGdansk
//
//  Created by Artur Rybak on 5/18/13.
//  Copyright (c) 2013 Kainos Software Polska. All rights reserved.
//

#define METERS_PER_MILE 1609.344
#define METERS_PER_KM 1000.0
#define RADIUS_FOR_NEAR_IN_KM 5 

#import "MapViewController.h"
#import "AFNetworking.h"
#import "CachesService.h"
#import "Geocache.h"
#import "GeocacheAnnotation.h"
#import "MultiRowCalloutAnnotationView.h"
#import "MultiRowAnnotation.h"
#import "GenericPinAnnotationView.h"
#import "CacheDetailViewController.h"
#import "LogEntry.h"

@interface MapViewController ()
@property (nonatomic, retain) CLLocationManager *locationManager;
@property (nonatomic, retain) CLLocation *startLocation;
@property (nonatomic, retain) CachesService *cachesService;
@property (nonatomic, retain) MKAnnotationView *selectedAnnotationView;
@property (nonatomic,retain) MultiRowAnnotation *calloutAnnotation;
@property (nonatomic, retain) GeocacheAnnotation *selectedAnnotation;
@end

@implementation MapViewController
@synthesize locationManager = _locationManager, startLocation = _startLocation, cachesService = _cachesService, selectedAnnotationView = _selectedAnnotationView, calloutAnnotation = _calloutAnnotation, selectedAnnotation =_selectedAnnotation;

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
    
    //    CLLocation *newLocation = [locations lastObject];
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
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(coordinate, RADIUS_FOR_NEAR_IN_KM*METERS_PER_KM, RADIUS_FOR_NEAR_IN_KM*METERS_PER_KM);
    
    [self.mapView setRegion:region animated:YES];
}

- (void)registerForLocationUpdates {
    
    self.locationManager = [CLLocationManager new];
    self.locationManager.delegate = self;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    [self.locationManager startUpdatingLocation];
}

- (void)fetchNearestCachesFromLocation:(CLLocation *)location {
    [self.cachesService nearestCachesWithCenter:location.coordinate successBlock:^(id result){
        NSDictionary *nearestCachesDict =  result;
        
        [nearestCachesDict enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
            Geocache *geocache = [Geocache new];
            geocache.code = nearestCachesDict[key][@"code"];
            geocache.name = nearestCachesDict[key][@"name"];
            geocache.owner = nearestCachesDict[key][@"owner" ][@"username"];
            geocache.size = nearestCachesDict[key][@"size2"];
            geocache.rating = nearestCachesDict[key][@"rating"];
            geocache.description = nearestCachesDict[key][@"descriptions"][@"pl"];
            geocache.founds = nearestCachesDict[key][@"founds"];
            geocache.notfounds = nearestCachesDict[key][@"notfounds"];
            geocache.ratingVotes = nearestCachesDict[key][@"rating_votes"];
            
            // parse latestLogs
            NSMutableArray * logs = [NSMutableArray new];
            for (NSDictionary *logDictionary in nearestCachesDict[key][@"latest_logs"]) {
                LogEntry *logEntry = [LogEntry new];
                logEntry.username = logDictionary[@"user"][@"username"];
                logEntry.type = logDictionary[@"type"];
                logEntry.date = logDictionary[@"date"];
                logEntry.comment = logDictionary[@"comment"];
                
                [logs addObject:logEntry];
            }
            geocache.latestLogs = logs;
            
//            geocache.previewImageUrl = nearestCachesDict[key][@"preview_image"];
            NSArray *coordinateComponents = [nearestCachesDict[key][@"location"] componentsSeparatedByString:@"|"];
            geocache.coordinate = CLLocationCoordinate2DMake([coordinateComponents[0] floatValue], [coordinateComponents[1] floatValue]);
            
            GeocacheAnnotation *geocacheAnnotation = [[GeocacheAnnotation alloc] initWithGeocache:geocache];
            
            [self.mapView addAnnotation:geocacheAnnotation];
            
        }];
    } failureBlock:^(id result) {
        ;
    }];
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

// When a map annotation point is added, zoom to it (1500 range)
- (void)mapView:(MKMapView *)mv didAddAnnotationViews:(NSArray *)views
{
//	MKAnnotationView *annotationView = [views objectAtIndex:0];
//	id <MKAnnotation> mp = [annotationView annotation];
//	MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance([mp coordinate], 1500, 1500);
//	[mv setRegion:region animated:YES];
//	[mv selectAnnotation:mp animated:YES];
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation {
    static NSString *identifier = @"GeocacheAnnotation";
    if ([annotation isKindOfClass:[GeocacheAnnotation class]]) {
        GeocacheAnnotation *geocacheAnnotation = annotation;
        
        MKAnnotationView *annotationView = (MKAnnotationView *) [_mapView dequeueReusableAnnotationViewWithIdentifier:identifier];
        if (annotationView == nil) {
            annotationView = [[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:identifier];
            annotationView.enabled = YES;
            annotationView.canShowCallout = YES;
            annotationView.image = [UIImage imageNamed:@"green-pin32"];//here we use a nice image instead of the default pins

            UIImageView *annotationLeftImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 32, 32)];
            [annotationLeftImageView setImageWithURL:[NSURL URLWithString:geocacheAnnotation.previewImageUrl] placeholderImage:[UIImage imageNamed:@"box-32"]];
            annotationView.leftCalloutAccessoryView = annotationLeftImageView;
            
            UIButton *disclosureButton = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
            annotationView.rightCalloutAccessoryView = disclosureButton;
            
        } else {
            annotationView.annotation = annotation;
        }
        
        return annotationView;
    }
    
    return nil;
}


- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control {
    self.selectedAnnotation = view.annotation;
    [self performSegueWithIdentifier:@"CacheDetail" sender:self];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"CacheDetail"]) {
//        UINavigationController *cacheDetailNavVC = segue.destinationViewController;
//        CacheDetailViewController *cacheDetailVC = (CacheDetailViewController *)[cacheDetailNavVC.childViewControllers lastObject];
        CacheDetailViewController *cacheDetailVC = segue.destinationViewController;
        
        cacheDetailVC.geocache = self.selectedAnnotation.geocache;
    }
}

@end
