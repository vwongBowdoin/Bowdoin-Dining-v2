//
//  RootViewController.m
//  The RootViewController directs the entirety of the application. It is the orchestrator of the application
//  DiningTableViewTest
//
//  Created by Ben Johnson on 7/8/10.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import "RootViewController.h"
#import "LogInViewController.h"
#import "PolarPoints.h"
#import "CustomTableViewCell.h"
#import "UICustomTableView.h"
#import "DiningParser.h"
#import "MealDecider.h"
#import "DownloadManager.h"
#import "mealHandler.h"
#import "ScheduleDecider.h"
#import "HoursViewController.h"
#import "NavigationBarController.h"
#import "CSGoldController.h"


@implementation RootViewController

@synthesize customTableView, hallScrollView, mealScrollView, alternateScroller, selectedIndexPath, dayDeciderBar;

#pragma mark -
#pragma mark View lifecycle

// Defining Tags used in Implementation
#define hallScroller 1
#define mealScroller 2

// Responsible for setting up the look of Bowdoin Dining
- (void)viewDidLoad {
    
	
	[super viewDidLoad];
	[self.navigationController setNavigationBarHidden:YES animated: NO];
	self.title = @"Main";
     
	// Table View Initiliazation - sets data source and delegate
	customTableView.delegate = self;
	customTableView.dataSource = self;
	customTableView.separatorColor = [UIColor clearColor];
	
	/* Create Local Helpers */
	
    // Meal Decider decides what meal to display
    MealDecider *mealDecider = [[MealDecider alloc]init];
	localMealDecider = mealDecider;
	//[mealDecider release];
	
	
	[self setupMealData];
       
    // Grill View
    [alternateScroller addSubview:grillView];
    [alternateScroller setContentSize:CGSizeMake(320, 600)];

}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
	[self.navigationController setNavigationBarHidden:YES animated:YES];
}


// Handles Downloading or Processing of Already Downloaded Menus
-(void)setupMealData{
	
	// Register for Notifications regarding Downloading
    [self registerNotifications];
	
	// Initializes the Download Manager to Deal with Meal Data
	DownloadManager *manager = [[DownloadManager alloc] init];
    [manager initializeDownloads];
	

	
}

//Registering Notifications
-(void)registerNotifications{
    
    
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(swipeRight)
												 name:@"TableViewSwipeRight" object:nil];
	[[NSNotificationCenter defaultCenter] addObserver:self
											 selector:@selector(swipeLeft)
												 name:@"TableViewSwipeLeft" object:nil];
	
    // Menu Download Completion
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(downloadCompleted)
												 name:@"Download Completed" object:nil];
	
    
}

-(void)setNavigationBarsWithArray:(NSMutableArray*)scheduleArray{
    
    NavigationBarController *navBarController = [[NavigationBarController alloc] initWithScheduleArray:scheduleArray];

    
    // Establishes the navigation bars at the top of the page
	// Top Scroll Bar for Meals
	[mealScrollView setContentSize:CGSizeMake(1280, 44)];
	[mealScrollView setBackgroundColor:[UIColor clearColor]];
	[mealScrollView setPagingEnabled:YES];
	[mealScrollView setShowsHorizontalScrollIndicator:NO];
	[mealScrollView setTag:mealScroller];
	[mealScrollView setDelegate:self];
    
    
    
    [mealScrollView addSubview:[navBarController returnMealNavigationBar]];
	//[mealScrollView addSubview:mealHeaderView];
    
    
    // Second Scroll Bar for Meals
    [hallScrollView setContentSize:CGSizeMake(960, 44)];
	[hallScrollView setBackgroundColor:[UIColor clearColor]];
	[hallScrollView setPagingEnabled:YES];
	[hallScrollView setShowsHorizontalScrollIndicator:NO];
	[hallScrollView setTag:hallScroller];
	[hallScrollView setDelegate:self];
	[hallScrollView addSubview:hallHeaderView];

    
    
}

