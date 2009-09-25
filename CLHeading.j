

/*
 * CLHeading.j
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
    @code CLHeading

  */
 @implementation CLHeading : CPObject
 {
	double _magneticHeading @accessors(getter=magneticHeading);
	double _trueHeading @accessors(getter=trueHeading);
	double _headingAccuracy @accessors(getter=headingAccuracy);
	double _timestamp @accessors(getter=timestamp);
	double _x @accessors(getter=x);
	double _y @accessors(getter=y);
	double _z @accessors(getter=z);
 
 }
 
 
 - (CLHeading) _initWithMagneticHeading: (double) mHeading trueHeading: (double) tHeading timestamp: (CPDate) timestamp
 {
 	self = [super init];
 	if(self){
 		_magneticHeading = mHeading;
 		_trueHeading = tHeading;
 		_timestamp = [[CPDate alloc] initWithTimeIntervalSince1970: timestamp / 1000];
 	}
 	
 	return self;
 }
 
 
 /*!
 A string of the form ÒmagneticHeading <magnetic> trueHeading <heading> accuracy <accuracy> x <x> y <y> z <z> @ <date-time>Ó
 where <magnetic>, <heading>, <accuracy>, <x>, <y>, and <z> are formatted floating point numbers 
 and <date-time> is a formatted date string that includes date, time, and time zone information.
 */
 - (CPString)description
 {
 
 }
 
 @end