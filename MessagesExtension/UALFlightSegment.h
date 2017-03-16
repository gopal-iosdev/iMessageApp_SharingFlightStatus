//
//  UALFlightSegment.h
//  MySecond_iMessagesApp
//
//  Created by Gopal Rao Gurram on 3/15/17.
//  Copyright © 2017 Gopal Rao Gurram. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "MOBFlightStatusSegment.h"
#import "UALFlightStatusAdapter.h"
#import "DateExtension.h"

@interface UALFlightSegment : NSObject

+(UALFlightSegment *)singleton;

typedef void (^flightSegmentResponseCompletionHandler)(UALFlightSegment*);

@property (nonatomic, assign) BOOL flightStatusCallFailed;
@property (nonatomic, strong) NSString *errorMessage;

@property (nonatomic, strong) NSString *flightDateForMakingUrl;

@property (nonatomic, strong) NSString *flightNumber;

@property (nonatomic, strong) NSString *flightDepartDay;

@property (nonatomic, strong) NSString *flightDepartureCode;
@property (nonatomic, strong) NSString *flightArrivalCode;

@property (nonatomic, strong) NSString *flightDepartCityName;
@property (nonatomic, strong) NSString *flightArrivalCityName;

@property (nonatomic, strong) NSString *flightStatus;
@property (nonatomic, strong) UIColor *flightStatusTextColor;

@property (nonatomic, strong) NSString *flightScheduledDepartureTime;
@property (nonatomic, strong) NSString *flightScheduledArrivalTime;

@property (nonatomic, strong) NSString *flightScheduledArrivalDay;
@property (nonatomic, assign) int flightScheduledArrivalDayLabelWidthConstraint;

@property (nonatomic, strong) NSString *flightScheduledDepartureStatus;
@property (nonatomic, strong) UIColor *flightScheduledDepartureStatusTextColor;
@property (nonatomic, strong) NSString *flightScheduledArrivalStatus;

@property (nonatomic, assign) int flightEstimatedSegmentViewHeightConstraint;
@property (nonatomic, assign) int flightEstimatedSegmentFlightDepartureTimeLabelHeightConstraint;
@property (nonatomic, assign) int flightEstimatedDepartureStatusLabelHeightConstraint;

@property (nonatomic, strong) NSString *flightEstimatedDepartureTime;
@property (nonatomic, strong) NSString *flightEstimatedArrivalTime;

@property (nonatomic, strong) NSString *flightEstimatedArrivalDay;
@property (nonatomic, assign) int flightEstimatedArrivalDayLabelWidthConstraint;

@property (nonatomic, strong) NSString *flightEstimatedDepartureStatus;
@property (nonatomic, strong) UIColor *flightEstimatedDepartureStatusTextColor;
@property (nonatomic, strong) NSString *flightEstimatedArrivalStatus;

@property (nonatomic, strong) NSString *flightDepartureGateNum;
@property (nonatomic, strong) NSString *flightArrivalGateNum;

@property (nonatomic, strong) NSString *flightBaggageClaimCenterName;

- (void)returnUALFlightSegementFor:(NSString *)flightNumber forFlightDate:(NSString *)flightDate forOrigin:(NSString *)origin completionHandler:(flightSegmentResponseCompletionHandler)handler;

@end
