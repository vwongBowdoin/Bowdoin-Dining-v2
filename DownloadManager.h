//
//  DownloadManager.h
//  DiningTableViewTest
//
//  Created by Ben Johnson on 7/28/10.
//  Copyright (c) 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
@class MealDecider;

@interface DownloadManager : NSObject {

	MealDecider *localDecider;
	
}

-(void)initializeDownloads;
-(void)errorOccurred;

@end
