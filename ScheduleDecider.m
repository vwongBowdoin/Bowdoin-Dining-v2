//
//  ScheduleDecider.m
//  DiningTableViewTest
//
//  Created by Ben Johnson on 8/3/10.
//  Copyright (c) 2010 __MyCompanyName__. All rights reserved.
//

#import "ScheduleDecider.h"
#import "MealSchedule.h"
#import "ScheduleConstants.h"
#import "WristWatch.h"
#import "FavoriteItem.h"

@interface ScheduleDecider (PrivateMethods)

- (NSString*)currentlySelectedHoursDescription;
- (void)populateSpecialsArray;

@end


@implementation ScheduleDecider

@synthesize mealArray, diningHallMealArray, thorneArray, moultonArray, 
navBarArray, thorne_dictionary_array, moulton_dictionary_array, specialsArray;

@synthesize managedObjectContext;

- (void)dealloc{
	NSLog(@"ScheduleDecider De-Allocated");

	
	[mealArray release];
	[diningHallMealArray release];
	[thorneArray release];
	[moultonArray release];
	[navBarArray release];
	[thorne_dictionary_array release];
	[moulton_dictionary_array release];
	[expressLunch release];
	[expressDinner release];
	[mHotBreakfast release];
	[mColdBreakfast release];
	[mLunch release];
	[mDinner release];
	[mBrunch release];
	[tHotBreakfast release];
	[tColdLunch release];
	[tHotLunch release];
	[tDinner release];
	[tBrunch release];
	[tSuperSnax release];
	[cafeMorning release];
	[cafeNight release];
	[theGrill release];
	[thePub release];
	[theCStore release];
	[openArray release];
	[allHoursArray release];
	[super dealloc];
	
}

/**
 Populates MealSchedule objects with information
 @returns self
 */
