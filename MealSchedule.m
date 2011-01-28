//
//  MealSchedule.m
//  DiningTableViewTest
//
//  Created by Ben Johnson on 8/3/10.
//  Copyright (c) 2010 __MyCompanyName__. All rights reserved.
//

#import "MealSchedule.h"
#import "WristWatch.h"

@implementation MealSchedule

@synthesize mealName, shortName, fileName, currentDay, currentWeek, openTimes, closeTimes, location;

// Returns an NSDate initialized for the current opening time.
- (NSDate *)currentOpening{
    	
	NSTimeInterval interval = [[openTimes objectAtIndex:currentDay-1] intValue];
		
	NSDate *openTime = [[NSDate alloc] initWithTimeInterval:interval 
													  sinceDate:[self midnightDate]];
				
	_currentOpening = openTime;

    return openTime;
    
}

- (NSDate *)currentClosing{
		
	NSTimeInterval interval = [[closeTimes objectAtIndex:currentDay-1] intValue];
		
	NSDate *closeTime = [[NSDate alloc] initWithTimeInterval:interval 
													   sinceDate:[self midnightDate]];
		
	_currentClosing = closeTime;
	
    return closeTime;    
}

// Returns an NSDate initialized for the current opening time tomorrow.
- (NSDate *)currentOpeningTomorrow{
		
	NSTimeInterval interval = [[openTimes objectAtIndex:currentDay-1] intValue];
		
	NSDate *openTime = [[NSDate alloc] initWithTimeInterval:interval 
													  sinceDate:[self tomorrowMidnight]];
		
	
	_currentOpeningTomorrow = openTime;

    return openTime;
    
}



// Creates an NSDate object for 1AM today.
- (NSDate *)oneAMDate{
    
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];

	if (stressTesting) {
		<#statements#>
	}
	
    NSDate* now = [NSDate date];

    NSDateComponents* nowHour = [gregorian components:NSHourCalendarUnit fromDate:now];
    NSDateComponents* nowMinute = [gregorian components:NSMinuteCalendarUnit fromDate:now];
    NSDateComponents* nowSecond = [gregorian components:NSSecondCalendarUnit fromDate:now];
    
    NSDateComponents* componentsToSubtract = [[NSDateComponents alloc] init];
    
    [componentsToSubtract setHour:0-[nowHour hour] + 1];
    [componentsToSubtract setMinute:0-[nowMinute minute]];
    [componentsToSubtract setSecond:0-[nowSecond second]];
    
    
    
    NSDate *oneAM = [gregorian dateByAddingComponents:componentsToSubtract toDate:now options:0];
    
    [componentsToSubtract release];
    [gregorian release];
    
	_oneAMDate = oneAM;
	
    return oneAM;
    
    }

- (NSDate *)tomorrowOneAM{
    
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
	
    NSDate* now = [NSDate date];
	
    NSDateComponents* nowHour = [gregorian components:NSHourCalendarUnit fromDate:now];
    NSDateComponents* nowMinute = [gregorian components:NSMinuteCalendarUnit fromDate:now];
    NSDateComponents* nowSecond = [gregorian components:NSSecondCalendarUnit fromDate:now];
    
    NSDateComponents* componentsToAdd = [[NSDateComponents alloc] init];
    
    [componentsToAdd setHour:25-[nowHour hour]];
    [componentsToAdd setMinute:60-[nowMinute minute]];
    [componentsToAdd setSecond:60-[nowSecond second]];
    
    
    NSDate *oneAMTomorrow = [gregorian dateByAddingComponents:componentsToAdd toDate:now options:0];
    
    [componentsToAdd release];
    [gregorian release];
    
	_tomorrowOneAM = oneAMTomorrow;
	
    return oneAMTomorrow;
    
}

