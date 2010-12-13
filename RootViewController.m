//
//  RootViewController.m
//  The RootViewController directs the entirety of the application. It is the orchestrator of the application
//  DiningTableViewTest
//
//  Created by Ben Johnson on 7/8/10.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import "RootViewController.h"
#import "PolarPoints.h"
#import "CustomTableViewCell.h"
#import "UICustomTableView.h"
#import "DiningParser.h"
#import "DownloadManager.h"
#import "WristWatch.h"
#import "ScheduleDecider.h"
#import "HoursViewController.h"
#import "NavigationBarController.h"
#import "CSGoldController.h"
#import "HallNavigationBar.h"
#import "MealNavigationBar.h"
#import "GrillAreaViewController.h"
#import "LineCountViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "AlertViews.h"
#import "FavoriteItem.h"

@interface RootViewController (PrivateMethods)

- (void)animateNavigationBars;
- (void)loadContent;
- (void)cleanupAlertViews;
- (void)navigateScrollBarRight:(UIScrollView*)scrollView;
- (void)navigateScrollBarLeft:(UIScrollView*)scrollView;
- (IBAction)launchPhone;
- (IBAction)launchGrillMenu;
- (void)setNavigationBarsWithArray:(NSMutableArray*)scheduleArray;

@end

@implementation RootViewController

@synthesize managedObjectContext;

@synthesize customTableView, hallScrollView, mealScrollView, selectedIndexPath, 
dayDeciderBar, callButton, callText, menuButton, menuText, scheduler;

#pragma mark -
#pragma mark Memory management

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Relinquish ownership any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    // Relinquish ownership of anything that can be recreated in viewDidLoad or on demand.
    // For example: self.myOutlet = nil;
}

- (void)dealloc {
	[managedObjectContext release];
	[customTableView release];
	[hallScrollView release];
	[mealScrollView release];
	[selectedIndexPath release];
	[dayDeciderBar release];
	[callButton release];
	[callText release];
	[menuButton release];
	[menuText release];
	[scheduler release];
	[[NSNotificationCenter defaultCenter] removeObserver:self];
    [super dealloc];
}

#pragma mark -
#pragma mark Application State Changes

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
	[self.navigationController setNavigationBarHidden:YES animated:YES];
	
}

- (void)registerNotifications{
    
    // Menu Download Completion
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(downloadSucceeded)
												 name:@"Download Completed" object:nil];
	
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(noInternetConnection)
												 name:@"No Internet Connection" object:nil];
	
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(noBowdoinConnection)
												 name:@"No Bowdoin Connection" object:nil];
	
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(noMenusAvailable)
												 name:@"No Menus Available" object:nil];
	
	[[NSNotificationCenter defaultCenter] addObserver:self 
											 selector:@selector(becomeActive:)
												 name:UIApplicationDidBecomeActiveNotification
											   object:nil];
    
}

- (void)becomeActive:(NSNotification *)notification{
	NSLog(@"Application Became Active");
	[self cleanupAlertViews];
	[self setupMealData];

}


- (void)showLocalAlertView{
	
	if (contentReady) {
		
		if (localAlertView == nil) {
			localAlertView = [AlertViews noMealAlert];
		}
		// Flashes Meal Notifcation
		[UIView beginAnimations:nil context:nil];
		[self.view addSubview:localAlertView];
		[UIView setAnimationDuration:0.4];
		[UIView setAnimationTransition:UIViewAnimationTransitionNone forView:localAlertView cache:YES];
		[UIView setAnimationDelegate:self]; 
		localAlertView.alpha = 1.0;
		[UIView commitAnimations];
		
		NSLog(@"-- Local Alert View Displayed");
	}
	
}

- (void)hideLocalAlertView{
		
	if (localAlertView != nil) {
		
		// Flashes TableView
		[UIView beginAnimations:nil context:nil];
		[UIView setAnimationDuration:0.4];
		[UIView setAnimationTransition:UIViewAnimationTransitionNone forView:localAlertView cache:YES];
		[UIView setAnimationDelegate:self]; 
		localAlertView.alpha = 0.0;
		[UIView commitAnimations];
		
		NSLog(@"-- Local Alert View Hidden.");
		
	}
}

