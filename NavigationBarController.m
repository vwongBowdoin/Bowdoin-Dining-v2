//
//  NavigationBarController.m
//  DiningTableViewTest
//
//  Created by Ben Johnson on 8/11/10.
//  Copyright (c) 2010 __MyCompanyName__. All rights reserved.
//

#import "NavigationBarController.h"


@implementation NavigationBarController
@synthesize scheduleArray;

-(id)initWithScheduleArray:(NSMutableArray *)theScheduleArray{
    
    // Sets the Passed Schedule Array within the class.
    scheduleArray = theScheduleArray;
    
    return self;
    
}

-(UIScrollView*)returnTopScrollBar{
	
	
	UIScrollView *theScroller = [[[UIScrollView alloc] init] autorelease];

	return theScroller;
	
}

-(UIView*)returnMealNavigationBar{
    
    float barWidth = 320;
    float barHeight = 44;
        
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, barWidth * [scheduleArray count], barHeight)];
	[view setBackgroundColor:[UIColor clearColor]];
    
    for (int i = 0; i < [scheduleArray count]; i++){
        
        // Returns the NSString at each index of the array
        NSString *mealTitle = [scheduleArray objectAtIndex:i];
        NSString *leftTitle;
        NSString *rightTitle;
        
        // Makes sure no out of bounds errors will occur
        if (i != 0){
            leftTitle = [scheduleArray objectAtIndex:i-1];
        } else {
            leftTitle = NULL;
        }
        
        if (i != [scheduleArray count]-1){
            rightTitle = [scheduleArray objectAtIndex:i+1];
        } else {
            rightTitle = NULL;
        }
			
        [view addSubview:[self createMealHeader:mealTitle atIndex:i leftTitle:leftTitle rightTitle:rightTitle]];
        
    }
	
	UIView *theMasterView = view;
	[view release];
    
    return theMasterView;
}

-(UIView*)createMealHeader:(NSString *)mealName atIndex:(int)index leftTitle:(NSString *)leftTitle rightTitle:(NSString *)rightTitle{
    
    // Initializes the View
    
    float barWidth = 320;
    float barHeight = 44;
    float indicatorOffset = 10;

    
    UIView *theView = [[UIView alloc] initWithFrame:CGRectMake(0+ index*barWidth, 0, barWidth, barHeight)];
	
	[theView setBackgroundColor:[UIColor clearColor]];
	
	UILabel *mealDescription = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, barWidth, barHeight)];
    mealDescription.text = [NSString stringWithFormat:@"Today's %@", mealName];
    mealDescription.textColor = [UIColor whiteColor];
	mealDescription.backgroundColor = [UIColor clearColor];
    mealDescription.textAlignment = UITextAlignmentCenter;
	
	[mealDescription setFont:[UIFont boldSystemFontOfSize:18.0]];

   
    if (leftTitle != NULL){
        
		UILabel *leftIndicator = [[UILabel alloc]initWithFrame:CGRectMake(indicatorOffset, 0, barWidth - 2*indicatorOffset, barHeight)];
        
		leftIndicator.text = [NSString stringWithFormat:@"< %@", leftTitle];
        leftIndicator.textColor = [UIColor whiteColor];
		leftIndicator.backgroundColor = [UIColor clearColor];
        leftIndicator.textAlignment = UITextAlignmentLeft;
        [leftIndicator setFont:[UIFont boldSystemFontOfSize:10.0]];
		
		[theView addSubview:leftIndicator];

    }
    
    
    if (rightTitle != NULL){
		UILabel *rightIndicator = [[UILabel alloc]initWithFrame:CGRectMake(indicatorOffset, 0, barWidth - 2*indicatorOffset, barHeight)];
        
		rightIndicator.text = [NSString stringWithFormat:@"%@ >", rightTitle];
        rightIndicator.textColor = [UIColor whiteColor];
		rightIndicator.backgroundColor = [UIColor clearColor];
        rightIndicator.textAlignment = UITextAlignmentRight;
        [rightIndicator setFont:[UIFont boldSystemFontOfSize:10.0]];
		
		[theView addSubview:rightIndicator];

        
    }
    
    
	NSLog(@"\n Meal Description: \n x = %f \n y = %f \n x_width = %f \n y_width = %f" , mealDescription.frame.origin.x, mealDescription.frame.origin.y, mealDescription.frame.size.width, mealDescription.frame.size.height);

	
	NSLog(@"\n Meal Header View: \n x = %f \n y = %f \n x_width = %f \n y_width = %f" , theView.frame.origin.x, theView.frame.origin.y, theView.frame.size.width, theView.frame.size.height);
	NSLog(@"\n Left Title = %@ \n Meal Title = %@ \n Right Title = %@", leftTitle, mealName, rightTitle);
	
    return theView;
    
}



@end
