//
//  LineCountAnalyzer.h
//  DiningTableViewTest
//
//  Created by Ben Johnson on 11/16/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface LineCountAnalyzer : NSObject {

	UILabel *thorneLabel;
	UILabel *moultonLabel;
	UILabel *expressLabel;
	
	
	int thorneScore;
	int moultonScore;
	int expressScore;
	
	int total_Patrons;
	
}

@property (nonatomic) int total_Patrons;



@end
