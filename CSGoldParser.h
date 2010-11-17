//
//  CSGoldParser.h
//  DiningTableViewTest
//
//  Created by Ben Johnson on 9/24/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface CSGoldParser : NSObject <NSXMLParserDelegate> {

	
	NSXMLParser *theParser;
	NSString *currentElement;
	NSString *currentLineLocation;
	int currentSVCAccount;
	
	
	NSString *smallBucket;
	NSString *mediumBucket;
	
	
	NSMutableArray *thorne_Line_Array;
	NSMutableArray *moulton_Line_Array;
	NSMutableArray *express_Line_Array;
	
	NSError *error;
	
}

@property (nonatomic, retain) NSString *smallBucket;
@property (nonatomic, retain) NSString *mediumBucket;
@property (nonatomic, retain) NSMutableArray *thorne_Line_Array;
@property (nonatomic, retain) NSMutableArray *moulton_Line_Array;
@property (nonatomic, retain) NSMutableArray *express_Line_Array;

-(void)parseWithData:(NSData *)data;
-(NSString*)returnFormattedMoneyBalance:(NSString *)inputString;
-(NSString*)returnCombinedBalance;

@end
