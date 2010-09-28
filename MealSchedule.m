//
//  MealSchedule.m
//  DiningTableViewTest
//
//  Created by Ben Johnson on 8/3/10.
//  Copyright (c) 2010 __MyCompanyName__. All rights reserved.
//

#import "MealSchedule.h"


@implementation MealSchedule

@synthesize mealName, shortName, fileName, currentDay, openTimes, closeTimes, location;

// Returns an NSDate initialized for the current opening time.
-(NSDate *)currentOpening{
    
    NSTimeInterval interval = [[openTimes objectAtIndex:currentDay] intValue];
    
    NSDate *openTime = [[NSDate alloc] initWithTimeInterval:interval 
                                                  sinceDate:[self midnightDate]];
    
    NSDate *timeToReturn = openTime;
    
//    [openTime release];
    
    return timeToReturn;
    
}

-(NSDate *)currentClosing{
    
    NSTimeInterval interval = [[closeTimes objectAtIndex:currentDay] intValue];
    
    
    NSDate *closeTime = [[NSDate alloc] initWithTimeInterval:interval 
                                                  sinceDate:[self midnightDate]];
    
    NSDate *timeToReturn = closeTime;

 //   [closeTime release];
    
    return timeToReturn;    
}

// Creates an NSDate object for 1AM today.
-(NSDate *)oneAMDate{
    
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];

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
    
    return oneAM;
    
    }


// uses the one AM date to decide if today's hours of operation should be initialized from todays 12AM or yesterdays
// i.e. if someone is still out and about before 1AM - the grill is still open on some days.
-(NSDate *)midnightDate{
    
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
    
   // NSLog(@"Returning Midnight Date: %@", midnightDate);
    
    return midnightDate;
        
    
    
    
}

-(BOOL)isOpen{
    
	NSLog(@"Checking %@", fileName);
	
    NSDate *currentTime = [NSDate date];
    NSDate *currentOpening = [self currentOpening];
    NSDate *currentClosing = [self currentClosing];

    
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

-(BOOL)hasClosed{
    
    NSDate *currentTime = [NSDate date];
    NSDate *currentClosing = [self currentClosing];
    
    NSComparisonResult nowClosingComparison = [currentTime compare:currentClosing];
    
    if (nowClosingComparison == NSOrderedDescending){
        
        return YES;
   
    } else {
        
        return NO;
        
    }
    
    
}

-(BOOL)willOpen{
    
    NSDate *currentTime = [NSDate date];
    NSDate *currentOpening = [self currentOpening];
    
    
    NSComparisonResult nowOpeningComparison = [currentTime compare:currentOpening];
    
    
    if (nowOpeningComparison == NSOrderedAscending){

        return YES;
        
    } else {

        return NO;
    }
        
}

-(NSString *)dateText{
    
    NSString *openingTime = [self formattedTimeString:[self currentOpening]];
    NSString *closingTime = [self formattedTimeString:[self currentClosing]];

    
    
    if ([self isOpen]){
        
        NSString *stringToReturn = [NSString stringWithFormat:@"Closes at %@", closingTime];
       
        NSLog(@"%@ returning %@",mealName, stringToReturn);
        return stringToReturn;
        
    }
    
    
    else if ([self willOpen]){
        
        
        NSString *stringToReturn = [NSString stringWithFormat:@"%@ - %@", openingTime, closingTime];

        NSLog(@"%@ returning %@",mealName, stringToReturn);
        return stringToReturn;
    }
    
    else if ([self hasClosed]){
        
        NSLog(@"Returning Closed");
        return @"Closed for the Day";

        
    }
    
    return @"NULL";
    
}

-(NSString*)fullHoursText{
    
    NSString *openingTime = [self formattedTimeString:[self currentOpening]];
    NSString *closingTime = [self formattedTimeString:[self currentClosing]];
    
    NSString *stringToReturn = [NSString stringWithFormat:@"%@ - %@", openingTime, closingTime];
    
	NSLog(@"Full Hours returning %@", stringToReturn);

	
    return stringToReturn;

    
    
}


-(NSString *)returnDescription{
	
	return shortName;
	
}

-(NSString*)returnFileLocation{
	
	
	return [NSString stringWithFormat:@"%@/%@%d.xml",[self documentsDirectory], fileName, currentDay];
	
	
}

// returns the local document directory
- (NSString *)documentsDirectory {
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	return [paths objectAtIndex:0];
}


-(NSString *)formattedTimeString:(NSDate*)dateToFormat{
    
        
    NSDateFormatter *inputFormatter = [[[NSDateFormatter alloc] init] autorelease];
    // String Formatted to 10:30 AM
    [inputFormatter setDateFormat:@"h:mm a"];
        
    NSString *formattedDateString = [inputFormatter stringFromDate:dateToFormat];
        
    return formattedDateString;
    
}



@end
