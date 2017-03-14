//
//  MOBEquipment.h
//  MySecond_iMessagesApp
//
//  Created by Gopal Rao Gurram on 3/12/17.
//  Copyright © 2017 Gopal Rao Gurram. All rights reserved.
//

#import <JSONModel/JSONModel.h>

#import "MOBAircraft.h"

@protocol MOBEquipment @end

@interface MOBEquipment : JSONModel

@property (nonatomic, retain) NSString *id;
@property (nonatomic, retain) MOBAircraft *aircraft;

@end

