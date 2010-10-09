//
//  HoursViewController.m
//  DiningTableViewTest
//
//  Created by Ben Johnson on 8/5/10.
//  Copyright (c) 2010 __MyCompanyName__. All rights reserved.
//

#import "HoursViewController.h"
#import "ScheduleDecider.h"
#import "MealSchedule.h"
#import "UICustomTableView.h"

@implementation HoursViewController

@synthesize hoursScheduler, openNowArray, theTableView;

#pragma mark -
#pragma mark View lifecycle

// Required to initialize Hours View Controller
-(id)initWithScheduleDecider:(ScheduleDecider*)decider{

	localScheduler = decider;
	
	return self;
	
}

- (void)viewDidLoad {
    [super viewDidLoad];

	self.title = @"Dining Hours";
	
	[self.navigationController setNavigationBarHidden:YES animated:YES];

	[localScheduler processArrays];
	theTableView.separatorColor = [UIColor clearColor];
	theTableView.backgroundColor = [UIColor blackColor];
	[theTableView reloadData];
	//[NSThread detachNewThreadSelector:@selector(processDeciderArrays) toTarget:self withObject:nil];
    
    
}

// Begins to Process the Decider's Arrays
- (void)processDeciderArrays{
    
	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];  
	
	
	
	
	
	
	[pool release];
}


/*
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}
*/
/*
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}
*/
/*
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}
*/
/*
- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
}
*/
/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/


#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    //return [localScheduler returnNumberOfSectionsInOH];
	
	return 3;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    //return [localScheduler returnNumberOfRowsInOH:section];
	return [localScheduler returnNumberOfRowsInAH:section];

}
/*
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
	
	return [localScheduler returnOHSectionTitleForSection:section];
}

 */

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
	
	return 30.0;
}


- (UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section { 
	UIView* customView = [[[UIView alloc]initWithFrame:CGRectMake(10.0, 0.0, 300.0, 44.0)]autorelease];
	customView.backgroundColor = [UIColor blackColor];
	
	UILabel * headerLabel = [[[UILabel alloc] initWithFrame:CGRectZero] autorelease];
	headerLabel.backgroundColor = [UIColor clearColor];
	headerLabel.textColor = [UIColor whiteColor];
	headerLabel.font = [UIFont boldSystemFontOfSize:18];
	headerLabel.frame = CGRectMake(20, -5.0, 300.0, 44.0);
	headerLabel.textAlignment = UITextAlignmentLeft;
	headerLabel.text = [localScheduler returnOHSectionTitleForSection:section];	
	
	[customView addSubview:headerLabel];

	return customView;
	
}

// Height of Rows
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{	
	
	return 30.0;

}




// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier] autorelease];
    }
    
   // cell.textLabel.text = @"Test";
        
//    cell.textLabel.text = [[localScheduler returnOHDictionaryAtIndex:indexPath] objectForKey:@"meal"];
//    cell.detailTextLabel.text = [[localScheduler returnOHDictionaryAtIndex:indexPath] objectForKey:@"hours"];		

	cell.textLabel.text = [[localScheduler returnAHDictionaryAtIndex:indexPath] objectForKey:@"meal"];
    [cell.textLabel setFont:[UIFont systemFontOfSize:16.0]]; 
	
	cell.detailTextLabel.text = [[localScheduler returnAHDictionaryAtIndex:indexPath] objectForKey:@"fullhours"];	
	[cell.detailTextLabel setTextColor:[UIColor blackColor]];

	
    return cell;
}



#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

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

