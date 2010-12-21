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
#import "MBProgressHUD.h"

@class mealHandler;
@class WristWatch;
@class UICustomTableView;
@class ScheduleDecider;

@interface RootViewController : UIViewController <UITableViewDelegate, UITabBarDelegate, UITableViewDataSource, UIActionSheetDelegate, MFMailComposeViewControllerDelegate, MBProgressHUDDelegate> {
	
	@private

	// Table View Outlets
	IBOutlet UICustomTableView *customTableView;
	IBOutlet UITableViewCell *tempCell;
	
	// Navigation Scrollers and Views
	IBOutlet UIScrollView *hallScrollView;
	IBOutlet UIScrollView *mealScrollView;
    IBOutlet UIScrollView *alternateScroller;
	IBOutlet UIView *hallHeaderView;
    IBOutlet UIView *hallHeaderTemplate;
	
	// Grill Buttons
	IBOutlet UIButton *callButton;
	IBOutlet UIButton *menuButton;
	IBOutlet UILabel *callText;
	IBOutlet UILabel *menuText;
	

	IBOutlet UIView *mealHeaderView;
    IBOutlet UIView *dayDeciderView;
    IBOutlet UISegmentedControl *dayDeciderBar;
    IBOutlet UIToolbar *topFillerBar;
    
    IBOutlet UIView *grillView;
	
	// Data Controllers
	mealHandler *todaysMealHandler;
	WristWatch *watch;
	NSIndexPath *selectedIndexPath;
	NSMutableArray *currentArray;
	
	ScheduleDecider *scheduler;
    
    BOOL navigationBarsAnimatedOut;

	int currentHallPage;
	int currentMealPage;
	
	HallNavigationBar *hallNavBar;
	
}

@property (nonatomic, retain) IBOutlet UICustomTableView *customTableView;
@property (nonatomic, retain) IBOutlet UIScrollView *hallScrollView;
@property (nonatomic, retain) IBOutlet UIScrollView *mealScrollView;
@property (nonatomic, retain) IBOutlet UISegmentedControl *dayDeciderBar;

@property (nonatomic, retain) IBOutlet UIButton * callButton;
@property (nonatomic, retain) IBOutlet UILabel * callText;
@property (nonatomic, retain) IBOutlet UIButton * menuButton;
@property (nonatomic, retain) IBOutlet UILabel * menuText;

@property (nonatomic, retain) ScheduleDecider *scheduler;


@property (nonatomic, retain) NSIndexPath *selectedIndexPath;

-(void)setupMealData;
-(void)registerNotifications;





@end
