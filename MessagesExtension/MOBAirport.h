//
//  MOBAirport.h
//  MySecond_iMessagesApp
//
//  Created by Gopal Rao Gurram on 3/12/17.
//  Copyright © 2017 Gopal Rao Gurram. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@protocol MOBAirport @end

@interface MOBAirport : JSONModel

@property (nonatomic, retain) NSString *code;
@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSString *city;

@end
