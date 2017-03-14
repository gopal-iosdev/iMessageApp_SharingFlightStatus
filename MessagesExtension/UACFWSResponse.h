//
//  UACFWSResponse.h
//  MySecond_iMessagesApp
//
//  Created by Gopal Rao Gurram on 3/12/17.
//  Copyright © 2017 Gopal Rao Gurram. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UACFWSResponse : NSObject

typedef void (^wsResponseCompletionHandler)(UACFWSResponse*);

@property (strong, atomic) NSError *Error;
@property (strong, atomic) id Result;
@property (strong, atomic) NSError *RawError;

- (id)initWithResult:(id)result Error:(NSError *) error;
- (id)initWithResult:(id)result Error:(NSError *) error RawError:(NSError *) rawError;

@end
