//
//  MOBFlightSegment.h
//  MySecond_iMessagesApp
//
//  Created by Gopal Rao Gurram on 3/12/17.
//  Copyright © 2017 Gopal Rao Gurram. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@protocol MOBFlightSegment @end

@interface MOBFlightSegment : JSONModel

@property (nonatomic, retain) NSString *arrivalAirport;
@property (nonatomic, retain) NSString *arrivalAirportName;
@property (nonatomic, retain) NSString *carrierCode;
@property (nonatomic, retain) NSString *departureAirport;
@property (nonatomic, retain) NSString *departureAirportName;
@property (nonatomic, retain) NSString *departureDate;
@property (nonatomic, retain) NSString *flightNumber;



@end
