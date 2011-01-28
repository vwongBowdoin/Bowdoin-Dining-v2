//
//  RecentTransactions.h
//  DiningTableViewTest
//
//  Created by Ben Johnson on 10/8/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"
#import "CSGoldController.h"

@interface RecentTransactions : UIViewController <UITableViewDelegate, UITableViewDataSource, MBProgressHUDDelegate> {

	IBOutlet UITableView *tableView;
	
	MBProgressHUD *HUD;
	
	// Login Information
	NSString *userName;
	NSString *password;
	
	CSGoldController *session_Controller;
	
	NSMutableArray *transactions;
	
}

@property (nonatomic, retain) NSMutableArray *transactions;


- (IBAction)backButtonSelected;

@end