- (id)init{
	
    //
    // Moulton Hot Breakfast
    //
    
    mHotBreakfast = [[MealSchedule alloc] init];
    
	
    
	NSArray * open = [[NSArray alloc] initWithObjects:[NSNumber numberWithInt:mwkBreakfastStart],  // Sun
					  [NSNumber numberWithInt:mHotBreakfastStart], // Mon
					  [NSNumber numberWithInt:mHotBreakfastStart], // Tue
					  [NSNumber numberWithInt:mHotBreakfastStart], // Wed
					  [NSNumber numberWithInt:mHotBreakfastStart], // Thu
					  [NSNumber numberWithInt:mHotBreakfastStart], // Fri
					  [NSNumber numberWithInt:mwkBreakfastStart],  // Sat
					  
					  nil];
    
	NSArray * close = [[NSArray alloc] initWithObjects:[NSNumber numberWithInt:mwkBreakfastStop],  // Sun
					   [NSNumber numberWithInt:mHotBreakfastStop], // Mon
					   [NSNumber numberWithInt:mHotBreakfastStop], // Tue
					   [NSNumber numberWithInt:mHotBreakfastStop], // Wed
					   [NSNumber numberWithInt:mHotBreakfastStop], // Thu
					   [NSNumber numberWithInt:mHotBreakfastStop], // Fri
					   [NSNumber numberWithInt:mwkBreakfastStop],  // Sat
					   
					   nil];
    
    
    mHotBreakfast.openTimes = open;
    mHotBreakfast.closeTimes = close;
    mHotBreakfast.mealName = @"Hot Breakfast";
    mHotBreakfast.shortName = @"Breakfast";
    mHotBreakfast.fileName = @"moultonBreakfast";
	mHotBreakfast.location = @"Moulton";
	
	
    //
    // Moulton Cold Breakfast
    //
    
    mColdBreakfast = [[MealSchedule alloc] init];
    
	
    open = [[NSArray alloc] initWithObjects:[NSNumber numberWithInt:noMealForDay],  // Sun
			[NSNumber numberWithInt:mColdBreakfastStart], // Mon
            [NSNumber numberWithInt:mColdBreakfastStart], // Tue
            [NSNumber numberWithInt:mColdBreakfastStart], // Wed
            [NSNumber numberWithInt:mColdBreakfastStart], // Thu
            [NSNumber numberWithInt:mColdBreakfastStart], // Fri
            [NSNumber numberWithInt:noMealForDay],  // Sat
            
            nil];
    
    close = [[NSArray alloc] initWithObjects:[NSNumber numberWithInt:noMealForDay],  // Sun
			 [NSNumber numberWithInt:mColdBreakfastStop], // Mon
             [NSNumber numberWithInt:mColdBreakfastStop], // Tue
             [NSNumber numberWithInt:mColdBreakfastStop], // Wed
             [NSNumber numberWithInt:mColdBreakfastStop], // Thu
             [NSNumber numberWithInt:mColdBreakfastStop], // Fri
             [NSNumber numberWithInt:noMealForDay],  // Sat
             
             nil];
    
    
    mColdBreakfast.openTimes = open;
    mColdBreakfast.closeTimes = close;
    mColdBreakfast.mealName = @"Cold Breakfast";  
    mColdBreakfast.shortName = @"Breakfast";
    mColdBreakfast.fileName = @"moultonBreakfast";
	mColdBreakfast.location = @"Moulton";
	
	
	//
    // Express Lunch
    //  
	
    expressLunch = [[MealSchedule alloc] init];
    
	open = [[NSArray alloc] initWithObjects:
			[NSNumber numberWithInt:noMealForDay],			// Sun
			[NSNumber numberWithInt:mExpressLunchStart],	// Mon
			[NSNumber numberWithInt:mExpressLunchStart],	// Tue
			[NSNumber numberWithInt:mExpressLunchStart],	// Wed
			[NSNumber numberWithInt:mExpressLunchStart],	// Thu
			[NSNumber numberWithInt:mExpressLunchStart],	// Fri
			[NSNumber numberWithInt:noMealForDay],			// Sat
			nil];
    
	close = [[NSArray alloc] initWithObjects:[NSNumber numberWithInt:noMealForDay], // Sun
			 [NSNumber numberWithInt:mExpressLunchStop], // Mon
			 [NSNumber numberWithInt:mExpressLunchStop], // Tue
			 [NSNumber numberWithInt:mExpressLunchStop], // Wed
			 [NSNumber numberWithInt:mExpressLunchStop], // Thu
			 [NSNumber numberWithInt:mExpressLunchStop], // Fri
			 [NSNumber numberWithInt:noMealForDay],      // Sat
			 
			 nil];
	
	
	
    expressLunch.openTimes = open;
    expressLunch.closeTimes = close;
    expressLunch.mealName = @"Express";
	expressLunch.shortName = @"Express";
	expressLunch.location = @"Moulton";
	
	
	
	//
    // Moulton Brunch
    //
    
    mBrunch = [[MealSchedule alloc] init];
    
    open = [[NSArray alloc] initWithObjects:[NSNumber numberWithInt:mwkBrunchStart],  // Sun
			[NSNumber numberWithInt:noMealForDay], // Mon
            [NSNumber numberWithInt:noMealForDay], // Tue
            [NSNumber numberWithInt:noMealForDay], // Wed
            [NSNumber numberWithInt:noMealForDay], // Thu
            [NSNumber numberWithInt:noMealForDay], // Fri
            [NSNumber numberWithInt:mwkBrunchStart],  // Sat
            
            nil];
    
    close = [[NSArray alloc] initWithObjects:[NSNumber numberWithInt:mwkBrunchStop],  // Sun
			 [NSNumber numberWithInt:noMealForDay], // Mon
             [NSNumber numberWithInt:noMealForDay], // Tue
             [NSNumber numberWithInt:noMealForDay], // Wed
             [NSNumber numberWithInt:noMealForDay], // Thu
             [NSNumber numberWithInt:noMealForDay], // Fri
             [NSNumber numberWithInt:mwkBrunchStop],  // Sat
             
             nil];
    
    
    mBrunch.openTimes = open;
    mBrunch.closeTimes = close;
    mBrunch.mealName = @"Brunch";   
    mBrunch.shortName = @"Brunch";   
    mBrunch.fileName = @"moultonBrunch";
	mBrunch.location = @"Moulton";
	
	
	
	
    //
    // Moulton Lunch
    //
    
    mLunch = [[MealSchedule alloc] init];
	
    
    open = [[NSArray alloc] initWithObjects:[NSNumber numberWithInt:noMealForDay],  // Sun
			[NSNumber numberWithInt:mLunchStart], // Mon
            [NSNumber numberWithInt:mLunchStart], // Tue
            [NSNumber numberWithInt:mLunchStart], // Wed
            [NSNumber numberWithInt:mLunchStart], // Thu
            [NSNumber numberWithInt:mLunchStart], // Fri
            [NSNumber numberWithInt:noMealForDay],  // Sat
            
            nil];
    
    close = [[NSArray alloc] initWithObjects:[NSNumber numberWithInt:noMealForDay],  // Sun
			 [NSNumber numberWithInt:mLunchStop], // Mon
             [NSNumber numberWithInt:mLunchStop], // Tue
             [NSNumber numberWithInt:mLunchStop], // Wed
             [NSNumber numberWithInt:mLunchStop], // Thu
             [NSNumber numberWithInt:mLunchStop], // Fri
             [NSNumber numberWithInt:noMealForDay],  // Sat
             nil];
    
    
    mLunch.openTimes = open;
    mLunch.closeTimes = close;
    mLunch.mealName = @"Lunch";  
    mLunch.shortName = @"Lunch";
    mLunch.fileName = @"moultonLunch";
	mLunch.location = @"Moulton";
	
	
    //
    // Express Dinner
    //
	
    expressDinner = [[MealSchedule alloc] init];
    
    
    open = [[NSArray alloc] initWithObjects:[NSNumber numberWithInt:noMealForDay], // Sun
			[NSNumber numberWithInt:mExpressDinnerStart], // Mon
			[NSNumber numberWithInt:mExpressDinnerStart], // Tue
			[NSNumber numberWithInt:mExpressDinnerStart], // Wed
			[NSNumber numberWithInt:mExpressDinnerStart], // Thu
			[NSNumber numberWithInt:mExpressDinnerStart], // Fri
			[NSNumber numberWithInt:noMealForDay],       // Sat
			
			nil];
    
    close = [[NSArray alloc] initWithObjects:[NSNumber numberWithInt:noMealForDay],  // Sun
			 [NSNumber numberWithInt:mExpressDinnerStop], // Mon
			 [NSNumber numberWithInt:mExpressDinnerStop], // Tue
			 [NSNumber numberWithInt:mExpressDinnerStop], // Wed
			 [NSNumber numberWithInt:mExpressDinnerStop], // Thu
			 [NSNumber numberWithInt:mExpressDinnerStop], // Fri
			 [NSNumber numberWithInt:noMealForDay],       // Sat
			 nil];
    
    
    expressDinner.openTimes = open;
    expressDinner.closeTimes = close;
    expressDinner.mealName = @"Express";
	expressDinner.shortName = @"Express";
	expressDinner.location = @"Moulton";
	
	
    
    //
    // Moulton Dinner
    //
    
    mDinner = [[MealSchedule alloc] init];
    
	open = [[NSArray alloc] initWithObjects:[NSNumber numberWithInt:mwkDinnerStart],  // Sun
			[NSNumber numberWithInt:mDinnerStart], // Mon
            [NSNumber numberWithInt:mDinnerStart], // Tue
            [NSNumber numberWithInt:mDinnerStart], // Wed
            [NSNumber numberWithInt:mDinnerStart], // Thu
            [NSNumber numberWithInt:mDinnerStart], // Fri
            [NSNumber numberWithInt:mwkDinnerStart],  // Sat
            
            nil];
    
    close = [[NSArray alloc] initWithObjects:[NSNumber numberWithInt:mwkDinnerStop],  // Sun
			 [NSNumber numberWithInt:mDinnerStop], // Mon
             [NSNumber numberWithInt:mDinnerStop], // Tue
             [NSNumber numberWithInt:mDinnerStop], // Wed
             [NSNumber numberWithInt:mDinnerStop], // Thu
             [NSNumber numberWithInt:mDinnerStop], // Fri
             [NSNumber numberWithInt:mwkDinnerStop],  // Sat
             
             nil];
    
    
    mDinner.openTimes = open;
    mDinner.closeTimes = close;
    mDinner.mealName = @"Dinner";  
    mDinner.shortName = @"Dinner";
    mDinner.fileName = @"moultonDinner";
	mDinner.location = @"Moulton";
	
    
    //
    // Thorne Hot Breakfast
    //
    
    tHotBreakfast = [[MealSchedule alloc] init];
	
    open = [[NSArray alloc] initWithObjects:[NSNumber numberWithInt:noMealForDay],  // Sun
			[NSNumber numberWithInt:tHotBreakfastStart], // Mon
            [NSNumber numberWithInt:tHotBreakfastStart], // Tue
            [NSNumber numberWithInt:tHotBreakfastStart], // Wed
            [NSNumber numberWithInt:tHotBreakfastStart], // Thu
            [NSNumber numberWithInt:tHotBreakfastStart], // Fri
            [NSNumber numberWithInt:noMealForDay],  // Sat
            
            nil];
    
    close = [[NSArray alloc] initWithObjects:[NSNumber numberWithInt:noMealForDay],  // Sun
			 [NSNumber numberWithInt:tHotBreakfastStop], // Mon
             [NSNumber numberWithInt:tHotBreakfastStop], // Tue
             [NSNumber numberWithInt:tHotBreakfastStop], // Wed
             [NSNumber numberWithInt:tHotBreakfastStop], // Thu
             [NSNumber numberWithInt:tHotBreakfastStop], // Fri
             [NSNumber numberWithInt:noMealForDay],  // Sat
             
             nil];
    
    
	
    tHotBreakfast.openTimes = open;
    tHotBreakfast.closeTimes = close;
    tHotBreakfast.mealName = @"Hot Breakfast";  
    tHotBreakfast.shortName = @"Breakfast";  
    tHotBreakfast.fileName = @"thorneBreakfast";
	tHotBreakfast.location = @"Thorne";
	
    
	
    //
    // Thorne Brunch
    //
    
    tBrunch = [[MealSchedule alloc] init];
    
	
    open = [[NSArray alloc] initWithObjects:[NSNumber numberWithInt:twkBrunchStart],  // Sun
			[NSNumber numberWithInt:noMealForDay], // Mon
            [NSNumber numberWithInt:noMealForDay], // Tue
            [NSNumber numberWithInt:noMealForDay], // Wed
            [NSNumber numberWithInt:noMealForDay], // Thu
            [NSNumber numberWithInt:noMealForDay], // Fri
            [NSNumber numberWithInt:twkBrunchStart],  // Sat
            
            nil];
    
    close = [[NSArray alloc] initWithObjects:[NSNumber numberWithInt:twkBrunchStop],  // Sun
			 [NSNumber numberWithInt:noMealForDay], // Mon
             [NSNumber numberWithInt:noMealForDay], // Tue
             [NSNumber numberWithInt:noMealForDay], // Wed
             [NSNumber numberWithInt:noMealForDay], // Thu
             [NSNumber numberWithInt:noMealForDay], // Fri
             [NSNumber numberWithInt:twkBrunchStop],  // Sat
             
             nil];
    
    
    tBrunch.openTimes = open;
    tBrunch.closeTimes = close;
    tBrunch.mealName = @"Brunch";
    tBrunch.shortName = @"Brunch";  
    tBrunch.fileName = @"thorneBrunch";
	tBrunch.location = @"Thorne";
	
	
	
    //
    // Thorne Hot Lunch
    //
    
    tHotLunch = [[MealSchedule alloc] init];
	
    open = [[NSArray alloc] initWithObjects:[NSNumber numberWithInt:noMealForDay],  // Sun
			[NSNumber numberWithInt:tHotLunchStart], // Mon
            [NSNumber numberWithInt:tHotLunchStart], // Tue
            [NSNumber numberWithInt:tHotLunchStart], // Wed
            [NSNumber numberWithInt:tHotLunchStart], // Thu
            [NSNumber numberWithInt:tHotLunchStart], // Fri
            [NSNumber numberWithInt:noMealForDay],  // Sat
            
            nil];
    
    close = [[NSArray alloc] initWithObjects:[NSNumber numberWithInt:noMealForDay],  // Sun
			 [NSNumber numberWithInt:tHotLunchStop], // Mon
             [NSNumber numberWithInt:tHotLunchStop], // Tue
             [NSNumber numberWithInt:tHotLunchStop], // Wed
             [NSNumber numberWithInt:tHotLunchStop], // Thu
             [NSNumber numberWithInt:tHotLunchStop], // Fri
             [NSNumber numberWithInt:noMealForDay],  // Sat
             
             nil];
    
    
    tHotLunch.openTimes = open;
    tHotLunch.closeTimes = close;
    tHotLunch.mealName = @"Hot Lunch";
    tHotLunch.shortName = @"Lunch";  
    tHotLunch.fileName = @"thorneLunch";
	tHotLunch.location = @"Thorne";
	
    
    
    //
    // Thorne Deli Lunch
    //
    
    tColdLunch = [[MealSchedule alloc] init];
	
    open = [[NSArray alloc] initWithObjects:[NSNumber numberWithInt:noMealForDay],  // Sun
			[NSNumber numberWithInt:tColdLunchStart], // Mon
            [NSNumber numberWithInt:tColdLunchStart], // Tue
            [NSNumber numberWithInt:tColdLunchStart], // Wed
            [NSNumber numberWithInt:tColdLunchStart], // Thu
            [NSNumber numberWithInt:tColdLunchStart], // Fri
            [NSNumber numberWithInt:noMealForDay],  // Sat
            
            nil];
    
    close = [[NSArray alloc] initWithObjects:[NSNumber numberWithInt:noMealForDay],  // Sun
			 [NSNumber numberWithInt:tColdLunchStop], // Mon
             [NSNumber numberWithInt:tColdLunchStop], // Tue
             [NSNumber numberWithInt:tColdLunchStop], // Wed
             [NSNumber numberWithInt:tColdLunchStop], // Thu
             [NSNumber numberWithInt:tColdLunchStop], // Fri
             [NSNumber numberWithInt:noMealForDay],  // Sat
             
             nil];
    
    
    tColdLunch.openTimes = open;
    tColdLunch.closeTimes = close;
    tColdLunch.mealName = @"Deli Lunch";
    tColdLunch.shortName = @"Lunch";  
    tColdLunch.fileName = @"thorneLunch";
	tColdLunch.location = @"Thorne";
	
    
    
    //
    // Thorne Dinner
    //
    
    tDinner = [[MealSchedule alloc] init];
	
    open = [[NSArray alloc] initWithObjects:[NSNumber numberWithInt:twkDinnerStart],  // Sun
			[NSNumber numberWithInt:tDinnerStart], // Mon
            [NSNumber numberWithInt:tDinnerStart], // Tue
            [NSNumber numberWithInt:tDinnerStart], // Wed
            [NSNumber numberWithInt:tDinnerStart], // Thu
            [NSNumber numberWithInt:tDinnerStart], // Fri
            [NSNumber numberWithInt:twkDinnerStart],  // Sat
            
            nil];
    
    close = [[NSArray alloc] initWithObjects:[NSNumber numberWithInt:twkDinnerStop],  // Sun
			 [NSNumber numberWithInt:tDinnerStop], // Mon
             [NSNumber numberWithInt:tDinnerStop], // Tue
             [NSNumber numberWithInt:tDinnerStop], // Wed
             [NSNumber numberWithInt:tDinnerStop], // Thu
             [NSNumber numberWithInt:tDinnerStop], // Fri
             [NSNumber numberWithInt:twkDinnerStop],  // Sat
             
             nil];
    
    
    tDinner.openTimes = open;
    tDinner.closeTimes = close;
    tDinner.mealName = @"Dinner";  
    tDinner.shortName = @"Dinner";  
    tDinner.fileName = @"thorneDinner";
	tDinner.location = @"Thorne";
	
	
    //
    // Super Snacks
    //
    
    tSuperSnax = [[MealSchedule alloc] init];
    
    open = [[NSArray alloc] initWithObjects:[NSNumber numberWithInt:noMealForDay],  // Sun
			[NSNumber numberWithInt:noMealForDay], // Mon
            [NSNumber numberWithInt:noMealForDay], // Tue
            [NSNumber numberWithInt:noMealForDay], // Wed
            [NSNumber numberWithInt:sSnackStart], // Thu
            [NSNumber numberWithInt:sSnackStart], // Fri
            [NSNumber numberWithInt:sSnackStart],  // Sat
            
            nil];
    
    close = [[NSArray alloc] initWithObjects:[NSNumber numberWithInt:noMealForDay],  // Sun
			 [NSNumber numberWithInt:noMealForDay], // Mon
             [NSNumber numberWithInt:noMealForDay], // Tue
             [NSNumber numberWithInt:noMealForDay], // Wed
             [NSNumber numberWithInt:sSnackStop], // Thu
             [NSNumber numberWithInt:sSnackStop], // Fri
             [NSNumber numberWithInt:sSnackStop],  // Sat
             
             nil];
    
    
    tSuperSnax.openTimes = open;
    tSuperSnax.closeTimes = close;
    tSuperSnax.mealName = @"Super Snacks"; 
	tSuperSnax.shortName = @"Super Snacks";
    tSuperSnax.location = @"Thorne";
    
    
    
    ///////////////////////
    // Smith Union Dining//
    ///////////////////////
    
    //
    // Cafe Morning
    //
    
    cafeMorning = [[MealSchedule alloc] init];
	
    open = [[NSArray alloc] initWithObjects:[NSNumber numberWithInt:csuMorningStart],  // Sun
			[NSNumber numberWithInt:cmwMorningStart], // Mon
            [NSNumber numberWithInt:cmwMorningStart], // Tue
            [NSNumber numberWithInt:cmwMorningStart], // Wed
            [NSNumber numberWithInt:ctfMorningStart], // Thu
            [NSNumber numberWithInt:ctfMorningStart], // Fri
            [NSNumber numberWithInt:csaMorningStart],  // Sat
			
            nil];
    
    close = [[NSArray alloc] initWithObjects:[NSNumber numberWithInt:csuMorningStop],  // Sun
			 [NSNumber numberWithInt:cmwMorningStop], // Mon
             [NSNumber numberWithInt:cmwMorningStop], // Tue
             [NSNumber numberWithInt:cmwMorningStop], // Wed
             [NSNumber numberWithInt:ctfMorningStop], // Thu
             [NSNumber numberWithInt:ctfMorningStop], // Fri
             [NSNumber numberWithInt:csaMorningStop],  // Sat
             
             nil];
    
    
    cafeMorning.openTimes = open;
    cafeMorning.closeTimes = close;
    cafeMorning.mealName = @"Cafe AM";  
    cafeMorning.shortName = @"Cafe AM";
	cafeMorning.location = @"Smith Union";
	
    
    //
    // Cafe Evening
    //
    
    cafeNight = [[MealSchedule alloc] init];
	
    open = [[NSArray alloc] initWithObjects:[NSNumber numberWithInt:csuNightStart],  // Sun
			[NSNumber numberWithInt:cmwNightStart], // Mon
            [NSNumber numberWithInt:cmwNightStart], // Tue
            [NSNumber numberWithInt:cmwNightStart], // Wed
            [NSNumber numberWithInt:noMealForDay], // Thu
            [NSNumber numberWithInt:noMealForDay], // Fri
            [NSNumber numberWithInt:noMealForDay],  // Sat
            
            nil];
    
    close = [[NSArray alloc] initWithObjects:[NSNumber numberWithInt:csuNightStop],  // Sun
			 [NSNumber numberWithInt:cmwNightStop], // Mon
             [NSNumber numberWithInt:cmwNightStop], // Tue
             [NSNumber numberWithInt:cmwNightStop], // Wed
             [NSNumber numberWithInt:noMealForDay], // Thu
             [NSNumber numberWithInt:noMealForDay], // Fri
             [NSNumber numberWithInt:noMealForDay],  // Sat
             nil];
    
    
    cafeNight.openTimes = open;
    cafeNight.closeTimes = close;
    cafeNight.mealName = @"Cafe PM";  
	cafeNight.shortName = @"Cafe PM";
	cafeNight.location = @"Smith Union";
    
    
    //
    // The Grill
    //
    
    theGrill = [[MealSchedule alloc] init];
	
    open = [[NSArray alloc] initWithObjects:[NSNumber numberWithInt:grillsuStart],  // Sun
			[NSNumber numberWithInt:grillmwStart], // Mon
            [NSNumber numberWithInt:grillmwStart], // Tue
            [NSNumber numberWithInt:grillmwStart], // Wed
            [NSNumber numberWithInt:grilltfStart], // Thu
            [NSNumber numberWithInt:grilltfStart], // Fri
            [NSNumber numberWithInt:grillsaStart],  // Sat
            nil];
    
    close = [[NSArray alloc] initWithObjects:[NSNumber numberWithInt:grillsuStop],  // Sun
			 [NSNumber numberWithInt:grillmwStop], // Mon
             [NSNumber numberWithInt:grillmwStop], // Tue
             [NSNumber numberWithInt:grillmwStop], // Wed
             [NSNumber numberWithInt:grilltfStop], // Thu
             [NSNumber numberWithInt:grilltfStop], // Fri
             [NSNumber numberWithInt:grillsaStop],  // Sat
             
             nil];
    
    
    theGrill.openTimes = open;
    theGrill.closeTimes = close;
    theGrill.mealName = @"The Grill";  
	theGrill.shortName = @"The Grill";
	theGrill.location = @"Smith Union";
    
    
    //
    // The Pub
    //
    
    thePub = [[MealSchedule alloc] init];
	
    open = [[NSArray alloc] initWithObjects:[NSNumber numberWithInt:noMealForDay],  // Sun
			[NSNumber numberWithInt:noMealForDay], // Mon
            [NSNumber numberWithInt:noMealForDay], // Tue
            [NSNumber numberWithInt:noMealForDay], // Wed
            [NSNumber numberWithInt:pubtStart], // Thu
            [NSNumber numberWithInt:pubfsStart], // Fri
            [NSNumber numberWithInt:pubfsStart],  // Sat
            
            nil];
    
    close = [[NSArray alloc] initWithObjects:[NSNumber numberWithInt:noMealForDay],  // Sun
			 [NSNumber numberWithInt:noMealForDay], // Mon
             [NSNumber numberWithInt:noMealForDay], // Tue
             [NSNumber numberWithInt:noMealForDay], // Wed
             [NSNumber numberWithInt:pubtStop], // Thu
             [NSNumber numberWithInt:pubfsStop], // Fri
             [NSNumber numberWithInt:pubfsStop],  // Sat
             
             nil];
    
    
    thePub.openTimes = open;
    thePub.closeTimes = close;
    thePub.mealName = @"The Pub";  
    thePub.shortName = @"The Pub";
    thePub.location = @"Smith Union";
	
    //
    // The Convenience Store
    //
	
    theCStore = [[MealSchedule alloc] init];
	
    open = [[NSArray alloc] initWithObjects:[NSNumber numberWithInt:emssStart],  // Sun
			[NSNumber numberWithInt:emfStart], // Mon
            [NSNumber numberWithInt:emfStart], // Tue
            [NSNumber numberWithInt:emfStart], // Wed
            [NSNumber numberWithInt:emfStart], // Thu
            [NSNumber numberWithInt:emfStart], // Fri
            [NSNumber numberWithInt:emssStart],  // Sat
            
            nil];
    
    close = [[NSArray alloc] initWithObjects:[NSNumber numberWithInt:emssStop],  // Sun
			 [NSNumber numberWithInt:emfStop], // Mon
             [NSNumber numberWithInt:emfStop], // Tue
             [NSNumber numberWithInt:emfStop], // Wed
             [NSNumber numberWithInt:emfStop], // Thu
             [NSNumber numberWithInt:emfStop], // Fri
             [NSNumber numberWithInt:emssStop],  // Sat
             
             nil];
    
    
    theCStore.openTimes = open;
    theCStore.closeTimes = close;
    theCStore.mealName = @"C-Store";  
	theCStore.shortName = @"C-Store";  
    theCStore.location = @"Smith Union";  
	
	
    // Creates an Array with Meals
    NSMutableArray *arrayMeals = [[NSArray alloc] initWithObjects:
								  mHotBreakfast,
								  mColdBreakfast,
								  expressLunch,
								  mLunch,
								  expressDinner,
								  mDinner,
								  mBrunch,
								  tHotBreakfast,
								  tColdLunch,
								  tHotLunch,
								  tDinner,
								  tBrunch,
								  tSuperSnax,
								  cafeMorning,
								  cafeNight,
								  theGrill,
								  thePub,
								  theCStore,
								  nil];
    
    mealArray = arrayMeals;
    
    
    NSMutableArray *diningHallMeals = [[NSArray alloc] initWithObjects:
									   mHotBreakfast,
									   mColdBreakfast,
									   mBrunch,
									   mLunch,
									   mDinner,
									   tHotBreakfast,
									   tBrunch,
									   tColdLunch,
									   tHotLunch,
									   tDinner,
									   nil];
    
    diningHallMealArray = diningHallMeals;
	
    return self;
}

