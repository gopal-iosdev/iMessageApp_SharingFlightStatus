//
//  MessagesViewController.h
//  MessagesExtension
//
//  Created by Gopal Rao Gurram on 3/9/17.
//  Copyright © 2017 Gopal Rao Gurram. All rights reserved.
//

#import <Messages/Messages.h>
#import "UALBaseMessageViewController.h"
#import "UALFlightStatusMainViewController.h"
#import <UIKit/UIKit.h>

@interface MessagesViewController : MSMessagesAppViewController<UALBaseMessageViewControllerDelegate, UIAlertViewDelegate>

@property (strong, nonatomic) IBOutlet UIView *messagesView;


@end
