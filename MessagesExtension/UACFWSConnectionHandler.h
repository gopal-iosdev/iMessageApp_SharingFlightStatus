//
//  UACFWSConnectionHandler.h
//  MySecond_iMessagesApp
//
//  Created by Gopal Rao Gurram on 3/12/17.
//  Copyright © 2017 Gopal Rao Gurram. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UACFWSResponse.h"
//#import "SBJsonParser.h"
@class SBJsonParser;

@interface UACFWSConnectionHandler : NSObject<NSURLConnectionDataDelegate>{
    
@private
    NSURLRequest *_request;
    BOOL _showIndicator;
    BOOL _showCancelButton;
    BOOL _doResponseOnCancel;
    BOOL _resultAsString;
    BOOL _dismissActivityIndicator;
    BOOL _showToast;
    id _result;
    NSString *_toastTitle;
    NSString *_toastMessage;
    NSMutableData *_webData;
    //NSURLConnection *_connection;
    NSURLSessionDataTask *_dataTask;
    NSString *_contentType;
    //SBJsonParser *_parser;
}

- (id)initWithRequest:(NSURLRequest *)request completionHandler:(wsResponseCompletionHandler)handler;

- (void) doNSURLSessionTask;

@end
