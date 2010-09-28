//
//  ScheduleDecider.m
//  DiningTableViewTest
//
//  Created by Ben Johnson on 8/3/10.
//  Copyright (c) 2010 __MyCompanyName__. All rights reserved.
//

#import "ScheduleDecider.h"
#import "MealSchedule.h"
#import "mealHandler.h"
#import "ScheduleConstants.h"

@implementation ScheduleDecider

@synthesize expressLunch, expressDinner, mHotBreakfast, mColdBreakfast, mLunch, mDinner,mBrunch;
@synthesize tHotBreakfast, tColdLunch, tHotLunch, tDinner, tBrunch, tSuperSnax;
@synthesize cafeMorning, cafeNight, theGrill, thePub, theCStore;
@synthesize mealArray, diningHallMealArray, thorneArray, moultonArray, navBarArray;


// This method populates MealSchedule objects with their allotted times

-(id)init{
    
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
    expressLunch.mealName = @"Express Lunch";
	expressLunch.shortName = @"Express Lunch";
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
    expressDinner.mealName = @"Express Dinner";
	expressDinner.shortName = @"Express Dinner";
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
    
    close = [[NSArray alloc] initWithObjects:[NSNumber numberWithInt:mExpressDinnerStop], // Mon
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
    
    close = [[NSArray alloc] initWithObjects:[NSNumber numberWithInt:mLunchStop], // Mon
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
    
    close = [[NSArray alloc] initWithObjects:[NSNumber numberWithInt:mLunchStop], // Mon
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
    
    close = [[NSArray alloc] initWithObjects:[NSNumber numberWithInt:mLunchStop], // Mon
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
    
    close = [[NSArray alloc] initWithObjects:[NSNumber numberWithInt:mLunchStop], // Mon
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

-(NSMutableArray *)returnArrayOfOpenMeals{
    
    //Assumes we want an array of today's meals.
    
    NSMutableArray *array = [[NSMutableArray alloc]init];
    int currentDay = (int)[self returnCurrentWeekDay];
    

    for(MealSchedule *element in mealArray){
        [element setCurrentDay:currentDay];
		
		NSMutableDictionary *dictionary = [[NSMutableDictionary alloc]init];
        if ([element isOpen] /*|| [element willOpen]*/){
            
			if (element.location != nil) {
				[dictionary setObject:element.location forKey:@"location"];
			} else {
				[dictionary setObject:@"NOLOC" forKey:@"location"];	
			}

			if (element.shortName != nil) {
				[dictionary setObject:element.shortName forKey:@"meal"];
			}
			else {
				[dictionary setObject:@"NONAME" forKey:@"meal"];
	
			}

			
			[dictionary setObject:[element dateText] forKey:@"hours"];
			[dictionary setObject:[element fullHoursText] forKey:@"fullhours"];
			         
			[array addObject:dictionary];

        }
		

        
    }
    
    return array;
    
}

-(void)processMealArrays{
    
	// We establish three arrays to keep track of our meal information
    NSMutableArray *thorne_array  = [[NSMutableArray alloc] init];
    NSMutableArray *moulton_array = [[NSMutableArray alloc] init];
    NSMutableArray *navigation_array  = [[NSMutableArray alloc] init];
	
	
    int currentDay = (int)[self returnCurrentWeekDay];
   
	// Running through every element of the DiningHallMealArray
    for(MealSchedule *element in diningHallMealArray){
        NSMutableDictionary *dictionary = [[NSMutableDictionary alloc]init];
        
		[element setCurrentDay:currentDay];
        if ([element isOpen] || [element willOpen]){
            
            
            NSLog(@"Storing Short Name: %@", element.shortName);
            
            [dictionary setObject:element.shortName forKey:@"Shortname"];
            [dictionary setObject:[element returnFileLocation] forKey:@"FileLocation"];
            [dictionary setObject:[element returnDescription] forKey:@"Day"];
            
			
            // Decides which of our location arrays to populate
			if ([element.location isEqualToString:@"Thorne"]) {
				
				// Adds Object if the Shortname does not repeat
				// This filters out meal objects i.e. Hot Breakfast, Cold Breakfast
				if (![[[thorne_array lastObject] objectForKey:@"Shortname"] isEqualToString:element.shortName]) {
					
					[thorne_array addObject:dictionary];	
				}	
			} else {
				
				if (![[[moulton_array lastObject] objectForKey:@"Shortname"] isEqualToString:element.shortName]) {
					
					[moulton_array addObject:dictionary];
					
				}
			} // end if, else
			
        }
        
    } // end iteration of mealschedule objects
	
	
	
	// Resolve Inconsistencies in Populating Arrays
	// Array with fewer objects needs a placeholder dictionary inserted
	
	if ([thorne_array count] < [moulton_array count]){
		
		NSMutableDictionary *fakeDictionary = [[NSMutableDictionary alloc] init];
		
		[fakeDictionary setObject:[[moulton_array objectAtIndex:0] objectForKey:@"Shortname"] forKey:@"Shortname"];
		[fakeDictionary setObject:[[moulton_array objectAtIndex:0] objectForKey:@"Day"] forKey:@"Day"];

		// placeholder dictionary inserted at index 0
		[thorne_array insertObject:fakeDictionary atIndex:0];
		
		[fakeDictionary release];
		
	} else if ([moulton_array count] < [thorne_array count]) {
		
		NSMutableDictionary *fakeDictionary = [[NSMutableDictionary alloc] init];

		[fakeDictionary setObject:[[thorne_array objectAtIndex:0] objectForKey:@"Shortname"] forKey:@"Shortname"];
		[fakeDictionary setObject:[[thorne_array objectAtIndex:0] objectForKey:@"Day"] forKey:@"Day"];
		
		// placeholder dictionary inserted at index 0
		[moulton_array insertObject:fakeDictionary atIndex:0];
		
		[fakeDictionary release];

	} else {
		
		// Must be equal - no Inconsistencies
		
	}
	
	
	// Populate Navigation Array to Properly Display Title Bar
	for(NSDictionary *element in thorne_array){
		[navigation_array addObject:[element objectForKey:@"Day"]];
	}
	
	
	// Sets local copies of Arrays
	thorneArray = thorne_array;
	moultonArray = moulton_array;
	navBarArray = navigation_array;
	   
}

-(NSMutableArray*)returnThorneArray{
	
	
	return thorneArray;
	
	
}

-(NSMutableArray *)returnMoultonArray{
	
	return moultonArray;	
}

-(NSMutableArray *)returnNavBarArray{
	
	return navBarArray;
	
}


-(int)returnCurrentWeekDay{
    
    NSDateFormatter *inputFormatter = [[[NSDateFormatter alloc] init] autorelease];
	[inputFormatter setDateFormat:@"e"];
	NSDate *toBeFormatted = [[[NSDate alloc] init] autorelease];
	
	NSString *formattedDate = [inputFormatter stringFromDate:toBeFormatted];
	
	
	if ([formattedDate intValue] == 1) {
		NSLog(@"formattedWeekday: %d", 6);

		return 6;
	} else {
		NSLog(@"formattedWeekday: %d", [formattedDate intValue] - 2);

		return [formattedDate intValue] - 2;
	}

}

-(NSNumber *)returnCurrentWeekDayNSNumber{
    
    int intToReturn = [self returnCurrentWeekDay];
    
    
    return [NSNumber numberWithInt:intToReturn];
    
}

@end
