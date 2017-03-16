//
//  UALFlightSegment.m
//  MySecond_iMessagesApp
//
//  Created by Gopal Rao Gurram on 3/15/17.
//  Copyright © 2017 Gopal Rao Gurram. All rights reserved.
//

#import "UALFlightSegment.h"

@interface UALFlightSegment()

@property (nonatomic, copy) flightSegmentResponseCompletionHandler CompletionHandler;
@property (nonatomic, strong) UALFlightSegment *flightSegment;

@end

@implementation UALFlightSegment

static UALFlightSegment *gInstance = NULL;

+(UALFlightSegment *)singleton{
    
    @synchronized(self){
        if (gInstance == NULL)
            gInstance = [[self alloc] init];
    }
    return(gInstance);
}

-(UALFlightSegment *)init{
    
    self = [super init];
    return self;
}


- (void)returnUALFlightSegementFor:(NSString *)flightNumber forFlightDate:(NSString *)flightDate forOrigin:(NSString *)origin completionHandler:(flightSegmentResponseCompletionHandler)handler{
    
    self.flightSegment = [UALFlightSegment new];
    
    self.flightSegment.flightDateForMakingUrl = flightDate;
    
    self.flightSegment.flightStatusCallFailed = NO;
    
    
    self.CompletionHandler = handler;
    
    __weak typeof(self) weakSelf = self;
    [[UALFlightStatusAdapter singleton] getFlightStatus:flightNumber forFlightDate: flightDate forOrigin: origin : ^(UACFWSResponse *response){
        
        [weakSelf flightStatusWithNumberCallCompleted:response];
    }];
}

- (void)flightStatusWithNumberCallCompleted:(UACFWSResponse *)response{
    
    if (response.Error == nil){
        
        NSString *jsonString = (NSString *)response.Result;
        NSError *err = nil;
        MOBFlightStatusResponse *flightStatusResponse = [[MOBFlightStatusResponse alloc] initWithString:jsonString error:&err];
        if (err == nil){
            
            MOBException *exception = flightStatusResponse.exception;
            if (!exception || [exception.code isEqualToString:@""] || exception.code.length){
                
                if (flightStatusResponse.flightStatusInfo.segments != nil && [flightStatusResponse.flightStatusInfo.segments count] > 0 && ([flightStatusResponse.flightStatusInfo.segments count] == 1)){
                    
                    self.flightSegment.flightStatusCallFailed = NO;
                    self.flightSegment.errorMessage = @"";
                    
                    MOBFlightStatusSegment *segment = [flightStatusResponse.flightStatusInfo.segments objectAtIndex:0];
                    // return response
                    [self buildFlightSegmentFrom: segment];
                    
                    self.CompletionHandler(self.flightSegment);
                    return;
                    
                }else{
                    self.flightSegment.errorMessage = @" This is a MultiSegment Flight";
                }
            }
            else{
                self.flightSegment.errorMessage = exception.message;
            }
        }
        else{
            self.flightSegment.errorMessage = err.localizedDescription;
        }
    }
    else{
        self.flightSegment.errorMessage = response.Error.localizedDescription;
    }
    self.flightSegment.flightStatusCallFailed = YES;
    self.CompletionHandler(self.flightSegment);
}

