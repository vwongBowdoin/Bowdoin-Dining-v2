//
//  RootViewController.h
//  DiningTableViewTest
//
//  Created by Ben Johnson on 7/8/10.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>

@class mealHandler;
@class UICustomTableView;

@interface RootViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, UIActionSheetDelegate, MFMailComposeViewControllerDelegate> {
	

	// Table View Outlets
	IBOutlet UICustomTableView *customTableView;
	IBOutlet UITableViewCell *tempCell;
	
	// Navigation Scrollers and Views
	IBOutlet UIScrollView *hallScrollView;
	IBOutlet UIScrollView *mealScrollView;
	IBOutlet UIView *hallHeaderView;
	IBOutlet UIView *mealHeaderView;
	
	// Data Controllers
	mealHandler *todaysMealHandler;
	NSIndexPath *selectedIndexPath;
	NSMutableArray *currentArray;

	
	int currentHallPage;
	int currentMealPage;
}

@property (nonatomic, retain) IBOutlet UICustomTableView *customTableView;
@property (nonatomic, retain) IBOutlet UIScrollView *hallScrollView;
@property (nonatomic, retain) IBOutlet UIScrollView *mealScrollView;
@property (nonatomic, retain) NSIndexPath *selectedIndexPath;


-(id)init;
-(IBAction)settingsPage;
-(IBAction)displayActionPage;
-(IBAction)displayPolarPoints;

@end
