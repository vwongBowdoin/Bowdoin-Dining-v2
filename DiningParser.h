//
//  Parser.h
//  TableView
//
//  Created by Ben Johnson on 6/5/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
@class mealHandler;

@interface DiningParser : NSObject <NSXMLParserDelegate>{

	NSXMLParser * rssParser;
	NSMutableArray * mealArray;
	
	// a temporary item; added to the "stories" array one at a time, and cleared for the next one
	NSMutableDictionary * item;
	
	// parses through the document, from top to bottom...
	// we collect and cache each sub-element value, and then save each item to our array.
	// we use these to track each current item, until it's ready to be added to the "stories" array
	NSString * currentElement, * currentCourse, * currentUnit, * currentMeal;
	NSMutableString * currentTitle;
	
	NSString * feedAddress;
	mealHandler *todaysMealHandler;
	
	// Storage Arrays
	NSMutableArray *thorneBreakfast;
	NSMutableArray *thorneLunch;
	NSMutableArray *thorneDinner;
	NSMutableArray *thorneBrunch;
	
	NSMutableArray *moultonBreakfast;
	NSMutableArray *moultonLunch;
	NSMutableArray *moultonDinner;
	NSMutableArray *moultonBrunch;
    
    NSString *currentDayIndex;
	
}

// Methods that add to TableView Data
- (void)parseXMLData:(NSData *)data forDay:(NSString *)day;
-(NSMutableArray*)addTitleToArray:(NSString*)theTitle forArray:(NSMutableArray *)theArray;
-(void)addArrayofItems:(NSMutableArray *)items forCourse:(NSString *)courseTitle forMeal:(NSString *)mealTitle forHall:(NSString *)diningHall;
-(NSString*)documentsDirectory;

// Methods that return TableView Data
-(NSString *)returnItem:(NSString *)theHall atIndex:(NSIndexPath *)indexPath inArray:(NSMutableArray *)theCurrentArray;

-(NSInteger)numberOfSectionsForArray:(NSMutableArray *)theCurrentArray;
-(NSInteger)sizeOfSection:(NSInteger)section inArray:(NSMutableArray *)theCurrentArray;

-(CGFloat)returnHeightForCellatIndex:(NSIndexPath *)indexPath inArray:(NSMutableArray*)theCurrentArray;


@property (nonatomic, retain) mealHandler *todaysMealHandler;
@property (nonatomic, retain) NSMutableArray *thorneBreakfast;
@property (nonatomic, retain) NSMutableArray *thorneLunch;
@property (nonatomic, retain) NSMutableArray *thorneDinner;
@property (nonatomic, retain) NSMutableArray *thorneBrunch;
@property (nonatomic, retain) NSMutableArray *moultonBreakfast;
@property (nonatomic, retain) NSMutableArray *moultonLunch;
@property (nonatomic, retain) NSMutableArray *moultonDinner;
@property (nonatomic, retain) NSMutableArray *moultonBrunch;


@end