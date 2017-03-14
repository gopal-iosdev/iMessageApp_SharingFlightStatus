//
//  UACFWSConnectionHandler.m
//  MySecond_iMessagesApp
//
//  Created by Gopal Rao Gurram on 3/12/17.
//  Copyright © 2017 Gopal Rao Gurram. All rights reserved.
//

#import "UACFWSConnectionHandler.h"
//#import "SBJson.h"


@interface UACFWSConnectionHandler()

@property (nonatomic, copy) wsResponseCompletionHandler CompletionHandler;

@end

@implementation UACFWSConnectionHandler

- (id)initWithRequest:(NSURLRequest *)request completionHandler:(wsResponseCompletionHandler)handler{
    
    self = [super init];
    if (self) {
        _dataTask = nil;
        _webData = nil;
        _contentType = nil;
        _request = request;
        _showIndicator = NO;
        _showCancelButton = NO;
        _resultAsString = NO;
        _dismissActivityIndicator = NO;
        //_parser = [[SBJsonParser alloc] init];
        self.CompletionHandler = handler;
    }
    
    return self;
}

- (void) doNSURLSessionTask: (wsResponseCompletionHandler)handler{
    
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:config];
    NSError *errorMain;
    
    _dataTask = [session dataTaskWithRequest:_request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        [_webData setLength:0];
        [_webData appendData:data];
        
        _contentType = [[((NSHTTPURLResponse*)response) allHeaderFields] objectForKey:@"Content-Type"];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            if (error){
                NSLog(@"doNSURLSessionTask, error : \n %@",error.localizedDescription);
            }
            else{
                NSLog(@"doNSURLSessionTask, success : \n %@", response);
            }
            
            NSString *jsonString = [[NSString alloc] initWithData:_webData encoding:NSUTF8StringEncoding];
            //_result = [_parser objectWithString: jsonString];
            _result = jsonString;
            [self doCallBackWithResult:_result error:nil];
        });
        
    }];
    
    if (_dataTask) {
        
        _webData = [NSMutableData data];
        [_dataTask resume];
    }
}

- (void)doCallBackWithResult:(id)result error:(NSError *)error{
    
    UACFWSResponse *errResponse = [[UACFWSResponse alloc] initWithResult:result Error:error];
    _CompletionHandler(errResponse);
}


@end
