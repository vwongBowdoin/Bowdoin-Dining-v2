//
//  CustomUITableView.h
//
//  .
//

#import <UIKit/UIKit.h>

@interface UICustomTableView : UITableView
{
	
	NSTimeInterval startTouchTime;
	CGPoint previousTouchPosition1, previousTouchPosition2;
	CGPoint startTouchPosition1, startTouchPosition2;
	
	
}

- (void)sendEvent:(UIEvent *)event;
- (void)moveToNextItem;
- (void)moveToPreviousItem;

@end
