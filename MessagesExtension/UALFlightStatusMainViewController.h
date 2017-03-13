//
//  UALFlightStatusMainViewController.h
//  MySecond_iMessagesApp
//
//  Created by Gopal Rao Gurram on 3/11/17.
//  Copyright © 2017 Gopal Rao Gurram. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "UACFWSResponse.h"

@interface UALFlightStatusMainViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *flightNumberTextField;

@property (weak, nonatomic) IBOutlet UIDatePicker *flightDepartDatePickerView;

@property (weak, nonatomic) IBOutlet UIButton *searchFlightStatusButton;


@end
