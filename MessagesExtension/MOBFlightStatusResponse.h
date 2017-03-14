//
//  MOBFlightStatusResponse.h
//  MySecond_iMessagesApp
//
//  Created by Gopal Rao Gurram on 3/12/17.
//  Copyright © 2017 Gopal Rao Gurram. All rights reserved.
//

#import <JSONModel/JSONModel.h>
#import "MOBFlightStatusInfo.h"
#import "MOBException.h"

@protocol MOBFlightStatusResponse @end

@interface MOBFlightStatusResponse : JSONModel

@property (nonatomic, retain) MOBFlightStatusInfo *flightStatusInfo;
@property (nonatomic, retain) NSString *transactionId;
@property (nonatomic, retain) NSString *languageCode;
@property (nonatomic, retain) NSString *machineName;
@property (nonatomic, assign) long callDuration;
@property (nonatomic, retain) MOBException <Optional> *exception;

@end