- (void)showGlobalAlertView{
	
	if (contentReady) {
		
		if (globalAlertView == nil) {
			globalAlertView = [AlertViews noInternetAlert];
		}
		// Flashes Meal Notifcation
		[UIView beginAnimations:nil context:nil];
		[self.view addSubview:globalAlertView];
		[UIView setAnimationDuration:0.4];
		[UIView setAnimationTransition:UIViewAnimationTransitionNone forView:globalAlertView cache:YES];
		[UIView setAnimationDelegate:self]; 
		globalAlertView.alpha = 1.0;
		[UIView commitAnimations];
		
		NSLog(@"-- Global Alert View Displayed");
	}
	
	
	
	
}

- (void)hideGlobalAlertView{
	
	NSLog(@"Trying to hide global alert view");
	
	if (globalAlertView != nil) {
		
		// Flashes TableView
		[UIView beginAnimations:nil context:nil];
		[UIView setAnimationDuration:0.4];
		[UIView setAnimationTransition:UIViewAnimationTransitionNone forView:globalAlertView cache:YES];
		[UIView setAnimationDelegate:self]; 
		globalAlertView.alpha = 0.0;
		[UIView commitAnimations];
		
		NSLog(@"-- GLobal Alert View Hidden.");
		
	}
}

#pragma mark -
#pragma mark View lifecycle

// Navigation Bars
#define hallScroller 1
#define mealScroller 2

// MBProgressHUD delegate method
- (void)hudWasHidden{
	
	NSLog(@"HUD was hidden method triggered in RootView");
	
	/*if (downloadSucceeded) {
		localAlertView = [AlertViews noMealAlert];
		[self cleanupAlertViews];
		[self loadContent];
	} else {
		localAlertView = [AlertViews closedForSemesterAlert];
		[self loadContent];
	} */

}
- (void)viewDidLoad {
	
	[super viewDidLoad];
	
	// Creating the Main View
	[self.navigationController setNavigationBarHidden:YES animated: NO];
	self.title = @"Main";
	
	// Table View Initiliazation - sets data source and delegate
	customTableView.dataSource = self;
	customTableView.delegate = self;
	customTableView.separatorColor = [UIColor clearColor];
	
    // WristWatch is the global timer.
    WristWatch *localWatch = [[WristWatch alloc]init];
	watch = localWatch;
	
    [self registerNotifications];
	[self setupMealData];
	
	// Creates the No Meal Alert View

}


 /**
	Handles Menu Data
 */
- (void)setupMealData{

	// Initializes the Download Manager to Deal with Meal Data
	DownloadManager *manager = [[DownloadManager alloc] init];
    [manager setDelegate:self];
	
	// Successful Download Activates DownloadCompleted method
	[manager initializeDownloads];	
	
}

- (void)cleanupAlertViews{
	
	[self hideLocalAlertView];
	[self hideGlobalAlertView];
	localAlertView = nil;
	globalAlertView = nil;
	
}



/**
	Activated by NSNotificationCenter during normal download
 */
- (void)loadContent {
   	
	// Initializes the Schedule Decider if the scheduler does not exist
	// or the scheduler is out of date
	
	ScheduleDecider *decider = [[ScheduleDecider alloc] init];
	self.scheduler = decider;
	
	scheduler.managedObjectContext = self.managedObjectContext;
	
	[scheduler processArrays];
	[self setNavigationBarsWithArray:[scheduler returnNavBarArray]];
	
	
	contentReady = YES;
	[customTableView reloadData];
	
}

- (void)downloadSucceeded {
	
	
	downloadSucceeded = YES;
	localAlertView = [AlertViews noMealAlert];
	[self cleanupAlertViews];
	[self loadContent];
	
}

