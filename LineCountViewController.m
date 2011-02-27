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


@synthesize thorne_label, moulton_label, express_label, refreshButton, repeatingTimer, currentTime_label, updatedTime_label;
@synthesize moultonTen_label, moultonThirty_label, thorneTen_label, thorneThirty_label;
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
	currentTime_label.text = [self getUpdatedTimeString];

	
	[self.navigationController setNavigationBarHidden:YES];
	
	NSLog(@"View Controller Created");

	NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(updateClock:) userInfo:nil repeats:YES];
	self.repeatingTimer = timer;
		
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
	
	detailsVisible = NO;
	
	
	
	
	
	// Sets Alpha Levels
	moultonTen_label.alpha = 0.0;
	moultonThirty_label.alpha = 0.0;
	thorneTen_label.alpha = 0.0;
	thorneThirty_label.alpha = 0.0;
	
	/*
	descriptionsLabelOne.alpha = 0.0;
	descriptionsLabelTwo.alpha = 0.0;
	descriptionsLabelThree.alpha = 0.0;
	descriptionsLabelFour.alpha = 0.0;
	
	personOne.alpha = 0.0;
	personTwo.alpha = 0.0;
	personThree.alpha = 0.0;
	personFour.alpha = 0.0;
	*/
	
	NSLog(@"moultonTen_label: %f, %f, %f, %f", moultonTen_label.frame.origin.x, moultonTen_label.frame.origin.y, moultonTen_label.frame.size.width, moultonTen_label.frame.size.height);
	NSLog(@"moultonThirty_label: %f, %f, %f, %f", moultonThirty_label.frame.origin.x, moultonThirty_label.frame.origin.y, moultonThirty_label.frame.size.width, moultonThirty_label.frame.size.height);
	NSLog(@"thorneTen_label: %f, %f, %f, %f", thorneTen_label.frame.origin.x, thorneTen_label.frame.origin.y, thorneTen_label.frame.size.width, thorneTen_label.frame.size.height);
	NSLog(@"thorneThirty_label: %f, %f, %f, %f", thorneThirty_label.frame.origin.x, thorneThirty_label.frame.origin.y, thorneThirty_label.frame.size.width, thorneThirty_label.frame.size.height);
	
	/*
	NSLog(@"descriptionsLabelOne: %f, %f, %f, %f", descriptionsLabelOne.frame.origin.x, descriptionsLabelOne.frame.origin.y, descriptionsLabelOne.frame.size.width, descriptionsLabelOne.frame.size.height);
	NSLog(@"descriptionsLabelTwo: %f, %f, %f, %f", descriptionsLabelTwo.frame.origin.x, descriptionsLabelTwo.frame.origin.y, descriptionsLabelTwo.frame.size.width, descriptionsLabelTwo.frame.size.height);
	NSLog(@"descriptionsLabelThree: %f, %f, %f, %f", descriptionsLabelThree.frame.origin.x, descriptionsLabelThree.frame.origin.y, descriptionsLabelThree.frame.size.width, descriptionsLabelThree.frame.size.height);
	NSLog(@"descriptionsLabelFour: %f, %f, %f, %f", descriptionsLabelFour.frame.origin.x, descriptionsLabelFour.frame.origin.y, descriptionsLabelFour.frame.size.width, descriptionsLabelFour.frame.size.height);
	
	NSLog(@"personOne: %f, %f, %f, %f", personOne.frame.origin.x, personOne.frame.origin.y, personOne.frame.size.width, personOne.frame.size.height);
	NSLog(@"personTwo: %f, %f, %f, %f", personTwo.frame.origin.x, personTwo.frame.origin.y, personTwo.frame.size.width, personTwo.frame.size.height);
	NSLog(@"personThree: %f, %f, %f, %f", personThree.frame.origin.x, personThree.frame.origin.y, personThree.frame.size.width, personThree.frame.size.height);
	NSLog(@"personFour: %f, %f, %f, %f", personFour.frame.origin.x, personFour.frame.origin.y, personFour.frame.size.width, personFour.frame.size.height);
	*/
	
	NSLog(@"moultonButton: %f, %f, %f, %f", moultonButton.frame.origin.x, moultonButton.frame.origin.y, moultonButton.frame.size.width, moultonButton.frame.size.height);
	NSLog(@"thorneButton: %f, %f, %f, %f", thorneButton.frame.origin.x, thorneButton.frame.origin.y, thorneButton.frame.size.width, thorneButton.frame.size.height);

	
	moultonDetails.alpha = 0.0;
	thorneDetails.alpha = 0.0;
	
}

- (void)updateClock:(id)sender {

	currentTime_label.text = [self getUpdatedTimeString];

}

