//
//  PolarPoints.m
//  DiningTableViewTest
//
//  Created by Ben Johnson on 7/13/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "PolarPoints.h"


@implementation PolarPoints

- (void)viewDidLoad{
	
	//self.title = @"Polar Points";
	
	
	
	
}

-(IBAction)dismissPage{
	
	[self.navigationController popViewControllerAnimated:self];
	
	
}

- (void)viewWillAppear:(BOOL)animated {

	//[self.navigationController setNavigationBarHidden:NO animated: YES];
	
	
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
