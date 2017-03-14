//
//  UALFlightStatusViewController.m
//  MySecond_iMessagesApp
//
//  Created by Gopal Rao Gurram on 3/13/17.
//  Copyright © 2017 Gopal Rao Gurram. All rights reserved.
//

#import "UALFlightStatusViewController.h"

@interface UALFlightStatusViewController ()

@end

@implementation UALFlightStatusViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self updateFlightStatusView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)updateFlightStatusView{
    
    //
    
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    NSLocale *timeLocale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
    [df setLocale:timeLocale];
    [df setDateFormat:@"MM/dd/yyyy hh:mma"];
    NSDate *flightDt = [df dateFromString: self.flightStatusSegment.scheduledDepartureDateTime];
    //[df setDateFormat:@"MMM dd, yyyy"];
    [df setDateFormat:@"EEE., MMM d, yyyy"];
    NSString *flightDate = [df stringFromDate:flightDt];
    
    NSString *origin = @"";
    NSString *destination = @"";
    
    //check to see if we have the cities...
    if (![self.flightStatusSegment.departure.city isEqualToString:@""])
    {
        origin = self.flightStatusSegment.departure.city;
    }
    else
    {
        origin = self.flightStatusSegment.departure.code;
    }
    
    if (![self.flightStatusSegment.arrival.city isEqualToString:@""])
    {
        destination = self.flightStatusSegment.arrival.city;
    }
    else
    {
        destination = self.flightStatusSegment.arrival.code;
    }

    
    self.flightNumAndDepartDateLabel.text = [NSString stringWithFormat:@"%@%@ / %@", @"UA", self.flightStatusSegment.flightNumber, flightDate];
    self.departureToArrivalCityLabel.text = [NSString stringWithFormat:@"%@ to %@", origin, destination];
    
    //FLIGHT STATUS
    self.flightStatusLabel.text = self.flightStatusSegment.status;
    
    self.flightStatusLabel.textColor = self.flightStatusSegment.isSegmentCancelled? [UIColor redColor]: [UIColor greenColor];
    
    //Origin & Destination
    self.flightOriginLabel.text = self.flightStatusSegment.departure.code;
    self.flightDestinationLabel.text = self.flightStatusSegment.arrival.code;
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setAMSymbol:@"am"];
    [dateFormatter setPMSymbol:@"pm"];
    
    NSLocale *timeLocale2 = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
    [dateFormatter setLocale:timeLocale2];
    
    [dateFormatter setDateFormat:@"MM/dd/yyyy hh:mma"];
    NSDate *scheduleDepartureDate = [dateFormatter dateFromString: self.flightStatusSegment.scheduledDepartureDateTime];
    NSDate *departureDate = [dateFormatter dateFromString: self.flightStatusSegment.scheduledDepartureDateTime];
    NSDate *arrivalDate = [dateFormatter dateFromString: self.flightStatusSegment.scheduledArrivalDateTime];
    
    [dateFormatter setDateFormat:@"h:mma"];
    
    self.flightDepartureTimeLabel.text = [dateFormatter stringFromDate:departureDate];
    self.flightArrivalTimeLabel.text = [dateFormatter stringFromDate:arrivalDate];
    
    [dateFormatter setDateFormat:@"(MMM d)"];
    NSString *offsetDate = [dateFormatter stringFromDate:arrivalDate];
    
    NSDate *departDtWithoutTime = [self dateWithOutTime:departureDate];
    NSDate *arriveDtWithoutTime = [self dateWithOutTime:arrivalDate];
    
    // flightArrivalDayLabel
    
    if ([departDtWithoutTime isEqualToDate:arriveDtWithoutTime]){
        
        self.flightArrivalDayLabelWidthConstraint.constant = 0;
    }
    else{
        
        self.flightArrivalDayLabel.text = offsetDate;
        self.flightArrivalDayLabelWidthConstraint.constant = 45;
    }
    
    // lblScheduleDepartureName, lblScheduledArrivalName

    if (self.flightStatusSegment.isSegmentCancelled){
        
        self.lblScheduleDepartureName.text = @"Canceled";
        self.lblScheduledArrivalName.text = @"";
        self.lblScheduleDepartureName.textColor = [UIColor redColor];
    }
    else{
        self.lblScheduleDepartureName.text = @"Scheduled";
        self.lblScheduledArrivalName.text = @"Scheduled";
    }
    
    //
    
    //ESTIMATED OR ACTUAL TIME
    NSString *schDeparture = self.flightStatusSegment.scheduledDepartureDateTime;
    NSString *schArrival = self.flightStatusSegment.scheduledArrivalDateTime;
    NSString *estDeparture = self.flightStatusSegment.estimatedDepartureDateTime;
    NSString *estArrival = self.flightStatusSegment.estimatedArrivalDateTime;
    NSString *actDeparture = self.flightStatusSegment.actualDepartureDateTime;
    NSString *actArrival = self.flightStatusSegment.actualArrivalDateTime;
    
    bool bHide = NO;
    //check to see if this flight has not departed yet...
    if (actDeparture.length == 0)
    {
        bool bHideDeparture = NO;
        bool bHideArrival = NO;
        
        //check to see if we have estimated departure and if so, is the same as scheduled?
        if (estDeparture.length == 0 || [schDeparture isEqualToString:estDeparture])
        {
            bHideDeparture = YES;
            
        }
        
        //check to see if we have estimated departure and if so, is the same as scheduled?
        if (estArrival.length == 0 || [schArrival isEqualToString:estArrival])
        {
            bHideArrival = YES;
            
        }
        
        if (bHideDeparture == YES && bHideArrival == YES)
        {
            bHide = YES;
        }
        else
        {
            bHide = NO;
        }
        
    }
    if (self.flightStatusSegment.isSegmentCancelled)
    {
        bHide = YES;
    }
    
    //reset all the labels...
    self.estimatedSegmentFlightDepartureTimeLabel.text = @"";
    self.estimatedSegmentLeftLabel.text = @"";
    self.estimatedSegmentFlightArrivalTimeLabel.text = @"";
    self.estimatedSegmentRightLabel.text = @"";
    
    if (bHide == YES){
        //we need to hide the Estimated/Actual view
        // hide Estimated View
        self.estimatedSegmentViewHeightConstraint.constant = 0;
        self.estimatedSegmentFlightDepartureTimeLabelHeightConstraint.constant = 0;
        self.estimatedSegmentLeftLabelHeightConstraint.constant = 0;
    }
    else{
        
        // Don't hide Estimated View
        
        self.estimatedSegmentViewHeightConstraint.constant = 50;
        self.estimatedSegmentFlightDepartureTimeLabelHeightConstraint.constant = 25;
        self.estimatedSegmentLeftLabelHeightConstraint.constant = 21;
        
        //do we have an actual departure time?
        if (actDeparture.length){
            
            self.estimatedSegmentLeftLabel.text = @"Actual";
            [dateFormatter setDateFormat:@"MM/dd/yyyy hh:mm a"];
            departureDate = [dateFormatter dateFromString: actDeparture];
            
            [dateFormatter setDateFormat:@"h:mma"];
            
            self.estimatedSegmentFlightDepartureTimeLabel.text = [dateFormatter stringFromDate:departureDate];
            
        }
        else if (estDeparture.length){
            
            self.estimatedSegmentLeftLabel.text = @"Estimated";
            [dateFormatter setDateFormat:@"MM/dd/yyyy hh:mm a"];
            departureDate = [dateFormatter dateFromString: estDeparture];
            
            [dateFormatter setDateFormat:@"h:mma"];
            
            self.estimatedSegmentFlightDepartureTimeLabel.text = [dateFormatter stringFromDate:departureDate];
        }
        else{//always default to scheduled
            
            self.estimatedSegmentLeftLabel.text = @"Scheduled";
            self.estimatedSegmentFlightDepartureTimeLabel.text = self.flightDepartureTimeLabel.text;
        }
        
        //do we have an actual departure time?
        if (actArrival.length){
            
            self.estimatedSegmentRightLabel.text = @"Actual";
            [dateFormatter setDateFormat:@"MM/dd/yyyy hh:mm a"];
            arrivalDate = [dateFormatter dateFromString: actArrival];
            
            [dateFormatter setDateFormat:@"h:mma"];
            
            self.estimatedSegmentFlightArrivalTimeLabel.text = [dateFormatter stringFromDate:arrivalDate];
            
            [dateFormatter setDateFormat:@"(MMM d)"];
            NSString *offsetDate = [dateFormatter stringFromDate:arrivalDate];
            
            NSDate *departDtWithoutTime = [self dateWithOutTime:scheduleDepartureDate];
            NSDate *arriveDtWithoutTime = [self dateWithOutTime:arrivalDate];
            
            if ([departDtWithoutTime isEqualToDate:arriveDtWithoutTime]){
                
                self.lblDateOffsetEstimatedOrActualWidthConstraint.constant = 0;
            }
            else{
                self.lblDateOffsetEstimatedOrActualWidthConstraint.constant = 45;
                self.lblDateOffsetEstimatedOrActual.text = offsetDate;
            }
        }
        else if (estArrival.length){
            
            self.estimatedSegmentRightLabel.text = @"Estimated";
            [dateFormatter setDateFormat:@"MM/dd/yyyy hh:mm a"];
            arrivalDate = [dateFormatter dateFromString: estArrival];
            
            [dateFormatter setDateFormat:@"h:mma"];
            
            self.estimatedSegmentFlightArrivalTimeLabel.text = [dateFormatter stringFromDate:arrivalDate];
            
            [dateFormatter setDateFormat:@"(MMM d)"];
            NSString *offsetDate = [dateFormatter stringFromDate:arrivalDate];
            
            NSDate *departDtWithoutTime = [self dateWithOutTime:scheduleDepartureDate];
            NSDate *arriveDtWithoutTime = [self dateWithOutTime:arrivalDate];
            
            if ([departDtWithoutTime isEqualToDate:arriveDtWithoutTime]){
                
                self.lblDateOffsetEstimatedOrActualWidthConstraint.constant = 0;
            }
            else{
                self.lblDateOffsetEstimatedOrActualWidthConstraint.constant = 45;
                self.lblDateOffsetEstimatedOrActual.text = offsetDate;
            }
        }
        else{//always default to scheduled
            
            self.estimatedSegmentRightLabel.text = @"Scheduled";
            self.estimatedSegmentFlightArrivalTimeLabel.text = self.flightArrivalTimeLabel.text;
        }
    
    }
    
    //Gate Information
    
    if (self.flightStatusSegment.departureGate.length == 0)
    {
        self.departureGateLabel.text = @"N/A";
    }
    else
    {
        self.departureGateLabel.text = self.flightStatusSegment.departureGate;
    }
    
    if (self.flightStatusSegment.arrivalGate.length == 0)
    {
        self.arrivalGateLabel.text = @"N/A";
    }
    else
    {
        self.arrivalGateLabel.text = self.flightStatusSegment.arrivalGate;
    }
    
    //baggageClaimStatusLabel
    self.baggageClaimStatusLabel.text = self.flightStatusSegment.baggage.bagClaimUnit;

}

# pragma mark - All Helper Methods

-(NSDate *)dateWithOutTime:(NSDate *)datDate
{
    if( datDate == nil ) {
        datDate = [NSDate date];
    }
    NSDateComponents* comps = [[NSCalendar currentCalendar] components:NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit fromDate:datDate];
    return [[NSCalendar currentCalendar] dateFromComponents:comps];
}

- (IBAction)shareFlightStatusButtonClicked:(UIButton *)sender {
    
    
}


@end
