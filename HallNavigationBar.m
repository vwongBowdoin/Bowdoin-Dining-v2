//
//  HallNavigationBar.m
//  DiningTableViewTest
//
//  Created by Ben Johnson on 10/3/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "HallNavigationBar.h"


@implementation HallNavigationBar
@synthesize timeToDisplay;

- (id)initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {
        // Initialization code
    }
    return self;
}


 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
	 
	 float barWidth = 320;
	 float barHeight = 44;
	 float indicatorOffset = 10;
	 [self setBackgroundColor:[UIColor whiteColor]];

	 
	 NSString *title;
	 // Iterator to populate the entire bar
	 for (int x = 0; x < 3; x++) {

		 switch (x) {
			 case 0:
				 title = @"Thorne Hall";
				 break;
			 case 1:
				 title = @"Moulton Union";
				 break;
			 case 2:
				 title = @"The Grill | The Cafe";
				 break;
			 default:
				 break;
		 }
		 
		 UILabel *mealDescription = [[UILabel alloc]initWithFrame:CGRectMake(0 + (barWidth * x), 0, barWidth, 30)];
		 mealDescription.text = title;
		 mealDescription.textColor = [UIColor blackColor];
		 mealDescription.backgroundColor = [UIColor whiteColor];
		 mealDescription.textAlignment = UITextAlignmentCenter;
		 [mealDescription setFont:[UIFont boldSystemFontOfSize:18.0]];
		 
		 [self addSubview:mealDescription];		
		 
		 
		 UILabel *mealTimes = [[UILabel alloc]initWithFrame:CGRectMake(0 + (barWidth * x), 22, barWidth, 22)];
		 mealTimes.text = timeToDisplay;
		 mealTimes.textColor = [UIColor blackColor];
		 mealTimes.backgroundColor = [UIColor whiteColor];
		 mealTimes.textAlignment = UITextAlignmentCenter;
		 [mealTimes setFont:[UIFont systemFontOfSize:14.0]];
		 
		 [self addSubview:mealTimes];	
		 
		 
		 // Makes sure no out of bounds errors will occur
		 if (x != 0){

			 UILabel *leftIndicator = [[UILabel alloc]initWithFrame:CGRectMake(indicatorOffset + (barWidth * x), 0, barWidth - 2*indicatorOffset, barHeight)];
			 
			 leftIndicator.text = @"< Thorne";
			 leftIndicator.textColor = [UIColor blackColor];
			 leftIndicator.backgroundColor = [UIColor clearColor];
			 leftIndicator.textAlignment = UITextAlignmentLeft;
			 [leftIndicator setFont:[UIFont boldSystemFontOfSize:10.0]];
			 
			 [self addSubview:leftIndicator];
			 
			 
		 } 
		 
		 
		 if (x != 2){

			 UILabel *rightIndicator = [[UILabel alloc]initWithFrame:CGRectMake(indicatorOffset + (barWidth * x), 0, barWidth - 2*indicatorOffset, barHeight)];
			
			 rightIndicator.text = @"Moulton >";
			 rightIndicator.textColor = [UIColor blackColor];
			 rightIndicator.backgroundColor = [UIColor clearColor];
			 rightIndicator.textAlignment = UITextAlignmentRight;
			 [rightIndicator setFont:[UIFont boldSystemFontOfSize:10.0]];
			 
			 [self addSubview:rightIndicator];
			 
		 } 

		 
	 }
	
	 
 }

- (void)dealloc {
    [super dealloc];
}


@end

