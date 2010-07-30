//
//  MealDecider.h
//  DiningTableViewTest
//
//  Created by Ben Johnson on 7/27/10.
//  Copyright (c) 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface MealDecider : NSObject {

}

- (int)getYear;
- (int)getMonth;
- (int)getDay;
- (int)getHour;
- (int)getMinute;
- (int)getWeekDay;
- (int)getWeekofYear;
-(NSString*)getCurrentDayTitle;
-(NSString*)getNextDayTitle;
-(NSString*)getDateString;
-(NSString *)sundayDateString;
-(NSString *)documentsDirectory;
-(NSString *)atreusSeverPath;
-(void)errorOccurred;

@end
