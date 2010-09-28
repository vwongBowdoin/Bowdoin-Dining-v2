//
//  ScheduleDecider.h
//  DiningTableViewTest
//
//  Created by Ben Johnson on 8/3/10.
//  Copyright (c) 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
@class MealSchedule;
@class mealHandler;

@interface ScheduleDecider : NSObject {

    // Array of Meals
    NSMutableArray *mealArray;
    NSMutableArray *diningHallMealArray;
	
	NSMutableArray *thorneArray;
	NSMutableArray *moultonArray;
	NSMutableArray *navBarArray;
	
	NSMutableArray *openArray;
	NSMutableArray *allHoursArray;


    // Meal Handler
    mealHandler *storedMealHandler;
    
    // Moulton Meals
    MealSchedule *expressLunch;
    MealSchedule *expressDinner;
    
    MealSchedule *mHotBreakfast;
    MealSchedule *mColdBreakfast;
    MealSchedule *mLunch;
    MealSchedule *mDinner;
    MealSchedule *mBrunch;
    
    // Thorne Meals
    MealSchedule *tHotBreakfast;
    MealSchedule *tColdLunch;
    MealSchedule *tHotLunch;
    MealSchedule *tDinner;
    MealSchedule *tBrunch;
    MealSchedule *tSuperSnax;
    
    
    // Smith Union Dining
    MealSchedule *cafeMorning;
    MealSchedule *cafeNight;
    
    MealSchedule *theGrill;
    MealSchedule *thePub;
    MealSchedule *theCStore;




}

// Array of Meals
@property (nonatomic, retain) NSMutableArray *mealArray;
@property (nonatomic, retain) NSMutableArray *diningHallMealArray;

@property (nonatomic, retain) NSMutableArray *thorneArray;
@property (nonatomic, retain) NSMutableArray *moultonArray;
@property (nonatomic, retain) NSMutableArray *navBarArray;


// Moulton Express Properties
@property (nonatomic, retain) MealSchedule *expressLunch;
@property (nonatomic, retain) MealSchedule *expressDinner;

// Moulton Meal Properties
@property (nonatomic, retain) MealSchedule *mHotBreakfast;
@property (nonatomic, retain) MealSchedule *mColdBreakfast;
@property (nonatomic, retain) MealSchedule *mLunch;
@property (nonatomic, retain) MealSchedule *mDinner;
@property (nonatomic, retain) MealSchedule *mBrunch;


// Thorne Meal Properties
@property (nonatomic, retain) MealSchedule *tHotBreakfast;
@property (nonatomic, retain) MealSchedule *tColdLunch;
@property (nonatomic, retain) MealSchedule *tHotLunch;
@property (nonatomic, retain) MealSchedule *tDinner;
@property (nonatomic, retain) MealSchedule *tBrunch;
@property (nonatomic, retain) MealSchedule *tSuperSnax;


//Smith Union Properties
@property (nonatomic, retain) MealSchedule *cafeMorning;
@property (nonatomic, retain) MealSchedule *cafeNight;
@property (nonatomic, retain) MealSchedule *theGrill;
@property (nonatomic, retain) MealSchedule *thePub;
@property (nonatomic, retain) MealSchedule *theCStore;



-(void)testMethods;
-(int)returnCurrentWeekDay; 
-(NSString *)documentsDirectory;
-(NSString *)locationStringForMeal:(NSString*)mealTitle date:(int)date;

-(void)processMealArrays;


// Data Accessor Methods
-(NSMutableArray *)returnArrayOfOpenMeals;
-(NSMutableArray *)returnArrayForDiningHalls;
-(NSMutableArray *)returnMoultonArray;
-(NSMutableArray *)returnThorneArray;
-(NSMutableArray *)returnNavBarArray;


@end
