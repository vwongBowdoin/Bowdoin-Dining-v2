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
		[[NSNotificationCenter defaultCenter] postNotificationName:@"Download Completed" object:nil];

	} else {

		MBProgressHUD *HUD = [[MBProgressHUD alloc] initWithView:delegate.view];
		
		// Adds HUD to screen
		HUD.delegate = self;
		HUD.labelText = @"Downloading:";
		HUD.detailsLabelText = @"Updating Menus...";
		[delegate.view addSubview:HUD];
		
		[HUD showWhileExecuting:@selector(downloadMenus) onTarget:self withObject:nil animated:YES];  
		
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
			NSLog(@"Download Completed For Day = %d", i);
			[[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"downloadSuccessful"];
			[[NSNotificationCenter defaultCenter] postNotificationName:@"Download Completed" object:nil];
		}
        
        NSString *dayString = [NSString stringWithFormat:@"%d.xml", i];
        NSString *downloadAddress = [NSString stringWithFormat:@"%@%@/%@", serverPath, sundayString, dayString];
        NSURL *downloadURL = [NSURL URLWithString:downloadAddress];
		
		NSLog(@"Download Address: %@", downloadAddress);
        
		
        // Saving File for Parser - checking for errorq
		NSError *error = nil;
        NSData *xmlFile = [NSData dataWithContentsOfURL:downloadURL options:0 error:&error];
        
        if (error != NULL) {
            [self errorOccurred];
            return;
        }
        
        // Parse XML from downloaded Data
		NSLog(@"Initializing parser with Day %d", i);
        [todaysParser parseXMLData:xmlFile forDay:i];
	
    }
    
	NSLog(@"Jumping out of DownloadManager.m -downloadMenus");
    // once downloaded and no error - set download confirm for day to YES
	[[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"downloadSuccessful"];
    [[NSUserDefaults standardUserDefaults] setInteger:[localWatch getWeekofYear] forKey:@"lastUpdatedWeek"];
	
}

// returns the atreus server path
- (NSString *)atreusSeverPath {
    return @"http://www.bowdoin.edu/atreus/lib/xml/";
}

- (void)errorOccurred{
    NSLog(@"Downloading Error - DownloadMananger.m");
	[[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"downloadSuccessful"];
	[[NSNotificationCenter defaultCenter] postNotificationName:@"Download Completed" object:nil];
	
}

- (void)dealloc{
	
	NSLog(@"Releasing DownloadManager.m");
	[localWatch release];
	[super dealloc];	
	
	
}



@end
