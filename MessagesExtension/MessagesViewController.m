//
//  MessagesViewController.m
//  MessagesExtension
//
//  Created by Gopal Rao Gurram on 3/9/17.
//  Copyright © 2017 Gopal Rao Gurram. All rights reserved.
//

#import "MessagesViewController.h"


@interface MessagesViewController ()

@property (nonatomic, strong) UALBaseMessageViewController *baseMessageViewController;

@property (nonatomic, strong) UALFlightStatusMainViewController *flightStatusController;

@end

@implementation MessagesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Conversation Handling

-(void)willBecomeActiveWithConversation:(MSConversation *)conversation {
    
    [self presentViewControllerForconversation: conversation withPresentationStyle: self.presentationStyle];
}

-(void)willTransitionToPresentationStyle:(MSMessagesAppPresentationStyle)presentationStyle {
    // Called before the extension transitions to a new presentation style.
    
    // Use this method to prepare for the change in presentation style.
}


-(void)didBecomeActiveWithConversation:(MSConversation *)conversation {
    // Called when the extension is about to move from the inactive to active state.
    // This will happen when the extension is about to present UI.
    
    // Use this method to configure the extension and restore previously stored state.
}

-(void)willResignActiveWithConversation:(MSConversation *)conversation {
    // Called when the extension is about to move from the active to inactive state.
    // This will happen when the user dissmises the extension, changes to a different
    // conversation or quits Messages.
    
    // Use this method to release shared resources, save user data, invalidate timers,
    // and store enough state information to restore your extension to its current state
    // in case it is terminated later.
}

-(void)didReceiveMessage:(MSMessage *)message conversation:(MSConversation *)conversation {
    // Called when a message arrives that was generated by another instance of this
    // extension on a remote device.
    
    // Use this method to trigger UI updates in response to the message.
}

-(void)didStartSendingMessage:(MSMessage *)message conversation:(MSConversation *)conversation {
    // Called when the user taps the send button.
}

-(void)didCancelSendingMessage:(MSMessage *)message conversation:(MSConversation *)conversation {
    // Called when the user deletes the message without sending it.
    
    // Use this to clean up state related to the deleted message.
}


-(void)didTransitionToPresentationStyle:(MSMessagesAppPresentationStyle)presentationStyle {
    // Called after the extension transitions to a new presentation style.
    
    // Use this method to finalize any behaviors associated with the change in presentation style.
    MSConversation *conversation = self.activeConversation? self.activeConversation: nil;
    [self presentViewControllerForconversation: conversation withPresentationStyle: self.presentationStyle];
}

# pragma mark -

- (void) presentViewControllerForconversation:(MSConversation *)conversation withPresentationStyle: (MSMessagesAppPresentationStyle)presentationStyle{
    
    for (UIView *childVw in self.messagesView.subviews) {
        
        for (UIView *childSubVw in childVw.subviews) {
            [childSubVw removeFromSuperview];
        }
        [childVw removeFromSuperview];
    }
    
    // Determine the controller to present.
    UIViewController *controller = [UIViewController new];
    
    //controller = [self instantiateFlightStatusMainViewController];
    
    
    if (presentationStyle == MSMessagesAppPresentationStyleCompact) {
        
        controller = [self instantiateBaseMessageViewController];
    }
    else{
        
        controller = [self instantiateFlightStatusMainViewController];
    }
    
    [self.messagesView addSubview: controller.view];
    [self addChildViewController: controller];
    [controller didMoveToParentViewController: self];
    
    controller.view.frame = CGRectMake(0, 0, self.messagesView.frame.size.width, self.messagesView.frame.size.height);
    
    [self.navigationController presentViewController: controller animated: YES completion: nil];
}

# pragma mark - Instantiate View Controllers

- (UIViewController *)instantiateBaseMessageViewController{
    
    self.baseMessageViewController = (UALBaseMessageViewController *)[self.storyboard instantiateViewControllerWithIdentifier:@"UALBaseMessageViewController"];
    self.baseMessageViewController.delegate = self;
    return self.baseMessageViewController;
}

- (UIViewController *)instantiateFlightStatusMainViewController{
    
    self.flightStatusController = (UALFlightStatusMainViewController *)[self.storyboard instantiateViewControllerWithIdentifier:@"UALFlightStatusMainViewController"];
    self.flightStatusController.delegate = self;
    return self.flightStatusController;
}

# pragma mark - Send Or Insert Message

