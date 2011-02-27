//
//  ScheduleDecider.h
//  DiningTableViewTest
//
//  Created by Ben Johnson on 8/3/10.
//  Copyright (c) 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class MealSchedule;
@class WristWatch;

@interface ScheduleDecider : NSObject {

	// Core Data
	NSManagedObjectContext *managedObjectContext;	 
	
    // Array of Meals
    NSMutableArray *mealArray;
    NSMutableArray *diningHallMealArray;
	
	// Dictionary Arrays
	NSMutableArray *thorne_dictionary_array;
    NSMutableArray *moulton_dictionary_array;
	
	
	NSMutableArray *thorneArray;
	NSMutableArray *moultonArray;
	NSMutableArray *navBarArray;
	NSMutableArray *specialsArray;

	
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
    
    
    // Smith Union Meals
    MealSchedule *cafeMorning;
    MealSchedule *cafeNight;
    
    MealSchedule *theGrill;
    MealSchedule *thePub;
    MealSchedule *theCStore;
	
	
	NSInteger currentHours;

	

	WristWatch *watch;
	
	BOOL stressTesting;
	int testDay;
	int testWeek;
	NSDate *testDate;
	
	
}

@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;	    

// Array of Meals
@property (nonatomic, retain) NSMutableArray *mealArray;
@property (nonatomic, retain) NSMutableArray *diningHallMealArray;

@property (nonatomic, retain) NSMutableArray *thorneArray;
@property (nonatomic, retain) NSMutableArray *moultonArray;
@property (nonatomic, retain) NSMutableArray *navBarArray;
@property (nonatomic, retain) NSMutableArray *specialsArray;



@property (nonatomic, retain) NSMutableArray *thorne_dictionary_array;
@property (nonatomic, retain) NSMutableArray *moulton_dictionary_array;



-(NSString *)documentsDirectory;

// Public Methods for Array Processing
-(void)processArrays;

// Private Methods for Processing Arrays
-(void)processMealArraysForDay:(int)day forWeek:(int)week;
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
- (void)changeDisplayedHourInformation;
- (NSString*)currentlySelectedHoursDescription;


@end
