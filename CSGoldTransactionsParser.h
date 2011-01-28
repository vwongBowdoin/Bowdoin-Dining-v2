//
//  CSGoldTransactionsParser.h
//  DiningTableViewTest
//
//  Created by Ben Johnson on 10/8/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RecentTransactions.h"

@interface CSGoldTransactionsParser : NSObject <NSXMLParserDelegate> {

	NSXMLParser *theParser;
	NSString *currentElement;
	int currentSVCAccount;
	
	RecentTransactions *delegate;
	

	
	NSMutableArray *transactionsArray;
	NSMutableDictionary *transactionsDict;
	
}

@property (nonatomic, retain) RecentTransactions *delegate;


- (void)arrayFromData:(NSData *)data;
-(NSString*)returnFormattedMoneyBalance:(NSString *)inputString;


@end
