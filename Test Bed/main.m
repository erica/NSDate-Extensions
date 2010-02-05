/*
 Erica Sadun, http://ericasadun.com
 iPhone Developer's Cookbook, 3.0 Edition
 BSD License, Use at your own risk
 */

#import <UIKit/UIKit.h>
#import "NSDate-Utilities.h"

#define COOKBOOK_PURPLE_COLOR	[UIColor colorWithRed:0.20392f green:0.19607f blue:0.61176f alpha:1.0f]
#define BARBUTTON(TITLE, SELECTOR) 	[[[UIBarButtonItem alloc] initWithTitle:TITLE style:UIBarButtonItemStylePlain target:self action:SELECTOR] autorelease]

@interface TestBedViewController : UIViewController
@end

@implementation TestBedViewController
- (void) action: (UIBarButtonItem *) bbi
{
}

- (void) viewDidLoad
{
	self.navigationController.navigationBar.tintColor = COOKBOOK_PURPLE_COLOR;
	self.navigationItem.rightBarButtonItem = BARBUTTON(@"Action", @selector(action:));
	
	NSDateFormatter *formatter = [[[NSDateFormatter alloc] init] autorelease];
	formatter.dateFormat = @"MM-dd-yyyy";
	NSDate *testDate1 = [formatter dateFromString:@"12-31-2009"];
	
	NSLog(@"Today: %@", [NSDate date]);
	NSLog(@"Tomorrow: %@", [NSDate dateTomorrow]);
	NSLog(@"Yesterday: %@", [NSDate dateYesterday]);
	
	NSLog(@"2 days from now: %@", [NSDate dateWithDaysFromNow:2]);
	NSLog(@"5 days ago: %@", [NSDate dateWithDaysBeforeNow:5]);
	NSLog(@"3 hours from now: %@", [NSDate dateWithHoursFromNow:3]);
	NSLog(@"3 hours ago: %@", [NSDate dateWithHoursBeforeNow:3]);
	
	NSLog(@"Is tomorrow? (YES) %@", [[NSDate dateTomorrow] isTomorrow] ? @"Yes" : @"No");
	NSLog(@"Is yesterday? (NO) %@", [[NSDate dateTomorrow] isYesterday] ? @"Yes" : @"No");
	NSLog(@"Is today? (YES) %@", [[NSDate dateWithMinutesFromNow:5] isToday] ? @"Yes" : @"No");
	
	for (int i = 0; i < 9; i++)
		NSLog(@"Day: %@ is this week: %@", [formatter stringFromDate:[NSDate dateWithDaysFromNow:i]], [[NSDate dateWithDaysFromNow:i] isThisWeek] ? @"Yes" : @"No");
	
	NSDate *testDate2 = [formatter dateFromString:@"01-01-2010"];
	NSLog(@"Comparing 12/31/09 against 1/1/10. Same week?: %@", [testDate1 isSameWeekAsDate:testDate2] ? @"Yes" : @"No");
	
	NSLog(@"12/31 earlier? %@ Later? %@",
		  [testDate1 isEarlierThanDate:testDate2] ? @"Yes" :  @"No",
		  [testDate1 isLaterThanDate:testDate2] ? @"Yes" :  @"No");
	
	NSLog(@"days: %d, hours: %d, minutes: %d",
		  [testDate2 daysAfterDate:testDate1],
		  [testDate2 hoursAfterDate:testDate1],
		  [testDate2 minutesAfterDate:testDate1]);
	
	NSLog(@"nearest hour: %d, hour: %d, minute: %d, seconds: %d, day: %d, month: %d, week: %d, weekday: %d, nthWeekday: %d, year: %d",
		  [[NSDate date] nearestHour],
		  [[NSDate date] hour],
		  [[NSDate date] minute],
		  [[NSDate date] seconds],
		  [[NSDate date] day],
		  [[NSDate date] month],
		  [[NSDate date] week],
		  [[NSDate date] weekday],
		  [[NSDate date] nthWeekday],
		  [[NSDate date] year]);
}
@end

@interface TestBedAppDelegate : NSObject <UIApplicationDelegate>
@end

@implementation TestBedAppDelegate
- (void)applicationDidFinishLaunching:(UIApplication *)application {	
	UIWindow *window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
	UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:[[TestBedViewController alloc] init]];
	[window addSubview:nav.view];
	[window makeKeyAndVisible];
}
@end

int main(int argc, char *argv[])
{
	NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
	int retVal = UIApplicationMain(argc, argv, nil, @"TestBedAppDelegate");
	[pool release];
	return retVal;
}
