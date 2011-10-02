//
//  MealNavigationBar.m
//  Bowdoin Dining
//
//  Created by Ben Johnson on 10/5/10.
//  Copyright Two Fourteen Software. All rights reserved.
//

#import "MealNavigationBar.h"


@implementation MealNavigationBar


- (id)initWithArray:(NSMutableArray*)array{
    
	// Creates a frame based on the number of objects in the array
	CGRect frame = CGRectMake(0, 0, 320 * [array count], 44);
	
	controllerArray = array;
	
	if ((self = [super initWithFrame:frame])) {
        
		
	}
    return self;
}


// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
	
	float barWidth = 320;
    float barHeight = 44;
    float indicatorOffset = 10;
	[self setBackgroundColor:[UIColor clearColor]];
	
	// Iterator to populate the entire bar
	for (int x = 0; x < [controllerArray count]; x++) {
		
		NSString *mealTitle = [controllerArray objectAtIndex:x];
		NSString *leftTitle;
		NSString *rightTitle;
		
		// Makes sure no out of bounds errors will occur
        if (x != 0){
            leftTitle = [self pruneString:[controllerArray objectAtIndex:x-1]];
	        } else {
            leftTitle = NULL;
        }
        
		
        if (x != [controllerArray count]-1){
            rightTitle = [self pruneString:[controllerArray objectAtIndex:x+1]];
			} else {
            rightTitle = NULL;
        }
		
		
		// Draws the Meal Description
		
		UILabel *mealDescription = [[UILabel alloc]initWithFrame:CGRectMake(0 + (barWidth * x), 0, barWidth, barHeight)];
		mealDescription.text = mealTitle;
		mealDescription.textColor = [UIColor whiteColor];
		mealDescription.backgroundColor = [UIColor clearColor];
		mealDescription.textAlignment = UITextAlignmentCenter;
		[mealDescription setFont:[UIFont boldSystemFontOfSize:18.0]];
		
		[self addSubview:mealDescription];
		
		
		// Draws the Left Indicator
		if (leftTitle != NULL){
			
			UILabel *leftIndicator = [[UILabel alloc]initWithFrame:CGRectMake(indicatorOffset + (barWidth * x), 0, barWidth - 2*indicatorOffset, barHeight)];
			
			leftIndicator.text = [NSString stringWithFormat:@"< %@", leftTitle];
			leftIndicator.textColor = [UIColor whiteColor];
			leftIndicator.backgroundColor = [UIColor clearColor];
			leftIndicator.textAlignment = UITextAlignmentLeft;
			[leftIndicator setFont:[UIFont boldSystemFontOfSize:11.0]];
			
			[self addSubview:leftIndicator];
			
		}
		
		// Draws the Right Indicator
		if (rightTitle != NULL){
			UILabel *rightIndicator = [[UILabel alloc]initWithFrame:CGRectMake(indicatorOffset + (barWidth * x), 0, barWidth - 2*indicatorOffset, barHeight)];
			rightIndicator.text = [NSString stringWithFormat:@"%@ >", rightTitle];
			rightIndicator.textColor = [UIColor whiteColor];
			rightIndicator.backgroundColor = [UIColor clearColor];
			rightIndicator.textAlignment = UITextAlignmentRight;
			[rightIndicator setFont:[UIFont boldSystemFontOfSize:11.0]];
			
			[self addSubview:rightIndicator];
			
			
		}
		
	}
	
}


-(NSString *)pruneString:(NSString *)stringToProcess{
		
	NSString *stringToReturn;
	
	stringToReturn = [stringToProcess stringByReplacingOccurrencesOfString:@"Today's" withString:@""];
	stringToReturn = [stringToReturn stringByReplacingOccurrencesOfString:@"Tomorrow's" withString:@""];
	
	return stringToReturn;
	
}

- (void)dealloc {
    [super dealloc];
}


@end

