//
//  UALFlightStatusMainViewController.m
//  MySecond_iMessagesApp
//
//  Created by Gopal Rao Gurram on 3/11/17.
//  Copyright © 2017 Gopal Rao Gurram. All rights reserved.
//

#import "UALFlightStatusMainViewController.h"

@interface UALFlightStatusMainViewController ()

@property (nonatomic,retain) NSDate *FlightDate;
@property (nonatomic, strong) UALFlightStatusViewController *flightStatusViewController;

@end

@implementation UALFlightStatusMainViewController

NSString *requestString;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.flightNumberSearchTitleLabelHeightConstraint.constant = 44.0;
    self.flightNumberTextField.delegate = self;
    
    [self updateAcitivityIndicatorWithFlag: 0];
}

- (void)viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear: animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)flightDepartDateValueChanged:(UIDatePicker *)sender {
    
    self.FlightDate = sender.date;
}


- (IBAction)searchFlightStatusButtonClicked:(UIButton *)sender {
    
    [self updateAcitivityIndicatorWithFlag: 1];
    self.activityIndicatorViewHeightConstraint.constant = 100;
    [self resignFirstResponders];
    if ([self.flightNumberTextField.text length] > 0){
        
        [self doSearchByFlightNumber];
    }
    else{
        
        [self updateAcitivityIndicatorWithFlag: 0];
        [self showAlertViewWithTitle: @"United Airlines" message: @"Please complete all necessary information to search for Flight information."];
    }
}

- (void) resignFirstResponders{
    
    [self.flightNumberTextField resignFirstResponder];
    [self.flightDepartDatePickerView resignFirstResponder];
}

- (void) doSearchByFlightNumber{
    
    NSString *flightNumber = [[NSString alloc] init];
    flightNumber = self.flightNumberTextField.text;
    
    NSDateFormatter *dateFormatterNew = [DateExtension getDateFormatterWithFormat: @"yyyy-MM-dd"];
    NSString *flightDate =  [dateFormatterNew stringFromDate: (self.FlightDate? self.FlightDate: self.flightDepartDatePickerView.date)];
    NSString *origin = @"";
    
    __weak typeof(self) weakSelf = self;
    
    [[UALFlightSegment singleton] returnUALFlightSegementFor: flightNumber forFlightDate: flightDate forOrigin: origin completionHandler:^(UALFlightSegment *flightSegment) {
        [weakSelf navigateToFlightStatusViewControllerWith: flightSegment];
    }];
}

- (void)navigateToFlightStatusViewControllerWith: (UALFlightSegment *)flightSegment{
    
    [self updateAcitivityIndicatorWithFlag: 0];
    if (flightSegment.flightStatusCallFailed) {
        
        [self showAlertViewWithTitle: @"United Airlines" message: flightSegment.errorMessage];
        return;
    }
    [self presentFlightStatusViewControllerWithFlightSegment: flightSegment];
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

# pragma mark - Present Flight Status View Controller

- (void)presentFlightStatusViewControllerWithFlightSegment: (UALFlightSegment *)flightSegment{
    
    self.flightStatusViewController = (UALFlightStatusViewController *)[self.storyboard instantiateViewControllerWithIdentifier:@"UALFlightStatusViewController"];
    self.flightNumberSearchTitleLabelHeightConstraint.constant = 0;
    self.flightStatusViewController.flightSegment = flightSegment;
    [self.view addSubview: self.flightStatusViewController.view];
    [self addChildViewController: self.flightStatusViewController];
    [self.flightStatusViewController didMoveToParentViewController: self];
    self.flightStatusViewController.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    self.flightStatusViewController.delegate = self;
    [self.navigationController presentViewController: self.flightStatusViewController animated: YES completion: nil];
}

# pragma mark - All Delegate Methods

# pragma mark UITextField Delegate Methods

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    //[self.delegate expandFlightStatusMainViewController: textField];
}

# pragma mark - UALFlightStatusViewControllerDelegate

- (void)composeMessageWithMOBFlightStatusSegment: (UALFlightSegment *)flightSegment{
    
     [self.delegate composeMessageWithFlightStatusSegment: flightSegment];
}

# pragma mark - All Helper Methods

- (void)updateAcitivityIndicatorWithFlag: (int)show{
    
    self.activityIndicator.alpha = show;
    self.statusMessageLabel.alpha = show;
}

@end