- (void)setupCoreData{
	
	/*
	 Fetch existing events.
	 Create a fetch request; find the Event entity and assign it to the request; add a sort descriptor; then execute the fetch.
	 */
	NSFetchRequest *request = [[NSFetchRequest alloc] init];
	NSEntityDescription *entity = [NSEntityDescription entityForName:@"FavoriteItem" inManagedObjectContext:managedObjectContext];
	[request setEntity:entity];
	
	// Order the events by creation date, most recent first.
	NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"itemName" ascending:NO];
	NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
	[request setSortDescriptors:sortDescriptors];
	[sortDescriptor release];
	[sortDescriptors release];
	
	// Execute the fetch -- create a mutable copy of the result.
	NSError *error = nil;
	NSMutableArray *mutableFetchResults = [[managedObjectContext executeFetchRequest:request error:&error] mutableCopy];
	if (mutableFetchResults == nil) {
		// Handle the error.
	}
	
	NSLog(@"Core Date:");
	for (int i = 0; i < [mutableFetchResults count]; i++) {
		NSLog(@"%@", [[mutableFetchResults objectAtIndex:i] itemName]);
	}
	
	// Set self's events array to the mutable array, then clean up.
	//[self setEventsArray:mutableFetchResults];
	[mutableFetchResults release];
	[request release];
	
	
}

