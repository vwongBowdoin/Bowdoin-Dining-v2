//
//  LogInViewController.m
//  Bowdoin Dining
//
//  Created by Ben Johnson on 7/19/10.
//  Copyright Two Fourteen Software. All rights reserved.
//

#import "LogInViewController.h"
#import "PolarPoints.h"

@implementation LogInViewController
@synthesize delegate;


-(void)viewDidLoad{
	
	userNameField.delegate = self;
	passwordField.delegate = self;
	
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
	
	[self launchPolarPoints];
	
	return YES;
}

-(IBAction)launchPolarPoints{
	
	[self dismissModalViewControllerAnimated:YES];
	
	NSString *login = userNameField.text;
	NSString *pass = passwordField.text;
	
	// checks to make sure text is entered in the username field
	if (userNameField.text.length == 0) {
		NSLog(@"No User Name Entered");
	}
	
	
	
	
	if ([saveSwitch isOn]){
		
		[[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"LoginStored"];
		[[NSUserDefaults standardUserDefaults] setValue:login forKey:@"Login"];
		[[NSUserDefaults standardUserDefaults] setValue:pass forKey:@"Password"];
		
		[delegate loadCSGoldDataWithUserName:login password:pass];
		
	} else {
		
		// Destroy Previous Saved Login and set LoginStored to NO
		[[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"LoginStored"];
		[[NSUserDefaults standardUserDefaults] setValue:NULL forKey:@"Login"];
		[[NSUserDefaults standardUserDefaults] setValue:NULL forKey:@"Password"];
		
		NSLog(@"Updating with Non Stored Login: Login = %@", login);

		[delegate loadCSGoldDataWithUserName:login password:pass];
		
	}

	

	
}


-(IBAction)dismissModalController{

	[self dismissModalViewControllerAnimated:YES];
	[delegate dismissPage];
}


- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
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
