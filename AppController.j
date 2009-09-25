/*
 * AppController.j
 * corelocation
 *
 * Created by Yo Mama on September 23, 2009.
 * Copyright 2009, Your Company All rights reserved.
 */

@import <Foundation/CPObject.j>
@import "CLLocationManager.j"

@implementation AppController : CPObject
{
    CPTextField label;
    CPView contentView;
    CLLocationManager locationManager;
    
}

- (void)applicationDidFinishLaunching:(CPNotification)aNotification
{
    var theWindow = [[CPWindow alloc] initWithContentRect:CGRectMakeZero() styleMask:CPBorderlessBridgeWindowMask];
        
    contentView = [theWindow contentView];

    label = [[CPTextField alloc] initWithFrame:CGRectMakeZero()];

    [label setStringValue:@"Hello CoreLocation!"];
    [label setFont:[CPFont boldSystemFontOfSize:24.0]];

    [label sizeToFit];

    [label setAutoresizingMask:CPViewMinXMargin | CPViewMaxXMargin | CPViewMinYMargin | CPViewMaxYMargin];
    [label setCenter:[contentView center]];

    [contentView addSubview:label];

    [theWindow orderFront:self];
    
    locationManager = [[CLLocationManager alloc] init];
    if(![locationManager locationServicesEnabled]){
        [self _setLabelValue:@"CoreLocation not supported"];
    }else{
         [self _setLabelValue:@"CoreLocation supported"];
    }
    [locationManager setDelegate: self];
    [locationManager startUpdatingLocation];
    // Uncomment the following line to turn on the standard menu bar.
    //[CPMenu setMenuBarVisible:YES];
}


-(void) _setLabelValue: (CPString) aString
{
    [label setStringValue: aString];
    [label sizeToFit];
    
    [label setCenter:[contentView center]];

}

//CLLocationManagerDelegate
- (void)locationManager:(CLLocationManager)manager didFailWithError:(CPError)error
{
/*
    CPLogConsole(manager);
    CPLogConsole(error);
*/
}

- (void)locationManager:(CLLocationManager)manager didUpdateHeading:(CLHeading)newHeading
{
/*
    CPLogConsole(manager);
    CPLogConsole(newHeading);
*/
}

- (void)locationManager:(CLLocationManager)manager didUpdateToLocation:(CLLocation)newLocation fromLocation:(CLLocation)oldLocation
{
         [self _setLabelValue:  [newLocation description]];

         console.warn("stopUpdatingLocation");
         [locationManager stopUpdatingLocation];

}

- (BOOL)locationManagerShouldDisplayHeadingCalibration:(CLLocationManager)manager
{
/*     CPLogConsole(manager); */
}
//CLLocationManagerDelegate

@end
