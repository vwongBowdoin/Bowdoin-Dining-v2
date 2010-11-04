//
//  ScheduleDecider.h
//  DiningTableViewTest
//
//  Created by Ben Johnson on 8/3/10.
//  Copyright (c) 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
@class MealSchedule;

@interface ScheduleDecider : NSObject {

    // Array of Meals
    NSMutableArray *mealArray;
    NSMutableArray *diningHallMealArray;
	
	// Arrays for Dictionary
	NSMutableArray *thorne_dictionary_array;
    NSMutableArray *moulton_dictionary_array;
	
	
	NSMutableArray *thorneArray;
	NSMutableArray *moultonArray;
	NSMutableArray *navBarArray;
	
	NSMutableArray *thorneNavHours;
	NSMutableArray *moultonNavHours;
	
	NSMutableArray *openArray;
	NSMutableArray *allHoursArray;

	
	
	NSMutableArray *moultonEntriesArray;
	NSMutableArray *thorneEntriesArray;
	

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
	
	
	NSInteger currentHours;




}

// Array of Meals
@property (nonatomic, retain) NSMutableArray *mealArray;
@property (nonatomic, retain) NSMutableArray *diningHallMealArray;

@property (nonatomic, retain) NSMutableArray *thorneArray;
@property (nonatomic, retain) NSMutableArray *moultonArray;
@property (nonatomic, retain) NSMutableArray *navBarArray;


@property (nonatomic, retain) NSMutableArray *thorne_dictionary_array;
@property (nonatomic, retain) NSMutableArray *moulton_dictionary_array;



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



-(int)returnCurrentWeekDay; 
-(NSString *)documentsDirectory;

// Public Methods for Array Processing
-(void)processArrays;

// Private Methods for Processing Arrays
-(void)processMealArraysForDay:(int)day;
-(void)processHoursArrays;
-(void)resolveInconsistenciesInArrays;

// Populating Arrays
-(NSMutableArray*)populateArrayFromDict:(NSMutableArray*)dictArray;
-(void)populateNavigationBarArray;
-(void)populateMealArrays;


// Private Methods Not To Be Used Outside of Class
-(NSMutableArray*)mealArrayFromFile:(NSString*)fileLocation;

// Data Accessor Methods
-(NSMutableArray *)returnNavBarArray;


// Methods that return TableView Data
-(NSInteger)sizeOfSection:(NSInteger)section forLocation:(NSInteger)location atMealIndex:(NSUInteger)mealIndex;
-(NSInteger)numberOfSectionsForLocation:(NSInteger)location atMealIndex:(NSInteger)mealIndex;
-(NSString *)returnItemFromLocation:(NSInteger)location atMealIndex:(NSInteger)mealIndex atPath:(NSIndexPath *)indexPath;
-(CGFloat)returnHeightForCellatLocation:(NSInteger)location atMealIndex:(NSInteger)mealIndex atPath:(NSIndexPath *)indexPath;


// Hours Table View Methods
-(NSInteger)returnNumberOfSections;
-(NSInteger)returnNumberOfRows:(NSInteger)section;
-(NSDictionary *)returnDictionaryAtIndex:(NSIndexPath *)indexPath;
-(NSString *)returnSectionTitleForSection:(NSInteger)section;


// Return method for time of navigation bar
-(NSString*)hoursOfOperationForHall:(int)hall meal:(int)meal;


@end
