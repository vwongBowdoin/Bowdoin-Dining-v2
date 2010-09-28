//
//  PolarPoints.h
//  DiningTableViewTest
//
//  Created by Ben Johnson on 7/13/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PolarPoints : UIViewController {

	IBOutlet UILabel *mealsRemaining;
	IBOutlet UILabel *polarPoints;
	
	// Login Information
	NSString *userName;
	NSString *password;

}

-(IBAction)dismissPage;
- (void)loadCSGoldDataWithUserName:(NSString *)login password:(NSString*)password;

@end
