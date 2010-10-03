//
//  WristWatch.m
//  DiningTableViewTest
//
//  Created by Ben Johnson on 9/27/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "WristWatch.h"
#import "Constants.h"

@implementation WristWatch

// Public Methods

// returns the atreus server path
-(NSString *)atreusSeverPath {
    
    return @"http://www.bowdoin.edu/atreus/lib/xml/";
}

// returns the local document directory
- (NSString *)documentsDirectory {
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	return [paths objectAtIndex:0];
}

/* 
 The Atreus server bundles XML documents for 
 weekly meals in folder labled with the sunday of each week 
 */
-(NSString *)sundayDateString {
    
    NSDate *today = [[NSDate alloc] init];
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    
    NSDateComponents *weekdayComponents = [gregorian components:NSWeekdayCalendarUnit fromDate:today];
    
    /*
     Create a date components to represent the number of days to subtract from the current date.
     The weekday value for Sunday in the Gregorian calendar is 1, so subtract 1 from the number of days to subtract from the date in question.  (If today's Sunday, subtract 0 days.)
     */
    NSDateComponents *componentsToSubtract = [[NSDateComponents alloc] init];
    [componentsToSubtract setDay: 0 - ([weekdayComponents weekday] - 1)];
    
    NSDate *beginningOfWeek = [gregorian dateByAddingComponents:componentsToSubtract toDate:today options:0];
    
    
    NSDateFormatter *yearFormatter = [[[NSDateFormatter alloc] init] autorelease];
	[yearFormatter setDateFormat:@"Y"];
	
    NSDateFormatter *monthFormatter = [[[NSDateFormatter alloc] init] autorelease];
	[monthFormatter setDateFormat:@"M"];
    
    NSDateFormatter *dayFormatter = [[[NSDateFormatter alloc] init] autorelease];
	[dayFormatter setDateFormat:@"d"];
    
    NSString *formattedYear = [yearFormatter stringFromDate:beginningOfWeek];
    NSString *formattedMonth = [monthFormatter stringFromDate:beginningOfWeek];
    NSString *formattedDay = [dayFormatter stringFromDate:beginningOfWeek];
	
    NSInteger formattedInt;
	formattedInt = [formattedMonth intValue] - 1;
    
    NSString *formattedDate = [NSString stringWithFormat:@"%@-%d-%@",formattedYear, formattedInt, formattedDay];
    
    
    return formattedDate;
    
}

// returns todays xml string
-(NSString *)todaysXMLString{
    
    NSString *stringToReturn = [NSString stringWithFormat:@"%d.xml",[self getWeekDay]];
    
    return stringToReturn;
    
}

// *** These Methods Will Deal with Time ***//
- (int)getYear {
	NSDateFormatter *inputFormatter = [[[NSDateFormatter alloc] init] autorelease];
	[inputFormatter setDateFormat:@"Y"];
	NSDate *toBeFormatted = [[[NSDate alloc] init] autorelease];
	
	NSString *formattedDate = [inputFormatter stringFromDate:toBeFormatted];
	//NSLog(@"formattedYear: %@", formattedDate);
	
	return[formattedDate intValue];
	
}

- (int)getMonth {
	NSDateFormatter *inputFormatter = [[[NSDateFormatter alloc] init] autorelease];
	[inputFormatter setDateFormat:@"M"];
	NSDate *toBeFormatted = [[[NSDate alloc] init] autorelease];
	
	NSString *formattedDate = [inputFormatter stringFromDate:toBeFormatted];
	
	// compensates for Atreus server which takes values of 0-11
	NSInteger formattedMonth;
	formattedMonth = [formattedDate intValue];
	//NSLog(@"formattedMonth: %@", formattedMonth);
    
	return formattedMonth;
}

