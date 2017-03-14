//
//  UACFWSResponse.m
//  MySecond_iMessagesApp
//
//  Created by Gopal Rao Gurram on 3/12/17.
//  Copyright © 2017 Gopal Rao Gurram. All rights reserved.
//

#import "UACFWSResponse.h"

@implementation UACFWSResponse

- (id)init
{
    self = [super init];
    if (self)
    {
        self.Error = nil;
        self.Result = nil;
        self.RawError = nil;
    }
    return self;
}

- (id)initWithResult:(id)result Error:(NSError *) error
{
    self = [super init];
    
    if (self)
    {
        self.Error = error;
        self.Result = result;
        self.RawError = nil;
    }
    return self;
}

- (id)initWithResult:(id)result Error:(NSError *) error RawError:(NSError *) rawError
{
    self = [super init];
    
    if (self)
    {
        self.Error = error;
        self.Result = result;
        self.RawError = rawError;
    }
    return self;
}

- (id) proxyForJson {
    
    return [NSDictionary dictionaryWithObjectsAndKeys:
            self.Error, @"error",
            self.Result, @"result",
            self.RawError, @"rawError",
            nil ];
}

@end