- (void)searchCoreData{
	
	NSLog(@"Searching for FUBAR");
	
	/*
	 Fetch existing events.
	 Create a fetch request; find the Event entity and assign it to the request; add a sort descriptor; then execute the fetch.
	 */
	NSFetchRequest *request = [[NSFetchRequest alloc] init];
	NSEntityDescription *entity = [NSEntityDescription entityForName:@"FavoriteItem" inManagedObjectContext:managedObjectContext];
	[request setEntity:entity];
	
	// Order the events by creation date, most recent first.
	NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"itemName" ascending:NO];
	NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
	[request setSortDescriptors:sortDescriptors];
	[sortDescriptor release];
	[sortDescriptors release];
	
	// Execute the fetch -- create a mutable copy of the result.
	NSError *error = nil;
	NSMutableArray *mutableFetchResults = [[managedObjectContext executeFetchRequest:request error:&error] mutableCopy];
	if (mutableFetchResults == nil) {
		// Handle the error.
	}
	
	NSMutableArray *searchArray = [[NSMutableArray alloc] init];
	for (FavoriteItem *favorite in mutableFetchResults) {
		[searchArray addObject:[favorite itemName]];
	}

	NSLog(@"Object at Index %i", [searchArray indexOfObject:@"FUBAR"]);
	
	// Set self's events array to the mutable array, then clean up.
	//[self setEventsArray:mutableFetchResults];
	[mutableFetchResults release];
	[request release];
	[searchArray release];
	
	
	
	
	
	
}