// No Internet Connectivity
- (void)noInternetConnection{
	
	globalAlertView = [AlertViews noInternetAlert];
	
	[self loadContent];
	[self showGlobalAlertView];
	
}

// Bowdoin Servers Down
- (void)noBowdoinConnection{
	
	globalAlertView = [AlertViews noServerAlert];
	
	[self loadContent];
	[self showGlobalAlertView];

}

// No Menus Available - Closed for Semester Break
- (void)noMenusAvailable{
	
	downloadSucceeded = NO;
	localAlertView = [AlertViews closedForSemesterAlert];
	[self loadContent];
		
}

/**
	Creates a Navigation Bar from an Array of Meals
	@param scheduleArray array generated by Schedule Decider
 */
- (void)setNavigationBarsWithArray:(NSMutableArray*)scheduleArray {
    
	
    NavigationBarController *navBarController = [[NavigationBarController alloc] initWithScheduleArray:scheduleArray];
	
    // Establishes the meal bars at the top of the page

	[mealScrollView setContentSize:CGSizeMake(320 * [navBarController.scheduleArray count], 44)];
	
	[mealScrollView setTag:mealScroller];
	[mealScrollView setDelegate:self];
	[mealScrollView setOpaque:NO];
	[mealScrollView setShowsHorizontalScrollIndicator:NO];
	
	mealNavBar = [[MealNavigationBar alloc] initWithArray:scheduleArray];
	
	[mealScrollView addSubview:mealNavBar];
	[mealScrollView setBackgroundColor:[UIColor blackColor]];
	[mealScrollView setPagingEnabled:YES];
    
    
	hallNavBar = [[HallNavigationBar alloc] initWithFrame:CGRectMake(0, 0, 960, 44)];
	hallNavBar.timeToDisplay = [scheduler hoursOfOperationForHall:0 meal:0];

    [hallScrollView setContentSize:CGSizeMake(960, 44)];
	
	[hallScrollView setOpaque:NO];
	
	[hallScrollView setShowsHorizontalScrollIndicator:NO];
	[hallScrollView setTag:hallScroller];
	[hallScrollView setDelegate:self];
	
	[hallScrollView addSubview:hallNavBar];
	[hallScrollView setBackgroundColor:[UIColor whiteColor]];
	[hallScrollView setPagingEnabled:YES];
	
    
}

    #define thorne		0
    #define moulton		1

/**
	Delegate Method activated when ScrollView scrolls
	@param scrollView the message-sending scrollView
 */


// Method for Sending Email with Item
- (void)composeEmail{
	
	NSString *itemTitle = @"Pancakes"; //cell.textLabel.text;
	NSString *mealTitle = @"Breakfast";
	NSString *hallTitle = @"Thorne";
	
	MFMailComposeViewController *controller = [[MFMailComposeViewController alloc] init];
	[controller setSubject:mealTitle];
	controller.mailComposeDelegate = self;
	// code for creating message body
	NSString *messageBody = [NSString stringWithFormat:@"%@ is at %@ for %@", itemTitle, hallTitle, mealTitle];
	
	[controller setMessageBody:messageBody isHTML:NO];
	[self presentModalViewController:controller animated:YES];
	[controller release];
}

- (void)mailComposeController:(MFMailComposeViewController*)controller 
		  didFinishWithResult:(MFMailComposeResult)result 
						error:(NSError*)error {
	
	[self dismissModalViewControllerAnimated:YES];
}

#pragma mark -
#pragma mark Export Options

- (IBAction)displayActionPage{
	
	UIActionSheet *actionSheet = [[UIActionSheet alloc]initWithTitle:@"Export" 
															delegate:self 
												   cancelButtonTitle:@"Dismiss"
											  destructiveButtonTitle:nil
												   otherButtonTitles:@"Export to Email", nil];
	
	[actionSheet showInView:self.view];
	
	
	
}

#pragma mark -
#pragma mark Main Page Navigation

- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item {
	
	if (item.tag == 0) {
		
		LineCountViewController *lines = [[LineCountViewController alloc] init];
		[self.navigationController pushViewController:lines animated:YES];
		[lines release];
		
		
	} else if (item.tag == 1) {
		
		HoursViewController *controller = [[HoursViewController alloc] initWithScheduleDecider:scheduler];
		[self.navigationController pushViewController:controller animated:YES];
		[controller release];	
		
	} else if (item.tag == 2) {
		
		PolarPoints *polarController = [[PolarPoints alloc] init];
		[self.navigationController pushViewController:polarController animated:YES];
		[polarController release];	
		
	}
	
	
}

- (IBAction)launchPhone{
	
	[[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"tel://2077253888"]];
	
	UIDevice *device = [UIDevice currentDevice];
	if (![device.model isEqualToString:@"iPhone"]){
		NSString *title = @"Jack Magee's Grill";
		NSString *message = @"207-725-3888";
		NSString *cancelButtonTitle = @"Dismiss";
		
		UIAlertView *tempPhoneNumberAlert = [[UIAlertView alloc] initWithTitle:(NSString *)title 
																	   message:(NSString *)message 
																	  delegate: self 
															 cancelButtonTitle:(NSString *)cancelButtonTitle
															 otherButtonTitles: NULL];
		
		[tempPhoneNumberAlert show];
		
	}
	
	
}

- (IBAction)launchGrillMenu{
	
	GrillAreaViewController *grill = [[GrillAreaViewController alloc] init];
	[self.navigationController presentModalViewController:grill animated:YES];
	[grill release];
	
	
}

#pragma mark -
#pragma mark - Navigation Bar Operation

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {

	
	// Filters out UITableView Scroll Events which inherits from UIScrollView
	if ([scrollView isKindOfClass:[UITableView class]]) {

		return;
	}
	

	
	// Decides the current page of the Hall scroller.	
	CGFloat hallPageWidth = hallScrollView.frame.size.width;
	int hallPage = floor((hallScrollView.contentOffset.x - hallPageWidth / 2) / hallPageWidth) + 1;

	
	CGFloat mealPageWidth = hallScrollView.frame.size.width;
	int mealPage = floor((mealScrollView.contentOffset.x - mealPageWidth / 2) / mealPageWidth) + 1;
	


	
    // Decides how to animate and when to animate by comparing the currentPage to the page
    // that should come into view.
	
	if ((currentHallPage != hallPage || currentMealPage != mealPage) && hallPage != 2) {
		
        if (navigationBarsAnimatedOut){
            
            [self animateNavigationBars];
			
			
			currentHallPage = hallPage;
            currentMealPage = mealPage;
			
			[customTableView reloadData];

			hallNavBar.timeToDisplay = [scheduler hoursOfOperationForHall:currentHallPage meal:currentMealPage];
			[hallNavBar setNeedsDisplay];
			
            
        } else {
			
			// Flashes TableView
			[UIView beginAnimations:nil context:nil];
			[UIView setAnimationDuration:0.2];
			[UIView setAnimationTransition:UIViewAnimationTransitionNone forView:self.view cache:YES];
			[UIView setAnimationDelegate:self]; 
			[UIView setAnimationDidStopSelector:@selector(tableViewAnimationDone:finished:context:)];
			customTableView.alpha = 0.0;
			[UIView commitAnimations];
			
			
			
			currentHallPage = hallPage;
			currentMealPage = mealPage;
			
			hallNavBar.timeToDisplay = [scheduler hoursOfOperationForHall:currentHallPage meal:currentMealPage];
			[hallNavBar setNeedsDisplay];
			
		}

        
		        
        
	} else if (currentHallPage != hallPage && hallPage == 2){
        
        NSLog(@"Trying to Animate");
        [self animateNavigationBars];
     
		
		currentHallPage = hallPage;
		currentMealPage = mealPage;
			
		[customTableView reloadData];
			
			
		hallNavBar.timeToDisplay = [scheduler hoursOfOperationForHall:currentHallPage meal:currentMealPage];
		[hallNavBar setNeedsDisplay];
		
	}
       
		
}		

