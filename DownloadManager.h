//
//  DownloadManager.h
//  DiningTableViewTest
//
//  Created by Ben Johnson on 7/28/10.
//  Copyright (c) 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RootViewController.h"

@class WristWatch;

@interface DownloadManager : NSObject <MBProgressHUDDelegate> {

	WristWatch *localWatch;
	
	RootViewController *delegate;
}

@property (nonatomic, retain) RootViewController *delegate;

-(void)initializeDownloads;
-(void)errorOccurred;

@end
