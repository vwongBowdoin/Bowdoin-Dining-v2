//
//  CustomTableViewCell.m
//  TableView
//
//  Created by Ben Johnson on 6/5/10.
//  Copyright Two Fourteen Software. All rights reserved.
//

#import "CustomTableViewCell.h"


@implementation CustomTableViewCell

@synthesize isFavorited, diningHallTitle , mainCourseTitle, mealSummary, secondCourseTitle, mealSummary2, hoursInformation;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if ((self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])) {
        // Initialization code
		
		
    }
    return self;
}

/*-(void)layoutSubviews{
	
	
	
}*/


//** CODE FOR SWIPING **//


#define HORIZ_SWIPE_DRAG_MIN 100
CGPoint mystartTouchPosition;
BOOL isProcessingListMove;
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
	UITouch *touch = [touches anyObject];
	CGPoint newTouchPosition = [touch locationInView:self];
	if(mystartTouchPosition.x != newTouchPosition.x || mystartTouchPosition.y != newTouchPosition.y) {
		isProcessingListMove = NO;
	}
	mystartTouchPosition = [touch locationInView:self];
	[super touchesBegan:touches withEvent:event];
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event 
{
	UITouch *touch = touches.anyObject;
	CGPoint currentTouchPosition = [touch locationInView:self];
	
	// If the swipe tracks correctly.
	double diffx = mystartTouchPosition.x - currentTouchPosition.x + 0.1; // adding 0.1 to avoid division by zero
	double diffy = mystartTouchPosition.y - currentTouchPosition.y + 0.1; // adding 0.1 to avoid division by zero
	
	if(abs(diffx / diffy) > 1 && abs(diffx) > HORIZ_SWIPE_DRAG_MIN)
	{
		// It appears to be a swipe.
		if(isProcessingListMove) {
			// ignore move, we're currently processing the swipe
			return;
		}
		
		if (mystartTouchPosition.x < currentTouchPosition.x) {
			isProcessingListMove = YES;
			[self moveToPreviousItem];
			return;
		}
		else {
			isProcessingListMove = YES;
			[self moveToNextItem];
			return;
		}
	}
	else if(abs(diffy / diffx) > 1)
	{
		isProcessingListMove = YES;
		[super touchesMoved:touches	withEvent:event];
	}
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event 
{
	
	UITouch *touch = touches.anyObject;
	CGPoint currentTouchPosition = [touch locationInView:self];
	
	// If the swipe tracks correctly.
	double diffx = mystartTouchPosition.x - currentTouchPosition.x + 0.1; // adding 0.1 to avoid division by zero
	double diffy = mystartTouchPosition.y - currentTouchPosition.y + 0.1; // adding 0.1 to avoid division by zero
	
	if (diffx < HORIZ_SWIPE_DRAG_MIN && diffy < HORIZ_SWIPE_DRAG_MIN) {
		if (touch.tapCount == 1) {
			NSLog(@"Definite Single Tap");
			
		}
	}
	
	isProcessingListMove = NO;
	[super touchesEnded:touches withEvent:event];
}


-(void)moveToPreviousItem{
	NSLog(@"Cell Move To Previous Item");
	[[NSNotificationCenter defaultCenter] postNotificationName:@"TableViewSwipeLeft" object:self];
}
-(void)moveToNextItem{
	NSLog(@"Cell Move To Next Item");
	[[NSNotificationCenter defaultCenter] postNotificationName:@"TableViewSwipeRight" object:self];

}




- (void)setSelected:(BOOL)selected animated:(BOOL)animated {

   // [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (void)dealloc {
    [super dealloc];
}


@end
