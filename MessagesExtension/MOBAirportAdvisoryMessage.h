//
//  MOBAirportAdvisoryMessage.h
//  MySecond_iMessagesApp
//
//  Created by Gopal Rao Gurram on 3/12/17.
//  Copyright © 2017 Gopal Rao Gurram. All rights reserved.
//

#import <JSONModel/JSONModel.h>

#import "MOBTypeOption.h"

@protocol MOBSchedule @end

@interface MOBAirportAdvisoryMessage : JSONModel
@property (nonatomic, retain) NSString <Optional> *buttonTitle;
@property (nonatomic, retain) NSString <Optional> *headerTitle;
@property (nonatomic, retain) NSArray<MOBTypeOption> *advisoryMessages;

@end