- (IBAction)navigateRight:(id)sender {

	
	if ([sender tag] == 1) {
		NSLog(@"Navigate Right Button Activated for Meal");
		[self navigateScrollBarRight:mealScrollView];
	} else {
		NSLog(@"Navigate Right Button Activated for Hall");
		[self navigateScrollBarRight:hallScrollView];
		
	}
	
    
}

- (IBAction)navigateLeft:(id)sender {
	
	if ([sender tag] == 1) {
		NSLog(@"Navigate Left Button Activated for Meal");
		[self navigateScrollBarLeft:mealScrollView];
	} else {
		NSLog(@"Navigate Left Button Activated for Hall");
		[self navigateScrollBarLeft:hallScrollView];
		
	}	
}

- (void)navigateScrollBarRight:(UIScrollView*)scrollView {
		
	NSLog(@"Scrolling Right");

	// Decides the current page of the Hall scroller.	
	CGFloat hallPageCurrentX = scrollView.contentOffset.x;
	CGFloat hallPageTotalWidth = scrollView.contentSize.width;
	
	CGFloat currentPage = hallPageCurrentX / 320.f;
	CGFloat totalPages = hallPageTotalWidth / 320.f;

	// Rounds Down
	int page = currentPage;
	int total = totalPages;
	
	NSLog(@"Current Page = %d", page);
	
	if (page == total - 1) {
		// Do Nothing
	} else {
		
		CGFloat dispatchPage = (page * 320.0) + 320.0;
		[scrollView setContentOffset:CGPointMake(dispatchPage, 0) animated:YES];
		NSLog(@"Dispatching Scroller to : %f", dispatchPage);	
	}
	
}

- (void)navigateScrollBarLeft:(UIScrollView*)scrollView {
	
	NSLog(@"Scrolling Left");
	
	// Decides the current page of the Hall scroller.	
	CGFloat hallPageCurrentX = scrollView.contentOffset.x;
	CGFloat hallPageTotalWidth = scrollView.contentSize.width;

	CGFloat currentPage = hallPageCurrentX / 320.f;
	CGFloat totalPages = hallPageTotalWidth / 320.f;
	
	// Rounds Down
	int page = currentPage;
	
	NSLog(@"Current Page = %d", page);

	
	if (page == 0) {
		// Do Nothing
	} else {
		
		CGFloat dispatchPage = (page * 320.0) - 320.0;
		[scrollView setContentOffset:CGPointMake(dispatchPage, 0) animated:YES];
		NSLog(@"Dispatching Scroller to : %f", dispatchPage);
		
	}
	
}

