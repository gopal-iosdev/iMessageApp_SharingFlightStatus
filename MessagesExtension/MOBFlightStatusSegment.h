//
//  MOBFlightStatusSegment.h
//  MySecond_iMessagesApp
//
//  Created by Gopal Rao Gurram on 3/12/17.
//  Copyright © 2017 Gopal Rao Gurram. All rights reserved.
//

#import <JSONModel/JSONModel.h>
#import "MOBEquipment.h"
#import "MOBAirline.h"
#import "MOBAirport.h"
#import "MOBFlightSegment.h"
#import "MOBBaggage.h"

@protocol MOBFlightStatusSegment @end

@interface MOBFlightStatusSegment : JSONModel

@property (nonatomic, retain) NSString *estimatedDepartureDateTime;
@property (nonatomic, retain) NSString *estimatedArrivalDateTime;
@property (nonatomic, retain) NSString *actualDepartureDateTime;
@property (nonatomic, retain) NSString *actualArrivalDateTime;
@property (nonatomic, retain) NSString *departureTerminal;
@property (nonatomic, retain) NSString *arrivalTerminal;
@property (nonatomic, retain) NSString *departureGate;
@property (nonatomic, retain) NSString *arrivalGate;
@property (nonatomic, retain) MOBEquipment *ship;
@property (nonatomic, retain) MOBAirline <Optional> *operatingCarrier;
@property (nonatomic, retain) MOBAirline <Optional> *codeShareCarrier;
@property (nonatomic, retain) NSString *status;
//@property (nonatomic, assign) BOOL getInBoundSegment;
@property (nonatomic, assign) BOOL enableSeatMap;
@property (nonatomic, assign) BOOL enableStandbyList;
@property (nonatomic, assign) BOOL enableUpgradeList;
@property (nonatomic, assign) BOOL enableAmenity;
@property (nonatomic, assign) BOOL addToComplications;
@property (nonatomic, assign) BOOL isWiFiAvailable;
@property (nonatomic, retain) NSString *codeShareflightNumber;
@property (nonatomic, assign) BOOL canPushNotification;
@property (nonatomic, assign) BOOL isSegmentCancelled;
@property (nonatomic, retain) MOBAirline *marketingCarrier;
@property (nonatomic, retain) NSString *flightNumber;
@property (nonatomic, retain) MOBAirport *departure;
@property (nonatomic, retain) MOBAirport *arrival;
@property (nonatomic, retain) NSString *scheduledDepartureDateTime;
@property (nonatomic, retain) NSString *scheduledArrivalDateTime;
@property (nonatomic, retain) NSString *scheduledDepartureTimeGMT;
@property (nonatomic, retain) NSString *scheduledArrivalTimeGMT;
@property (nonatomic, retain) NSString *formattedScheduledDepartureDateTime;
@property (nonatomic, retain) NSString *formattedScheduledArrivalDateTime;
@property (nonatomic, retain) NSString *formattedScheduledDepartureDate;
@property (nonatomic, retain) NSString *formattedScheduledArrivalDate;
@property (nonatomic, retain) NSString *formattedScheduledDepartureTime;
@property (nonatomic, retain) NSString *formattedScheduledArrivalTime;
@property (nonatomic, retain) NSString *statusShort;
@property (nonatomic, retain) NSString *pushNotificationRegId;
@property (nonatomic, retain) NSString *lastUpdatedGMT;
@property (nonatomic, retain) MOBFlightSegment <Optional> *inBoundSegment;
@property (nonatomic, retain) MOBBaggage* baggage;

@end
