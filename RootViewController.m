//
//  RootViewController.m
//  The RootViewController directs the entirety of the application. It is 
//  DiningTableViewTest
//
//  Created by Ben Johnson on 7/8/10.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import "RootViewController.h"
#import "LogInViewController.h"
#import "PolarPoints.h"
#import "SettingsController.h"
#import "CustomTableViewCell.h"
#import "UICustomTableView.h"
#import "DiningParser.h"
#import "MealDecider.h"
#import "DownloadManager.h"
#import "mealHandler.h"

@implementation RootViewController

@synthesize customTableView, hallScrollView, mealScrollView;

#pragma mark -
#pragma mark View lifecycle

// Defining Tags
#define hallScroller 1
#define mealScroller 2

- (void)viewDidLoad {
    [super viewDidLoad];
	[self.navigationController setNavigationBarHidden:YES animated: NO];
	self.title = @"Main";
    
	// Table View Initiliazation
	customTableView.delegate = self;
	customTableView.dataSource = self;
	customTableView.separatorColor = [UIColor clearColor];
	
	// Establishes the navigation bars at the top of the page
	[hallScrollView setContentSize:CGSizeMake(640, 44)];
	[hallScrollView setBackgroundColor:[UIColor clearColor]];
	[hallScrollView setPagingEnabled:YES];
	[hallScrollView setShowsHorizontalScrollIndicator:NO];
	[hallScrollView setTag:hallScroller];
	[hallScrollView setDelegate:self];

	
	[mealScrollView setContentSize:CGSizeMake(1280, 44)];
	[mealScrollView setBackgroundColor:[UIColor clearColor]];
	[mealScrollView setPagingEnabled:YES];
	[mealScrollView setShowsHorizontalScrollIndicator:NO];
	[mealScrollView setTag:mealScroller];
	[mealScrollView setDelegate:self];

	// Call to Set up hallheaderView
	[hallScrollView addSubview:hallHeaderView];
	
	[mealScrollView addSubview:mealHeaderView];
	
	// Initializes the Parser with the Correct Feed
	
	DownloadManager *manager = [[DownloadManager alloc] init];
    
    [manager initializeDownloads];
    
    	
	NSLog(@"initialized parser");

		
	// Initializes pointers to Today's Meal Handler Arrays
	// current
	//NSMutableArray *currentArray;
	
	//Registering Notification for Table View Swipe
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(swipeRight)
												 name:@"TableViewSwipeRight" object:nil];
	[[NSNotificationCenter defaultCenter] addObserver:self
											 selector:@selector(swipeLeft)
												 name:@"TableViewSwipeLeft" object:nil];
	
	//Registering Notification for Polar Point Authorization
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(launchPolarPoints)
												 name:@"Authorization Cleared" object:nil];
	
    //Registering Notification for Download Completion
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(downloadCompleted)
												 name:@"Download Completed" object:nil];

	
    
	
}

-(void)downloadCompleted{
    NSLog(@"Download Completed");
    
    MealDecider *mealDecider = [[MealDecider alloc]init];
    
    mealHandler *MealHandler = [[mealHandler alloc]initArraysFromWeekday:[mealDecider getWeekDay]];
    
    todaysMealHandler = MealHandler;
    
    //[MealHandler release];
    
	currentArray = todaysMealHandler.thorneBreakfast;

    [customTableView reloadData];
    
    
    
}

#define thorne		1
#define moulton		2
#define breakfast	0
#define lunch		1
#define dinner		2
#define brunch		3

// Logic for deciding the current menu to display
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {

	
	if ([scrollView isKindOfClass:[UITableView class]]) {
	
		return;
	}
	
		
	CGFloat hallPageWidth = hallScrollView.frame.size.width;
	int hallPage = floor((hallScrollView.contentOffset.x - hallPageWidth / 2) / hallPageWidth) + 1;

	
	CGFloat mealPageWidth = hallScrollView.frame.size.width;
	int mealPage = floor((mealScrollView.contentOffset.x - mealPageWidth / 2) / mealPageWidth) + 1;
	
	NSLog(@"HALL = %d MEAL = %d", hallPage, mealPage);

	
	// setting currentArray
	if (hallPage == 0){
		switch (mealPage) {
			case breakfast:
				currentArray = todaysMealHandler.thorneBreakfast;
				NSLog(@"Current Array is ThorneBreakfast");
				break;
			case lunch:
				currentArray = todaysMealHandler.thorneLunch;
				NSLog(@"Current Array is Thorne Lunch");
				break;
			case dinner:
				currentArray = todaysMealHandler.thorneDinner;
				NSLog(@"Current Array is Thorne Dinner");

				break;
			case brunch:
				currentArray = todaysMealHandler.thorneBrunch;
				NSLog(@"Current Array is Thorne Brunch");

				break;
			case 5:
				break;
			case 6:
				break;
			case 7:
				break;
			case 8:
				break;
			default:
				break;
		}
		
		
		
	}
	
	else {
		switch (mealPage) {
			case breakfast:
				currentArray = todaysMealHandler.moultonBreakfast;
				NSLog(@"Current Array is Moulton Breakfast");
				break;
			case lunch:
				currentArray = todaysMealHandler.moultonLunch;
				NSLog(@"Current Array is Moulton Lunch");
				break;
			case dinner:
				currentArray = todaysMealHandler.moultonDinner;
				NSLog(@"Current Array is Moulton Dinner");
				break;
			case brunch:
				currentArray = todaysMealHandler.moultonBrunch;
				NSLog(@"Current Array is Moulton Brunch");
				break;
			case 5:
				break;
			case 6:
				break;
			case 7:
				break;
			case 8:
				break;
			default:
				break;
		}
		
	}

	
	if (currentHallPage != hallPage || currentMealPage != mealPage) {
		NSLog(@"Reloading Data while hall page = %d and meal page = %d", hallPage, mealPage);
		
		 [UIView beginAnimations:nil context:nil];
		 [UIView setAnimationDuration:0.2];
		 [UIView setAnimationTransition:UIViewAnimationTransitionNone forView:self.view cache:YES];
		 [UIView setAnimationDelegate:self]; 
		 [UIView setAnimationDidStopSelector:@selector(tableViewAnimationDone:finished:context:)];
		 customTableView.alpha = 0.0;
		 [UIView commitAnimations];
		 
		 
		//[customTableView reloadData];
		currentHallPage = hallPage;
		currentMealPage = mealPage;
	}
		
	
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
		 


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
	[self.navigationController setNavigationBarHidden:YES animated:YES];
}

