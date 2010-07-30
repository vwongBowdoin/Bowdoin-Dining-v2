//
//  mealHandler.m
//  DiningTable
//
//  Created by Ben Johnson on 6/17/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "mealHandler.h"


@implementation mealHandler
@synthesize thorneBreakfast, thorneLunch, thorneDinner, thorneBrunch, moultonBreakfast, moultonLunch, moultonDinner, moultonBrunch;


//@synthesize locationArray, thorneCourseTitles, thorneCourseItems, moultonCourseTitles, moultonCourseItems;

-(id)initArraysFromWeekday:(NSString *)weekDay {
	
    // Use Meal Decider to pull correct arrays.
    NSLog(@"Trying to Recover Arrays");
    
    NSString *archivePath = [NSString stringWithFormat:@"%@/thorneBreakfast%d.xml",[self documentsDirectory],weekDay];

    
    thorneBreakfast = [[NSMutableArray alloc] initWithContentsOfFile:archivePath];

   
    archivePath = [NSString stringWithFormat:@"%@/thorneLunch%d.xml",[self documentsDirectory],weekDay];
    
    
    thorneLunch = [[NSMutableArray alloc] initWithContentsOfFile:archivePath];

    archivePath = [NSString stringWithFormat:@"%@/thorneDinner%d.xml",[self documentsDirectory],weekDay];
    
    
    thorneDinner = [[NSMutableArray alloc] initWithContentsOfFile:archivePath];

    archivePath = [NSString stringWithFormat:@"%@/thorneBrunch%d.xml",[self documentsDirectory],weekDay];
    
    
    thorneBrunch = [[NSMutableArray alloc] initWithContentsOfFile:archivePath];

    archivePath = [NSString stringWithFormat:@"%@/moultonBreakfast%d.xml",[self documentsDirectory],weekDay];
    
    
    moultonBreakfast = [[NSMutableArray alloc] initWithContentsOfFile:archivePath];

    archivePath = [NSString stringWithFormat:@"%@/moultonLunch%d.xml",[self documentsDirectory],weekDay];
    
    
    moultonLunch = [[NSMutableArray alloc] initWithContentsOfFile:archivePath];

    archivePath = [NSString stringWithFormat:@"%@/moultonDinner%d.xml",[self documentsDirectory],weekDay];
    
    
    moultonDinner = [[NSMutableArray alloc] initWithContentsOfFile:archivePath];

    archivePath = [NSString stringWithFormat:@"%@/moultonBrunch%d.xml",[self documentsDirectory],weekDay];
    
    
    moultonBrunch = [[NSMutableArray alloc] initWithContentsOfFile:archivePath];

    
    
    
	return self;
}

-(void)printItems {
	

}

-(NSInteger)sizeOfSection:(NSInteger)section inArray:(NSMutableArray *)theCurrentArray{
	
	return [[theCurrentArray objectAtIndex:section] count];
	
}

-(NSInteger)numberOfSectionsForArray:(NSMutableArray *)theCurrentArray{
	
	
	return [theCurrentArray count];
}

-(NSString *)returnItem:(NSString *)theHall atIndex:(NSIndexPath *)indexPath inArray:(NSMutableArray *)theCurrentArray {
	
	NSString *stringToReturn;
	
	stringToReturn = [[theCurrentArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
	
	
	return stringToReturn;
	
}

-(CGFloat)returnHeightForCellatIndex:(NSIndexPath *)indexPath inArray:(NSMutableArray *)currentArray{
	
	NSString *stringToConsider;
	
	stringToConsider = [[currentArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
	
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
