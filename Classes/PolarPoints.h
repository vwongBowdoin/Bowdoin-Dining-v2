//
//  PolarPoints.h
//  Bowdoin Dining
//
//  Created by Ben Johnson on 7/13/10.
//  Copyright Two Fourteen Software. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"
#import "CSGoldController.h"

@interface PolarPoints : UIViewController <MBProgressHUDDelegate> {

	IBOutlet UILabel *mealsRemaining;
	IBOutlet UILabel *polarPoints;
	IBOutlet UILabel *oneCardBalance;
	IBOutlet UILabel *lastUpdatedLabel;

	IBOutlet UIActivityIndicatorView *activityIndicator1;
	IBOutlet UIActivityIndicatorView *activityIndicator2;
	IBOutlet UIActivityIndicatorView *activityIndicator3;

	
	CSGoldController *session_Controller;
	
	MBProgressHUD *HUD;
	
	// Login Information
	NSString *userName;
	NSString *password;

}

// Public Methods
- (void)loadCSGoldDataWithUserName:(NSString *)login password:(NSString*)password;
- (void)updateVisibleInformation;


// Private Methods
- (void)beginCSGoldDownload;
- (void)registerForNotifications;
- (void)destroyLoginInformation;
- (void)destroySessionInformation;


- (IBAction)dismissPage;
- (IBAction)logout;
- (IBAction)refreshInformation;
- (IBAction)launchRecentTransactions;


@end
