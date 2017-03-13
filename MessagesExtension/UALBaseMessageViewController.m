//
//  UALBaseMessageViewController.m
//  MySecond_iMessagesApp
//
//  Created by Gopal Rao Gurram on 3/10/17.
//  Copyright © 2017 Gopal Rao Gurram. All rights reserved.
//

#import "UALBaseMessageViewController.h"

@interface UALBaseMessageViewController ()

@end

@implementation UALBaseMessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)shareFlightStatusButtonPressed:(UIButton *)sender {
    
    [self.delegate presentFlightStatusViewController];
}


@end
