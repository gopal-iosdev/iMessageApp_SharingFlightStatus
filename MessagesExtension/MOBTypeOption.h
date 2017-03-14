//
//  MOBTypeOption.h
//  MySecond_iMessagesApp
//
//  Created by Gopal Rao Gurram on 3/12/17.
//  Copyright © 2017 Gopal Rao Gurram. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@protocol MOBTypeOption @end

@interface MOBTypeOption : JSONModel

@property (nonatomic, retain) NSString *key;
@property (nonatomic, retain) NSString *value;

@end

