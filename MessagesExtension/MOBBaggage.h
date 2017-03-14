//
//  MOBBaggage.h
//  MySecond_iMessagesApp
//
//  Created by Gopal Rao Gurram on 3/12/17.
//  Copyright © 2017 Gopal Rao Gurram. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@protocol MOBBaggage @end

@interface MOBBaggage : JSONModel

@property (strong, nonatomic) NSString* bagClaimUnit;
@property (strong, nonatomic) NSString* bagTerminal;
@property (assign, nonatomic) BOOL hasBagLocation;

@end
