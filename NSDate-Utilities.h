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
+ (NSDate *) daysFromNow: (NSUInteger) days;
+ (NSDate *) daysAgo: (NSUInteger) days;
+ (NSDate *) tomorrow;
+ (NSDate *) yesterday;
+ (NSDate *) hoursFromNow: (NSUInteger) dHours;
+ (NSDate *) hoursAgo: (NSUInteger) dHours;
+ (NSDate *) minutesFromNow: (NSUInteger) dMinutes;
+ (NSDate *) minutesAgo: (NSUInteger) dMinutes;

- (BOOL) isSameDate: (NSDate *) aDate;
- (BOOL) isToday;
- (BOOL) isTomorrow;
- (BOOL) isYesterday;
- (BOOL) isSameWeek: (NSDate *) aDate;
- (BOOL) isThisWeek;
- (BOOL) isNextWeek;
- (BOOL) isLastWeek;
- (BOOL) isSameYear: (NSDate *) aDate;
- (BOOL) isThisYear;
- (BOOL) isNextYear;
- (BOOL) isLastYear;

- (BOOL) isBeforeDate: (NSDate *) aDate;
- (BOOL) isAfterDate: (NSDate *) aDate;

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
