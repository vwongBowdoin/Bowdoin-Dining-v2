//
//  LineCountViewController.m
//  DiningTableViewTest
//
//  Created by Ben Johnson on 11/16/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "LineCountViewController.h"
#import "CSGoldController.h"
#import "LineCountAnalyzer.h"

@interface LineCountViewController (PrivateMethods)


@end


@implementation LineCountViewController


@synthesize thorne_label, moulton_label, express_label, refreshButton;
// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
/*
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization.
    }
    return self;
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	self.title = @"Line Counts";
	
	[self.navigationController setNavigationBarHidden:YES];
	
	NSLog(@"View Controller Created");

		
	// ** HUD Code by Matej Bukovinski ** //
	
	// Initializes Heads Up Display
	HUD = [[MBProgressHUD alloc] initWithView:self.view];
	
	// Adds HUD to screen
	HUD.delegate = self;
	
	HUD.labelText = @"Loading...";
	[self.view addSubview:HUD];
	
	[HUD showWhileExecuting:@selector(downloadLineData) onTarget:self withObject:nil animated:YES];	
	//[self parseXMLFileAtURL:feedAddress];
	
	
	[thorne_label setNeedsDisplay];
	
}

-(void)downloadLineData{
	
	NSLog(@"Downloading Line Data");

	
	NSString *login = [[NSUserDefaults standardUserDefaults] valueForKey:@"Login"];
	NSString *pass = [[NSUserDefaults standardUserDefaults] valueForKey:@"Password"];
	
	if (login == NULL) {
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Line Counts" message:@"You must store your login and password on the polar point page for this feature to work." delegate:nil cancelButtonTitle:@"Cancel" otherButtonTitles:nil];
		[alert show];
	}
	
	
	CSGoldController *theController = [[CSGoldController alloc]init];	
	NSData *lineData = [theController getCSGoldLineCountsWithUserName:login password:pass];
	[theController release];
	
	stored_data = lineData;
	[self analyzeData:lineData];

	
	
}

- (void)analyzeData:(NSData*)theData{
	
	NSLog(@"Analyze Line Data");

	// Testing Line Count Data
	LineCountAnalyzer *analyzer = [[LineCountAnalyzer alloc] init];
	
	[analyzer analyzeData:theData];
	
	thorne_label.text = [analyzer thorneText];
	thorne_label.textColor = [analyzer thorneColor];
//	thorneCount.text = [NSString stringWithFormat:@"(%d/100)", [analyzer thorneScore]];
	
	
	moulton_label.text = [analyzer moultonText];
	moulton_label.textColor = [analyzer moultonColor];
//	moultonCount.text = [NSString stringWithFormat:@"(%d/100)", [analyzer moultonScore]];

	
	express_label.text = [analyzer expressText];
	express_label.textColor = [analyzer expressColor];
//	expressCount.text = [NSString stringWithFormat:@"(%d/100)", [analyzer expressScore]];
		
//	totalPatrons.text = [NSString stringWithFormat:@"%d", [analyzer total_Patrons]];
	
	[analyzer release];
	
	
}

-(IBAction)refresh{
	
	[HUD showWhileExecuting:@selector(downloadLineData) onTarget:self withObject:nil animated:YES];	
	
	
}

// Delegate Method for MBProgressHUD
-(void)hudWasHidden{
	
	
	
}


- (IBAction)report{
	
	MFMailComposeViewController *controller = [[MFMailComposeViewController alloc] init];
	[controller setToRecipients:[NSArray arrayWithObject:@"ebjohnso@bowdoin.edu"]];
	[controller setSubject:@"Line Count Report"];
	controller.mailComposeDelegate = self;
	
	
	NSString *accuracy_response = [accuracy titleForSegmentAtIndex:accuracy.selectedSegmentIndex];
	NSString *location_response = [location titleForSegmentAtIndex:location.selectedSegmentIndex];
	NSString *line_response = [line titleForSegmentAtIndex:line.selectedSegmentIndex];
	NSString *crowd_response = [crowd titleForSegmentAtIndex:crowd.selectedSegmentIndex];

	
	// code for creating message body
	NSString *messageBody = [NSString stringWithFormat:@"Please check that you have entered report data correctly: \n \n Accurate: %@ \n Location: %@ \n Servine Line: %@ \n Dining Hall Crowd: %@ \n \n Please Enter Other Comments / Inconsistencies Below: " , accuracy_response, location_response, line_response, crowd_response];
	
	
	// creates the generated report
//	NSString *report_string = [NSString stringWithFormat:@"User Rating / Response: \n Accurate: %@ \n Location: %@ \n Servine Line: %@ \n Dining Hall Crowd: %@ \n \n Algorithm Data: \n \n Thorne: %@, %@ \n Moulton: %@, %@ \n Express: %@, %@ \n \n ",accuracy_response, location_response, line_response, crowd_response, thorneCount.text, thorne_label.text, moultonCount.text, moulton_label.text, expressCount.text, express_label.text ];
	//NSData *report_data = [report_string dataUsingEncoding:NSUTF8StringEncoding];
	
	WristWatch *watch = [[WristWatch alloc] init];
	NSString *date_string = [watch getFileNameString];
	[watch release];
	
	
	// creates unique filename for reporting purposes
	NSString *file_name = [NSString stringWithFormat:@"%@-%@-%@", accuracy_response, location_response, date_string];
	
	[controller setMessageBody:messageBody isHTML:NO];
	[controller addAttachmentData:stored_data mimeType:@"xml" fileName:[NSString stringWithFormat:@"%@.xml", file_name]]; // adds the XML Data
//	[controller addAttachmentData:report_data mimeType:@"txt" fileName:[NSString stringWithFormat:@"%@.txt", file_name]]; // adds the TXT report
	
	controller.navigationBar.barStyle = UIBarStyleBlack; // choose your style, unfortunately, Translucent colors behave quirky.
	
	[self presentModalViewController:controller
							animated:YES];
	
	[controller release];
	
	

}





- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error {
	//[self becomeFirstResponder];
	[self dismissModalViewControllerAnimated:YES];
}



/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}


@end
