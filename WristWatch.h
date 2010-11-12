//
//  WristWatch.h
//  DiningTableViewTest
//
//  Created by Ben Johnson on 9/27/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WristWatch : NSObject {

}

- (int)getYear;
- (int)getMonth;
- (int)getDay;
- (int)getHour;
- (int)getMinute;
- (int)getWeekDay;
- (int)getNextWeekDay;
- (int)getWeekofYear;
-(NSString*)getCurrentDayTitle;
-(NSString*)getNextDayTitle;
-(NSString*)getDateString;
-(NSString *)sundayDateString;
-(NSString *)documentsDirectory;
-(NSString *)atreusSeverPath;
-(NSString *)getUpdatedTimeString;

@end
