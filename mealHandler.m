//
//  mealHandler.m
//  DiningTable
//
//  Created by Ben Johnson on 6/17/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "mealHandler.h"


@implementation mealHandler
@synthesize moultonArrayHolder, thorneArrayHolder, moultonArray, thorneArray;


- (id)initWithMoultonArray:(NSMutableArray*)firstArray  thorneArray:(NSMutableArray *)secondArray {
	
	
	// Local Copy of Schedule Decider Arrays
	moultonArray = firstArray;
	thorneArray = secondArray;
	
	return self;
}

- (void)processArrays{
	
	
	[self setMoultonArray:moultonArray];
	[self setThorneArray:thorneArray];
	
	
}
- (void)setMoultonArray:(NSMutableArray*)mArray {
		
	NSMutableArray *tempArray = [[NSMutableArray alloc] init];
	
	for (NSMutableDictionary *element in mArray){
		
		NSMutableArray *array;		
		
		if ([element objectForKey:@"FileLocation"] != NULL) {
			NSLog(@"Loading Array = %@", [[element objectForKey:@"FileLocation"] stringByReplacingOccurrencesOfString:[self documentsDirectory] withString:@""]);
			array = [[NSMutableArray alloc] initWithContentsOfFile:[element objectForKey:@"FileLocation"]];
			
			
			if (array == NULL) {
				array = [[NSMutableArray alloc] initWithObjects:@"NULL STRING BITCH", nil];
			}
			
			[tempArray addObject:array];

		} 
		
		
	}
	
	self.moultonArrayHolder = tempArray;
	
}
- (void)setThorneArray:(NSMutableArray *)tArray {
	
	NSMutableArray *tempArray2 = [[NSMutableArray alloc] init];

	
	for (NSMutableDictionary *element in tArray){
		
		NSMutableArray *array;		
		
		if ([element objectForKey:@"FileLocation"] != nil) {
			NSLog(@"Loading Array = %@", [[element objectForKey:@"FileLocation"] stringByReplacingOccurrencesOfString:[self documentsDirectory] withString:@""]);
			array = [[NSMutableArray alloc] initWithContentsOfFile:[element objectForKey:@"FileLocation"]];
		}
		
		[tempArray2 addObject:array];
		
	}
	
	self.thorneArrayHolder = tempArray2;
	
}

//////////////////////////// Data for TableViews ////////////////////////////////////

-(NSInteger)sizeOfSection:(NSInteger)section forLocation:(NSInteger)location atMealIndex:(NSUInteger)mealIndex{
	
	if (location == 0){
		
		return [[[thorneArrayHolder objectAtIndex:mealIndex] objectAtIndex:section] count];
		
	} else {
		
		return [[[moultonArrayHolder objectAtIndex:mealIndex] objectAtIndex:section] count];

	}

}

-(NSInteger)numberOfSectionsForLocation:(NSInteger)location atMealIndex:(NSInteger)mealIndex{
	
	if (location == 0){

		if ([thorneArrayHolder count] == 0) {
			
			return 0;
		}
		
		return [[thorneArrayHolder objectAtIndex:mealIndex] count];
		
	} else {
		
		if ([moultonArrayHolder count] == 0) {
			
			return 0;
		}
		
		return [[moultonArrayHolder objectAtIndex:mealIndex] count];
		
	}

}

-(NSString *)returnItemFromLocation:(NSInteger)location atMealIndex:(NSInteger)mealIndex atPath:(NSIndexPath *)indexPath  {
	
	if (location == 0){
		
		return [[[thorneArrayHolder objectAtIndex:mealIndex] objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
		
	} else {
		
		return [[[moultonArrayHolder objectAtIndex:mealIndex] objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
		
	}
	
}

-(CGFloat)returnHeightForCellatLocation:(NSInteger)location atMealIndex:(NSInteger)mealIndex atPath:(NSIndexPath *)indexPath{
	
	NSString *stringToConsider;
	
	if (location == 0){
		
		stringToConsider = [[[thorneArrayHolder objectAtIndex:mealIndex] objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
		
	} else {
		
		stringToConsider = [[[moultonArrayHolder objectAtIndex:mealIndex] objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
		
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

					 

- (void) dealloc {

	[super dealloc];
}

@end
