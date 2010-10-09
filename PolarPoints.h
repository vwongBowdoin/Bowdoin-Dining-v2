//
//  PolarPoints.h
//  DiningTableViewTest
//
//  Created by Ben Johnson on 7/13/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"


@interface PolarPoints : UIViewController {

	IBOutlet UILabel *mealsRemaining;
	IBOutlet UILabel *polarPoints;
	IBOutlet UILabel *oneCardBalance;

	IBOutlet UIActivityIndicatorView *activityIndicator1;
	IBOutlet UIActivityIndicatorView *activityIndicator2;
	IBOutlet UIActivityIndicatorView *activityIndicator3;

	MBProgressHUD *HUD;
	
	// Login Information
	NSString *userName;
	NSString *password;

}

- (void)loadCSGoldDataWithUserName:(NSString *)login password:(NSString*)password;

- (IBAction)dismissPage;
- (IBAction)logout;
- (IBAction)refreshInformation;


@end
