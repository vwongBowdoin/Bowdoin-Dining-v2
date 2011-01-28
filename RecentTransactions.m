//
//  RecentTransactions.m
//  DiningTableViewTest
//
//  Created by Ben Johnson on 10/8/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "RecentTransactions.h"
#import "CSGoldTransactionsParser.h"
#import "TransactionCell.h"

@implementation RecentTransactions
@synthesize transactions;

#pragma mark -
#pragma mark View lifecycle

-(id)initWithUserName:(NSString*)user andPassword:(NSString*)pass{
	
	
	userName = user;
	password = pass;
	
	
	
	return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
	
	// Polar Point Authorization
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateInformation)
												 name:@"CSGold Recent Transactions Completed" object:nil];
	
	// ** HUD Code by Matej Bukovinski ** //
	
	// Initializes Heads Up Display
	HUD = [[MBProgressHUD alloc] initWithView:self.view];
	
	// Adds HUD to screen
	HUD.delegate = self;
	
	HUD.labelText = @"Downloading";
	HUD.detailsLabelText = @"Transactions...";
	
	[self.view addSubview:HUD];
	
	[HUD showWhileExecuting:@selector(beginCSGoldTransactionDownload) onTarget:self withObject:nil animated:YES];	
	
	
}

- (void)beginCSGoldTransactionDownload{
	
	
	NSString *login = userName;
	NSString *pass = password;
	
	if (login == NULL) {
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Recent Transactions" message:@"You must store your login and password on the polar point page for this feature to work." delegate:nil cancelButtonTitle:@"Cancel" otherButtonTitles:nil];
		[alert show];
	}
	
	CSGoldController *theController = [[CSGoldController alloc]init];	
	session_Controller = theController;
	NSData *downloaded_data = [session_Controller getCSGoldTransactionsWithUserName:login password:pass];
	
	NSLog(@"Downloaded Data: %@", downloaded_data);
	
	CSGoldTransactionsParser *parser = [[CSGoldTransactionsParser alloc] init];
	parser.delegate = self;
	[parser arrayFromData:downloaded_data];
		
}

- (void)updateInformation{
	
	[tableView reloadData];
	
	
}

- (IBAction)backButtonSelected{
	
	[self.navigationController popViewControllerAnimated:YES];
	
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
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [transactions count];;
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"TransactionCell";
	
	TransactionCell *cell = (TransactionCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	
	if (cell == nil){
		NSLog(@"New Cell Made");
		
		NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"TransactionCell" owner:nil options:nil];
		
		for(id currentObject in topLevelObjects)
		{
			if([currentObject isKindOfClass:[TransactionCell class]])
			{
				cell = (TransactionCell *)currentObject;
				break;
			}
		}
	}
	
	
	NSString *location = [[transactions objectAtIndex:indexPath.row] objectForKey:@"LONGDES"];
	NSString *date = [[transactions objectAtIndex:indexPath.row] objectForKey:@"TRANDATE"];
	NSString *amount = [[transactions objectAtIndex:indexPath.row] objectForKey:@"APPRVALUEOFTRAN"];
	NSString *balance = [[transactions objectAtIndex:indexPath.row] objectForKey:@"BALVALUEAFTERTRAN"];

	cell.location.text = location;
	cell.date.text =  date;
    cell.amount.text = amount;
	cell.balance.text = balance;
	
	if ([[amount substringToIndex:1] isEqualToString:@"-"]) {
	} else {
		cell.amount.textColor = [UIColor colorWithRed:0 green:128/255.0 blue:0 alpha:1.0];

	}

	
    // Configure the cell...
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
	
	return 80;
	
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/


/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/


/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/


/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Navigation logic may go here. Create and push another view controller.
	/*
	 <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
	 [self.navigationController pushViewController:detailViewController animated:YES];
	 [detailViewController release];
	 */
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