- (NSDate *)tomorrowMidnight{
    
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
	
    NSDate* now = [NSDate date];
	
    NSDateComponents* nowHour = [gregorian components:NSHourCalendarUnit fromDate:now];
    NSDateComponents* nowMinute = [gregorian components:NSMinuteCalendarUnit fromDate:now];
    NSDateComponents* nowSecond = [gregorian components:NSSecondCalendarUnit fromDate:now];
    
    NSDateComponents* componentsToAdd = [[NSDateComponents alloc] init];
    
    [componentsToAdd setHour:24-[nowHour hour]];
    [componentsToAdd setMinute:60-[nowMinute minute]];
    [componentsToAdd setSecond:60-[nowSecond second]];
    
    
    NSDate *tomorrowMidnight = [gregorian dateByAddingComponents:componentsToAdd toDate:now options:0];
    
    [componentsToAdd release];
    [gregorian release];
    
	_tomorrowMidnight = tomorrowMidnight;
	
    return tomorrowMidnight;
    
}

// uses the one AM date to decide if today's hours of operation should be initialized from todays 12AM or yesterdays
// i.e. if someone is still out and about before 1AM - the grill is still open on some days.
- (NSDate *)midnightDate{
    
    // Initializes the Calendar Objects
    NSDate *currentTime = [NSDate date];
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDate * oneAM = [self oneAMDate];
   
    NSComparisonResult result = [currentTime compare:oneAM];
    
    int hoursToSubtract = 0;
    
    switch (result)
    {
        case NSOrderedAscending:  hoursToSubtract = 24; break;
        case NSOrderedDescending: hoursToSubtract =  0; break;
        case NSOrderedSame:       hoursToSubtract = 24; break;
        default: break;
    }
    
    
    NSDateComponents* nowHour = [gregorian components:NSHourCalendarUnit fromDate:currentTime];
    NSDateComponents* nowMinute = [gregorian components:NSMinuteCalendarUnit fromDate:currentTime];
    NSDateComponents* nowSecond = [gregorian components:NSSecondCalendarUnit fromDate:currentTime];
    
    NSDateComponents* componentsToSubtract = [[NSDateComponents alloc] init];
	
    [componentsToSubtract setHour:0-[nowHour hour] - hoursToSubtract];
    [componentsToSubtract setMinute:0-[nowMinute minute]];
    [componentsToSubtract setSecond:0-[nowSecond second]];
    
	
    NSDate *midnightDate = [gregorian dateByAddingComponents:componentsToSubtract toDate:currentTime options:0];
    
    [componentsToSubtract release];
    [gregorian release];
    
	_midnightDate = midnightDate;
    
    return midnightDate;
        
    
    
    
}

- (BOOL)isOpen{
    
	
    NSDate *currentTime = [NSDate date];
	
	if (_currentOpening == nil) { [self currentOpening]; }
	if (_currentClosing == nil) { [self currentClosing]; }
	
    NSDate *currentOpening = _currentOpening;
    NSDate *currentClosing = _currentClosing;
    
    NSComparisonResult nowOpeningComparison = [currentTime compare:currentOpening];
    NSComparisonResult nowClosingComparison = [currentTime compare:currentClosing];

    // NSOrderedDesceding result means currentTime is AFTER 
    // NSOrderedAscending result means currentTime is BEFORE
    // NSOrderedSame means dates are identical
    
    // Within Hours of Operation
    if (nowOpeningComparison ==  NSOrderedDescending  && nowClosingComparison == NSOrderedAscending){
		return YES;
    } else {
        return NO;
    }

}

- (BOOL)hasClosed{
    
    NSDate *currentTime = [NSDate date];

    if (_currentOpening == nil) { [self currentOpening]; }
	if (_currentClosing == nil) { [self currentClosing]; }
	
    NSDate *currentOpening = _currentOpening;
    NSDate *currentClosing = _currentClosing;	
	
    NSComparisonResult nowClosingComparison = [currentTime compare:currentClosing];
	
	BOOL result;
	
    if (nowClosingComparison == NSOrderedDescending){ result = YES; } 
	else { result = NO; }
    
	// checks whether start and end date are identical 
	// (i.e. 00000 NoMeal - see ScheduleConstants.h
	if (currentOpening == currentClosing) {
		result = NO;
	}
	
	return result;
    
}

