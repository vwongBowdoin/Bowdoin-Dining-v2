//
//  MealNavigationBar.h
//  Bowdoin Dining
//
//  Created by Ben Johnson on 10/5/10.
//  Copyright Two Fourteen Software. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface MealNavigationBar : UIView {

	NSMutableArray *controllerArray;

	
}


-(NSString *)pruneString:(NSString *)stringToProcess;

@end
