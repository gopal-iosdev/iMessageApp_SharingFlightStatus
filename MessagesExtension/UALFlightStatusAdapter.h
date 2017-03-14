//
//  UALFlightStatusAdapter.h
//  MySecond_iMessagesApp
//
//  Created by Gopal Rao Gurram on 3/14/17.
//  Copyright © 2017 Gopal Rao Gurram. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UACFWSResponse.h"
#import "UACFWSConnectionHandler.h"
#import "MOBFlightStatusResponse.h"

@interface UALFlightStatusAdapter : NSObject

+(UALFlightStatusAdapter *)singleton;

- (void)getFlightStatus:(NSString *)flightNumber forFlightDate:(NSString *)flightDate forOrigin:(NSString *)origin :(wsResponseCompletionHandler)handler;

- (NSURL *)getFlightStatusURL:(NSString *)flightNumber forFlightDate:(NSString *)flightDate forOrigin:(NSString *)origin;

@property (nonatomic, copy) wsResponseCompletionHandler CompletionHandler;

@end