- (void)buildFlightSegmentFrom: (MOBFlightStatusSegment *)flightStatusSegment{
    
    self.flightSegment.flightNumber = flightStatusSegment.flightNumber;
    
    self.flightSegment.flightDepartDay = [DateExtension getWordFormatStringDatefrom: flightStatusSegment.scheduledDepartureDateTime];
    
    self.flightSegment.flightDepartureCode = flightStatusSegment.departure.code;
    self.flightSegment.flightArrivalCode = flightStatusSegment.arrival.code;
    
    self.flightSegment.flightDepartCityName = [flightStatusSegment.departure.city isEqualToString:@""]? self.flightSegment.flightDepartureCode: flightStatusSegment.departure.city;
    self.flightSegment.flightArrivalCityName = [flightStatusSegment.arrival.city isEqualToString:@""]? self.flightSegment.flightArrivalCode: flightStatusSegment.arrival.city;
    
    self.flightSegment.flightStatus = flightStatusSegment.status;
    self.flightSegment.flightStatusTextColor = flightStatusSegment.isSegmentCancelled? [UIColor redColor]: [UIColor blueColor];
    
    self.flightSegment.flightScheduledDepartureTime = [DateExtension getHourlyOrMonthlyFormatNumberTimeFromDate: flightStatusSegment.scheduledDepartureDateTime withFormat: @"h:mma"];
    self.flightSegment.flightScheduledArrivalTime = [DateExtension getHourlyOrMonthlyFormatNumberTimeFromDate: flightStatusSegment.scheduledArrivalDateTime withFormat: @"h:mma"];
    
    NSDate *departureDate = [DateExtension getDateFrom: flightStatusSegment.scheduledDepartureDateTime withFormat: @"MM/dd/yyyy hh:mma"];
    NSDate *arrivalDate = [DateExtension getDateFrom: flightStatusSegment.scheduledArrivalDateTime withFormat: @"MM/dd/yyyy hh:mma"];
    NSDate *departDtWithoutTime = [DateExtension dateWithOutTime:departureDate];
    NSDate *arriveDtWithoutTime = [DateExtension dateWithOutTime:arrivalDate];
    self.flightSegment.flightScheduledArrivalDayLabelWidthConstraint = [departDtWithoutTime isEqualToDate:arriveDtWithoutTime]? 0: 45;
    self.flightSegment.flightScheduledArrivalDay = self.flightSegment.flightScheduledArrivalDayLabelWidthConstraint? [DateExtension getHourlyOrMonthlyFormatNumberTimeFromDate: flightStatusSegment.scheduledArrivalDateTime withFormat: @"(MMM d)"]: @"";
    
    self.flightSegment.flightScheduledDepartureStatus = (flightStatusSegment.isSegmentCancelled)? @"Canceled": @"Scheduled";
    self.flightSegment.flightScheduledDepartureStatusTextColor = (flightStatusSegment.isSegmentCancelled)? [UIColor redColor]: [UIColor lightGrayColor];
    self.flightSegment.flightScheduledArrivalStatus = (flightStatusSegment.isSegmentCancelled)? @"": @"Scheduled";
    
    self.flightSegment.flightEstimatedSegmentViewHeightConstraint = [UALFlightSegment hideEstimatedSegmentViewFor: flightStatusSegment]? 0: 50;
    self.flightSegment.flightEstimatedSegmentFlightDepartureTimeLabelHeightConstraint = self.flightSegment.flightEstimatedSegmentViewHeightConstraint? 25: 0;
    self.flightSegment.flightEstimatedDepartureStatusLabelHeightConstraint = self.flightSegment.flightEstimatedSegmentViewHeightConstraint? 21: 0;
    
    [self buildEstimatedViewValuesFor: flightStatusSegment];
    
    self.flightSegment.flightDepartureGateNum = flightStatusSegment.departureGate.length? flightStatusSegment.departureGate: @"N/A";
    self.flightSegment.flightArrivalGateNum = flightStatusSegment.arrivalGate.length? flightStatusSegment.arrivalGate: @"N/A";
    
    self.flightSegment.flightBaggageClaimCenterName = flightStatusSegment.baggage.bagClaimUnit;
    
}

# pragma mark - Helper Methods

+ (BOOL)hideEstimatedSegmentViewFor: (MOBFlightStatusSegment *)flightStatusSegment{
    
    NSString *schDeparture = flightStatusSegment.scheduledDepartureDateTime;
    NSString *schArrival = flightStatusSegment.scheduledArrivalDateTime;
    NSString *estDeparture = flightStatusSegment.estimatedDepartureDateTime;
    NSString *estArrival = flightStatusSegment.estimatedArrivalDateTime;
    NSString *actDeparture = flightStatusSegment.actualDepartureDateTime;
    
    bool bHide = NO;
    
    if (flightStatusSegment.isSegmentCancelled){
        bHide = YES;
        return bHide;
    }
    //check to see if this flight has not departed yet...
    if (actDeparture.length == 0){
        
        bool bHideDeparture = (estDeparture.length == 0 || [schDeparture isEqualToString:estDeparture]);
        bool bHideArrival = (estArrival.length == 0 || [schArrival isEqualToString:estArrival]);
        bHide = (bHideDeparture && bHideArrival)? YES: NO;
    }
    return bHide;
}

