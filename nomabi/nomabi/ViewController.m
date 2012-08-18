//
//  ViewController.m
//  nomabi
//
//  Created by Phil Beadle on 8/17/12.
//  Copyright (c) 2012 nomabi. All rights reserved.
//

#import "ViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "AFJSONRequestOperation.h"
#import "AFImageRequestOperation.h"
#import "UIImageView+AFNetworking.h"
#import "AFHTTPClient.h"
#import "Constants.h"
#import "SVProgressHUD.h"
#import <CoreLocation/CoreLocation.h>
#import "AppDelegate.h"

@interface ViewController (){
    CLLocationManager *locationManager;
    float latestLatitude;
    float latestLongitude;
}

@end

@implementation ViewController

-(void)loadView{
    [super loadView];
    
    UIView *view = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    [view setBackgroundColor:[UIColor grayColor]];
    
    self.view = view;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
    } else {
        return YES;
    }
}

#pragma mark - Button Presses

-(void)locationButtonPressed{
   // [(UIActivityIndicatorView *)[locationButton viewWithTag:TAG_SPINNER_VIEW] startAnimating];
    if(!locationManager){
        locationManager = [[CLLocationManager alloc] init];
        locationManager.delegate = self;
        locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    }
    
    [locationManager startUpdatingLocation];
    [self performSelector:@selector(stopUpdatingLocation) withObject:nil afterDelay:10.0];
    
}

#pragma mark - Location Delegate Methods
- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation {
    
    NSTimeInterval locationAge = -[newLocation.timestamp timeIntervalSinceNow];
    if (locationAge > 5.0) return;
    
    if (newLocation.horizontalAccuracy < 0) return;
    
    if (newLocation.horizontalAccuracy <= locationManager.desiredAccuracy) {
        
        [locationManager stopUpdatingLocation];
        
        CLGeocoder *geoCoder = [[CLGeocoder alloc] init];
        [geoCoder reverseGeocodeLocation:newLocation completionHandler:^(NSArray *placemarks, NSError *error){
            
            for(CLPlacemark *placemark in placemarks){
                NSLog(@"placemark info***: latitude %f & longitude %f", [[placemark location] coordinate].latitude, [[placemark location] coordinate].longitude);
                
                latestLatitude = [[placemark location] coordinate].latitude;
                latestLongitude = [[placemark location] coordinate].longitude;
                //TODO populate current location information
                
                //[locationButton setEnabled:YES];
                //[(UIActivityIndicatorView *)[locationButton viewWithTag:TAG_SPINNER_VIEW] stopAnimating];

            }
            
        }];
    }
    
}

#pragma mark - My Methods

-(void)sendLocationInformation{

    [SVProgressHUD showWithStatus:@"Loading" maskType:SVProgressHUDMaskTypeGradient];
    
    NSURL *editedUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@?%@=%f&%@=%f", kSendLocationUrl, kJSONLatitude, latestLatitude, kJSONLongitude, latestLongitude]];
    
    NSMutableURLRequest *mutableRequest = [NSMutableURLRequest requestWithURL:editedUrl];
    [mutableRequest setTimeoutInterval:10];
    [mutableRequest setHTTPMethod:@"POST"];
    
    AFJSONRequestOperation *requestOperation = [AFJSONRequestOperation JSONRequestOperationWithRequest:mutableRequest success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
        if(kLoggingEnabled)NSLog(@"send location information response json: %@", JSON);
        if([JSON valueForKeyPath:kJSONStatus] && [[JSON valueForKeyPath:kJSONStatus] isEqualToString:kJSONStatusSuccess]){
            [SVProgressHUD dismiss];
            NSDictionary *resultDictionary = [JSON valueForKeyPath:kJSONResult];
            
            //TODO Success code
            
        }else if([JSON valueForKeyPath:kJSONStatus] && [[JSON valueForKeyPath:kJSONStatus] isEqualToString:kJSONStatusError]){
            [SVProgressHUD dismiss];
          
            NSDictionary *resultDictionary = [JSON valueForKeyPath:kJSONResult];
            NSString *errorMessage = [resultDictionary objectForKey:kJSONFriendlyError];
            UIAlertView *loginErrorAlertView = [[UIAlertView alloc] initWithTitle:@"Error" message:errorMessage delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [loginErrorAlertView show];
        }else{
            [SVProgressHUD dismiss];
            
            UIAlertView *errorAlertView = [[UIAlertView alloc] initWithTitle:@"Error" message:kConnectionErrorText delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [errorAlertView show];
        }
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
        [SVProgressHUD dismiss];

        if(kLoggingEnabled)NSLog(@"check limitations failure error: \n%@", error);
        
        UIAlertView *loginErrorAlertView = [[UIAlertView alloc] initWithTitle:@"Error" message:kConnectionErrorText delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [loginErrorAlertView show];
    }];
    
    [requestOperation start];
    
    
}

-(void)getLocationInformation{
    // [(UIActivityIndicatorView *)[locationButton viewWithTag:TAG_SPINNER_VIEW] startAnimating];
    if(!locationManager){
        locationManager = [[CLLocationManager alloc] init];
        locationManager.delegate = self;
        locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    }
    
    [locationManager startUpdatingLocation];
    [self performSelector:@selector(stopUpdatingLocation) withObject:nil afterDelay:10.0];
    
}

-(void)stopUpdatingLocation{
    //[locationButton setEnabled:YES];
    //[(UIActivityIndicatorView *)[locationButton viewWithTag:TAG_SPINNER_VIEW] stopAnimating];
    [locationManager stopUpdatingLocation];
    
}

@end
