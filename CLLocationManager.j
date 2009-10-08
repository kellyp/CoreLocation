

/*
 * CLLocationManager.j
 * CoreLocation
 *
 * Created by Kelly Plummer.
 * Copyright 2009, Kelly Plummer
 *
 * This library is free software; you can redistribute it and/or
 * modify it under the terms of the GNU Lesser General Public
 * License as published by the Free Software Foundation; either
 * version 2.1 of the License, or (at your option) any later version.
 *
 * This library is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
 * Lesser General Public License for more details.
 *
 * You should have received a copy of the GNU Lesser General Public
 * License along with this library; if not, write to the Free Software
 * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
 */
 
 @import <Foundation/CPObject.j>
 
 @import "CLHeading.j"
 @import "CLLocation.j"
 
 
 
 CLLocationAccuracyBest = 0;
 CLLocationAccuracyNearestTenMeters = 1;
 CLLocationAccuracyHundredMeters = 2;
 CLLocationAccuracyKilometer = 3;
 CLLocationAccuracyThreeKilometers = 4;
 
 
 
  /*! 
    @ingroup corelocation
    @code CLLocationManager
    
    
    CLLocationManagerDelegate
    - (void)locationManager:(CLLocationManager)manager didFailWithError:(CPError)error
    - (void)locationManager:(CLLocationManager)manager didUpdateHeading:(CLHeading)newHeading
    - (void)locationManager:(CLLocationManager)manager didUpdateToLocation:(CLLocation)newLocation fromLocation:(CLLocation)oldLocation
    - (BOOL)locationManagerShouldDisplayHeadingCalibration:(CLLocationManager)manager

  */
 @implementation CLLocationManager : CPObject
 {
    id _delegate @accessors(setter=setDelegate:, getter=delegate);
    double _distanceFilter @accessors(setter=setDistanceFilter:, getter=distanceFilter);
    double _desiredAccuracy @accessors(setter=setDesiredAccuracy:, getter=desiredAccuracy);

    double _headingFilter @accessors(setter=setheadingFilter:, getter=headingFilter);
 	BOOL _headingAvailable @accessors(getter=headingAvailable);

 	BOOL _locationServicesEnabled @accessors(getter=locationServicesEnabled);

 	CLLocation _location @accessors(getter=location);

 	int _updateId;
 }
 
 - (CLLocationManager) init
 {
	//check if geolocation is supported


 		
 	self = [super init];
 	if(self){
     	if(!navigator.geolocation){
     	  _locationServicesEnabled = NO;
     	  return self;
     	}
     	//set some defaults
        _locationServicesEnabled = YES;
        _desiredAccuracy = CLLocationAccuracyThreeKilometers;
        _headingAvailable = NO;
 	}
 	
 	return self;
 }
 

 - (void)startUpdatingLocation
 {
        if(_updateId != nil)
            [self stopUpdatingLocation];
        
        _updateId = navigator.geolocation.watchPosition(function(position){
            
            var coordinate = new CLLocationCoordinate2D(position.coords.latitude, position.coords.longitude);
            var newLocation = [[CLLocation alloc] initWithCoordinate: coordinate 
                altitude:position.coords.altitude 
                horizontalAccuracy:position.coords.accuracy verticalAccuracy:position.coords.altitudeAccuracy timestamp:position.timestamp];
                
            //if heading is null it isn't supported
            _headingAvailable = position.heading != nil;
            
            //holla at a delegate
            if(_delegate && [_delegate respondsToSelector: @selector(locationManager:didUpdateToLocation:fromLocation:)]){
                [_delegate locationManager: self didUpdateToLocation: newLocation fromLocation: _location];
            }
            _location = newLocation;
        }, function(error){CPLogConsole(error);}, {maximumAge:6000000000, timeout:0, enableHighAccuracy:(_desiredAccuracy<CLLocationAccuracyHundredMeters)});
 }
 
 - (void) stopUpdatingLocation
 {

 	navigator.geolocation.clearWatch(_updateId);
 	_updateId = nil;
 }
 
 - (void)stopUpdatingHeading
 {
 }
 
 - (void)startUpdatingHeading
 {
 }
 
 
 - (void)dismissHeadingCalibrationDisplay
 {
    
 }
 
 
 @end
 
