

/*
 * CLLocation.j
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
 
  /*! 
    @ingroup corelocation
    @code CLocation

  */
 @implementation CLLocation : CPObject
 {
 	CLLocationCoordinate2D 	_coordinate @accessors(getter=coordinate);
 	double 					_altitude @accessors(getter=altitude);

	double					_horizontalAccuracy @accessors(getter=horizontalAccuracy);
	double					_verticalAccuracy @accessors(getter=verticalAccuracy);
	CPDate					_timestamp @accessors(getter=timeStamp);
	
	double					_speed @accessors(getter=speed);
	double					_course @accessors(getter=course);
 
 }
 
 
 - (id)initWithLatitude:(CLLocationDegrees)latitude longitude:(CLLocationDegrees)longitude
 {
 	self = [super init];
 	if(self){
	 	_coordinate = new CLLocationCoordinate2D();
	 	_coordinate.latitude = latitude;
	 	_coordinate.longitude = longitude;
	 }
	 return self;
 }
 
 - (id)initWithCoordinate:(CLLocationCoordinate2D)coordinate altitude:(CLLocationDistance)altitude horizontalAccuracy:(CLLocationAccuracy)hAccuracy verticalAccuracy:(CLLocationAccuracy)vAccuracy timestamp:(CPDate)timestamp
 {
	self = [super init];
 	if(self){
	 	_coordinate = coordinate;
		_altitude = altitude;
		_horizontalAccuracy = hAccuracy;
		_verticalAccuracy = vAccuracy;
		_timestamp = [[CPDate alloc] initWithTimeIntervalSince1970: timestamp / 1000];
	 } 	
	 
	 return self;
 }
 
 
- (CLLocationDistance)getDistanceFrom:(CLLocation)location
{
        var lat1 = _coordinate.latitude;
        var lon1 = _coordinate.longitude;
        var lat2 = [location coordinate].latitude;
        var lon2 = [location coordinate].longitude;


		if (ABS(lat1) > 90 || ABS(lat2) > 90){
			return -1;
		}
		lat1 = ABS([self _toRadians: lat1]);
		lon1 = ABS([self _toRadians: lon1]);
		lat2 = ABS([self _toRadians: lat2]);
		lon2 = ABS([self _toRadians: lon2]);

		var d = 2 * Math.asin(Math.sqrt((Math.pow(Math.sin((lat1 - lat2) / 2) , 2)) + Math.pow(Math.cos(lat1) * Math.cos(lat2) * (Math.sin((lon1 - lon2) / 2)) , 2)));
		//convert from nautical miles to meters
		d = d * 1852;
		return d * 180*60/Math.PI ;

}

- (double) _toRadians: (double) degrees
{
    return degrees * PI / 180
}

- (CPString) description
{
	//A string of the form Ò<<latitude>, <longitude>> +/- <accuracy>m (speed <speed> kph / heading <heading>) @ <date-time>Ó, 
	//where <latitude>, <longitude>, <accuracy>, <speed>, and <heading> are formatted floating point numbers 
	//and <date-time> is a formatted date string that includes date, time, and time zone information. 
	
	return _coordinate.latitude + ", " + _coordinate.longitude + " +/- " + _horizontalAccuracy + "m " + " @ " + [_timestamp description];
}

@end
 
 
 
 CLLocationCoordinate2D = function (lat, lon) {
  	this.latitude = lat;
 	this.longitude = lon;
 } 
 
 
 