-(NSString*)getUpdatedTimeString{
	
	NSDateFormatter *inputFormatter = [[[NSDateFormatter alloc] init] autorelease];
	[inputFormatter setDateFormat:@"h:mm a"];
	NSDate *toBeFormatted = [[[NSDate alloc] init] autorelease];
	
	NSString *formattedDate = [inputFormatter stringFromDate:toBeFormatted];
		
	return formattedDate;
	
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
	thorneTen_label.text = [NSString stringWithFormat:@"%d", analyzer.thorneTen];
	thorneThirty_label.text = [NSString stringWithFormat:@"%d", analyzer.thorneThirty];

	
	moulton_label.text = [analyzer moultonText];
	moulton_label.textColor = [analyzer moultonColor];
	moultonTen_label.text = [NSString stringWithFormat:@"%d", analyzer.moultonTen];
	moultonThirty_label.text = [NSString stringWithFormat:@"%d", analyzer.moultonThirty];
	
	express_label.text = [analyzer expressText];
	express_label.textColor = [analyzer expressColor];
		
	
	[analyzer release];
	
	
}

-(IBAction)refresh{
	
	[HUD showWhileExecuting:@selector(downloadLineData) onTarget:self withObject:nil animated:YES];	
	
	
}

-(IBAction)toggleDetails{
	
	if (detailsVisible) {

		[UIView beginAnimations:nil context:nil];
		[UIView setAnimationDuration:0.4];
		[UIView setAnimationTransition:UIViewAnimationTransitionNone forView:self.view cache:YES];
		[UIView setAnimationDelegate:self]; 
		
		
		// Sets Alpha Levels
		moultonTen_label.alpha = 0.0;
		moultonThirty_label.alpha = 0.0;
		thorneTen_label.alpha = 0.0;
		thorneThirty_label.alpha = 0.0;
		
		/*
		descriptionsLabelOne.alpha = 0.0;
		descriptionsLabelTwo.alpha = 0.0;
		descriptionsLabelThree.alpha = 0.0;
		descriptionsLabelFour.alpha = 0.0;

		personOne.alpha = 0.0;
		personTwo.alpha = 0.0;
		personThree.alpha = 0.0;
		personFour.alpha = 0.0;
		 */
		
		moultonDetails.alpha = 0.0;
		thorneDetails.alpha = 0.0;
		
		/*
		
		// Adjusts Frames
		moultonTen_label.frame = CGRectMake(moultonTen_label.frame.origin.x, 163, moultonTen_label.frame.size.width, moultonTen_label.frame.size.height);
		moultonThirty_label.frame = CGRectMake(moultonThirty_label.frame.origin.x, 163, moultonThirty_label.frame.size.width, moultonThirty_label.frame.size.height);
		thorneTen_label.frame = CGRectMake(thorneTen_label.frame.origin.x, 269, thorneTen_label.frame.size.width, thorneTen_label.frame.size.height);
		thorneThirty_label.frame = CGRectMake(thorneThirty_label.frame.origin.x, 269, thorneThirty_label.frame.size.width, thorneThirty_label.frame.size.height);
		
		descriptionsLabelOne.frame = CGRectMake(descriptionsLabelOne.frame.origin.x, 163, descriptionsLabelOne.frame.size.width, descriptionsLabelOne.frame.size.height);
		descriptionsLabelTwo.frame = CGRectMake(descriptionsLabelTwo.frame.origin.x, 163, descriptionsLabelTwo.frame.size.width, descriptionsLabelTwo.frame.size.height);
		descriptionsLabelThree.frame = CGRectMake(descriptionsLabelThree.frame.origin.x, 269, descriptionsLabelThree.frame.size.width, descriptionsLabelThree.frame.size.height);
		descriptionsLabelFour.frame = CGRectMake(descriptionsLabelFour.frame.origin.x, 269, descriptionsLabelFour.frame.size.width, descriptionsLabelFour.frame.size.height);
		
		personOne.frame = CGRectMake(personOne.frame.origin.x, 162, personOne.frame.size.width, personOne.frame.size.height);
		personTwo.frame = CGRectMake(personTwo.frame.origin.x, 162, personTwo.frame.size.width, personTwo.frame.size.height);
		personThree.frame = CGRectMake(personThree.frame.origin.x, 268, personThree.frame.size.width, personThree.frame.size.height);
		personFour.frame = CGRectMake(personFour.frame.origin.x, 268, personFour.frame.size.width, personFour.frame.size.height);

		 */
		
		
		moultonDetails.frame = CGRectMake(moultonDetails.frame.origin.x, 148, moultonDetails.frame.size.width, moultonDetails.frame.size.height);
		thorneDetails.frame = CGRectMake(thorneDetails.frame.origin.x, 208, thorneDetails.frame.size.width, thorneDetails.frame.size.height);
		
		
		moultonButton.frame = CGRectMake(moultonButton.frame.origin.x, 148, moultonButton.frame.size.width, 44);
		moulton_name.frame = CGRectMake(moulton_name.frame.origin.x, 148, moulton_name.frame.size.width, moulton_name.frame.size.height);
		moulton_clock.frame = CGRectMake(moulton_clock.frame.origin.x, 156, moulton_clock.frame.size.width, moulton_clock.frame.size.height);
		moulton_label.frame = CGRectMake(moulton_label.frame.origin.x, 148, moulton_label.frame.size.width, moulton_label.frame.size.height);

		
		thorneButton.frame = CGRectMake(thorneButton.frame.origin.x, 208, thorneButton.frame.size.width, 44);
		thorne_name.frame = CGRectMake(thorne_name.frame.origin.x, 208, thorne_name.frame.size.width, thorne_name.frame.size.height);
		thorne_clock.frame = CGRectMake(thorne_clock.frame.origin.x, 216, thorne_clock.frame.size.width, thorne_clock.frame.size.height);
		thorne_label.frame = CGRectMake(thorne_label.frame.origin.x, 208, thorne_label.frame.size.width, thorne_label.frame.size.height);

		
		expressButton.frame = CGRectMake(expressButton.frame.origin.x, 268, expressButton.frame.size.width, 44);
		express_name.frame = CGRectMake(express_name.frame.origin.x, 268, express_name.frame.size.width, express_name.frame.size.height);
		express_clock.frame = CGRectMake(express_clock.frame.origin.x, 276, express_clock.frame.size.width, express_clock.frame.size.height);
		express_label.frame = CGRectMake(express_label.frame.origin.x, 268, express_label.frame.size.width, express_label.frame.size.height);

		
		detailsVisible = NO;
		
		[UIView commitAnimations];

		
	} else {

		[UIView beginAnimations:nil context:nil];
		[UIView setAnimationDuration:0.4];
		[UIView setAnimationTransition:UIViewAnimationTransitionNone forView:self.view cache:YES];
		[UIView setAnimationDelegate:self]; 
		
		// Sets Alpha
		moultonTen_label.alpha = 1.0;
		moultonThirty_label.alpha = 1.0;
		thorneTen_label.alpha = 1.0;
		thorneThirty_label.alpha = 1.0;
		
		
		moultonDetails.alpha = 1.0;
		thorneDetails.alpha = 1.0;
		
		
		moultonDetails.frame = CGRectMake(moultonDetails.frame.origin.x, 148, moultonDetails.frame.size.width, moultonDetails.frame.size.height);
		thorneDetails.frame = CGRectMake(thorneDetails.frame.origin.x, 258, thorneDetails.frame.size.width, thorneDetails.frame.size.height);
		
		moultonButton.frame = CGRectMake(moultonButton.frame.origin.x, 148, moultonButton.frame.size.width, 94);
		moulton_name.frame = CGRectMake(moulton_name.frame.origin.x, 148, moulton_name.frame.size.width, moulton_name.frame.size.height);
		moulton_clock.frame = CGRectMake(moulton_clock.frame.origin.x, 155, moulton_clock.frame.size.width, moulton_clock.frame.size.height);
		moulton_label.frame = CGRectMake(moulton_label.frame.origin.x, 148, moulton_label.frame.size.width, moulton_label.frame.size.height);

		thorneButton.frame = CGRectMake(thorneButton.frame.origin.x, 258, thorneButton.frame.size.width, 94);
		thorne_name.frame = CGRectMake(thorne_name.frame.origin.x, 258, thorne_name.frame.size.width, thorne_name.frame.size.height);
		thorne_clock.frame = CGRectMake(thorne_clock.frame.origin.x, 265, thorne_clock.frame.size.width, thorne_clock.frame.size.height);
		thorne_label.frame = CGRectMake(thorne_label.frame.origin.x, 258, thorne_label.frame.size.width, thorne_label.frame.size.height);

		expressButton.frame = CGRectMake(expressButton.frame.origin.x, 368, expressButton.frame.size.width, 44);
		express_name.frame = CGRectMake(express_name.frame.origin.x, 368, express_name.frame.size.width, express_name.frame.size.height);
		express_clock.frame = CGRectMake(express_clock.frame.origin.x, 378, express_clock.frame.size.width, express_clock.frame.size.height);
		express_label.frame = CGRectMake(express_label.frame.origin.x, 368, express_label.frame.size.width, express_label.frame.size.height);

		
		
		
		detailsVisible = YES;
		
		[UIView commitAnimations];

		
	}


	
}

// Delegate Method for MBProgressHUD
-(void)hudWasHidden{
	
	
	
}

- (IBAction)dismissPage{
	[self.navigationController popViewControllerAnimated:YES];	
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
	[repeatingTimer invalidate];
	self.repeatingTimer = nil; // stops timer
    [super dealloc];
}


@end