- (void)processArrays{
	
	
	//NSTimeInterval start = [NSDate timeIntervalSinceReferenceDate];
	
	WristWatch *clock= [[WristWatch alloc] init];
	watch = clock;

	
	[self processHoursArrays];
	
	[self processMealArraysForDay:[watch getWeekDay]];
	[self processMealArraysForDay:[watch getNextWeekDay]];
	
	[self resolveInconsistenciesInArrays];
	
	[self populateNavigationBarArray];
	[self populateMealArrays];
	[self populateSpecialsArray];
	
	//NSTimeInterval duration = [NSDate timeIntervalSinceReferenceDate] - start;
	//NSLog(@"Duration: %f", duration);
	
}

- (void)stressTestForDate:(NSDate*)result day:(int)dayToTest week:(int)weekToTest{
	
	stressTesting = YES;
	testDay = dayToTest;
	testWeek = weekToTest;
	testDate = result;
	
	WristWatch *clock= [[WristWatch alloc] init];
	watch = clock;
	
	[self processHoursArrays];
	[self processMealArraysForDay:dayToTest];
	[self processMealArraysForDay:(dayToTest + 1) % 7 ];
	[self resolveInconsistenciesInArrays];
	
	[self populateNavigationBarArray];
	[self populateMealArrays];
	[self populateSpecialsArray];

	
	
	
	
	
}


#pragma mark -
#pragma mark Meal Data Setup

