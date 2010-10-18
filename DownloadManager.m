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

@implementation DownloadManager


-(void)initializeDownloads {
   
	WristWatch *aTimer = [[WristWatch alloc] init];
	localWatch = aTimer;
	
    // Checks to see if Menus aren't Current
	if ([[NSUserDefaults standardUserDefaults] integerForKey:@"lastUpdatedWeek"] != [localWatch getWeekofYear]){
     
		// Download New Menus
        [NSThread detachNewThreadSelector:@selector(downloadMenus) toTarget:self withObject:nil];
        
    }
    
    // Menus are current
    else if ([[NSUserDefaults standardUserDefaults] integerForKey:@"lastUpdatedWeek"] == [localWatch getWeekofYear]) {
        
		// Post that menus are current
		[[NSNotificationCenter defaultCenter] postNotificationName:@"Download Completed" object:nil];

    }
    
    
}

// Download Menus
-(void) downloadMenus {
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];      
	
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
    for (int i = [localWatch getWeekDay]; i < 8; i++){
        
        
        NSString *dayString = [NSString stringWithFormat:@"%d.xml", i];
        NSString *downloadAddress = [NSString stringWithFormat:@"%@%@/%@", serverPath, sundayString, dayString];
        NSURL *downloadURL = [NSURL URLWithString:downloadAddress];
		
		NSLog(@"Download Address: %@", downloadAddress);
        
		
        // Saving File for Parser - checking for error
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
    
    // once downloaded and no error - set download confirm for day to YES
    [[NSUserDefaults standardUserDefaults] setInteger:[localWatch getWeekofYear] forKey:@"lastUpdatedWeek"];
    
	// alert that menus are parsed and ready
    [[NSNotificationCenter defaultCenter] postNotificationName:@"Download Completed" object:nil];
    
    [pool release];
}


// returns the atreus server path
-(NSString *)atreusSeverPath {
    
    return @"http://www.bowdoin.edu/atreus/lib/xml/";
}


-(void)errorOccurred{
    
    
    // handle the error
}

-(void)dealloc{
	[super dealloc];
	[localWatch release];
	
	
	
}



@end
