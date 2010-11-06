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

@implementation ScheduleDecider

@synthesize expressLunch, expressDinner, mHotBreakfast, mColdBreakfast, mLunch, mDinner,mBrunch;
@synthesize tHotBreakfast, tColdLunch, tHotLunch, tDinner, tBrunch, tSuperSnax;
@synthesize cafeMorning, cafeNight, theGrill, thePub, theCStore;
@synthesize mealArray, diningHallMealArray, thorneArray, moultonArray, navBarArray, thorne_dictionary_array, moulton_dictionary_array;


// This method populates MealSchedule objects with their allotted times

-(id)init{
    
	
	currentHours = 1;
	
	//
    // Express Lunch
    //  
    MealSchedule *tempSchedule = [[MealSchedule alloc] init];
    self.expressLunch = tempSchedule;
    [tempSchedule release];
    
    
#pragma mark -
#pragma mark Express Meals
    
    NSArray *open = [[NSArray alloc] initWithObjects:[NSNumber numberWithInt:mExpressLunchStart],	 // Mon
                                                        [NSNumber numberWithInt:mExpressLunchStart], // Tue
                                                        [NSNumber numberWithInt:mExpressLunchStart], // Wed
                                                        [NSNumber numberWithInt:mExpressLunchStart], // Thu
                                                        [NSNumber numberWithInt:mExpressLunchStart], // Fri
                                                        [NSNumber numberWithInt:noMealForDay],       // Sat
                                                        [NSNumber numberWithInt:noMealForDay],       // Sun
                                                        nil];
    
    NSArray *close = [[NSArray alloc] initWithObjects:[NSNumber numberWithInt:mExpressLunchStop], // Mon
                     [NSNumber numberWithInt:mExpressLunchStop], // Tue
                     [NSNumber numberWithInt:mExpressLunchStop], // Wed
                     [NSNumber numberWithInt:mExpressLunchStop], // Thu
                     [NSNumber numberWithInt:mExpressLunchStop], // Fri
                     [NSNumber numberWithInt:noMealForDay],       // Sat
                     [NSNumber numberWithInt:noMealForDay],       // Sun
                     nil];

	
		
    expressLunch.openTimes = open;
    expressLunch.closeTimes = close;
    expressLunch.mealName = @"Express";
	expressLunch.shortName = @"Express";
	expressLunch.location = @"Moulton";

    
    //
    // Express Dinner
    //
    tempSchedule = [[MealSchedule alloc] init];
    self.expressDinner = tempSchedule;
    [tempSchedule release];
    
    
    open = [[NSArray alloc] initWithObjects:[NSNumber numberWithInt:mExpressDinnerStart], // Mon
                     [NSNumber numberWithInt:mExpressDinnerStart], // Tue
                     [NSNumber numberWithInt:mExpressDinnerStart], // Wed
                     [NSNumber numberWithInt:mExpressDinnerStart], // Thu
                     [NSNumber numberWithInt:mExpressDinnerStart], // Fri
                     [NSNumber numberWithInt:noMealForDay],       // Sat
                     [NSNumber numberWithInt:noMealForDay],       // Sun
                     nil];
    
    close = [[NSArray alloc] initWithObjects:[NSNumber numberWithInt:mExpressDinnerStop], // Mon
                      [NSNumber numberWithInt:mExpressDinnerStop], // Tue
                      [NSNumber numberWithInt:mExpressDinnerStop], // Wed
                      [NSNumber numberWithInt:mExpressDinnerStop], // Thu
                      [NSNumber numberWithInt:mExpressDinnerStop], // Fri
                      [NSNumber numberWithInt:noMealForDay],       // Sat
                      [NSNumber numberWithInt:noMealForDay],       // Sun
                      nil];
    
    
    expressDinner.openTimes = open;
    expressDinner.closeTimes = close;
    expressDinner.mealName = @"Express";
	expressDinner.shortName = @"Express";
	expressDinner.location = @"Moulton";

    //
    // Moulton Hot Breakfast
    //
    
    tempSchedule = [[MealSchedule alloc] init];
    self.mHotBreakfast = tempSchedule;
    [tempSchedule release];
    
    
    open = [[NSArray alloc] initWithObjects:[NSNumber numberWithInt:mHotBreakfastStart], // Mon
            [NSNumber numberWithInt:mHotBreakfastStart], // Tue
            [NSNumber numberWithInt:mHotBreakfastStart], // Wed
            [NSNumber numberWithInt:mHotBreakfastStart], // Thu
            [NSNumber numberWithInt:mHotBreakfastStart], // Fri
            [NSNumber numberWithInt:mwkBreakfastStart],  // Sat
            [NSNumber numberWithInt:mwkBreakfastStart],  // Sun
            nil];
    
    close = [[NSArray alloc] initWithObjects:[NSNumber numberWithInt:mHotBreakfastStop], // Mon
             [NSNumber numberWithInt:mHotBreakfastStop], // Tue
             [NSNumber numberWithInt:mHotBreakfastStop], // Wed
             [NSNumber numberWithInt:mHotBreakfastStop], // Thu
             [NSNumber numberWithInt:mHotBreakfastStop], // Fri
             [NSNumber numberWithInt:mwkBreakfastStop],  // Sat
             [NSNumber numberWithInt:mwkBreakfastStop],  // Sun
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
    
    tempSchedule = [[MealSchedule alloc] init];
    self.mColdBreakfast = tempSchedule;
    [tempSchedule release];
    
    
    open = [[NSArray alloc] initWithObjects:[NSNumber numberWithInt:mColdBreakfastStart], // Mon
            [NSNumber numberWithInt:mColdBreakfastStart], // Tue
            [NSNumber numberWithInt:mColdBreakfastStart], // Wed
            [NSNumber numberWithInt:mColdBreakfastStart], // Thu
            [NSNumber numberWithInt:mColdBreakfastStart], // Fri
            [NSNumber numberWithInt:noMealForDay],  // Sat
            [NSNumber numberWithInt:noMealForDay],  // Sun
            nil];
    
    close = [[NSArray alloc] initWithObjects:[NSNumber numberWithInt:mColdBreakfastStop], // Mon
             [NSNumber numberWithInt:mColdBreakfastStop], // Tue
             [NSNumber numberWithInt:mColdBreakfastStop], // Wed
             [NSNumber numberWithInt:mColdBreakfastStop], // Thu
             [NSNumber numberWithInt:mColdBreakfastStop], // Fri
             [NSNumber numberWithInt:noMealForDay],  // Sat
             [NSNumber numberWithInt:noMealForDay],  // Sun
             nil];
    
    
    mColdBreakfast.openTimes = open;
    mColdBreakfast.closeTimes = close;
    mColdBreakfast.mealName = @"Cold Breakfast";  
    mColdBreakfast.shortName = @"Breakfast";
    mColdBreakfast.fileName = @"moultonBreakfast";
	mColdBreakfast.location = @"Moulton";


	//
    // Moulton Brunch
    //
    
    tempSchedule = [[MealSchedule alloc] init];
    self.mBrunch = tempSchedule;
    [tempSchedule release];
    
    
    open = [[NSArray alloc] initWithObjects:[NSNumber numberWithInt:noMealForDay], // Mon
            [NSNumber numberWithInt:noMealForDay], // Tue
            [NSNumber numberWithInt:noMealForDay], // Wed
            [NSNumber numberWithInt:noMealForDay], // Thu
            [NSNumber numberWithInt:noMealForDay], // Fri
            [NSNumber numberWithInt:mwkBrunchStart],  // Sat
            [NSNumber numberWithInt:mwkBrunchStart],  // Sun
            nil];
    
    close = [[NSArray alloc] initWithObjects:[NSNumber numberWithInt:noMealForDay], // Mon
             [NSNumber numberWithInt:noMealForDay], // Tue
             [NSNumber numberWithInt:noMealForDay], // Wed
             [NSNumber numberWithInt:noMealForDay], // Thu
             [NSNumber numberWithInt:noMealForDay], // Fri
             [NSNumber numberWithInt:mwkBrunchStop],  // Sat
             [NSNumber numberWithInt:mwkBrunchStop],  // Sun
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
    
    tempSchedule = [[MealSchedule alloc] init];
    self.mLunch = tempSchedule;
    [tempSchedule release];
    
    
    open = [[NSArray alloc] initWithObjects:[NSNumber numberWithInt:mLunchStart], // Mon
            [NSNumber numberWithInt:mLunchStart], // Tue
            [NSNumber numberWithInt:mLunchStart], // Wed
            [NSNumber numberWithInt:mLunchStart], // Thu
            [NSNumber numberWithInt:mLunchStart], // Fri
            [NSNumber numberWithInt:noMealForDay],  // Sat
            [NSNumber numberWithInt:noMealForDay],  // Sun
            nil];
    
    close = [[NSArray alloc] initWithObjects:[NSNumber numberWithInt:mLunchStop], // Mon
             [NSNumber numberWithInt:mLunchStop], // Tue
             [NSNumber numberWithInt:mLunchStop], // Wed
             [NSNumber numberWithInt:mLunchStop], // Thu
             [NSNumber numberWithInt:mLunchStop], // Fri
             [NSNumber numberWithInt:noMealForDay],  // Sat
             [NSNumber numberWithInt:noMealForDay],  // Sun
             nil];
    
    
    mLunch.openTimes = open;
    mLunch.closeTimes = close;
    mLunch.mealName = @"Lunch";  
    mLunch.shortName = @"Lunch";
    mLunch.fileName = @"moultonLunch";
	mLunch.location = @"Moulton";

    
    //
    // Moulton Dinner
    //
    
    tempSchedule = [[MealSchedule alloc] init];
    self.mDinner = tempSchedule;
    [tempSchedule release];
    
    
    open = [[NSArray alloc] initWithObjects:[NSNumber numberWithInt:mDinnerStart], // Mon
            [NSNumber numberWithInt:mDinnerStart], // Tue
            [NSNumber numberWithInt:mDinnerStart], // Wed
            [NSNumber numberWithInt:mDinnerStart], // Thu
            [NSNumber numberWithInt:mDinnerStart], // Fri
            [NSNumber numberWithInt:mwkDinnerStart],  // Sat
            [NSNumber numberWithInt:mwkDinnerStart],  // Sun
            nil];
    
    close = [[NSArray alloc] initWithObjects:[NSNumber numberWithInt:mDinnerStop], // Mon
             [NSNumber numberWithInt:mDinnerStop], // Tue
             [NSNumber numberWithInt:mDinnerStop], // Wed
             [NSNumber numberWithInt:mDinnerStop], // Thu
             [NSNumber numberWithInt:mDinnerStop], // Fri
             [NSNumber numberWithInt:mwkDinnerStop],  // Sat
             [NSNumber numberWithInt:mwkDinnerStop],  // Sun
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
    
    tempSchedule = [[MealSchedule alloc] init];
    self.tHotBreakfast = tempSchedule;
    [tempSchedule release];
    
    
    open = [[NSArray alloc] initWithObjects:[NSNumber numberWithInt:tHotBreakfastStart], // Mon
            [NSNumber numberWithInt:tHotBreakfastStart], // Tue
            [NSNumber numberWithInt:tHotBreakfastStart], // Wed
            [NSNumber numberWithInt:tHotBreakfastStart], // Thu
            [NSNumber numberWithInt:tHotBreakfastStart], // Fri
            [NSNumber numberWithInt:noMealForDay],  // Sat
            [NSNumber numberWithInt:noMealForDay],  // Sun
            nil];
    
    close = [[NSArray alloc] initWithObjects:[NSNumber numberWithInt:tHotBreakfastStop], // Mon
             [NSNumber numberWithInt:tHotBreakfastStop], // Tue
             [NSNumber numberWithInt:tHotBreakfastStop], // Wed
             [NSNumber numberWithInt:tHotBreakfastStop], // Thu
             [NSNumber numberWithInt:tHotBreakfastStop], // Fri
             [NSNumber numberWithInt:noMealForDay],  // Sat
             [NSNumber numberWithInt:noMealForDay],  // Sun
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
    
    tempSchedule = [[MealSchedule alloc] init];
    self.tBrunch = tempSchedule;
    [tempSchedule release];
    
    
    open = [[NSArray alloc] initWithObjects:[NSNumber numberWithInt:noMealForDay], // Mon
            [NSNumber numberWithInt:noMealForDay], // Tue
            [NSNumber numberWithInt:noMealForDay], // Wed
            [NSNumber numberWithInt:noMealForDay], // Thu
            [NSNumber numberWithInt:noMealForDay], // Fri
            [NSNumber numberWithInt:twkBrunchStart],  // Sat
            [NSNumber numberWithInt:twkBrunchStart],  // Sun
            nil];
    
    close = [[NSArray alloc] initWithObjects:[NSNumber numberWithInt:noMealForDay], // Mon
             [NSNumber numberWithInt:noMealForDay], // Tue
             [NSNumber numberWithInt:noMealForDay], // Wed
             [NSNumber numberWithInt:noMealForDay], // Thu
             [NSNumber numberWithInt:noMealForDay], // Fri
             [NSNumber numberWithInt:twkBrunchStop],  // Sat
             [NSNumber numberWithInt:twkBrunchStop],  // Sun
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
    
    tempSchedule = [[MealSchedule alloc] init];
    self.tHotLunch = tempSchedule;
    [tempSchedule release];
    
    
    open = [[NSArray alloc] initWithObjects:[NSNumber numberWithInt:tHotLunchStart], // Mon
            [NSNumber numberWithInt:tHotLunchStart], // Tue
            [NSNumber numberWithInt:tHotLunchStart], // Wed
            [NSNumber numberWithInt:tHotLunchStart], // Thu
            [NSNumber numberWithInt:tHotLunchStart], // Fri
            [NSNumber numberWithInt:noMealForDay],  // Sat
            [NSNumber numberWithInt:noMealForDay],  // Sun
            nil];
    
    close = [[NSArray alloc] initWithObjects:[NSNumber numberWithInt:tHotLunchStop], // Mon
             [NSNumber numberWithInt:tHotLunchStop], // Tue
             [NSNumber numberWithInt:tHotLunchStop], // Wed
             [NSNumber numberWithInt:tHotLunchStop], // Thu
             [NSNumber numberWithInt:tHotLunchStop], // Fri
             [NSNumber numberWithInt:noMealForDay],  // Sat
             [NSNumber numberWithInt:noMealForDay],  // Sun
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
    
    tempSchedule = [[MealSchedule alloc] init];
    self.tColdLunch = tempSchedule;
    [tempSchedule release];
    
    
    open = [[NSArray alloc] initWithObjects:[NSNumber numberWithInt:tColdLunchStart], // Mon
            [NSNumber numberWithInt:tColdLunchStart], // Tue
            [NSNumber numberWithInt:tColdLunchStart], // Wed
            [NSNumber numberWithInt:tColdLunchStart], // Thu
            [NSNumber numberWithInt:tColdLunchStart], // Fri
            [NSNumber numberWithInt:noMealForDay],  // Sat
            [NSNumber numberWithInt:noMealForDay],  // Sun
            nil];
    
    close = [[NSArray alloc] initWithObjects:[NSNumber numberWithInt:tColdLunchStop], // Mon
             [NSNumber numberWithInt:tColdLunchStop], // Tue
             [NSNumber numberWithInt:tColdLunchStop], // Wed
             [NSNumber numberWithInt:tColdLunchStop], // Thu
             [NSNumber numberWithInt:tColdLunchStop], // Fri
             [NSNumber numberWithInt:noMealForDay],  // Sat
             [NSNumber numberWithInt:noMealForDay],  // Sun
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
    
    tempSchedule = [[MealSchedule alloc] init];
    self.tDinner = tempSchedule;
    [tempSchedule release];
    
    
    open = [[NSArray alloc] initWithObjects:[NSNumber numberWithInt:tDinnerStart], // Mon
            [NSNumber numberWithInt:tDinnerStart], // Tue
            [NSNumber numberWithInt:tDinnerStart], // Wed
            [NSNumber numberWithInt:tDinnerStart], // Thu
            [NSNumber numberWithInt:tDinnerStart], // Fri
            [NSNumber numberWithInt:twkDinnerStart],  // Sat
            [NSNumber numberWithInt:twkDinnerStart],  // Sun
            nil];
    
    close = [[NSArray alloc] initWithObjects:[NSNumber numberWithInt:tDinnerStop], // Mon
             [NSNumber numberWithInt:tDinnerStop], // Tue
             [NSNumber numberWithInt:tDinnerStop], // Wed
             [NSNumber numberWithInt:tDinnerStop], // Thu
             [NSNumber numberWithInt:tDinnerStop], // Fri
             [NSNumber numberWithInt:twkDinnerStop],  // Sat
             [NSNumber numberWithInt:twkDinnerStop],  // Sun
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
    
    tempSchedule = [[MealSchedule alloc] init];
    self.tSuperSnax = tempSchedule;
    [tempSchedule release];
    
    
    open = [[NSArray alloc] initWithObjects:[NSNumber numberWithInt:noMealForDay], // Mon
            [NSNumber numberWithInt:noMealForDay], // Tue
            [NSNumber numberWithInt:noMealForDay], // Wed
            [NSNumber numberWithInt:sSnackStart], // Thu
            [NSNumber numberWithInt:sSnackStart], // Fri
            [NSNumber numberWithInt:sSnackStart],  // Sat
            [NSNumber numberWithInt:noMealForDay],  // Sun
            nil];
    
    close = [[NSArray alloc] initWithObjects:[NSNumber numberWithInt:noMealForDay], // Mon
             [NSNumber numberWithInt:noMealForDay], // Tue
             [NSNumber numberWithInt:noMealForDay], // Wed
             [NSNumber numberWithInt:sSnackStop], // Thu
             [NSNumber numberWithInt:sSnackStop], // Fri
             [NSNumber numberWithInt:sSnackStop],  // Sat
             [NSNumber numberWithInt:noMealForDay],  // Sun
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
    
    tempSchedule = [[MealSchedule alloc] init];
    self.cafeMorning = tempSchedule;
    [tempSchedule release];
    
    
    open = [[NSArray alloc] initWithObjects:[NSNumber numberWithInt:cmwMorningStart], // Mon
            [NSNumber numberWithInt:cmwMorningStart], // Tue
            [NSNumber numberWithInt:cmwMorningStart], // Wed
            [NSNumber numberWithInt:ctfMorningStart], // Thu
            [NSNumber numberWithInt:ctfMorningStart], // Fri
            [NSNumber numberWithInt:csaMorningStart],  // Sat
            [NSNumber numberWithInt:csuMorningStart],  // Sun
            nil];
    
    close = [[NSArray alloc] initWithObjects:[NSNumber numberWithInt:cmwMorningStop], // Mon
             [NSNumber numberWithInt:cmwMorningStop], // Tue
             [NSNumber numberWithInt:cmwMorningStop], // Wed
             [NSNumber numberWithInt:ctfMorningStop], // Thu
             [NSNumber numberWithInt:ctfMorningStop], // Fri
             [NSNumber numberWithInt:csaMorningStop],  // Sat
             [NSNumber numberWithInt:csuMorningStop],  // Sun
             nil];
    
    
    cafeMorning.openTimes = open;
    cafeMorning.closeTimes = close;
    cafeMorning.mealName = @"Cafe";  
    cafeMorning.shortName = @"Cafe";
	cafeMorning.location = @"Smith Union";
    
    
    
    //
    // Cafe Evening
    //
    
    tempSchedule = [[MealSchedule alloc] init];
    self.cafeNight = tempSchedule;
    [tempSchedule release];
    
    
    open = [[NSArray alloc] initWithObjects:[NSNumber numberWithInt:cmwNightStart], // Mon
            [NSNumber numberWithInt:cmwNightStart], // Tue
            [NSNumber numberWithInt:cmwNightStart], // Wed
            [NSNumber numberWithInt:ctfNightStart], // Thu
            [NSNumber numberWithInt:ctfNightStart], // Fri
            [NSNumber numberWithInt:noMealForDay],  // Sat
            [NSNumber numberWithInt:csuNightStart],  // Sun
            nil];
    
    close = [[NSArray alloc] initWithObjects:[NSNumber numberWithInt:cmwNightStop], // Mon
             [NSNumber numberWithInt:cmwNightStop], // Tue
             [NSNumber numberWithInt:cmwNightStop], // Wed
             [NSNumber numberWithInt:ctfNightStop], // Thu
             [NSNumber numberWithInt:ctfNightStop], // Fri
             [NSNumber numberWithInt:noMealForDay],  // Sat
             [NSNumber numberWithInt:csuNightStop],  // Sun
             nil];
    
    
    cafeNight.openTimes = open;
    cafeNight.closeTimes = close;
    cafeNight.mealName = @"Cafe";  
	cafeNight.shortName = @"Cafe";
	cafeNight.location = @"Smith Union";
    
    
    
    
    //
    // The Grill
    //
    
    tempSchedule = [[MealSchedule alloc] init];
    self.theGrill = tempSchedule;
    [tempSchedule release];
    
    
    open = [[NSArray alloc] initWithObjects:[NSNumber numberWithInt:grillmwStart], // Mon
            [NSNumber numberWithInt:grillmwStart], // Tue
            [NSNumber numberWithInt:grillmwStart], // Wed
            [NSNumber numberWithInt:grilltfStart], // Thu
            [NSNumber numberWithInt:grilltfStart], // Fri
            [NSNumber numberWithInt:grillsaStart],  // Sat
            [NSNumber numberWithInt:grillsuStart],  // Sun
            nil];
    
    close = [[NSArray alloc] initWithObjects:[NSNumber numberWithInt:grillmwStop], // Mon
             [NSNumber numberWithInt:grillmwStop], // Tue
             [NSNumber numberWithInt:grillmwStop], // Wed
             [NSNumber numberWithInt:grilltfStop], // Thu
             [NSNumber numberWithInt:grilltfStop], // Fri
             [NSNumber numberWithInt:grillsaStop],  // Sat
             [NSNumber numberWithInt:grillsuStop],  // Sun
             nil];
    
    
    theGrill.openTimes = open;
    theGrill.closeTimes = close;
    theGrill.mealName = @"The Grill";  
	theGrill.shortName = @"The Grill";
	theGrill.location = @"Smith Union";
    
    
    //
    // The Pub
    //
    
    tempSchedule = [[MealSchedule alloc] init];
    self.thePub = tempSchedule;
    [tempSchedule release];
    
    
    open = [[NSArray alloc] initWithObjects:[NSNumber numberWithInt:noMealForDay], // Mon
            [NSNumber numberWithInt:noMealForDay], // Tue
            [NSNumber numberWithInt:noMealForDay], // Wed
            [NSNumber numberWithInt:pubtStart], // Thu
            [NSNumber numberWithInt:pubfsStart], // Fri
            [NSNumber numberWithInt:pubfsStart],  // Sat
            [NSNumber numberWithInt:noMealForDay],  // Sun
            nil];
    
    close = [[NSArray alloc] initWithObjects:[NSNumber numberWithInt:noMealForDay], // Mon
             [NSNumber numberWithInt:noMealForDay], // Tue
             [NSNumber numberWithInt:noMealForDay], // Wed
             [NSNumber numberWithInt:pubtStop], // Thu
             [NSNumber numberWithInt:pubfsStop], // Fri
             [NSNumber numberWithInt:pubfsStop],  // Sat
             [NSNumber numberWithInt:noMealForDay],  // Sun
             nil];
    
    
    thePub.openTimes = open;
    thePub.closeTimes = close;
    thePub.mealName = @"The Pub";  
    thePub.shortName = @"The Pub";
    thePub.location = @"Smith Union";
	
    //
    // The Convenience Store
    //
    
    tempSchedule = [[MealSchedule alloc] init];
    self.theCStore = tempSchedule;
    [tempSchedule release];
    
    
    open = [[NSArray alloc] initWithObjects:[NSNumber numberWithInt:emfStart], // Mon
            [NSNumber numberWithInt:emfStart], // Tue
            [NSNumber numberWithInt:emfStart], // Wed
            [NSNumber numberWithInt:emfStart], // Thu
            [NSNumber numberWithInt:emfStart], // Fri
            [NSNumber numberWithInt:emssStart],  // Sat
            [NSNumber numberWithInt:emssStart],  // Sun
            nil];
    
    close = [[NSArray alloc] initWithObjects:[NSNumber numberWithInt:emfStop], // Mon
             [NSNumber numberWithInt:emfStop], // Tue
             [NSNumber numberWithInt:emfStop], // Wed
             [NSNumber numberWithInt:emfStop], // Thu
             [NSNumber numberWithInt:emfStop], // Fri
             [NSNumber numberWithInt:emssStop],  // Sat
             [NSNumber numberWithInt:emssStop],  // Sun
             nil];
    
    
    theCStore.openTimes = open;
    theCStore.closeTimes = close;
    theCStore.mealName = @"C-Store";  
	theCStore.shortName = @"C-Store";  
    theCStore.location = @"Smith Union";  


    // Creates an Array with Meals
    NSMutableArray *arrayMeals = [[NSArray alloc] initWithObjects:
                           expressLunch,
                           expressDinner,
                           mHotBreakfast,
                           mColdBreakfast,
                           mLunch,
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
    
    self.mealArray = arrayMeals;
    
    
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
    
    self.diningHallMealArray = diningHallMeals;
    
    
    return self;
}

- (void)processArrays{
	
	WristWatch *clock= [[WristWatch alloc] init];

	[self processHoursArrays];
	[self processArrayOfOpenMeals];
	
	// Processes Meals for Today and Tomorrow
	[self processMealArraysForDay:[clock getWeekDay]];
	[self processMealArraysForDay:[clock getWeekDay]+1];

	
	// Resolve Inconsistencies
	[self resolveInconsistenciesInArrays];
	
	// Populate Raw Arrays
	[self populateNavigationBarArray];
	[self populateMealArrays];
	
	
}

// Meal Schedule and Meal Items
- (void)processMealArraysForDay:(int)day{
    
	WristWatch *clock= [[WristWatch alloc] init];

	// We establish three arrays to keep dictionary objects of meals
	
	if (thorne_dictionary_array == nil || moulton_dictionary_array == nil) {
		thorne_dictionary_array  = [[NSMutableArray alloc] init];
		moulton_dictionary_array = [[NSMutableArray alloc] init];

	}
   	
	
		
	// Running through every possible meal to decide which meals are open
    for(MealSchedule *element in diningHallMealArray){
        NSMutableDictionary *dictionary = [[NSMutableDictionary alloc]init];
		[element setCurrentDay:day];
		
        if ([element isOpen] || [element willOpen]){
                        
            [dictionary setObject:element.shortName forKey:@"Shortname"];
            [dictionary setObject:[element returnFileLocation] forKey:@"FileLocation"];
            [dictionary setObject:[element returnDescription] forKey:@"Day"];
			[dictionary setObject:[element dateText] forKey:@"Hours_of_Operation"];
			
			if ([element currentDay] == [clock getWeekDay]) {
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
-(void)populateMealArrays{
	
	
	self.thorneArray = [self populateArrayFromDict:thorne_dictionary_array];
	self.moultonArray = [self populateArrayFromDict:moulton_dictionary_array];
	
}



-(NSMutableArray*)populateArrayFromDict:(NSMutableArray*)dictArray {
	
	NSMutableArray *tempArray = [[NSMutableArray alloc] init];
	
	for (NSMutableDictionary *element in dictArray){
		
		NSMutableArray *array;		
		
		if ([element objectForKey:@"FileLocation"] != NULL) {
			NSLog(@"Loading Array = %@", [[element objectForKey:@"FileLocation"] stringByReplacingOccurrencesOfString:[self documentsDirectory] withString:@""]);
			array = [[NSMutableArray alloc] initWithContentsOfFile:[element objectForKey:@"FileLocation"]];
			
			
			if (array == NULL) {
				array = [[NSMutableArray alloc] initWithObjects:@"NULL ENTRY", nil];
			}
			
			[tempArray addObject:array];
			
		} 
		
		
	}
	
	return tempArray;
	
}		 

-(void)populateNavigationBarArray{
	
	
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


-(NSString*)hoursOfOperationForHall:(int)hall meal:(int)meal{
	
	NSLog(@"Redisplaying Hours");
	
	// Thorne
	if (hall == 0) {
		return [thorneNavHours objectAtIndex:meal];
	} else {
		return [moultonNavHours objectAtIndex:meal];
	}

	
	
	
	
}

-(void)resolveInconsistenciesInArrays{
	
	// Resolve Inconsistencies in Populating Arrays so data structure maintains parallelism.
	// Array with fewer objects needs a placeholder dictionary inserted.
	
	
	// Decides which array is longer
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
				[fakeDictionary setObject:[[moulton_dictionary_array objectAtIndex:i] objectForKey:@"FileLocation"] forKey:@"FileLocation"];
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
				[fakeDictionary setObject:[[thorne_dictionary_array objectAtIndex:i] objectForKey:@"FileLocation"] forKey:@"FileLocation"];
				[fakeDictionary setObject:[[thorne_dictionary_array objectAtIndex:i] objectForKey:@"Formatted_Title"] forKey:@"Formatted_Title"];

				[fakeDictionary setObject:@"Closed" forKey:@"Hours_of_Operation"];

				
				// placeholder dictionary inserted at index 0
				[moulton_dictionary_array insertObject:fakeDictionary atIndex:i];
				
				[fakeDictionary release];
				
			
			}
	
		}	
		

	}//end for
		
	
}					 
-(NSMutableArray*)mealArrayFromFile:(NSString*)fileLocation{
						 
	NSMutableArray *arrayToReturn;
	
	if (fileLocation != NULL) {
		NSLog(@"Loading Array = %@", [fileLocation stringByReplacingOccurrencesOfString:[self documentsDirectory] withString:@""]);
		arrayToReturn = [[NSMutableArray alloc] initWithContentsOfFile:fileLocation];
		
		
		if (arrayToReturn == NULL) {
			arrayToReturn = [[NSMutableArray alloc] initWithObjects:@"NULL ENTRY", nil];
		}
				
	} 
	
	return arrayToReturn;
	
	
	
						 
}


//Navigation Bar Array
-(NSMutableArray*)returnNavBarArray{
	
	
	return navBarArray;
	
}

// Hours of Operation Code
-(void)processHoursArrays{
	
	allHoursArray = [[NSMutableArray alloc] init];

    //Assumes we want an array of today's hours.
    NSMutableArray *array1 = [[NSMutableArray alloc]init];
	NSMutableArray *array2 = [[NSMutableArray alloc]init];
    NSMutableArray *array3 = [[NSMutableArray alloc]init];
	
    int currentDay = (int)[self returnCurrentWeekDay];
    
	
    for(MealSchedule *element in mealArray){
        [element setCurrentDay:currentDay];
		
		NSMutableDictionary *dictionary = [[NSMutableDictionary alloc]init];
        if ([element isOpen] || [element willOpen]){
            
			
			if (element.mealName != nil) {
				[dictionary setObject:element.mealName forKey:@"meal"];
			}
			else {
				[dictionary setObject:@"NONAME" forKey:@"meal"];
				
			}
			
			[dictionary setObject:[element dateText] forKey:@"hours"];
			
			// This is the place for user defaults
			if (element.location == @"Thorne") {
				[array1 addObject:dictionary];
			} else if (element.location == @"Moulton") {
				[array2 addObject:dictionary];
			} else {
				[array3 addObject:dictionary];
			}
        }
    }
	
	
	if ([array1 count] != 0) {
		[allHoursArray addObject:array1];
	}
	
	if ([array2 count] != 0) {
		[allHoursArray addObject:array2];

	}
	
	if ([array3 count] != 0) {
		[allHoursArray addObject:array3];

	}
	
	
	
	
}
-(void)processArrayOfOpenMeals{
    
    //Assumes we want an array of today's meals.
    openArray = [[NSMutableArray alloc] init];
    NSMutableArray *section_one = [[NSMutableArray alloc]init];
	NSMutableArray *section_two = [[NSMutableArray alloc]init];
    NSMutableArray *section_three = [[NSMutableArray alloc]init];

    int currentDay = (int)[self returnCurrentWeekDay];

    for(MealSchedule *element in mealArray){
        [element setCurrentDay:currentDay];
		
		NSMutableDictionary *dictionary = [[NSMutableDictionary alloc]init];
        if ([element isOpen]){
            
		
			if (element.mealName != nil) {
				[dictionary setObject:element.mealName forKey:@"meal"];
			}
			else {
				[dictionary setObject:@"NONAME" forKey:@"meal"];
	
			}

			
			[dictionary setObject:[element fullHoursText] forKey:@"hours"];
			    

			// This is the place for user defaults
			if (element.location == @"Thorne") {
				[section_one addObject:dictionary];
				
			} else if (element.location == @"Moulton") {
				[section_two addObject:dictionary];
				
			} else {
				[section_three addObject:dictionary];
			}

				

				

        }
   
    }
	
	if ([section_one count] != 0) {
		[openArray addObject:section_one];
	}
	
	if ([section_two count] != 0) {
		[openArray addObject:section_two];
	}
	
	if ([section_three count] != 0) {
		[openArray addObject:section_three];
	}
	
	
}
-(NSNumber *)returnCurrentWeekDayNSNumber{
    
    int intToReturn = [self returnCurrentWeekDay];
    
    
    return [NSNumber numberWithInt:intToReturn];
    
}
- (int)returnCurrentWeekDay {
	
	NSDateFormatter *inputFormatter = [[[NSDateFormatter alloc] init] autorelease];
	[inputFormatter setDateFormat:@"e"];
	NSDate *toBeFormatted = [[[NSDate alloc] init] autorelease];
	
	NSString *formattedDate = [inputFormatter stringFromDate:toBeFormatted];
	
	return[formattedDate intValue];
	
}


#pragma mark -
#pragma mark TableViewCode for Meals

-(NSInteger)sizeOfSection:(NSInteger)section forLocation:(NSInteger)location atMealIndex:(NSUInteger)mealIndex{
	
	if (location == 0){
		
		return [[[thorneArray objectAtIndex:mealIndex] objectAtIndex:section] count];
		
	} else {
		
		return [[[moultonArray objectAtIndex:mealIndex] objectAtIndex:section] count];
		
	}
	
}

-(NSInteger)numberOfSectionsForLocation:(NSInteger)location atMealIndex:(NSInteger)mealIndex{
	
	if (location == 0){
		
		if ([thorneArray count] == 0) {
			
			return 0;
		}
		
		return [[thorneArray objectAtIndex:mealIndex] count];
		
	} else {
		
		if ([moultonArray count] == 0) {
			
			return 0;
		}
		
		return [[moultonArray objectAtIndex:mealIndex] count];
		
	}
	
}

-(NSString *)returnItemFromLocation:(NSInteger)location atMealIndex:(NSInteger)mealIndex atPath:(NSIndexPath *)indexPath  {
	
	if (location == 0){
		
		return [[[thorneArray objectAtIndex:mealIndex] objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
		
	} else {
		
		return [[[moultonArray objectAtIndex:mealIndex] objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
		
	}
	
}

-(CGFloat)returnHeightForCellatLocation:(NSInteger)location atMealIndex:(NSInteger)mealIndex atPath:(NSIndexPath *)indexPath{
	
	NSString *stringToConsider;
	
	if (location == 0){
		
		stringToConsider = [[[thorneArray objectAtIndex:mealIndex] objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
		
	} else {
		
		stringToConsider = [[[moultonArray objectAtIndex:mealIndex] objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
		
	}
	
	
	CGSize constraint = CGSizeMake(320.0f - (10.0f * 2), 50.0f);
	CGSize size = [stringToConsider sizeWithFont:[UIFont systemFontOfSize:14.0f] constrainedToSize:constraint lineBreakMode:UILineBreakModeWordWrap];
	CGFloat height = size.height;
    
	return height + 3;
}

// returns the local document directory
- (NSString *)documentsDirectory {
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	return [paths objectAtIndex:0];
}



#define now_hours 0
#define all_hours 1

/// Hours Table View Code

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

@end
