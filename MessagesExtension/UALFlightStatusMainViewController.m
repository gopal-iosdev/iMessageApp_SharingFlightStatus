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
@property (nonatomic, copy) wsResponseCompletionHandler CompletionHandler;
@property (nonatomic, strong) UALFlightStatusViewController *flightStatusViewController;

@end

@implementation UALFlightStatusMainViewController

NSString *requestString;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.flightNumberSearchTitleLabelHeightConstraint.constant = 44.0;
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
    
    [self getFlightStatus:flightNumber forFlightDate:dt forOrigin: origin : ^(UACFWSResponse *response){
        [weakSelf flightStatusWithNumberCallCompleted:response];}];
    
}

- (void)getFlightStatus:(NSString *)flightNumber forFlightDate:(NSString *)flightDate forOrigin:(NSString *)origin :(wsResponseCompletionHandler)handler{
    
    self.CompletionHandler = handler;
    NSString *transactionId = @"9A37EFB9-2C61-4440-8C46-B57CA65EE77A|5A6A3E09-F7BA-402F-AE72-2B90BC8A5971";
    NSString *culture = @"en-US";
    NSString* versionNumber = @"2.1.19I";
    
    NSString *urlString = [[NSString stringWithFormat:@"/FlightStatus/GetFlightStatus?applicationId=1&appversion=%@&accesscode=%@&transactionid=%@&flightnumber=%@&flightdate=%@&origin=%@&languagecode=%@", versionNumber, @"ACCESSCODE", transactionId, flightNumber, flightDate, origin, culture] stringByAddingPercentEscapesUsingEncoding: NSASCIIStringEncoding];
    
    NSString *baseURL = [@"https://mobile-test.united.com/RESTDEV/api" stringByAppendingString: urlString];
    
    NSURL *url = [NSURL URLWithString: baseURL];
    NSURLRequest *request = nil;
    
    NSTimeInterval timeoutTimeInterval = (NSTimeInterval)180;
    request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:timeoutTimeInterval];
    
    UACFWSConnectionHandler *wsConnHandler = [[UACFWSConnectionHandler alloc] initWithRequest:request completionHandler:handler];
    [wsConnHandler doNSURLSessionTask:^(UACFWSResponse *response){
        
        self.CompletionHandler(response);
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
                    
                    MOBFlightStatusSegment *segment = [flightStatusResponse.flightStatusInfo.segments objectAtIndex:0];
                    
                    NSString *carrierCode = @"UA";
                    NSString *flightNumber = flightStatusResponse.flightStatusInfo.flightNumber;
                    NSString *origin = segment.departure.code;
                    NSString *destination = segment.arrival.code;
                    NSDate *scheduledDeparture;
                    NSDate *scheduledArrival;
                    NSDate *lastUpdated;
                    NSDate *expiryDate;
                    
                    NSDateFormatter *df = [[NSDateFormatter alloc] init];
                    NSLocale *timeLocale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
                    [df setLocale:timeLocale];
                    [df setDateFormat:@"MM/dd/yyyy hh:mma"];
                    scheduledDeparture = [df dateFromString: segment.scheduledDepartureDateTime];
                    scheduledArrival = [df dateFromString: segment.scheduledArrivalDateTime];
                    lastUpdated = [NSDate date];
                    NSTimeInterval timeInterval48Hours = 36 * 60 * 60;
                    expiryDate = [scheduledDeparture dateByAddingTimeInterval:timeInterval48Hours];
                    [self presentFlightStatusViewControllerWithResponse: [flightStatusResponse.flightStatusInfo.segments objectAtIndex: 0]];
                    
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
    
    if (!self.flightStatusViewController) {
        self.flightStatusViewController = (UALFlightStatusViewController *)[self.storyboard instantiateViewControllerWithIdentifier:@"UALFlightStatusViewController"];
    }
    self.flightNumberSearchTitleLabelHeightConstraint.constant = 0;
    self.flightStatusViewController.flightStatusSegment = flightStatusSegment;
    [self.view addSubview: self.flightStatusViewController.view];
    [self addChildViewController: self.flightStatusViewController];
    [self.flightStatusViewController didMoveToParentViewController: self];
    self.flightStatusViewController.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    [self.navigationController presentViewController: self.flightStatusViewController animated: YES completion: nil];
}

@end
