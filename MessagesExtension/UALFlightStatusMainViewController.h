//
//  UALFlightStatusMainViewController.h
//  MySecond_iMessagesApp
//
//  Created by Gopal Rao Gurram on 3/11/17.
//  Copyright © 2017 Gopal Rao Gurram. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UACFWSResponse.h"
#import "UACFWSConnectionHandler.h"
#import "MOBFlightStatusResponse.h"
#import "UALFlightStatusViewController.h"
#import "UALFlightStatusAdapter.h"

@protocol UALFlightStatusMainViewControllerDelegate <NSObject>

@optional

- (void)expandFlightStatusMainViewController: (UITextField *)textField;

- (void)composeMessageWithFlightStatusSegment: (UALFlightSegment *)flightSegment;

@end

@interface UALFlightStatusMainViewController : UIViewController<UITextFieldDelegate, UALFlightStatusViewControllerDelegate>

@property (weak, nonatomic) IBOutlet UILabel *flightNumberSearchTitleLabel;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *flightNumberSearchTitleLabelHeightConstraint;



@property (weak, nonatomic) IBOutlet UITextField *flightNumberTextField;

@property (weak, nonatomic) IBOutlet UIDatePicker *flightDepartDatePickerView;

@property (weak, nonatomic) IBOutlet UIButton *searchFlightStatusButton;

@property (weak, nonatomic) NSObject<UALFlightStatusMainViewControllerDelegate> *delegate;

@property (weak, nonatomic) IBOutlet UIView *activityIndicatorView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *activityIndicatorViewHeightConstraint;

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

@property (weak, nonatomic) IBOutlet UILabel *statusMessageLabel;


@end
