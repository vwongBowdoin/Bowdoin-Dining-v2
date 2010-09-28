//
//  mealHandler.h
//  DiningTable
//
//  Created by Ben Johnson on 6/17/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface mealHandler : NSObject {

	NSMutableArray *moultonArrayHolder;
	NSMutableArray *thorneArrayHolder;

	
	NSMutableArray *moultonArray;
	NSMutableArray *thorneArray;
	
}

@property (nonatomic, retain) NSMutableArray *moultonArrayHolder;
@property (nonatomic, retain) NSMutableArray *thorneArrayHolder;

@property (nonatomic, retain) NSMutableArray *moultonArray;
@property (nonatomic, retain) NSMutableArray *thorneArray;

// Initialization method
- (id)initWithMoultonArray:(NSMutableArray*)firstArray thorneArray:(NSMutableArray *)secondArray;

// TableView Data
- (void)setMoultonArray:(NSMutableArray*)moultonArray;
- (void)setThorneArray:(NSMutableArray *)thorneArray;

// Methods that return TableView Data
-(NSInteger)sizeOfSection:(NSInteger)section forLocation:(NSInteger)location atMealIndex:(NSUInteger)mealIndex;
-(NSInteger)numberOfSectionsForLocation:(NSInteger)location atMealIndex:(NSInteger)mealIndex;
-(NSString *)returnItemFromLocation:(NSInteger)location atMealIndex:(NSInteger)mealIndex atPath:(NSIndexPath *)indexPath;
-(CGFloat)returnHeightForCellatLocation:(NSInteger)location atMealIndex:(NSInteger)mealIndex atPath:(NSIndexPath *)indexPath;


-(NSString*)documentsDirectory;


@end
