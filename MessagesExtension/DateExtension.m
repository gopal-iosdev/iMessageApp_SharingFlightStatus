//
//  DateExtension.m
//  MySecond_iMessagesApp
//
//  Created by Gopal Rao Gurram on 3/15/17.
//  Copyright © 2017 Gopal Rao Gurram. All rights reserved.
//

#import "DateExtension.h"

@implementation DateExtension

# pragma mark - All Helper Methods

+ (NSDate *)dateWithOutTime:(NSDate *)datDate
{
    if( datDate == nil ) {
        datDate = [NSDate date];
    }
    NSDateComponents* comps = [[NSCalendar currentCalendar] components:NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit fromDate:datDate];
    return [[NSCalendar currentCalendar] dateFromComponents:comps];
}

+ (NSString *)getWordFormatStringDatefrom: (NSString *)numberDate{
    
    NSDateFormatter *df = [DateExtension getDateFormatterWithFormat: @"MM/dd/yyyy hh:mma"];
    NSDate *flightDt = [df dateFromString: numberDate];
    [df setDateFormat:@"EEE., MMM d, yyyy"];
    NSString *flightDate = [df stringFromDate:flightDt];
    return flightDate;
}

+ (NSString *)getHourlyOrMonthlyFormatNumberTimeFromDate: (NSString *)dateString withFormat: (NSString *)timeFormat{
    
    NSDateFormatter *dateFormatter = [DateExtension getDateFormatterWithFormat: @"MM/dd/yyyy hh:mma"];
    NSDate *dateObj = [dateFormatter dateFromString: dateString];
    [dateFormatter setDateFormat: timeFormat];
    return [dateFormatter stringFromDate: dateObj];
}


+ (NSDateFormatter *)getDateFormatterWithFormat: (NSString *)dateFormat{
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setAMSymbol:@"am"];
    [dateFormatter setPMSymbol:@"pm"];
    NSLocale *timeLocale2 = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
    [dateFormatter setLocale:timeLocale2];
    [dateFormatter setDateFormat: dateFormat];
    return dateFormatter;
}


+ (NSDate *)getDateFrom: (NSString *)dateString withFormat:(NSString *)dateFormat{
    
    NSDateFormatter *dateFormatter = [DateExtension getDateFormatterWithFormat: dateFormat];
    NSDate *dateObj = [dateFormatter dateFromString: dateString];
    return dateObj;
}

@end