- (void)animateNavigationBars{
        
	if (animating) {
		return;
	} else {
		animating = YES;
	}
	
	NSLog(@"Animation Method Excecuting");

	
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];
    [UIView setAnimationTransition:UIViewAnimationTransitionNone forView:self.view cache:YES];
    [UIView setAnimationDelegate:self]; 

   
    // Constants for Navigation Bar Animation
    CGFloat mealScrollWidth = mealScrollView.frame.size.width;
    CGFloat mealScrollHeight = mealScrollView.frame.size.height;
    CGFloat mealScrollOriginY = mealScrollView.frame.origin.y;

    
    CGFloat hallScrollWidth = hallScrollView.frame.size.width;
    CGFloat hallScrollHeight = hallScrollView.frame.size.height;


    CGFloat fillerBarWidth = topFillerBar.frame.size.width;
    CGFloat fillerBarHeight = topFillerBar.frame.size.height;
    CGFloat fillerBarOriginY = topFillerBar.frame.origin.y;
    
 //   CGFloat altScrollerHeight = alternateScroller.frame.size.height;
 //   CGFloat altScrollerWidth = alternateScroller.frame.size.width;
    
    
    if (navigationBarsAnimatedOut){
        
		[UIView setAnimationDidStopSelector:@selector(navigationAnimationIn)];

        mealScrollView.frame = CGRectMake(0, 0, mealScrollWidth, mealScrollHeight);
        topFillerBar.frame = CGRectMake(0 , -1, fillerBarWidth, fillerBarHeight);
        hallScrollView.frame = CGRectMake(0 , mealScrollHeight, hallScrollWidth, hallScrollHeight);
               
        
        navigationBarsAnimatedOut = NO;
        [customTableView setAlpha:1.0];

		// Sets Buttons
		[callButton setAlpha:0.0];
		[callText setAlpha:0.0];
		[menuButton setAlpha:0.0];
		[menuText setAlpha:0.0];
		
		
        [dayDeciderBar setAlpha:0.0];
        
        
        
    } else {
        
        [UIView setAnimationDidStopSelector:@selector(navigationAnimationOut)];

        mealScrollView.frame = CGRectMake(0 , mealScrollOriginY-(mealScrollHeight), mealScrollWidth, mealScrollHeight);
        topFillerBar.frame = CGRectMake(0 , fillerBarOriginY-(fillerBarHeight), fillerBarWidth, fillerBarHeight);
        hallScrollView.frame = CGRectMake(0 , mealScrollHeight, hallScrollWidth, hallScrollHeight);
        
        
        navigationBarsAnimatedOut = YES;
        [customTableView setAlpha:1.0];

		[callButton setAlpha:1.0];
		[callText setAlpha:1.0];
		[menuButton setAlpha:1.0];
		[menuText setAlpha:1.0];
		

        
    }
    
    [UIView commitAnimations];
    

}

- (void)navigationAnimationOut{
    
	[callButton setAlpha:1.0];
	[callButton setUserInteractionEnabled:YES];
	
	[callText setAlpha:1.0];
	[menuText setAlpha:1.0];

	[menuButton setAlpha:1.0];
	[menuButton setUserInteractionEnabled:YES];
    NSLog(@"Navigation Done");
	animating = NO;
    
}

- (void)navigationAnimationIn{
 
	
	[callButton setAlpha:0.0];
	[callButton setUserInteractionEnabled:NO];
	
	[callText setAlpha:0.0];
	[menuText setAlpha:0.0];
	
	[menuButton setAlpha:0.0];
	[menuButton setUserInteractionEnabled:NO];
    NSLog(@"Navigation Done");
	animating = NO;

}
		 
- (void)tableViewAnimationDone:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context {
			 
	// reloads the table view		
	[customTableView reloadData];

	
	// animates the tableView back in
	[UIView beginAnimations:nil context:nil];
	[UIView setAnimationDuration:0.2];
	[UIView setAnimationTransition:UIViewAnimationTransitionNone forView:self.view cache:YES];
	[UIView setAnimationDelegate:self]; 
	customTableView.alpha = 1.0;
	[UIView commitAnimations];
			 
			
			 
}

