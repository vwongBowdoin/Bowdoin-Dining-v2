//
//  NavigationBarController.h
//  DiningTableViewTest
//
//  Created by Ben Johnson on 8/11/10.
//  Copyright (c) 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "mealHandler.h"

@class mealHandler;

@interface NavigationBarController : NSObject {

    // Parameters for Measuring Window

    
    mealHandler *passedMealHandler;
    NSMutableArray *scheduleArray;
    
}

-(id)initWithScheduleArray:(NSMutableArray *)theScheduleArray;
-(UIView*)createMealHeader:(NSString *)mealName atIndex:(int)index leftTitle:(NSString *)leftTitle rightTitle:(NSString *)rightTitle;
-(UIView*)returnMealNavigationBar;


@end
