//
//  DateExtension.h
//  MySecond_iMessagesApp
//
//  Created by Gopal Rao Gurram on 3/15/17.
//  Copyright © 2017 Gopal Rao Gurram. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DateExtension : NSDate

+ (NSDate *)dateWithOutTime:(NSDate *)datDate;

+ (NSString *)getWordFormatStringDatefrom: (NSString *)numberDate;

+ (NSString *)getHourlyOrMonthlyFormatNumberTimeFromDate: (NSString *)dateString withFormat: (NSString *)timeFormat;

+ (NSDateFormatter *)getDateFormatterWithFormat: (NSString *)dateFormat;

+ (NSDate *)getDateFrom: (NSString *)dateString withFormat:(NSString *)dateFormat;


@end
