//
//  UALFlightStatusAdapter.m
//  MySecond_iMessagesApp
//
//  Created by Gopal Rao Gurram on 3/14/17.
//  Copyright © 2017 Gopal Rao Gurram. All rights reserved.
//

#import "UALFlightStatusAdapter.h"

@implementation UALFlightStatusAdapter

static UALFlightStatusAdapter *gInstance = NULL;

+(UALFlightStatusAdapter *)singleton
{
    @synchronized(self)
    {
        if (gInstance == NULL)
            gInstance = [[self alloc] init];
    }
    
    return(gInstance);
}

-(UALFlightStatusAdapter *)init{
    
    self = [super init];
    return self;
}


- (void)getFlightStatus:(NSString *)flightNumber forFlightDate:(NSString *)flightDate forOrigin:(NSString *)origin :(wsResponseCompletionHandler)handler{
    
    self.CompletionHandler = handler;
    
    NSURL *url = [self getFlightStatusURL: flightNumber forFlightDate: flightDate forOrigin: origin];
    NSURLRequest *request = nil;
    
    NSTimeInterval timeoutTimeInterval = (NSTimeInterval)180;
    request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:timeoutTimeInterval];
    
    UACFWSConnectionHandler *wsConnHandler = [[UACFWSConnectionHandler alloc] initWithRequest:request completionHandler:handler];
    [wsConnHandler doNSURLSessionTask];
}

- (NSURL *)getFlightStatusURL:(NSString *)flightNumber forFlightDate:(NSString *)flightDate forOrigin:(NSString *)origin{
    
    NSString *transactionId = @"9A37EFB9-2C61-4440-8C46-B57CA65EE77A|5A6A3E09-F7BA-402F-AE72-2B90BC8A5971";
    NSString *culture = @"en-US";
    NSString* versionNumber = @"2.1.19I";
    NSString *urlString = [[NSString stringWithFormat:@"/FlightStatus/GetFlightStatus?applicationId=1&appversion=%@&accesscode=%@&transactionid=%@&flightnumber=%@&flightdate=%@&origin=%@&languagecode=%@", versionNumber, @"ACCESSCODE", transactionId, flightNumber, flightDate, origin, culture] stringByAddingPercentEscapesUsingEncoding: NSASCIIStringEncoding];
    
    NSString *devOrStageUrl = @"https://mobile-test.united.com/REST17CUAT/api";
    NSString *prodUrl = @"https://smartphone.united.com/UnitedMobileDataServices/api";
    
    NSString *baseURL = [devOrStageUrl stringByAppendingString: urlString];
    NSURL *url = [NSURL URLWithString: baseURL];
    return url;
}

@end
