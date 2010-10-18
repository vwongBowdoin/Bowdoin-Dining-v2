//
//  CSGoldTransactionsParser.h
//  DiningTableViewTest
//
//  Created by Ben Johnson on 10/8/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface CSGoldTransactionsParser : NSObject <NSXMLParserDelegate> {

	NSXMLParser *theParser;
	NSString *currentElement;
	int currentSVCAccount;
	

	
	NSMutableArray *transactionsArray;
	NSMutableDictionary *transactionsDict;
	
}


- (void)parseWithData:(NSData *)data;
-(NSString*)returnFormattedMoneyBalance:(NSString *)inputString;


@end