// Activated when Menus have Downloaded
-(void)downloadCompleted{
    NSLog(@"Download Completed");
    
    // Initializes the Schedule Decider which determines the array of meals
	// that will be displayed
    
	ScheduleDecider *scheduler = [[ScheduleDecider alloc] init];
	[scheduler processMealArrays];
	
	// Creates a Meal Handler to Populate Dining Menu Data
	// and initializes with Moulton and Thorne Arrays
    mealHandler *handler = [[mealHandler alloc] initWithMoultonArray:[scheduler returnMoultonArray] thorneArray:[scheduler returnThorneArray]];
	todaysMealHandler = handler;
	
	// Creates Arrays
	[todaysMealHandler processArrays];
                
	
    [self setNavigationBarsWithArray:nil]; //[scheduler returnArrayForDiningHalls]];
	
	NSLog(@"Reloading Data for Hall:%d, Meal:%d,", currentHallPage, currentMealPage);
    [customTableView reloadData];
    
}

    #define thorne		0
    #define moulton		1

// Logic for deciding the current Menu to display
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
            NSLog(@"Reloading Data for Hall:%d, Meal:%d,", currentHallPage, currentMealPage);
			[customTableView reloadData];
            
            currentHallPage = hallPage;
            currentMealPage = mealPage;
            return;
            
        }
        
		 [UIView beginAnimations:nil context:nil];
		 [UIView setAnimationDuration:0.2];
		 [UIView setAnimationTransition:UIViewAnimationTransitionNone forView:self.view cache:YES];
		 [UIView setAnimationDelegate:self]; 
		 [UIView setAnimationDidStopSelector:@selector(tableViewAnimationDone:finished:context:)];
		 customTableView.alpha = 0.0;
		 [UIView commitAnimations];
		 
		 
		currentHallPage = hallPage;
		currentMealPage = mealPage;
        
        
	} else if (currentHallPage != hallPage && hallPage == 2){
        
        
        [self animateNavigationBars];
     
        currentHallPage = hallPage;

    }		
	
}

- (void)animateNavigationBars{
        
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
    
    CGFloat altScrollerHeight = alternateScroller.frame.size.height;
    CGFloat altScrollerWidth = alternateScroller.frame.size.width;
    
    
    if (navigationBarsAnimatedOut){
        
        [UIView setAnimationDidStopSelector:@selector(navigationAnimationOut:finished:context:)];

        mealScrollView.frame = CGRectMake(0, 0, mealScrollWidth, mealScrollHeight);
        topFillerBar.frame = CGRectMake(0 , -1, fillerBarWidth, fillerBarHeight);
        hallScrollView.frame = CGRectMake(0 , mealScrollHeight, hallScrollWidth, hallScrollHeight);
        alternateScroller.frame = CGRectMake(0, mealScrollHeight + hallScrollHeight, altScrollerWidth, altScrollerHeight);
               
        
        navigationBarsAnimatedOut = NO;
        [customTableView setAlpha:1.0];
        [alternateScroller setAlpha:0.0];
        [dayDeciderBar setAlpha:0.0];
        
        
        
    } else {
        
        [UIView setAnimationDidStopSelector:@selector(navigationAnimationIn:finished:context:)];

        mealScrollView.frame = CGRectMake(0 , mealScrollOriginY-(mealScrollHeight), mealScrollWidth, mealScrollHeight);
        topFillerBar.frame = CGRectMake(0 , fillerBarOriginY-(fillerBarHeight), fillerBarWidth, fillerBarHeight);
        hallScrollView.frame = CGRectMake(0 , mealScrollHeight, hallScrollWidth, hallScrollHeight);
        alternateScroller.frame = CGRectMake(0, hallScrollHeight + mealScrollHeight, altScrollerWidth, altScrollerHeight);
        
        
        navigationBarsAnimatedOut = YES;
        [customTableView setAlpha:0.0];
        [alternateScroller setAlpha:1.0];
        [dayDeciderBar setAlpha:1.0];

        
    }
    
    [UIView commitAnimations];
    

}

// Method Triggerd at the Stop of an Animation
- (void)navigationAnimationOut{
    
    [customTableView removeFromSuperview];
    [self.view addSubview:dayDeciderView];

    [alternateScroller setAlpha:1.0];
    [alternateScroller setUserInteractionEnabled:YES];
    
}

