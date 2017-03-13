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

@end

@implementation UALFlightStatusMainViewController

NSString *requestString;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)flightDepartDateValueChanged:(UIDatePicker *)sender {
    
    self.FlightDate = sender.date;
}


- (IBAction)searchFlightStatusButtonClicked:(UIButton *)sender {
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle: @"Alert Title" message: @"Message" preferredStyle: UIAlertControllerStyleAlert];
    [self presentViewController: alertController animated: YES completion: nil];
//    [self resignFirstResponders];
//    if ([self.flightNumberTextField.text length] > 0){
//        
//        [self doSearchByFlightNumber];
//    }
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
    
//    [self getFlightStatus:flightNumber forFlightDate:dt forOrigin: origin : ^(UACFWSResponse *response){
//        [weakSelf flightStatusWithNumberCallCompleted:response];}];
    
}

//-(void)getFlightStatus:(NSString *)flightNumber forFlightDate:(NSString *)flightDate forOrigin:(NSString *)origin :(wsResponseCompletionHandler)handler{
//    
//    UACFRESTWebservice *flightStatusWebService = [[UACFRESTWebservice alloc] init];
//    
//    UALSession *session = [UALSession getInstance];
//    NSString *transactionId = session.transactionId;
//    NSString *culture = session.culture;
//    NSString* versionNumber = [UALSession getVersionNumber];
//    
//    
//    NSString *urlString = [[NSString stringWithFormat:@"/FlightStatus/GetFlightStatus?applicationId=1&appversion=%@&accesscode=%@&transactionid=%@&flightnumber=%@&flightdate=%@&origin=%@&languagecode=%@", versionNumber, [UALCatalog getAccessCode], transactionId, flightNumber, flightDate, origin, culture] stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding];
//    
//    NSString *baseURL = [[UALCatalog getWebApiBaseUrl] stringByAppendingString:urlString];
//    
//    //NSLog(@"log URL: %@", baseURL);
//    
//    //[flightStatusWebService doGetWithURL:baseURL timeout:[UALCatalog getTimeOut] showActivityIndicator:NO resultAsString:YES completionHandler:handler];
//    [flightStatusWebService doGetWithURL:baseURL timeout:[UALCatalog getTimeOut] showActivityIndicator:YES showCancelButton:YES resultAsString:YES completionHandler:handler];
//}
//
//- (void)flightStatusWithNumberCallCompleted:(UACFWSResponse *)response{
//    
//    NSLog(@"flightStatusWithNumberCallCompleted : \n %@", response);
//}

@end
