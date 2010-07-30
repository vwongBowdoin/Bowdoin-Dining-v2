//
//  mealHandler.h
//  DiningTable
//
//  Created by Ben Johnson on 6/17/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface mealHandler : NSObject {

	NSMutableArray *thorneBreakfast;
	NSMutableArray *thorneLunch;
	NSMutableArray *thorneDinner;
	NSMutableArray *thorneBrunch;
	
	NSMutableArray *moultonBreakfast;
	NSMutableArray *moultonLunch;
	NSMutableArray *moultonDinner;
	NSMutableArray *moultonBrunch;

	
}

@property (nonatomic, retain) NSMutableArray *thorneBreakfast;
@property (nonatomic, retain) NSMutableArray *thorneLunch;
@property (nonatomic, retain) NSMutableArray *thorneDinner;
@property (nonatomic, retain) NSMutableArray *thorneBrunch;
@property (nonatomic, retain) NSMutableArray *moultonBreakfast;
@property (nonatomic, retain) NSMutableArray *moultonLunch;
@property (nonatomic, retain) NSMutableArray *moultonDinner;
@property (nonatomic, retain) NSMutableArray *moultonBrunch;


-(id)initArraysFromWeekday:(NSString *)weekDay;
-(void)printItems;
-(NSString*)documentsDirectory;


// TableView Data

// Methods that return TableView Data
-(NSString *)returnItem:(NSString *)theHall atIndex:(NSIndexPath *)indexPath inArray:(NSMutableArray *)theCurrentArray;

-(NSInteger)numberOfSectionsForArray:(NSMutableArray *)theCurrentArray;
-(NSInteger)sizeOfSection:(NSInteger)section inArray:(NSMutableArray *)theCurrentArray;

-(CGFloat)returnHeightForCellatIndex:(NSIndexPath *)indexPath inArray:(NSMutableArray*)theCurrentArray;




@end
