//
//  MOBFlightStatusInfo.h
//  MySecond_iMessagesApp
//
//  Created by Gopal Rao Gurram on 3/12/17.
//  Copyright © 2017 Gopal Rao Gurram. All rights reserved.
//

#import <JSONModel/JSONModel.h>

#import "MOBFlightStatusSegment.h"
#import "MOBAirportAdvisoryMessage.h"

@protocol MOBFlightStatusInfo @end

@interface MOBFlightStatusInfo : JSONModel

@property (nonatomic, retain) NSString *carrierCode;
@property (nonatomic, retain) NSString *flightNumber;
@property (nonatomic, retain) NSString *codeShareflightNumber;
@property (nonatomic, retain) NSString *flightDate;
@property (nonatomic, retain) MOBAirportAdvisoryMessage *airportAdvisoryMessage;
@property (nonatomic, retain) NSArray<MOBFlightStatusSegment> *segments;

@end
