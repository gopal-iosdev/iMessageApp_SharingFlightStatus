//
//  UALFlightStatusViewController.h
//  MySecond_iMessagesApp
//
//  Created by Gopal Rao Gurram on 3/13/17.
//  Copyright © 2017 Gopal Rao Gurram. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MOBFlightStatusSegment.h"
#import "DateExtension.h"
#import "UALFlightSegment.h"

@protocol UALFlightStatusViewControllerDelegate <NSObject>

@optional

- (void)composeMessageWithMOBFlightStatusSegment: (UALFlightSegment *)flightSegment;

@end

@interface UALFlightStatusViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIView *contentView;

@property (weak, nonatomic) IBOutlet UILabel *flightNumAndDepartDateLabel;

@property (weak, nonatomic) IBOutlet UILabel *departureToArrivalCityLabel;

@property (weak, nonatomic) IBOutlet UILabel *flightStatusLabel;

@property (weak, nonatomic) IBOutlet UILabel *flightOriginLabel;

@property (weak, nonatomic) IBOutlet UILabel *flightDestinationLabel;

@property (weak, nonatomic) IBOutlet UILabel *flightDepartureTimeLabel;

@property (weak, nonatomic) IBOutlet UILabel *flightArrivalTimeLabel;

@property (weak, nonatomic) IBOutlet UILabel *flightArrivalDayLabel;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *flightArrivalDayLabelWidthConstraint;

@property (weak, nonatomic) IBOutlet UILabel *lblScheduleDepartureName;

@property (weak, nonatomic) IBOutlet UILabel *lblScheduledArrivalName;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *estimatedSegmentViewHeightConstraint;

@property (weak, nonatomic) IBOutlet UILabel *estimatedSegmentFlightDepartureTimeLabel;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *estimatedSegmentFlightDepartureTimeLabelHeightConstraint;


@property (weak, nonatomic) IBOutlet UILabel *estimatedSegmentFlightArrivalTimeLabel;

@property (weak, nonatomic) IBOutlet UILabel *lblDateOffsetEstimatedOrActual;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lblDateOffsetEstimatedOrActualWidthConstraint;


@property (weak, nonatomic) IBOutlet UILabel *estimatedSegmentLeftLabel;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *estimatedSegmentLeftLabelHeightConstraint;

@property (weak, nonatomic) IBOutlet UILabel *estimatedSegmentRightLabel;

@property (weak, nonatomic) IBOutlet UILabel *departureGateLabel;

@property (weak, nonatomic) IBOutlet UILabel *arrivalGateLabel;

@property (weak, nonatomic) IBOutlet UILabel *baggageClaimStatusLabel;

@property (weak, nonatomic) IBOutlet UIButton *shareFlightStatusButton;


@property (strong, retain) MOBFlightStatusSegment *flightStatusSegment;

@property (nonatomic, strong) UALFlightSegment *flightSegment;

@property (weak, nonatomic) NSObject<UALFlightStatusViewControllerDelegate> *delegate;

@property (nonatomic, assign) BOOL makeFlightStatusWebServiceCall;

@end
