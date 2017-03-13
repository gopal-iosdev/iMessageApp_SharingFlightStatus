//
//  UALBaseMessageViewController.h
//  MySecond_iMessagesApp
//
//  Created by Gopal Rao Gurram on 3/10/17.
//  Copyright © 2017 Gopal Rao Gurram. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol UALBaseMessageViewControllerDelegate <NSObject>

@optional

- (void)presentFlightStatusViewController;

@end

@interface UALBaseMessageViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIButton *shareFlightStatusButton;

@property (weak, nonatomic) NSObject<UALBaseMessageViewControllerDelegate> *delegate;

@end
