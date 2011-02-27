//
//  LineCountAnalyzer.m
//  DiningTableViewTest
//
//  Created by Ben Johnson on 11/16/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "LineCountAnalyzer.h"
#import "LineCountParser.h"

@interface LineCountAnalyzer (PrivateMethods)

- (int)scoreArray:(NSMutableArray*)array forHall:(int)lineID;
- (UILabel*)returnLabelForScore:(int)score;

@end

@implementation LineCountAnalyzer
@synthesize moultonTen, moultonThirty, thorneTen, thorneThirty;


-(void)analyzeData:(NSData*)data{
	
	LineCountParser *LCParser = [[LineCountParser alloc] init];
	[LCParser parseWithData:data];
	
	
	NSLog(@"Scoring Thorne");
	thorneLabel = [self returnLabelForScore:[self scoreArray:[LCParser returnThorneCounts] forHall:1]];
		
	NSLog(@"Scoring Moulton");
	moultonLabel = [self returnLabelForScore:[self scoreArray:[LCParser returnMoultonCounts] forHall:2]];
	  
	NSLog(@"Scoring Express");
	expressLabel = [self returnLabelForScore:[self scoreArray:[LCParser returnExpressCounts] forHall:3]];
	   
	
	
}

/// GETTER METHODS ////

- (NSString*)thorneText{
	return thorneLabel.text;
}

- (UIColor*)thorneColor{
	return thorneLabel.textColor;
}

- (int)thorneScore{
	return thorneScore;
}

- (NSString*)moultonText{
	return moultonLabel.text;	
}

- (UIColor*)moultonColor{
	return moultonLabel.textColor;	
}

- (int)moultonScore{
	return moultonScore;
}

- (NSString*)expressText{	
	return expressLabel.text;	
}

- (UIColor*)expressColor{	
	return expressLabel.textColor;	
}

- (int)expressScore{
	return expressScore;
}

- (int)total_Patrons{
	return total_Patrons;
}


- (UILabel*)returnLabelForScore:(int)score{
	
	NSLog(@"Creating Label For Score %d", score);
	
	int very_busy_score = 70;
	int busy_score = 40;
	
	
	UILabel *scoreLabel = [[[UILabel alloc] init] autorelease];
	
	if (score >= very_busy_score) {
		scoreLabel.text = @"Long Wait";
		scoreLabel.textColor = [UIColor colorWithRed:1 green:0 blue:0 alpha:1.0];
	} else if (score >= busy_score) {
		scoreLabel.text = @"Medium Wait";
		scoreLabel.textColor = [UIColor colorWithRed:160/255.0 green:146/255.0 blue:46/255.0 alpha:1.0];
	} else {
		scoreLabel.text = @"No Wait";
		scoreLabel.textColor = [UIColor colorWithRed:0 green:128/255.0 blue:0 alpha:1.0];

		// scoreLabel.textColor = [UIColor colorWithRed:0 green:128/255.0 blue:0 alpha:1.0];
	
	}

	
	return scoreLabel;
	
	
}

- (int)scoreArray:(NSMutableArray*)array forHall:(int)lineID{
	
	// Total Array Length
	double j = [array count];
	
	// If no entries, return
	if (j == 0) {
		return 0.0;
	}
	
	// Crowdedness Threshold based on Location
	// Allowable Points assumes crowdedness threshold reached every minute
	
	double crowdedness_threshold;
	double maximum_possible_score;
	
	switch (lineID) {
		case 1: crowdedness_threshold = 20;
			maximum_possible_score = 4.50;
			break;
		
		case 2:
			crowdedness_threshold = 15;
			maximum_possible_score = 4.50;
			break;

		case 3:
			crowdedness_threshold = 5;
			maximum_possible_score = 4.50;
			break;
			
		default:
			crowdedness_threshold = 15;
			maximum_possible_score = 4.50;

			break;
	}
	
	
	
	
	double totalScore = 0;
	
	for (double i = 0; i < j; i++) {
		
		// Last Five Minutes is 1 for 1 points
		if (i >= j-10) {
			
			double currentLineCount = [[array objectAtIndex:i] doubleValue];
			double minute_crowdedness = currentLineCount / crowdedness_threshold;
			double index = i - (j-11.0);
			double scale_multiplier = log10(index);
			double score = minute_crowdedness*scale_multiplier;
			
			
			totalScore = totalScore + score;
			
			
			// Overall Counts
			
			switch (lineID) {
				case 1: thorneTen += currentLineCount;
					thorneThirty += currentLineCount;
					total_Patrons += currentLineCount;
					break;
					
				case 2: moultonTen += currentLineCount;
					moultonThirty += currentLineCount;
					total_Patrons += currentLineCount;
					break;
			}
			
			
			
			
		} else {
					
			double currentLineCount = [[array objectAtIndex:i] doubleValue];
			
			
			// Overall Counts
			
			switch (lineID) {
				case 1:
					thorneThirty += currentLineCount;
					total_Patrons += currentLineCount;
					break;
					
				case 2:;
					moultonThirty += currentLineCount;
					total_Patrons += currentLineCount;
					break;
			}
			
		}

	}
	
	int finalScore = (totalScore / maximum_possible_score) * 100.0;
	
	
	// Set the Score Value
	switch (lineID) {
		case 1: thorneScore = finalScore;
			break;
			
		case 2: moultonScore = finalScore;
			break;
			
		case 3: expressScore = finalScore;
			break;
			
		default:
			break;
	}
	
	

	
	// Returns a value between 0 and 100
	return finalScore;
	
}



@end
