//
//  MealSchedule.h
//  DiningTableViewTest
//
//  Created by Ben Johnson on 8/3/10.
//  Copyright (c) 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface MealSchedule : NSObject {

    NSArray *openTimes;
    NSArray *closeTimes;
    int currentDay;
	int currentWeek;
    NSString *mealName;
    NSString *shortName;
	NSString *fileName;
	NSString *location;
	
	BOOL mealIsTomorrow;
    
}

@property (nonatomic, retain) NSArray *openTimes;
@property (nonatomic) int currentDay;
@property (nonatomic) int currentWeek;
@property (nonatomic, retain) NSArray *closeTimes;
@property (nonatomic, retain) NSString *mealName;
@property (nonatomic, retain) NSString *shortName;
@property (nonatomic, retain) NSString *fileName;
@property (nonatomic, retain) NSString *location;


// Boolean Conditions
-(BOOL)isOpen;
-(BOOL)willOpen;
-(BOOL)hasClosed;
-(BOOL)isValidMeal;

// Date Manipulation
-(NSDate *)oneAMDate;
-(NSDate *)tomorrowOneAM;
-(NSDate *)tomorrowMidnight;
-(NSDate *)midnightDate;
-(NSDate*)currentOpening;
-(NSDate*)currentClosing;


// String returns
-(NSString *)dateText;
-(NSString*)fullHoursText;
-(NSString *)formattedTimeString:(NSDate*)dateToFormat;
-(NSString*)returnFileLocation;
-(NSString *)returnDescription;



- (NSString *)documentsDirectory;

@end
