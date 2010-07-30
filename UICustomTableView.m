//
//  UICustomTableView.m
//  DiningTable
//
//  Created by Ben Johnson on 6/18/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "UICustomTableView.h"

@implementation UICustomTableView



#define HORIZ_SWIPE_DRAG_MIN 100
CGPoint mystartTouchPosition;
BOOL isProcessingListMove;
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
	UITouch *touch = [touches anyObject];
	CGPoint newTouchPosition = [touch locationInView:self];
	
	if (touch.tapCount == 1) {
		//NSLog(@"Tapped");
	}
	
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
	isProcessingListMove = NO;
	[super touchesEnded:touches withEvent:event];
}


-(void)moveToPreviousItem{
	NSLog(@"Move To Previous Item");
	[[NSNotificationCenter defaultCenter] postNotificationName:@"TableViewSwipeLeft" object:nil];
	

}
-(void)moveToNextItem{
	[[NSNotificationCenter defaultCenter] postNotificationName:@"TableViewSwipeRight" object:nil];
}


// Method for Setting Background Color
- (void)tableView: (UICustomTableView*)tableView willDisplayCell:(UICustomTableView *)cellforRowAtIndexPath: (NSIndexPath*)indexPath
{
	UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
	NSLog(@"Trying to Set Background Color");
	
	cell.backgroundColor = [UIColor grayColor];
	cell.textLabel.backgroundColor = [UIColor clearColor];
	cell.detailTextLabel.backgroundColor = [UIColor clearColor];
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
	
    [super setSelected:selected animated:animated];
	
    // Configure the view for the selected state
}


- (void)dealloc {
    [super dealloc];
}


@end
