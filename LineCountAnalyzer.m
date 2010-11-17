//
//  LineCountAnalyzer.m
//  DiningTableViewTest
//
//  Created by Ben Johnson on 11/16/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "LineCountAnalyzer.h"
#import "LineCountParser.h"

@implementation LineCountAnalyzer

-(void)analyzeData:(NSData*)data{
	
	LineCountParser *LCParser = [[LineCountParser alloc] init];
	[LCParser parseWithData:data];
	
	
	NSLog(@"Scoring Thorne");
	[self scoreArray:[LCParser returnThorneCounts]];
	
	NSLog(@"Scoring Moulton");
	[self scoreArray:[LCParser returnMoultonCounts]];
	  
	NSLog(@"Scoring Express");
	[self scoreArray:[LCParser returnExpressCounts]];
	   
	   
	
	
}

- (void)scoreArray:(NSMutableArray*)array{
	
	double j = [array count];
	
	double totalScore = 0;
	for (double i = 0; i < j; i++) {
		
		// Last Five Minutes is 1 for 1 points
		if (i >= j-5) {
			
			double currentLineCount = [[array objectAtIndex:i] doubleValue];

			totalScore = totalScore + currentLineCount;
			
			
		} else {
			double squaredIndex = pow(i+1, 2);
			double squaredTotal = pow(j-4, 2);
			
			double multiplier = squaredIndex / squaredTotal;
			
			double currentLineCount = [[array objectAtIndex:i] doubleValue];
			double score = currentLineCount*multiplier;
			
			
			NSLog(@"Index: %f, Count: %f, Multiplier: %f, Score: %f", i, currentLineCount, multiplier, score);
			totalScore = totalScore + score;
		}

	}
	
	
	
	
	
	
	NSLog(@"Score of Array = %f", totalScore);
	
}



@end