// Method Triggerd at the Stop of an Animation
-(void)navigationAnimationIn{
    
    [self.view addSubview:customTableView];
    [alternateScroller setUserInteractionEnabled:NO];
    [alternateScroller setAlpha:0.0];
    
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

// Customize the number of sections in the table view.
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return [todaysMealHandler numberOfSectionsForLocation:currentHallPage atMealIndex:currentMealPage];
}


// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return [todaysMealHandler sizeOfSection:section forLocation:currentHallPage atMealIndex:currentMealPage];
	
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
	
    static NSString *CellIdentifier = @"Cell";
    
    CustomTableViewCell *cell = (CustomTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[CustomTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
    }
    
	cell.textLabel.text = [todaysMealHandler returnItemFromLocation:currentHallPage atMealIndex:currentMealPage atPath:indexPath];
	
	if (cell.isFavorited == YES) {
		[cell setAccessoryType:UITableViewCellAccessoryCheckmark];;
	}
	
	// Configures whether a cell is bold or not
	if (indexPath.row != 0) {
		[cell.textLabel setFont:[UIFont systemFontOfSize:14.0]];
		cell.textLabel.numberOfLines = 3;
		cell.textLabel.lineBreakMode = UILineBreakModeWordWrap;
		
	} else {
		[cell.textLabel setFont:[UIFont boldSystemFontOfSize:16.0]];
		
	}

	
    return cell;
}


// Height of Table View Headers
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {

	if (section == 0) {
		return 0.0;
	}
	else {
		return 0.0;
	}

}

// Height of Rows
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{	
	
	if (indexPath.row == 0) {
		return 40.0;
	}
	else {
		
		return [todaysMealHandler returnHeightForCellatLocation:currentHallPage atMealIndex:currentMealPage atPath:indexPath]; //+ (cell.detailTextLabel.numberOfLines - 1) * 19.0;
	}

}


// Method for Setting Background Color
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath	{
		NSLog(@"Trying to Set Background Color");
		
		cell.backgroundColor = [UIColor whiteColor];
		cell.textLabel.backgroundColor = [UIColor clearColor];
		cell.detailTextLabel.backgroundColor = [UIColor clearColor];
}
														

#pragma mark -
#pragma mark Table view delegate
// Displays actions for items
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	CustomTableViewCell *cell = (CustomTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
	
	NSString *itemTitle = cell.textLabel.text;
	NSString *canelButtonTitle = @"Dismiss";
	NSString *removeFavoriteButton = @"Remove This Favorite";
	NSString *favoriteThisItem = @"Favorite This Item";
	NSString *shareThisItem = @"Share This Item";
	
	
	// Need to add in support for not selecting the first item of any section
	// so that "Main Course" can't be selected
	
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

		
	
	selectedIndexPath = indexPath;

	
}


#pragma mark -
#pragma mark Favorite Control
// Method for registering favorite selection
-(void)actionSheet:(UIActionSheet *)actionSheet willDismissWithButtonIndex:(NSInteger)buttonIndex{
	
	CustomTableViewCell *cell = (CustomTableViewCell *)[customTableView cellForRowAtIndexPath:selectedIndexPath];
	
	// Favoriting Tag
	if (buttonIndex == 0) {
		
		
		if (cell.isFavorited) {
			cell.isFavorited = NO;
		} else {
			cell.isFavorited = YES;
		}

		[customTableView reloadData];
		
		
	}
	else if (buttonIndex == 1) {
		
		
		
	}
	
}

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

- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error {
	[self dismissModalViewControllerAnimated:YES];
}

-(IBAction)navigateRight {
    
    NSLog(@"Animating Right");
    [mealScrollView setContentOffset:CGPointMake(320, 0) animated:YES];
    
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

-(IBAction)displayPolarPoints{
	
	PolarPoints *polarController = [[PolarPoints alloc] init];
	[self.navigationController pushViewController:polarController animated:YES];
	[polarController release];	

}


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
    [super dealloc];
}


@end

