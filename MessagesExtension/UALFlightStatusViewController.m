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
    
    if (self.makeFlightStatusWebServiceCall) {
        
        [self buildFlightSegmentModel];
        self.makeFlightStatusWebServiceCall = NO;
    }
    else{
        
        [self updateFlightStatusViewNew];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

# pragma mark - Build Flight Segment Model

- (void)buildFlightSegmentModel{
    
    __weak typeof(self) weakSelf = self;
    [[UALFlightSegment singleton] returnUALFlightSegementFor: self.flightSegment.flightNumber forFlightDate: self.flightSegment.flightDateForMakingUrl forOrigin: self.flightSegment.flightDepartureCode completionHandler:^(UALFlightSegment *flightSegment) {
        [weakSelf updateFlightStatusViewWith: flightSegment];
    }];
}

- (void)updateFlightStatusViewWith: (UALFlightSegment *)flightSegment{
    
    self.flightSegment = flightSegment;
    [self updateFlightStatusViewNew];
}


- (void)updateFlightStatusViewNew{
    
    if (self.flightSegment.flightStatusCallFailed) {
        [self showAlertViewWithTitle: @"United Airlines" message: self.flightSegment.errorMessage];
        return;
    }
    self.flightNumAndDepartDateLabel.text = [NSString stringWithFormat:@"%@%@ / %@", @"UA", self.flightSegment.flightNumber, self.flightSegment.flightDepartDay];
    
    self.departureToArrivalCityLabel.text = [NSString stringWithFormat:@"%@ to %@", self.flightSegment.flightDepartCityName, self.flightSegment.flightArrivalCityName];
    
    //FLIGHT STATUS
    self.flightStatusLabel.text = self.flightSegment.flightStatus;
    self.flightStatusLabel.textColor = self.flightSegment.flightStatusTextColor;
    
    //Origin & Destination
    self.flightOriginLabel.text = self.flightSegment.flightDepartureCode;
    self.flightDestinationLabel.text = self.flightSegment.flightArrivalCode;
    
    self.flightDepartureTimeLabel.text = self.flightSegment.flightScheduledDepartureTime;
    self.flightArrivalTimeLabel.text = self.flightSegment.flightScheduledArrivalTime;
    
    self.flightArrivalDayLabelWidthConstraint.constant = self.flightSegment.flightScheduledArrivalDayLabelWidthConstraint;
    self.flightArrivalDayLabel.text = self.flightSegment.flightScheduledArrivalDay;
    
    self.lblScheduleDepartureName.textColor = self.flightSegment.flightScheduledDepartureStatusTextColor;
    self.lblScheduleDepartureName.text = self.flightSegment.flightScheduledDepartureStatus;
    self.lblScheduledArrivalName.text = self.flightSegment.flightScheduledArrivalStatus;
    
    self.estimatedSegmentViewHeightConstraint.constant = self.flightSegment.flightEstimatedSegmentViewHeightConstraint;
    self.estimatedSegmentFlightDepartureTimeLabelHeightConstraint.constant = self.flightSegment.flightEstimatedSegmentFlightDepartureTimeLabelHeightConstraint;
    self.estimatedSegmentLeftLabelHeightConstraint.constant = self.flightSegment.flightEstimatedDepartureStatusLabelHeightConstraint;
    
    self.estimatedSegmentFlightDepartureTimeLabel.text = self.flightSegment.flightEstimatedDepartureTime;
    self.estimatedSegmentFlightArrivalTimeLabel.text = self.flightSegment.flightEstimatedArrivalTime;
    
    self.lblDateOffsetEstimatedOrActualWidthConstraint.constant = self.flightSegment.flightEstimatedArrivalDayLabelWidthConstraint;
    self.lblDateOffsetEstimatedOrActual.text = self.flightSegment.flightEstimatedArrivalDay;
    
    self.estimatedSegmentLeftLabel.text = self.flightSegment.flightEstimatedDepartureStatus;
    self.estimatedSegmentRightLabel.text = self.flightSegment.flightEstimatedArrivalStatus;
    
    self.departureGateLabel.text = self.flightSegment.flightDepartureGateNum;
    self.arrivalGateLabel.text = self.flightSegment.flightArrivalGateNum;
    
    self.baggageClaimStatusLabel.text = self.flightSegment.flightBaggageClaimCenterName;
}

# pragma mark - All Helper Methods

- (IBAction)shareFlightStatusButtonClicked:(UIButton *)sender {
    
    [self.delegate composeMessageWithMOBFlightStatusSegment: self.flightSegment];
}


- (void) showAlertViewWithTitle: (NSString *)alertTitle message: (NSString *)alertMessage{
    
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:alertTitle message: alertMessage preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"Continue" style: UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction * action) {
                                                              [alert dismissViewControllerAnimated:YES completion:nil];
                                                          }];
    [alert addAction:defaultAction];
    [self presentViewController:alert animated:YES completion:nil];
}


@end
