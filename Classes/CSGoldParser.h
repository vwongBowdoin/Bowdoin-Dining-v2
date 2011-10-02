//
//  CSGoldParser.h
//  Bowdoin Dining
//
//  Created by Ben Johnson on 9/24/10.
//  Copyright Two Fourteen Software. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface CSGoldParser : NSObject <NSXMLParserDelegate> {

	
	NSXMLParser *theParser;
	NSString *currentElement;
	int currentSVCAccount;
	
	
	NSString *smallBucket;
	NSString *mediumBucket;
	
	

	
	NSError *error;
	
}

@property (nonatomic, retain) NSString *smallBucket;
@property (nonatomic, retain) NSString *mediumBucket;

-(void)parseWithData:(NSData *)data;
-(NSString*)returnFormattedMoneyBalance:(NSString *)inputString;
-(NSString*)returnCombinedBalance;

@end