- (int)getDay {
	NSDateFormatter *inputFormatter = [[[NSDateFormatter alloc] init] autorelease];
	[inputFormatter setDateFormat:@"d"];
	NSDate *toBeFormatted = [[[NSDate alloc] init] autorelease];
	
	NSString *formattedDate = [inputFormatter stringFromDate:toBeFormatted];
	//NSLog(@"formattedDay: %@", formattedDate);
	
	return[formattedDate intValue];
}

- (int)getHour {
	NSDateFormatter *inputFormatter = [[[NSDateFormatter alloc] init] autorelease];
	[inputFormatter setDateFormat:@"H"];
	NSDate *toBeFormatted = [[[NSDate alloc] init] autorelease];
	
	NSString *formattedDate = [inputFormatter stringFromDate:toBeFormatted];
	//NSLog(@"formattedHour: %@", formattedDate);
	
	return[formattedDate intValue];
}

- (int)getMinute {
	NSDateFormatter *inputFormatter = [[[NSDateFormatter alloc] init] autorelease];
	[inputFormatter setDateFormat:@"m"];
	NSDate *toBeFormatted = [[[NSDate alloc] init] autorelease];
	
	NSString *formattedDate = [inputFormatter stringFromDate:toBeFormatted];
	
	return[formattedDate intValue];
}

- (int)getWeekDay {
	NSDateFormatter *inputFormatter = [[[NSDateFormatter alloc] init] autorelease];
	[inputFormatter setDateFormat:@"e"];
	NSDate *toBeFormatted = [[[NSDate alloc] init] autorelease];
	
	NSString *formattedDate = [inputFormatter stringFromDate:toBeFormatted];
	
	return[formattedDate intValue];
	
}

- (int)getWeekofYear{
	
	NSDateFormatter *inputFormatter = [[[NSDateFormatter alloc] init] autorelease];
	[inputFormatter setDateFormat:@"w"];
	NSDate *toBeFormatted = [[[NSDate alloc] init] autorelease];
	
	NSString *formattedDate = [inputFormatter stringFromDate:toBeFormatted];
    
	// Returns the week of the year
	NSInteger formattedWeek;
	formattedWeek = [formattedDate intValue];
	//NSLog(@"formattedWeek: %d", formattedWeek);
	
	return formattedWeek;
	
}

-(NSString*)getCurrentDayTitle{
	
	NSDateFormatter *inputFormatter = [[[NSDateFormatter alloc] init] autorelease];
	[inputFormatter setDateFormat:@"EEEE"];
	NSTimeInterval zeroDays = 24 * 60 * 60;
	NSDate *toBeFormatted = [[[NSDate alloc] initWithTimeIntervalSinceNow:zeroDays] autorelease];
	
	NSString *formattedDate = [inputFormatter stringFromDate:toBeFormatted];
	//NSLog(@"formattedNextDayTitle: %@", formattedDate);
	
	return formattedDate;
}

-(NSString*)getNextDayTitle{
	
	NSDateFormatter *inputFormatter = [[[NSDateFormatter alloc] init] autorelease];
	[inputFormatter setDateFormat:@"EEEE"];
	NSTimeInterval oneDay = 48 * 60 * 60;
	NSDate *toBeFormatted = [[[NSDate alloc] initWithTimeIntervalSinceNow:oneDay] autorelease];
	
	NSString *formattedDate = [inputFormatter stringFromDate:toBeFormatted];
	//NSLog(@"formattedNextDayTitle: %@", formattedDate);
	
	return formattedDate;
}

-(NSString*)getDateString{
	
	NSDateFormatter *inputFormatter = [[[NSDateFormatter alloc] init] autorelease];
	[inputFormatter setDateFormat:@"EEEE MMMM d"];
	NSDate *toBeFormatted = [[[NSDate alloc] init] autorelease];
	
	NSString *formattedDate = [inputFormatter stringFromDate:toBeFormatted];
	//NSLog(@"formattedWeekday: %@", formattedDate);
	
	return formattedDate;
	
}

@end
