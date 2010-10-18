//
//  RootViewController.h
//  DiningTableViewTest
//
//  Created by Ben Johnson on 7/8/10.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
#import "HallNavigationBar.h"

@class mealHandler;
@class WristWatch;
@class UICustomTableView;
@class ScheduleDecider;

@interface RootViewController : UIViewController <UITableViewDelegate, UITabBarDelegate, UITableViewDataSource, UIActionSheetDelegate, MFMailComposeViewControllerDelegate> {
	

	// Table View Outlets
	IBOutlet UICustomTableView *customTableView;
	IBOutlet UITableViewCell *tempCell;
	
	// Navigation Scrollers and Views
	IBOutlet UIScrollView *hallScrollView;
	IBOutlet UIScrollView *mealScrollView;
    IBOutlet UIScrollView *alternateScroller;
	IBOutlet UIView *hallHeaderView;
    IBOutlet UIView *hallHeaderTemplate;

	IBOutlet UIView *mealHeaderView;
    IBOutlet UIView *dayDeciderView;
    IBOutlet UISegmentedControl *dayDeciderBar;
    IBOutlet UIToolbar *topFillerBar;
    
    IBOutlet UIView *grillView;
	
	// Data Controllers
	mealHandler *todaysMealHandler;
	WristWatch *localMealDecider;
	NSIndexPath *selectedIndexPath;
	NSMutableArray *currentArray;
	
	ScheduleDecider *localScheduler;
    
    BOOL navigationBarsAnimatedOut;

	int currentHallPage;
	int currentMealPage;
	
	HallNavigationBar *hallNavBar;
	
}

@property (nonatomic, retain) IBOutlet UICustomTableView *customTableView;
@property (nonatomic, retain) IBOutlet UIScrollView *hallScrollView;
@property (nonatomic, retain) IBOutlet UIScrollView *mealScrollView;
@property (nonatomic, retain) IBOutlet UIScrollView * alternateScroller;
@property (nonatomic, retain) IBOutlet UISegmentedControl *dayDeciderBar;
@property (nonatomic, retain) NSIndexPath *selectedIndexPath;

-(void)setupMealData;
-(void)registerNotifications;

// Table View Swiping
-(void)animateNavigationBars;
-(IBAction)navigateRight:(id)sender;
-(IBAction)navigateLeft:(id)sender;

// Pages to Navigate To
-(IBAction)displayActionPage;
-(IBAction)displayPolarPoints;
-(IBAction)displayHoursPage;

-(IBAction)changeTime;



@end