- (void)processMealArraysForDay:(int)day{
	
	// We establish three arrays to keep dictionary objects of meals
	
	if (thorne_dictionary_array == nil || moulton_dictionary_array == nil) {
		thorne_dictionary_array  = [[NSMutableArray alloc] init];
		moulton_dictionary_array = [[NSMutableArray alloc] init];
		
	}
   	
	int currentWeek = [watch getWeekofYear];
	
	if (stressTesting) {
		currentWeek = testWeek;
	}
	
	
	// Running through every possible meal to decide which meals are open
	
    for(MealSchedule *element in diningHallMealArray){
        NSMutableDictionary *dictionary = [[NSMutableDictionary alloc]init];
		
		
		if (stressTesting) {
			[element setStressTesting:YES];
			element.stressTestTime = testDate;
		}

		
		[element setCurrentDay:day];
		[element setCurrentWeek:currentWeek];

		
        if ([element isOpen] || [element willOpen]){
			
			
            [dictionary setObject:element.shortName forKey:@"Shortname"];
            [dictionary setObject:[element returnFileLocation] forKey:@"FileLocation"];
            [dictionary setObject:[element returnDescription] forKey:@"Day"];
			[dictionary setObject:[element dateText] forKey:@"Hours_of_Operation"];
			
			
			if ([element currentDay] == [watch getWeekDay]) {
				[dictionary setObject:[NSString stringWithFormat:@"Today's %@", [element returnDescription]] forKey:@"Formatted_Title"];
				
			} else {
				[dictionary setObject:[NSString stringWithFormat:@"Tomorrow's %@", [element returnDescription]] forKey:@"Formatted_Title"];
			}
			
			
            
			
            // Decides which of our location arrays to populate
			if ([element.location isEqualToString:@"Thorne"]) {
				
				// Adds Object if the Shortname does not repeat
				// This filters out meal objects i.e. Hot Breakfast, Cold Breakfast
				if (![[[thorne_dictionary_array lastObject] objectForKey:@"Shortname"] isEqualToString:element.shortName]) {
					
					[thorne_dictionary_array addObject:dictionary];	
					
				}	
			} else {
				
				if (![[[moulton_dictionary_array lastObject] objectForKey:@"Shortname"] isEqualToString:element.shortName]) {
					
					[moulton_dictionary_array addObject:dictionary];
					
				}
			} // end if, else
			
        }
        
    } // end iteration of mealschedule objects
	
}


- (void)populateSpecialsArray{
	
	NSString *fileLocation = [NSString stringWithFormat:@"%@/%@.xml",[self documentsDirectory], @"specials"];
	
	//NSLog(@"Loading Array = %@", [fileLocation stringByReplacingOccurrencesOfString:[self documentsDirectory] withString:@""]);
	specialsArray = [[NSMutableArray alloc] initWithContentsOfFile:fileLocation];
	
}

- (void)populateMealArrays{
	
	
	self.thorneArray = [self populateArrayFromDict:thorne_dictionary_array];
	self.moultonArray = [self populateArrayFromDict:moulton_dictionary_array];
}

- (NSMutableArray*)populateArrayFromDict:(NSMutableArray*)dictArray {
	
	NSMutableArray *tempArray = [[NSMutableArray alloc] init];
	
	for (NSMutableDictionary *element in dictArray){
		
		NSMutableArray *array;		
		
		if ([element objectForKey:@"FileLocation"] != NULL) {
			
			//NSLog(@"Populating From File %@", [element objectForKey:@"FileLocation"]);
			
			array = [[NSMutableArray alloc] initWithContentsOfFile:[element objectForKey:@"FileLocation"]];
			
			
			if (array == NULL) {
				//NSLog(@"NULL File!!!");
				//array = [[NSMutableArray alloc] initWithObjects:@"NULL ENTRY", nil];
			} else {
				[tempArray addObject:array];
			}

			
			
		} 
		
		
	}
	
	return tempArray;
	
}		 

- (void)resolveInconsistenciesInArrays{
	
	// Resolve Inconsistencies in Populating Arrays so data structure maintains parallelism.
	// Array with fewer objects needs a placeholder dictionary inserted.
	
	int arrayLength;
	
	if ([thorne_dictionary_array count] < [moulton_dictionary_array count]) {
		arrayLength = [thorne_dictionary_array count];
	} else {
		arrayLength = [moulton_dictionary_array count];
		
	}
	
	
	for (int i = 0; i  < arrayLength; i++) {
		
		NSString *thorneMeal = [[thorne_dictionary_array objectAtIndex:i] objectForKey:@"Shortname"];
		NSString *moultonMeal = [[moulton_dictionary_array objectAtIndex:i] objectForKey:@"Shortname"];
		
		// If meal names are not the same, then there is an inconsitency in the data structure
		if (![thorneMeal isEqualToString:moultonMeal]) {
			
			// Catch Out of Bounds Errors
			if (i+1 == arrayLength) {
				
				// Get Out of There
				break;
				
			} 
			
			
			NSString *thorneNextItem = [[thorne_dictionary_array objectAtIndex:i+1] objectForKey:@"Shortname"];
			NSString *moultonNextItem = [[moulton_dictionary_array objectAtIndex:i+1] objectForKey:@"Shortname"];
			
			
			if ([thorneMeal isEqualToString:moultonNextItem]) {
				
				NSMutableDictionary *fakeDictionary = [[NSMutableDictionary alloc] init];
				
				[fakeDictionary setObject:[[moulton_dictionary_array objectAtIndex:i] objectForKey:@"Shortname"] forKey:@"Shortname"];
				[fakeDictionary setObject:[[moulton_dictionary_array objectAtIndex:i] objectForKey:@"Day"] forKey:@"Day"];
				
				// ultimately this needs to be a fake file location
				//[fakeDictionary setObject:[[moulton_dictionary_array objectAtIndex:i] objectForKey:@"FileLocation"] forKey:@"FileLocation"];
				[fakeDictionary setObject:[[moulton_dictionary_array objectAtIndex:i] objectForKey:@"Formatted_Title"] forKey:@"Formatted_Title"];
				
				[fakeDictionary setObject:@"Closed" forKey:@"Hours_of_Operation"];
				
				// placeholder dictionary inserted at index 0
				[thorne_dictionary_array insertObject:fakeDictionary atIndex:i];
				
				[fakeDictionary release];
				
				
				
			} else if ([moultonMeal isEqualToString:thorneNextItem]) {
				
				
				NSMutableDictionary *fakeDictionary = [[NSMutableDictionary alloc] init];
				
				[fakeDictionary setObject:[[thorne_dictionary_array objectAtIndex:i] objectForKey:@"Shortname"] forKey:@"Shortname"];
				[fakeDictionary setObject:[[thorne_dictionary_array objectAtIndex:i] objectForKey:@"Day"] forKey:@"Day"];
				
				// ultimately this needs to be a fake file location
				//[fakeDictionary setObject:[[thorne_dictionary_array objectAtIndex:i] objectForKey:@"FileLocation"] forKey:@"FileLocation"];
				[fakeDictionary setObject:[[thorne_dictionary_array objectAtIndex:i] objectForKey:@"Formatted_Title"] forKey:@"Formatted_Title"];
				
				[fakeDictionary setObject:@"Closed" forKey:@"Hours_of_Operation"];
				
				
				// placeholder dictionary inserted at index 0
				[moulton_dictionary_array insertObject:fakeDictionary atIndex:i];
				
				[fakeDictionary release];
				
				
			}
			
		}	
		
		
	}//end for
	
	
}		

