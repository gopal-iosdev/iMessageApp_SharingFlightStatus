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
}

- (void)viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear: animated];
    //[self.flightNumberTextField becomeFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)flightDepartDateValueChanged:(UIDatePicker *)sender {
    
    self.FlightDate = sender.date;
}


- (IBAction)searchFlightStatusButtonClicked:(UIButton *)sender {
    
    [self resignFirstResponders];
    if ([self.flightNumberTextField.text length] > 0){
        
        [self doSearchByFlightNumber];
    }
    else{

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
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    NSLocale *timeLocale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
    [dateFormatter setLocale:timeLocale];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *dt =  [dateFormatter stringFromDate:self.FlightDate];
    
    NSString *origin = @"";
    
    __weak typeof(self) weakSelf = self;
    
    requestString = [NSString stringWithFormat:@"FlightNumber:%@, FlightDate:%@, Origin:%@", flightNumber,dt,origin];
    
    [[UALFlightStatusAdapter singleton] getFlightStatus:flightNumber forFlightDate:dt forOrigin: origin : ^(UACFWSResponse *response){
        [weakSelf flightStatusWithNumberCallCompleted:response];}];
    
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
                    
                    MOBFlightStatusSegment *segment = [flightStatusResponse.flightStatusInfo.segments objectAtIndex:0];
                    [self presentFlightStatusViewControllerWithResponse: segment];
                    
                }else{
                    
                    [self showAlertViewWithTitle: @"United Airlines" message: @" This is a MultiSegment Flight"];
                }
            }
            else{
                
                NSString *errorMessage = exception.message;
                [self showAlertViewWithTitle: @"United Airlines" message:errorMessage];
            }
        }
        else{
            
            [self showAlertViewWithTitle: @"United Airlines" message: err.localizedDescription];
        }
    }
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

- (void)presentFlightStatusViewControllerWithResponse: (MOBFlightStatusSegment *)flightStatusSegment{
    
    self.flightStatusViewController = (UALFlightStatusViewController *)[self.storyboard instantiateViewControllerWithIdentifier:@"UALFlightStatusViewController"];
    self.flightNumberSearchTitleLabelHeightConstraint.constant = 0;
    self.flightStatusViewController.flightStatusSegment = flightStatusSegment;
    [self.view addSubview: self.flightStatusViewController.view];
    [self addChildViewController: self.flightStatusViewController];
    [self.flightStatusViewController didMoveToParentViewController: self];
    self.flightStatusViewController.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    [self.navigationController presentViewController: self.flightStatusViewController animated: YES completion: nil];
}

# pragma mark - UITextField Delegate Methods

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    //[self.delegate expandFlightStatusMainViewController: textField];
}


@end
