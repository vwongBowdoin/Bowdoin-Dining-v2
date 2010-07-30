//
//  LogInViewController.m
//  DiningTableViewTest
//
//  Created by Ben Johnson on 7/19/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "LogInViewController.h"
#import "PolarPoints.h"

@implementation LogInViewController

-(IBAction)launchPolarPoints{
	
	[self dismissModalViewControllerAnimated:YES];
	
	[[NSNotificationCenter defaultCenter] postNotificationName:@"Authorization Cleared" object:nil];

	
}

-(IBAction)dismissModalController{

	[self dismissModalViewControllerAnimated:YES];
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