- (NSMutableArray*)mealArrayFromFile:(NSString*)fileLocation{
	
	NSMutableArray *arrayToReturn;
	
	if (fileLocation != NULL) {
		//NSLog(@"Loading Array = %@", [fileLocation stringByReplacingOccurrencesOfString:[self documentsDirectory] withString:@""]);
		arrayToReturn = [[[NSMutableArray alloc] initWithContentsOfFile:fileLocation] autorelease] ;
	} else {
		arrayToReturn = [[[NSMutableArray alloc] init] autorelease];
	}

	
	return arrayToReturn;
	
	
	
	
}

#pragma mark -
#pragma mark Meal TableView DataSource

- (NSInteger)sizeOfSection:(NSInteger)section forLocation:(NSInteger)location atMealIndex:(NSUInteger)mealIndex{
		
	
	switch (location) {
		case 0:
			if (thorneArray == nil || [thorneArray count] == 0) {
				return 0;
			} else if ([[thorneArray objectAtIndex:mealIndex] objectAtIndex:section] == nil || [[[thorneArray objectAtIndex:mealIndex] objectAtIndex:section] count] == 0 ) {
				return 0;
			} else if ([[[thorneArray objectAtIndex:mealIndex] objectAtIndex:section] respondsToSelector:@selector(count)]) {
				return [[[thorneArray objectAtIndex:mealIndex] objectAtIndex:section] count];
			} else {
				return 0;
			}
		case 1:
			if (moultonArray == nil || [moultonArray count] == 0) {
				return 0;
			} else if ([[moultonArray objectAtIndex:mealIndex] objectAtIndex:section] == nil || [[[moultonArray objectAtIndex:mealIndex] objectAtIndex:section] count] == 0 ) {
				return 0;
			} else if ([[[moultonArray objectAtIndex:mealIndex] objectAtIndex:section] respondsToSelector:@selector(count)]) {
				return [[[moultonArray objectAtIndex:mealIndex] objectAtIndex:section] count];
			} else {
				return 0;
			}			
		case 2:
			return 1;
			break;
			
		default:
			return 0;
			break;
	}
	
	
}


- (NSInteger)numberOfSectionsForLocation:(NSInteger)location atMealIndex:(NSInteger)mealIndex{
	
	//NSLog(@"Number of Sections");
		
	switch (location) {
		case 0:
			if (thorneArray == nil || [thorneArray count] == 0) {
				return 0;
			} else if ([[thorneArray objectAtIndex:mealIndex] respondsToSelector:@selector(count)]) {
				return [[thorneArray objectAtIndex:mealIndex] count];
			} else {
				return 0;
			}
		case 1:
			if (moultonArray == nil || [moultonArray count] == 0) {
				return 0;
			} else if ([[moultonArray objectAtIndex:mealIndex] respondsToSelector:@selector(count)]) {
				return [[moultonArray objectAtIndex:mealIndex] count];
			} else {
				return 0;
			}
		case 2:
			return 2;
			break;
			
		default:
			return 0;
			break;
	}
			
}

