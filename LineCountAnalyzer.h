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
	
	int moultonTen;
	int moultonThirty;
	int thorneTen;
	int thorneThirty;
	
	int total_Patrons;
	
}

@property (nonatomic, assign) int moultonTen;
@property (nonatomic, assign) int moultonThirty;
@property (nonatomic, assign) int thorneTen;
@property (nonatomic, assign) int thorneThirty;

- (NSString*)thorneText;
- (UIColor*)thorneColor;
- (int)thorneScore;

- (NSString*)moultonText;
- (UIColor*)moultonColor;
- (int)moultonScore;

- (NSString*)expressText;
- (UIColor*)expressColor;
- (int)expressScore;

- (int)total_Patrons;

-(void)analyzeData:(NSData*)data;

@end