- (void)buildEstimatedViewValuesFor: (MOBFlightStatusSegment *)flightStatusSegment{
    
    self.flightSegment.flightEstimatedDepartureTime = @"";
    self.flightSegment.flightEstimatedArrivalTime = @"";
    
    self.flightSegment.flightEstimatedArrivalDay = @"";
    self.flightSegment.flightEstimatedArrivalDayLabelWidthConstraint = 0;
    
    self.flightSegment.flightEstimatedDepartureStatus = @"";
    self.flightSegment.flightEstimatedDepartureStatusTextColor = [UIColor lightGrayColor];
    self.flightSegment.flightEstimatedArrivalStatus = @"";
    
    if (!self.flightSegment.flightEstimatedSegmentViewHeightConstraint) {
        return;
    }
    
    //ESTIMATED OR ACTUAL TIME
    NSString *estDeparture = flightStatusSegment.estimatedDepartureDateTime;
    NSString *estArrival = flightStatusSegment.estimatedArrivalDateTime;
    NSString *actDeparture = flightStatusSegment.actualDepartureDateTime;
    NSString *actArrival = flightStatusSegment.actualArrivalDateTime;
    
    //do we have an actual departure time?
    if (actDeparture.length){
        
        self.flightSegment.flightEstimatedDepartureTime = [DateExtension getHourlyOrMonthlyFormatNumberTimeFromDate: actDeparture withFormat: @"h:mma"];
        self.flightSegment.flightEstimatedDepartureStatus = @"Actual";
        
    }
    else if (estDeparture.length){
        
        self.flightSegment.flightEstimatedDepartureTime = [DateExtension getHourlyOrMonthlyFormatNumberTimeFromDate: estDeparture withFormat: @"h:mma"];
        self.flightSegment.flightEstimatedDepartureStatus = @"Estimated";
    }
    else{//always default to scheduled
        
        self.flightSegment.flightEstimatedDepartureTime = self.flightSegment.flightScheduledDepartureTime;
        self.flightSegment.flightEstimatedDepartureStatus = @"Scheduled";
    }
    
    NSDate *departureDate = [DateExtension getDateFrom: flightStatusSegment.scheduledDepartureDateTime withFormat: @"MM/dd/yyyy hh:mma"];
    NSDate *arrivalDate = [DateExtension getDateFrom: flightStatusSegment.scheduledArrivalDateTime withFormat: @"MM/dd/yyyy hh:mma"];
    NSDate *departDtWithoutTime = [DateExtension dateWithOutTime: departureDate];
    NSDate *arriveDtWithoutTime = [DateExtension dateWithOutTime: arrivalDate];
    
    self.flightSegment.flightEstimatedArrivalDayLabelWidthConstraint = [departDtWithoutTime isEqualToDate:arriveDtWithoutTime]? 0: 45;
    self.flightSegment.flightEstimatedArrivalDay = self.flightSegment.flightEstimatedArrivalDayLabelWidthConstraint? [DateExtension getHourlyOrMonthlyFormatNumberTimeFromDate: (actArrival.length? actArrival: estArrival) withFormat: @"(MMM d)"]: @"";
    
    if (actArrival.length){
        
        self.flightSegment.flightEstimatedArrivalTime = [DateExtension getHourlyOrMonthlyFormatNumberTimeFromDate: actArrival withFormat: @"h:mma"];
        self.flightSegment.flightEstimatedArrivalStatus = @"Actual";
    }
    else if (estArrival.length){
        
        self.flightSegment.flightEstimatedArrivalTime = [DateExtension getHourlyOrMonthlyFormatNumberTimeFromDate: estArrival withFormat: @"h:mma"];
        self.flightSegment.flightEstimatedArrivalStatus = @"Estimated";
    }
    else{//always default to scheduled

        self.flightSegment.flightEstimatedArrivalTime = self.flightSegment.flightScheduledArrivalTime;
        self.flightSegment.flightEstimatedArrivalStatus = @"Scheduled";
    }
}

@end