- (NSString *)returnItemFromLocation:(NSInteger)location atMealIndex:(NSInteger)mealIndex atPath:(NSIndexPath *)indexPath  {
	
	NSString *itemToReturn;
	
	switch (location) {
		case 0:
			itemToReturn = [[[thorneArray objectAtIndex:mealIndex] objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
			break;
			
		case 1:
			itemToReturn = [[[moultonArray objectAtIndex:mealIndex] objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
			break;
			
		case 2:
			// Grill Data
			//if (indexPath.section == 0 && indexPath.row == 0)	{itemToReturn = @"The Grill";}
			if (indexPath.section == 0 && indexPath.row == 0) {itemToReturn = [[specialsArray objectAtIndex:[watch getWeekDay]-1] objectForKey:@"magees"];}
			
			// Cafe Data
			//if (indexPath.section == 1 && indexPath.row == 0)	{itemToReturn = @"The Cafe";}
			if (indexPath.section == 1 && indexPath.row == 0) {itemToReturn = [[specialsArray objectAtIndex:[watch getWeekDay]-1] objectForKey:@"cafe"];}
			break;
			
		default:
			itemToReturn = @"No Special For Today";
			break;
	}
	
	return itemToReturn;
	
	
	
	
}

- (CGFloat)returnHeightForCellatLocation:(NSInteger)location atMealIndex:(NSInteger)mealIndex atPath:(NSIndexPath *)indexPath{
	
	NSString *stringToConsider = @"";
	
	switch (location) {
		case 0:
			stringToConsider = [[[thorneArray objectAtIndex:mealIndex] objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
			break;
			
		case 1:
			stringToConsider = [[[moultonArray objectAtIndex:mealIndex] objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
			break;
			
		case 2:
			if (indexPath.section == 0) {stringToConsider = [[specialsArray objectAtIndex:[watch getWeekDay]-1] objectForKey:@"magees"];}
			if (indexPath.section == 1) {stringToConsider = [[specialsArray objectAtIndex:[watch getWeekDay]-1] objectForKey:@"cafe"];}
			break;
			
		default:
			stringToConsider = @"";
			break;
	}
	
	
	
	
	CGSize constraint = CGSizeMake(320.0f - (10.0f * 2), 200.0f);
	CGSize size = [stringToConsider sizeWithFont:[UIFont systemFontOfSize:14.0f] constrainedToSize:constraint lineBreakMode:UILineBreakModeWordWrap];
	CGFloat height = size.height;
    
	return height + 3;
}

#pragma mark -
#pragma mark Hours Of Operation 

#define now_hours 0
#define all_hours 1

- (void)processHoursArrays{
	
	allHoursArray = [[NSMutableArray alloc] init];
	openArray = [[NSMutableArray alloc] init];

    NSMutableArray *allHours_Thorne = [NSMutableArray array];
	NSMutableArray *allHours_Moulton = [NSMutableArray array];
    NSMutableArray *allHours_Smith = [NSMutableArray array];	
	
	
	NSMutableArray *nowHours_Thorne = [NSMutableArray array];
	NSMutableArray *nowHours_Moulton = [NSMutableArray array];
    NSMutableArray *nowHours_Smith = [NSMutableArray array];
	
	//Assumes we want an array of today's hours.
	int currentDay = (int)[watch getWeekDay];
	
	if (stressTesting) {
		currentDay = testDay;
	}
	
    for(MealSchedule *element in mealArray){
        
		if (stressTesting) {
			[element setStressTesting:YES];
			element.stressTestTime = testDate;
		}
		
		
		[element setCurrentDay:currentDay];
		
		
		
		
		BOOL hasClosed = [element hasClosed];
		BOOL isOpen = [element isOpen];
		BOOL willOpen = [element willOpen];
		BOOL isValid = [element isValidMeal];
		
		NSMutableDictionary *dictionary = [[NSMutableDictionary alloc]init];
        if ((hasClosed || isOpen || willOpen) && isValid){
            
			NSString *mealName = element.mealName;
			NSString *hoursText = element.dateText;
			NSString *location = element.location;
			
			if (mealName != nil) {
				[dictionary setObject:mealName forKey:@"meal"];
			}
			else {
				[dictionary setObject:@"NONAME" forKey:@"meal"];
			}
			
			
			[dictionary setObject:hoursText forKey:@"hours"];
			
			// Decides where to add the dictionary object
			// Adds to openArray if mealSchedule is open
			if (location == @"Thorne") {
				
				if (isOpen) {
					[allHours_Thorne addObject:dictionary];
					[nowHours_Thorne addObject:dictionary];
				} else{ 
					[allHours_Thorne addObject:dictionary]; 
				}
				
			}
			else if (location == @"Moulton") { 
				
				if (isOpen) {
					[allHours_Moulton addObject:dictionary];
					[nowHours_Moulton addObject:dictionary];
				} else{ 
					[allHours_Moulton addObject:dictionary]; 
				}
			} 
			else { 
				
				if (isOpen) {
					[allHours_Smith addObject:dictionary];
					[nowHours_Smith addObject:dictionary];
				} else{ 
					[allHours_Smith addObject:dictionary]; 
				}
			}
        }
    }
	
	// Arrays added shouldn't be empty
	if ([allHours_Thorne count] != 0) { [allHoursArray addObject:allHours_Thorne]; }
	if ([allHours_Moulton count] != 0) { [allHoursArray addObject:allHours_Moulton]; }
	if ([allHours_Smith count] != 0) { [allHoursArray addObject:allHours_Smith]; }
	
	if ([nowHours_Thorne count] != 0) { [openArray addObject:nowHours_Thorne]; }
	if ([nowHours_Moulton count] != 0) { [openArray addObject:nowHours_Moulton]; }
	if ([nowHours_Smith count] != 0) { [openArray addObject:nowHours_Smith]; }
	
	
	// set default current hours to all hours
	currentHours = 1;
	
}

- (NSString*)hoursOfOperationForHall:(int)hall meal:(int)meal{
	
	NSString *returnString;
	
	switch (hall) {
		case 0:
			returnString = [thorneNavHours objectAtIndex:meal];
			break;
			
		case 1:
			returnString = [moultonNavHours objectAtIndex:meal];
			break;
			
		case 2:
			//returnString = [[specialsArray objectAtIndex:1] objectForKey:@"description"];
			break;
			
		default:
			returnString = @"Thursday the 30th";
			break;
	}
	
	return returnString;
	
}

#pragma mark -
#pragma mark Hours TableView DataSource

- (NSInteger)returnNumberOfSections{
	
	switch (currentHours) {
		case now_hours:
			return [openArray count];
			break;
			
		case all_hours:
			return [allHoursArray count];
			break;
			
		default:
			return 0;
			break;
	}
	
}

- (NSInteger)returnNumberOfRows:(NSInteger)section {
	
	switch (currentHours) {
		case now_hours:
			return [[openArray objectAtIndex:section] count];
			break;
			
		case all_hours:
			return [[allHoursArray objectAtIndex:section] count];
			break;
			
		default:
			return 0;
			break;
	}
	
}

- (NSDictionary *)returnDictionaryAtIndex:(NSIndexPath *)indexPath{
	
	switch (currentHours) {
		case now_hours:
			return [[openArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
			break;
			
		case all_hours:
			return [[allHoursArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
			break;
			
		default:
			return NULL;
			break;
	}
	
	
}

- (NSString *)returnSectionTitleForSection:(NSInteger)section{
	
	
	switch (section) {
		case 0:
			return @"Thorne Hall";
			break;
			
		case 1:
			return @"Moulton Union";
			break;
			
		case 2:
			return @"Smith Union";
			break;
			
			
		default:
			break;
	}
	
	return @""; 
}

- (void) changeDisplayedHourInformation{
	
	if (currentHours == 0) {
		currentHours = 1;
	} else {
		currentHours = 0;
	}

}

- (NSString*)currentlySelectedHoursDescription{
	
	NSString *returnString;
	
	if (currentHours == 0) {
		returnString = @"Now";
	} else {
		returnString = @"Today";
	}
	
	return returnString;
	
}

- (NSString*)titleForHeaderInSection:(NSInteger)section forLocation:(NSInteger)location{
	
	if (location == 2) {
		return [[specialsArray objectAtIndex:1] objectForKey:@"description"];

	}
	
}

#pragma mark -
#pragma mark Navigation Bar

- (void)populateNavigationBarArray{
	
	navBarArray = [[NSMutableArray alloc] init];
	thorneNavHours = [[NSMutableArray alloc] init];
	moultonNavHours = [[NSMutableArray alloc] init];
	
	// Populate Navigation Array to Properly Display Title Bar
	for(NSDictionary *element in thorne_dictionary_array){
		
		[navBarArray addObject:[element objectForKey:@"Formatted_Title"]];
		[thorneNavHours addObject:[element objectForKey:@"Hours_of_Operation"]];
	}
	
	for(NSDictionary *element in moulton_dictionary_array){
		
		[moultonNavHours addObject:[element objectForKey:@"Hours_of_Operation"]];
	}
	
	
}

- (NSMutableArray*)returnNavBarArray{
	
	
	return navBarArray;
	
}

#pragma mark -
#pragma mark Helper Methods

- (NSString *)documentsDirectory {
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	return [paths objectAtIndex:0];
}

- (NSNumber *)returnCurrentWeekDayNSNumber{
    
    int intToReturn = [watch getWeekDay];
    
    
    return [NSNumber numberWithInt:intToReturn];
    
}

// Checks to see if Menus are current
- (BOOL)menusAreCurrent{
	
	int lastUpdatedWeek = [[NSUserDefaults standardUserDefaults] integerForKey:@"lastUpdatedWeek"];
	int currentWeek = [watch getWeekofYear];
	
	if (lastUpdatedWeek != currentWeek){
		return NO;
    }
	else {        
		return YES;
    }
	
}


@end