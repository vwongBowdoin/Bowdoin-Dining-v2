//
//  PolarPoints.m
//  DiningTableViewTest
//
//  Created by Ben Johnson on 7/13/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "PolarPoints.h"
#import "CSGoldController.h"
#import "LogInViewController.h"

@implementation PolarPoints


- (void)loadCSGoldDataWithUserName:(NSString *)login password:(NSString*)pass{
	
	// Should detach a thread
	
	CSGoldController *theController = [[CSGoldController alloc]init];	
	[theController getCSGoldDataWithUserName:login password:pass];
	[theController release];

}

- (void)viewDidLoad{
	
	NSLog(@"Points View Did Load");
	
	self.title = @"Polar Points";
	[self registerForNotifications];
	
	
	
	if ([[NSUserDefaults standardUserDefaults] boolForKey:@"LoginStored"]) {
		
		NSString *login = [[NSUserDefaults standardUserDefaults] valueForKey:@"Login"];
		NSString *pass = [[NSUserDefaults standardUserDefaults] valueForKey:@"Password"];
		
		NSLog(@"Updating with Stored Login:%@ and Password:*****", login);
		[self loadCSGoldDataWithUserName:login password:pass];
		
	
	} else {
		
		LogInViewController *loginController = [[LogInViewController alloc] init];
		[self.navigationController presentModalViewController:loginController animated:YES];
		loginController.delegate = self;
		[loginController release];	
		
	}



	
}

- (void)registerForNotifications{
	
	NSLog(@"Registering For Notification");
	
	// Polar Point Authorization
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateVisibleInformation)
												 name:@"CSGold DownloadCompleted" object:nil];
	
	
}

- (void)updateVisibleInformation{
	
	NSLog(@"Updating Visible Information");
	
	mealsRemaining.text = [[NSUserDefaults standardUserDefaults] valueForKey:@"MealsRemaining"];
	polarPoints.text = [[NSUserDefaults standardUserDefaults] valueForKey:@"PolarPointBalance"];
	
	
}

-(IBAction)dismissPage{
	
	[self.navigationController popViewControllerAnimated:self];
	
	
}

- (void)viewWillAppear:(BOOL)animated {
	
	
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