#pragma mark -
#pragma mark Table view data source



// Customize the number of sections in the table view.
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return [todaysMealHandler numberOfSectionsForArray:currentArray];
}


// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return [todaysMealHandler sizeOfSection:section inArray:currentArray];
	
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
	
    static NSString *CellIdentifier = @"Cell";
    
    CustomTableViewCell *cell = (CustomTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[CustomTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
    }
    
	cell.textLabel.text = [todaysMealHandler returnItem:@"Whatever" atIndex:indexPath inArray:currentArray];
	
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
		
		return [todaysMealHandler returnHeightForCellatIndex:indexPath inArray:currentArray]; //+ (cell.detailTextLabel.numberOfLines - 1) * 19.0;
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	CustomTableViewCell *cell = (CustomTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
	
	NSString *itemTitle = cell.textLabel.text;
	NSString *canelButtonTitle = @"Dismiss";
	NSString *removeFavoriteButton = @"Remove This Favorite";
	NSString *favoriteThisItem = @"Favorite This Item";
	NSString *shareThisItem = @"Share This Item";
	
	
	if (cell.isFavorited) {
		[[NSNotificationCenter defaultCenter] addObserver:self
												 selector:@selector(swipeLeft)
													 name:@"TableViewSwipeLeft" object:nil];
		
		UIActionSheet *favoriteSheet = [[UIActionSheet alloc] initWithTitle:itemTitle 
																   delegate:self 
														  cancelButtonTitle:canelButtonTitle 
													 destructiveButtonTitle:removeFavoriteButton 
														  otherButtonTitles:shareThisItem, nil];
		[favoriteSheet showInView:self.view];
		

	} else {
		[[NSNotificationCenter defaultCenter] addObserver:self
												 selector:@selector(swipeLeft)
													 name:@"TableViewSwipeLeft" object:nil];
		
		UIActionSheet *favoriteSheet = [[UIActionSheet alloc] initWithTitle:itemTitle 
																   delegate:self 
														  cancelButtonTitle:canelButtonTitle 
													 destructiveButtonTitle:nil 
														  otherButtonTitles:favoriteThisItem, shareThisItem, nil];
		[favoriteSheet showInView:self.view];
		
	}

		
	
	selectedIndexPath = indexPath;

	
}

- (void)swipeRight{
	NSLog(@"Trying to Swipe Right");
	
	
}

- (void)swipeLeft{
	NSLog(@"Trying to Swipe Left");
	
}


#pragma mark -
#pragma mark Favorite Controll
// Method for registering favorite selection
-(void)actionSheet:(UIActionSheet *)actionSheet willDismissWithButtonIndex:(NSInteger)buttonIndex{
	
	CustomTableViewCell *cell = (CustomTableViewCell *)[customTableView cellForRowAtIndexPath:selectedIndexPath];
	NSString *itemTitle = cell.textLabel.text;
	NSString *mealTitle = @"Breakfast";
	NSString *hallTitle = @"Thorne";
	
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
	//[self becomeFirstResponder];
	[self dismissModalViewControllerAnimated:YES];
}



-(IBAction)settingsPage {
	
	SettingsController *settingsPage = [[SettingsController alloc] init];
	[self.navigationController pushViewController:settingsPage animated:YES];
	[settingsPage release];
	
	
	
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
	
	// If no password is saved
	LogInViewController *theController = [[LogInViewController alloc] init];
	[self.navigationController presentModalViewController:theController animated:YES];
	
	[theController release];
	
	// Else load polar point page
	
}

-(void)launchPolarPoints {
	
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