- (void)sendOrInsertMessage: (MOBFlightStatusSegment *)flightStatusSegment{
    
    MSMessage *message = [[MSMessage alloc] init];
    
    MSMessageTemplateLayout *messageLayout = [[MSMessageTemplateLayout alloc]init];
    
    NSString *flightDate = [UALFlightStatusViewController getWordFormatStringDatefrom: flightStatusSegment.scheduledDepartureDateTime];
    messageLayout.imageTitle = [NSString stringWithFormat:@"%@%@ / %@", @"UA", flightStatusSegment.flightNumber, flightDate];
    
    NSString *origin = flightStatusSegment.departure.city? flightStatusSegment.departure.city: flightStatusSegment.departure.code;
    NSString *destination = flightStatusSegment.arrival.city? flightStatusSegment.arrival.city: flightStatusSegment.arrival.code;;
    messageLayout.imageSubtitle = [NSString stringWithFormat:@"%@ to %@", origin, destination];
    
    messageLayout.caption = flightStatusSegment.departure.code;
    messageLayout.subcaption = [UALFlightStatusViewController getHourlyOrMonthlyFormatNumberTimeFromDate: flightStatusSegment.scheduledDepartureDateTime withFormat: @"h:mma"];
    
    messageLayout.trailingCaption = flightStatusSegment.arrival.code;
    NSString *arrivalTime = [UALFlightStatusViewController getHourlyOrMonthlyFormatNumberTimeFromDate: flightStatusSegment.scheduledArrivalDateTime withFormat: @"h:mma"];
    NSString *arrivalDay = [UALFlightStatusViewController getHourlyOrMonthlyFormatNumberTimeFromDate: flightStatusSegment.scheduledArrivalDateTime withFormat: @"(MMM d)"];
    messageLayout.trailingSubcaption = [NSString stringWithFormat: @"%@%@", arrivalTime, arrivalDay];
    
    messageLayout.image = [UIImage imageNamed: @"United_Plane.png"];
    
    NSURL *flightStatusUrl = [self composeNavigationUrlForFlightStatusSegment: flightStatusSegment];
    
    message.URL = flightStatusUrl;
    message.layout = messageLayout;
    [self.activeConversation insertMessage: message completionHandler: nil];
    [self dismiss];
    

//    NSData *dataImage = UIImageJPEGRepresentation([self imageWithView:self.myViewBgImageConLogoDaSalvare], 0.0);
//    [dataImage writeToURL:urlImage atomically:true];
//    
//    [savedConversation insertAttachment:urlImage withAlternateFilename:nil completionHandler:^(NSError * error) {
//        
//    }];

    //[self.activeConversation insertMessage:<#(nonnull MSMessage *)#> completionHandler:<#^(NSError * _Nullable)completionHandler#>]
}

# pragma mark - Delegate Methods

- (void)presentFlightStatusViewController{
        
    [self requestPresentationStyle: MSMessagesAppPresentationStyleExpanded];
}

- (void)expandFlightStatusMainViewController: (UITextField *)textField{
    
    [self requestPresentationStyle: MSMessagesAppPresentationStyleExpanded];
}

# pragma mark Compose Message

- (void)composeMessageWithFlightStatusSegment: (MOBFlightStatusSegment *)flightStatusSegment{
    
    [self sendOrInsertMessage: flightStatusSegment];
}



# pragma mark - All Helper Methods

- (NSURL *)composeNavigationUrlForFlightStatusSegment: (MOBFlightStatusSegment *)flightStatusSegment{
    
    NSString *testurlString = @"https://mobile.united.com/FlightStatus/FlightDetails?carrierCode=UA&flightNumber=83&flightDate=03%2F14%2F2017%2000%3A00%3A00&origin=BOM&destination=EWR&GUID=9cb46164-a8f8-4148-b818-eef1ee36825a";//https://mobile.united.com/FlightDetails?carrierCode=UA&flightNumber=887&flightDate=03/14/2017&origin=YVR&destination=SFO&GUID=9cb46164-a8f8-4148-b818-eef1ee36825a
    
    NSString *flightNumber = flightStatusSegment.flightNumber;
    
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    NSLocale *timeLocale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
    [df setLocale:timeLocale];
    [df setDateFormat:@"MM/dd/yyyy hh:mma"];
    NSDate *flightDt = [df dateFromString: flightStatusSegment.scheduledDepartureDateTime];
    [df setDateFormat:@"MM/dd/yyyy"];
    NSString *flightDate = [df stringFromDate:flightDt];
    
    NSString* origin = flightStatusSegment.departure.code;
    NSString* destination = flightStatusSegment.arrival.code;
    
    NSString *gUID = @"9cb46164-a8f8-4148-b818-eef1ee36825a";
    
    NSString *urlString = [[NSString stringWithFormat:@"/FlightDetails?carrierCode=UA&flightNumber=%@&flightDate=%@&origin=%@&destination=%@&GUID=%@", flightNumber, flightDate, origin, destination, gUID] stringByAddingPercentEscapesUsingEncoding: NSASCIIStringEncoding];
    
    NSString *baseURL = [@"https://mobile.united.com" stringByAppendingString: urlString];
    NSURL *url = [NSURL URLWithString: baseURL];
    return url;

}

@end
