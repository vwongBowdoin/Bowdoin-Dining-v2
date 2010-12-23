//
//  DownloadManager.m
//  DiningTableViewTest
//
//  Created by Ben Johnson on 7/28/10.
//  Copyright (c) 2010 __MyCompanyName__. All rights reserved.
//

#import "DownloadManager.h"
#import "WristWatch.h"
#import "Constants.h"
#import "DiningParser.h"
#import "MBProgressHUD.h"
#import "GrillParser.h"

@implementation DownloadManager

@synthesize delegate;

- (void)initializeDownloads {
   
	WristWatch *aTimer = [[WristWatch alloc] init];
	localWatch = aTimer;

	//Check to see if there is a need to download specials
	[self downloadSpecials];
	
	
	if ([self menusAreCurrent]) {
		[[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"downloadSuccessful"];
		[[NSNotificationCenter defaultCenter] postNotificationName:@"Download Completed" object:nil];
		NSLog(@"Menus Are Current: \n-- downloadSuccessful set to YES \n-- Notification Posted");


	} else {

		MBProgressHUD *HUD = [[MBProgressHUD alloc] initWithView:delegate.view];
		
		// Adds HUD to screen
		HUD.delegate = self;
		HUD.labelText = @"Downloading:";
		HUD.detailsLabelText = @"Updating Menus...";
		
		HUD_local = HUD;
		[delegate.view addSubview:HUD_local];
		
		
		[HUD_local showWhileExecuting:@selector(downloadMenus) onTarget:self withObject:nil animated:YES];  
		
		[HUD release];
	}    
}

// Checks to see if Menus are current
- (BOOL)menusAreCurrent{
	
	if ([[NSUserDefaults standardUserDefaults] integerForKey:@"lastUpdatedWeek"] != [localWatch getWeekofYear]){
		return NO;
    }
	else {        
		return YES;
    }
	
}

- (void)downloadSpecials{
	
	NSString *downloadAddress = @"http://www.bowdoin.edu/atreus/diningspecials/admin/lib/xml/specials.xml";
	NSURL *downloadURL = [NSURL URLWithString:downloadAddress];
	NSError *error = nil;
	NSData *specialsXML = [NSData dataWithContentsOfURL:downloadURL options:0 error:&error];
	
	GrillParser *grillParser = [[GrillParser alloc] init];
	[grillParser parseSpecialsFromData:specialsXML];
	
	
}

// Download Menus
- (void) downloadMenus {
	
	// ** EASTER EGG ** 
	//if April Fools Day - load fakeXML File
	
	
    ////NSString *fakeXMLPath = [[NSBundle mainBundle] pathForResource:@"fakeXMLDoc" ofType:@"xml"];
    ////NSData *xmlFile = [NSData dataWithContentsOfFile:fakeXMLPath];
	
    
    // Parse XML from downloaded Data
	//  DiningParser *todaysParser = [[DiningParser alloc]init];
	//  [todaysParser parseXMLData:xmlFile forDay:[localWatch getWeekDay]];
	

	// Establishes Server Paths for Parsing Correct Files
    NSString *serverPath = [localWatch atreusSeverPath];
    NSString *sundayString = [localWatch sundayDateString];
    
	// Initializes Dining Parser
	DiningParser *todaysParser = [[DiningParser alloc]init];
	
	int startingDay = [localWatch getWeekDay];
	
    for (int i = startingDay; i < 8; i++){
        
		if (i == startingDay + 2) {
			[HUD_local hideUsingAnimation:YES];
			[[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"downloadSuccessful"];
			[[NSNotificationCenter defaultCenter] postNotificationName:@"Download Completed" object:nil];
			NSLog(@"Downloading Partially Completed: \n-- downloadSuccessful set to YES \n-- Notification Posted");

		}
        
        NSString *dayString = [NSString stringWithFormat:@"%d.xml", i];
        NSString *downloadAddress = [NSString stringWithFormat:@"%@%@/%@", serverPath, sundayString, dayString];
        NSURL *downloadURL = [NSURL URLWithString:downloadAddress];
		        
		
        // Saving File for Parser - checking for errorq
		NSError *error = nil;
        NSData *xmlFile = [NSData dataWithContentsOfURL:downloadURL options:0 error:&error];
        
        if (error != NULL) {
            [self errorOccurred:&error];
            return;
        }
        
        // Parse XML from downloaded Data
        [todaysParser parseXMLData:xmlFile forDay:i];
	
    }
    
    // once downloaded and no error - set download confirm for day to YES
	[[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"downloadSuccessful"];
    [[NSUserDefaults standardUserDefaults] setInteger:[localWatch getWeekofYear] forKey:@"lastUpdatedWeek"];
	
	NSLog(@"Downloading Fully Completed: \n-- downloadSuccessful set to YES \n-- lastUpdatedWeek set to %d", [localWatch getWeekofYear]);


}

// returns the atreus server path
- (NSString *)atreusSeverPath {
    return @"http://www.bowdoin.edu/atreus/lib/xml/";
}

- (void)errorOccurred:(NSError *)theErrorMessage{
	NSLog(@"Error Message Below");
	NSLog(@"** Error Message = %@", [theErrorMessage localizedDescription]);
	NSLog(@"** Downloading Error: \n-- downloadSuccessful set to NO \n-- Download Completed Notification Posted");
	
	[[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"downloadSuccessful"];
	[[NSNotificationCenter defaultCenter] postNotificationName:@"Download Completed" object:nil];
	
	
}

- (void)dealloc{
	
	[localWatch release];
	[super dealloc];	
	
	
}



@end
