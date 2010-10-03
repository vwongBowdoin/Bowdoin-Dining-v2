//
//  HallNavigationBar.m
//  DiningTableViewTest
//
//  Created by Ben Johnson on 10/3/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "HallNavigationBar.h"


@implementation HallNavigationBar


- (id)initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {
        // Initialization code
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
	
	UILabel *mealDescription = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, barWidth, barHeight)];
    mealDescription.text = [NSString stringWithFormat:@"Today's %@", @"Lunch"];
    mealDescription.textColor = [UIColor whiteColor];
	mealDescription.backgroundColor = [UIColor clearColor];
    mealDescription.textAlignment = UITextAlignmentCenter;
	
	[mealDescription setFont:[UIFont boldSystemFontOfSize:18.0]];
	
	
	NSString *leftTitle = @"Breakfast";
	NSString *rightTitle = @"Dinner";
	
    if (leftTitle != NULL){
        
		UILabel *leftIndicator = [[UILabel alloc]initWithFrame:CGRectMake(indicatorOffset, 0, barWidth - 2*indicatorOffset, barHeight)];
        
		leftIndicator.text = [NSString stringWithFormat:@"< %@", leftTitle];
        leftIndicator.textColor = [UIColor whiteColor];
		leftIndicator.backgroundColor = [UIColor clearColor];
        leftIndicator.textAlignment = UITextAlignmentLeft;
        [leftIndicator setFont:[UIFont boldSystemFontOfSize:10.0]];
		
		[self addSubview:leftIndicator];
		
    }
    
    
    if (rightTitle != NULL){
		UILabel *rightIndicator = [[UILabel alloc]initWithFrame:CGRectMake(indicatorOffset, 0, barWidth - 2*indicatorOffset, barHeight)];
        
		rightIndicator.text = [NSString stringWithFormat:@"%@ >", rightTitle];
        rightIndicator.textColor = [UIColor whiteColor];
		rightIndicator.backgroundColor = [UIColor clearColor];
        rightIndicator.textAlignment = UITextAlignmentRight;
        [rightIndicator setFont:[UIFont boldSystemFontOfSize:10.0]];
		
		[self addSubview:rightIndicator];
		
        
    }
    
    
    [self addSubview:mealDescription];
	NSLog(@"\n Meal Description: \n x = %f \n y = %f \n x_width = %f \n y_width = %f" , mealDescription.frame.origin.x, mealDescription.frame.origin.y, mealDescription.frame.size.width, mealDescription.frame.size.height);
	
	
	NSLog(@"\n Meal Header View: \n x = %f \n y = %f \n x_width = %f \n y_width = %f" , self.frame.origin.x, self.frame.origin.y, self.frame.size.width, self.frame.size.height);
	NSLog(@"\n Left Title = %@ \n Meal Title = %@ \n Right Title = %@", leftTitle, @"Lunch", rightTitle);
	
	
	
	
}


- (void)dealloc {
    [super dealloc];
}


@end
