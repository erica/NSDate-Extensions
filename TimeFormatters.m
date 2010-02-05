/*
 Dustin Voss
 BSD License, Use at your own risk
 */

#import "TimeFormatters.h"


// Localized string keys
static NSString *const Str_ShortInterval_M               = @"ShortInterval_M";
static NSString *const Str_ShortInterval_HM              = @"ShortInterval_HM";
static NSString *const Str_MediumInterval_M              = @"MediumInterval_M";
static NSString *const Str_MediumInterval_HM             = @"MediumInterval_HM";
static NSString *const Str_TimeComponentsSubMinute_M     = @"TimeComponentsSubMinute_M";
static NSString *const Str_TimeComponents_M              = @"TimeComponents_M";
static NSString *const Str_TimeComponents_MH             = @"TimeComponents_MH";
static NSString *const Str_TimeComponents_MHD            = @"TimeComponents_MHD";
static NSString *const Str_TimeComponentDay_D            = @"TimeComponentDay_D";
static NSString *const Str_TimeComponentDays_D           = @"TimeComponentDays_D";
static NSString *const Str_TimeComponentHour_H           = @"TimeComponentHour_H";
static NSString *const Str_TimeComponentHours_H          = @"TimeComponentHours_H";
static NSString *const Str_TimeComponentMinute_M         = @"TimeComponentMinute_M";
static NSString *const Str_TimeComponentMinutes_M        = @"TimeComponentMinutes_M";
static NSString *const Str_TimeComponentAbbrHour_H       = @"TimeComponentAbbrHour_H";
static NSString *const Str_TimeComponentAbbrHours_H      = @"TimeComponentAbbrHours_H";
static NSString *const Str_TimeComponentAbbrMinute_M     = @"TimeComponentAbbrMinute_M";
static NSString *const Str_TimeComponentAbbrMinutes_M    = @"TimeComponentAbbrMinutes_M";


// English
//
// /* Short time interval format (< 1 hr).
// "0:[mm]" */
// "ShortInterval_M" = "0:%.2d";
// 
// /* Short time interval format (≥ 1 hr).
// "[h]:[mm]" */
// "ShortInterval_HM" = "%1$d:%2$.2d";
// 
// /* Medium time interval format (< 1 hr).
// "0h [mm]m" */
// "MediumInterval_M" = "0h %.2dm";
// 
// /* Medium time interval format (≥ 1 hr).
// "[3]h [30]m" */
// "MediumInterval_HM" = "%1$dh %2$.2dm";
// 
// /* Long time interval format (< 1 minute). 
// "< [1 minute]" */
// "TimeComponentsSubMinute_M" = "< %1$@";
// 
// /* Long time interval format; arguments: min, hr, day.
// "[x minutes]" */
// "TimeComponents_M" = "%1$@";
// 
// /* Long time interval format; arguments: min, hr, day.
// "[x hours], [x minutes]" */
// "TimeComponents_MH" = "%2$@, %1$@";
// 
// /* Long time interval format; arguments: min, hr, day.
// "[x days], [x hours], [x minutes]" */
// "TimeComponents_MHD" = "%3$@, %2$@, %1$@";
// 
// /* Long time interval format (1 day). */
// "TimeComponentDay_D" = "%d day";
// 
// /* Long time interval format (> 1 day). */
// "TimeComponentDays_D" = "%d days";
// 
// /* Long time interval format (1 hour). */
// "TimeComponentHour_H" = "%d hour";
// 
// /* Long time interval format (> 1 hour). */
// "TimeComponentHours_H" = "%d hours";
// 
// /* Long time interval format (1 minute). */
// "TimeComponentMinute_M" = "%d minute";
// 
// /* Long time interval format (> 1 minute). */
// "TimeComponentMinutes_M" = "%d minutes";
// 
// /* Abbreviated long time interval format (1 hour). */
// "TimeComponentAbbrHour_H" = "%d hr";
// 
// /* Abbreviated long time interval format (> 1 hour). */
// "TimeComponentAbbrHours_H" = "%d hrs";
// 
// /* Abbreviated long time interval format (1 minute). */
// "TimeComponentAbbrMinute_M" = "%d min";
// 
// /* Abbreviated long time interval format (> 1 minute). */
// "TimeComponentAbbrMinutes_M" = "%d mins";


// Localized string accessor
NSString *LocStr(NSString *const key) {
    return [[NSBundle mainBundle] localizedStringForKey:key value:nil table:nil];
}