- (BOOL)isValidMeal{
	
	if (_currentOpening == nil) { [self currentOpening]; }
	if (_currentClosing == nil) { [self currentClosing]; }
	
    NSDate *currentOpening = _currentOpening;
    NSDate *currentClosing = _currentClosing;	

	NSTimeInterval opening = [currentOpening timeIntervalSince1970];
	NSTimeInterval closing = [currentClosing timeIntervalSince1970];
	
	if ((int)opening == (int)closing ) {
		return NO;
	} else {
		return YES;
	}


	
	
}

- (BOOL)willOpen{
    
	NSDate *currentTime;
	NSDate *currentOpening;
	
	// Initial Check for Tomorrow Query
	WristWatch *clock= [[WristWatch alloc] init];
	
	if (currentDay != [clock getWeekDay]) {
		
		if (_tomorrowOneAM == nil) { [self tomorrowOneAM]; }
		if (_currentOpeningTomorrow == nil) { [self currentOpeningTomorrow]; }
		
		currentTime = _tomorrowOneAM;
		currentOpening = _currentOpeningTomorrow;	
		
	} else {
		
		currentTime = [NSDate date];
		
		if (_currentOpening == nil) { [self currentOpening]; }
		
		currentOpening = _currentOpening;
	}

	[clock release];
	

    NSComparisonResult nowOpeningComparison = [currentTime compare:currentOpening];
    
    
    if (nowOpeningComparison == NSOrderedAscending){

        return YES;
        
    } else {

        return NO;
    }
        
}

- (NSString *)dateText{
    
	if (_currentOpening == nil) { [self currentOpening]; }
	if (_currentClosing == nil) { [self currentClosing]; }
	
    NSDate *currentOpening = _currentOpening;
    NSDate *currentClosing = _currentClosing;
	
    NSString *openingTime = [self formattedTimeString:currentOpening];
    NSString *closingTime = [self formattedTimeString:currentClosing];

    
    if ([self isOpen]){
        NSString *stringToReturn = [NSString stringWithFormat:@"Closes at %@", closingTime];
		return stringToReturn;
    }
    
    
    else if ([self willOpen]){
        
        NSString *stringToReturn = [NSString stringWithFormat:@"%@ - %@", openingTime, closingTime];
        return stringToReturn;
    }
    
    else if ([self hasClosed]){
        
        NSString *stringToReturn = [NSString stringWithFormat:@"%@ - %@", openingTime, closingTime];
        return stringToReturn;
        
    }
    
    return @"NULL";
    
}

- (NSString*)fullHoursText{
    
	if (_currentOpening == nil) { [self currentOpening]; }
	if (_currentClosing == nil) { [self currentClosing]; }
	
    NSDate *currentOpening = _currentOpening;
    NSDate *currentClosing = _currentClosing;
	
	
    NSString *openingTime = [self formattedTimeString:currentOpening];
    NSString *closingTime = [self formattedTimeString:currentClosing];
    
    NSString *stringToReturn = [NSString stringWithFormat:@"%@ - %@", openingTime, closingTime];
	
    return stringToReturn;

    
    
}

- (NSString *)returnDescription{
	
	return shortName;
	
}

- (NSString*)returnFileLocation{
	
	
	return [NSString stringWithFormat:@"%@/%d%@%d.xml",[self documentsDirectory], currentWeek, fileName, currentDay];
	
	
}

// returns the local document directory
- (NSString *)documentsDirectory {
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	return [paths objectAtIndex:0];
}

- (NSString *)formattedTimeString:(NSDate*)dateToFormat{
    
        
    NSDateFormatter *inputFormatter = [[[NSDateFormatter alloc] init] autorelease];
    // String Formatted to 10:30 AM
    [inputFormatter setDateFormat:@"h:mm a"];
        
    NSString *formattedDateString = [inputFormatter stringFromDate:dateToFormat];
        
    return formattedDateString;
    
}



@end