#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
	
	NSInteger *numberOfSections = [scheduler numberOfSectionsForLocation:currentHallPage atMealIndex:currentMealPage];
	
	NSLog(@"Number of Sections Captured == %d", numberOfSections);
	if (numberOfSections == 0 || numberOfSections == 1 || numberOfSections == nil) {
		
		NSLog(@"Showing Local Alert");

		[self showLocalAlertView];
	}
	
	else {
		
		NSLog(@"Hiding Local Alert");

		
		[self hideLocalAlertView];
	}
	
	return numberOfSections;

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	//NSLog(@"Rows = %d", [scheduler sizeOfSection:section forLocation:currentHallPage atMealIndex:currentMealPage] );

	return [scheduler sizeOfSection:section forLocation:currentHallPage atMealIndex:currentMealPage];
	
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
	
    static NSString *CellIdentifier = @"Cell";
    
    CustomTableViewCell *cell = (CustomTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[CustomTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
    }
    
	cell.textLabel.text = [scheduler returnItemFromLocation:currentHallPage atMealIndex:currentMealPage atPath:indexPath];
	
	if (cell.isFavorited == YES) {
		[cell setAccessoryType:UITableViewCellAccessoryCheckmark];;
	}
	
	// Configures whether a cell is bold or not
	if (indexPath.row != 0) {
		[cell.textLabel setFont:[UIFont systemFontOfSize:14.0]];
		cell.textLabel.numberOfLines = 10;
		cell.textLabel.lineBreakMode = UILineBreakModeWordWrap;
		
	} else{
		[cell.textLabel setFont:[UIFont boldSystemFontOfSize:16.0]];
		
	}

    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {

	
	if (section == 0) {
		return 0.0;
	}
	else {
		return 0.0;
	}

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{	
	
	if (indexPath.row == 0) {
		return 40.0;
	}
	else {
		
		return [scheduler returnHeightForCellatLocation:currentHallPage atMealIndex:currentMealPage atPath:indexPath];
	}

}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath	{		
		cell.backgroundColor = [UIColor whiteColor];
		cell.textLabel.backgroundColor = [UIColor clearColor];
		cell.detailTextLabel.backgroundColor = [UIColor clearColor];
	
}
														
#pragma mark -
#pragma mark Table view delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	CustomTableViewCell *cell = (CustomTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
	
	NSString *itemTitle = cell.textLabel.text;
	NSString *canelButtonTitle = @"Dismiss";
	NSString *removeFavoriteButton = @"Remove This Favorite";
	NSString *favoriteThisItem = @"Favorite This Item";
	NSString *shareThisItem = @"Share This Item";
	
	
	// Need to add in support for not selecting the first item of any section
	// so that "Main Course" can't be selected
	
	/*
	if (cell.isFavorited) {

		UIActionSheet *favoriteSheet = [[UIActionSheet alloc] initWithTitle:itemTitle 
																   delegate:self 
														  cancelButtonTitle:canelButtonTitle 
													 destructiveButtonTitle:removeFavoriteButton 
														  otherButtonTitles:shareThisItem, nil];
		[favoriteSheet showInView:self.view];
		

	} else {
				
		UIActionSheet *favoriteSheet = [[UIActionSheet alloc] initWithTitle:itemTitle 
																   delegate:self 
														  cancelButtonTitle:canelButtonTitle 
													 destructiveButtonTitle:nil 
														  otherButtonTitles:favoriteThisItem, shareThisItem, nil];
		[favoriteSheet showInView:self.view];
		
	}

	*/
	
	
	UIActionSheet *favoriteSheet = [[UIActionSheet alloc] initWithTitle:itemTitle 
															   delegate:self 
													  cancelButtonTitle:canelButtonTitle 
												 destructiveButtonTitle:nil 
													  otherButtonTitles:favoriteThisItem, shareThisItem, nil];
	[favoriteSheet showInView:self.view];
	
	
	
	selectedIndexPath = indexPath;

	
}


#pragma mark -
#pragma mark Favorite Control
// Method for registering favorite selection
-(void)actionSheet:(UIActionSheet *)actionSheet willDismissWithButtonIndex:(NSInteger)buttonIndex{
	
	CustomTableViewCell *cell = (CustomTableViewCell *)[customTableView cellForRowAtIndexPath:selectedIndexPath];
	
	// Favoriting Tag
	if (buttonIndex == 0) {
	
		/*
		Create a new instance of the Event entity.
		*/
		FavoriteItem *favorite = (FavoriteItem *)[NSEntityDescription insertNewObjectForEntityForName:@"FavoriteItem" inManagedObjectContext:managedObjectContext];
			
			
		[favorite setItemName:cell.textLabel.text];
			
		// Commit the change.
		NSError *error;
		if (![managedObjectContext save:&error]) {
			// Handle the error.
		}
			
		
	}
		
	else if (buttonIndex == 1) {
		
		
		
	}
	
}
@end