@implementation IntervalFormatter
@synthesize style;
- (NSString *) stringForObjectValue:(NSNumber *)minutesValue {
    if (minutesValue == nil)
        return @"";

    NSString *str = nil;
    float minutes = [minutesValue floatValue];
    NSInteger hours = floorf(minutes / 60.0f);
    NSInteger hourMinutes = floorf(fmodf(minutes, 60.0f));
    
    switch (style) {

        case kIntervalFormatterShortStyle: {
            // I am not using a NSDateFormatter because this is not time-of-day;
            // hours may exceed 24.
            if (hours < 1)
                str = [NSString stringWithFormat:LocStr(Str_ShortInterval_M), 
                       hourMinutes];
            else
                str = [NSString stringWithFormat:LocStr(Str_ShortInterval_HM), 
                       hours, hourMinutes];
            break;
        }
            
        case kIntervalFormatterMediumStyle: {
            if (hours < 1)
                str = [NSString stringWithFormat:LocStr(Str_MediumInterval_M), 
                       hourMinutes];
            else
                str = [NSString stringWithFormat:LocStr(Str_MediumInterval_HM),
                       hours, hourMinutes];
            break;
        }
            
        case kIntervalFormatterDecimalStyle: {
            NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
            [formatter setNumberStyle:NSNumberFormatterDecimalStyle];
            [formatter setMultiplier:[NSNumber numberWithFloat:(1.0f / 60.0f)]];
            [formatter setMaximumFractionDigits:2];
            [formatter setMinimumFractionDigits:1];
            str = [formatter stringFromNumber:minutesValue];
            [formatter release];
            break;
        }
            
        case kIntervalFormatterAbbrLongStyle:
        case kIntervalFormatterLongStyle: {
            float integralPart;
            NSInteger seconds = floorf(modff(minutes, &integralPart) * 60.0f);
            IntervalComponentsFormatter *formatter = [[IntervalComponentsFormatter alloc] init];
            NSDateComponents *components = [[NSDateComponents alloc] init];
            [components setHour:hours];
            [components setMinute:hourMinutes];
            [components setSecond:seconds];
            str = [formatter stringForObjectValue:components];
            [components release];
            [formatter release];
            break;
        }
    }
    
    return str;
}
@end


@implementation DateComponentsFormatter
@synthesize dateStyle, timeStyle;

- (void) dealloc {
    [formatter release];
}

- (NSString *) stringForObjectValue:(NSDateComponents *)components {
    if (formatter == nil) formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:dateStyle];
    [formatter setTimeStyle:timeStyle];
    NSDate *date = [[NSCalendar currentCalendar] dateFromComponents:components];
    return [formatter stringFromDate:date];
}

@end


@implementation IntervalComponentsFormatter
@synthesize style;
- (NSString *) stringForObjectValue:(NSDateComponents *)components {
    NSInteger days = [components day];
    NSInteger hours = [components hour];
    NSInteger minutes = [components minute];
    NSInteger seconds = [components second];
    
    NSNumber *daysValue = [[NSNumber alloc] initWithInteger:days];
    NSNumber *hoursValue = [[NSNumber alloc] initWithInteger:hours];
    NSNumber *minutesValue = [[NSNumber alloc] initWithInteger:minutes];
    
    DaysFormatter *daysFormatter = [[DaysFormatter alloc] init];
    HoursFormatter *hoursFormatter = [[HoursFormatter alloc] init];
    MinutesFormatter *minutesFormatter = [[MinutesFormatter alloc] init];
    
    daysFormatter.style = style;
    hoursFormatter.style = style;
    minutesFormatter.style = style;
    
    NSString *formatKey;
    BOOL noDays = (days == 0 || days == NSUndefinedDateComponent);
    BOOL noHours = (hours == 0 || hours == NSUndefinedDateComponent);
    BOOL noSeconds = (seconds == 0 || seconds == NSUndefinedDateComponent);
    
    if (noDays && noHours && minutes == 0 && !noSeconds) {
        formatKey = Str_TimeComponentsSubMinute_M;
        [minutesValue release];
        minutesValue = [[NSNumber alloc] initWithInteger:1];
    } else if (noDays && noHours) {
        formatKey = Str_TimeComponents_M;
    } else if (noDays) {
        formatKey = Str_TimeComponents_MH;
    } else {
        formatKey = Str_TimeComponents_MHD;
    }
    
    NSString *text = [NSString stringWithFormat:LocStr(formatKey), 
                      [minutesFormatter stringForObjectValue:minutesValue], 
                      [hoursFormatter stringForObjectValue:hoursValue], 
                      [daysFormatter stringForObjectValue:daysValue]];
    
    [minutesFormatter release];
    [hoursFormatter release];
    [daysFormatter release];
    [minutesValue release];
    [hoursValue release];
    [daysValue release];
    
    return text;
}
@end


@implementation MinutesFormatter
@synthesize style;
- (NSString *) stringForObjectValue:(NSNumber *)value {
    NSInteger mins = [value integerValue];
    NSString *formatKey = nil;
    if (style == kIntervalFormatterAbbrLongStyle) {
        formatKey = (mins == 1 ? Str_TimeComponentAbbrMinute_M 
                     : Str_TimeComponentAbbrMinutes_M);
    } else {
        formatKey = (mins == 1 ? Str_TimeComponentMinute_M 
                     : Str_TimeComponentMinutes_M);
    }
    return [NSString stringWithFormat:LocStr(formatKey), mins];
}
@end


@implementation HoursFormatter
@synthesize style;
- (NSString *) stringForObjectValue:(NSNumber *)value {
    NSInteger hrs = [value integerValue];
    NSString *formatKey = nil;
    if (style == kIntervalFormatterAbbrLongStyle) {
        formatKey = (hrs == 1 ? Str_TimeComponentAbbrHour_H 
                     : Str_TimeComponentAbbrHours_H);
    } else {
        formatKey = (hrs == 1 ? Str_TimeComponentHour_H 
                     : Str_TimeComponentHours_H);
    }
    return [NSString stringWithFormat:LocStr(formatKey), hrs];
}
@end


@implementation DaysFormatter
@synthesize style;
- (NSString *) stringForObjectValue:(NSNumber *)value {
    NSInteger days = [value integerValue];
    NSString *format = LocStr(days == 1 ? Str_TimeComponentDay_D : Str_TimeComponentDays_D);
    return [NSString stringWithFormat:format, days];
}
@end

