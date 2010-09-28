//
//  CustomTableViewCell.h
//  TableView
//
//  Created by Ben Johnson on 6/5/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface CustomTableViewCell : UITableViewCell {

	// Header
	IBOutlet UILabel *diningHallTitle;
	IBOutlet UILabel *hoursInformation;

	// Main Course
	IBOutlet UILabel *mainCourseTitle;
	IBOutlet UILabel *mealSummary;
	
	// More Courses
	IBOutlet UILabel *secondCourseTitle;
	IBOutlet UILabel *mealSummary2;

	
	NSTimeInterval startTouchTime;
	CGPoint previousTouchPosition1, previousTouchPosition2;
	CGPoint startTouchPosition1, startTouchPosition2;
	
	BOOL isFavorited;


}

@property (nonatomic, retain) IBOutlet UILabel *diningHallTitle;
@property (nonatomic, retain) IBOutlet UILabel *mainCourseTitle;
@property (nonatomic, retain) IBOutlet UILabel *mealSummary;

@property (nonatomic, retain) IBOutlet UILabel *secondCourseTitle;
@property (nonatomic, retain) IBOutlet UILabel *mealSummary2;
@property (nonatomic, retain) IBOutlet UILabel *hoursInformation;

@property (assign) BOOL isFavorited;

- (void)moveToNextItem;
- (void)moveToPreviousItem;

@end
