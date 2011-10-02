//
//  DownloadManager.h
//  Bowdoin Dining
//
//  Created by Ben Johnson on 7/28/10.
//  Copyright (c) 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RootViewController.h"

@class WristWatch;

/**
 * The Download Manager is responsible for overseeing the download of all
 * external files to the application.
 */

@interface DownloadManager : NSObject <MBProgressHUDDelegate> {

	/**
	 * The local timer.
	 */
	WristWatch *localWatch;
	
	
	/**
	 * DownloadManager Delegate - a RootViewController.
	 */ 
	RootViewController *delegate;
	
	
	MBProgressHUD *HUD_local;
	
	
	BOOL appleConnected;
	BOOL bowdoinConnected;
}

@property (nonatomic, retain) RootViewController *delegate;

-(void)initializeDownloads;
-(void)downloadSpecials;
-(BOOL)menusAreCurrent;

@end
