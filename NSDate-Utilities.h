//
//  NSDate-Utilities.h
//  HelloWorld
//
//  Created by Erica Sadun on 2/4/10.
//  Copyright 2010 Up To No Good, Inc.. All rights reserved.
//

#import <Foundation/Foundation.h>

#define D_MINUTE	60
#define D_HOUR		3600
#define D_DAY		86400
#define D_WEEK		604800
#define D_YEAR		31556926

@interface NSDate (Utilities)
+ (NSDate *) dateWithDaysFromNow: (NSUInteger) days;
+ (NSDate *) dateWithDaysBeforeNow: (NSUInteger) days;
+ (NSDate *) dateTomorrow;
+ (NSDate *) dateYesterday;
+ (NSDate *) dateWithHoursFromNow: (NSUInteger) dHours;
+ (NSDate *) dateWithHoursBeforeNow: (NSUInteger) dHours;
+ (NSDate *) dateWithMinutesFromNow: (NSUInteger) dMinutes;
+ (NSDate *) dateWithMinutesBeforeNow: (NSUInteger) dMinutes;

- (BOOL) isEqualToDateIgnoringTime: (NSDate *) aDate;
- (BOOL) isToday;
- (BOOL) isTomorrow;
- (BOOL) isYesterday;
- (BOOL) isSameWeekAsDate: (NSDate *) aDate;
- (BOOL) isThisWeek;
- (BOOL) isNextWeek;
- (BOOL) isLastWeek;
- (BOOL) isSameYearAsDate: (NSDate *) aDate;
- (BOOL) isThisYear;
- (BOOL) isNextYear;
- (BOOL) isLastYear;

- (BOOL) isEarlierThanDate: (NSDate *) aDate;
- (BOOL) isLaterThanDate: (NSDate *) aDate;

- (NSDate *) daysAfterDate: (NSUInteger) dDays;
- (NSDate *) daysBeforeDate: (NSUInteger) dDays;
- (NSDate *) hoursAfterDate: (NSUInteger) dHours;
- (NSDate *) hoursBeforeDate: (NSUInteger) dHours;
- (NSDate *) minutesAfterDate: (NSUInteger) dMinutes;
- (NSDate *) minutesBeforeDate: (NSUInteger) dMinutes;

- (NSInteger) nearestHour;
- (NSInteger) hour;
- (NSInteger) minute;
- (NSInteger) seconds;
- (NSInteger) day;
- (NSInteger) month;
- (NSInteger) week;
- (NSInteger) weekday;
- (NSInteger) nthWeekday;
- (NSInteger) year;
@end
