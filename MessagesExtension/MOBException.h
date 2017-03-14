//
//  MOBException.h
//  MySecond_iMessagesApp
//
//  Created by Gopal Rao Gurram on 3/12/17.
//  Copyright © 2017 Gopal Rao Gurram. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@protocol MOBException @end

@interface MOBException : JSONModel

@property (nonatomic, retain) NSString *code;
@property (nonatomic, retain) NSString *message;

@end
