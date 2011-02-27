//
//  CSGoldController.m
//  DiningTableViewTest
//
//  Created by Ben Johnson on 9/23/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "CSGoldController.h"
#import "ASIHTTPRequest.h"
#import "ASIDownloadCache.h"
#import "CSGoldParser.h"

@implementation CSGoldController

@synthesize userName, password;

-(id)init{
	
	NSLog(@"CSGoldController Initialized");
	
	return self;
}

- (void)getCSGoldDataWithUserName:(NSString*)user password:(NSString*)pass {
	
	
	if (user.length == 0 || pass.length == 0) {
		user = @"test";
		pass = @"testing";
	} else if (user == NULL || pass == NULL) {
		user = @"test";
		pass = @"testing";
	}
	
	self.userName = user;
	self.password = pass;
	
	

	

	
	NSLog(@"UN: %@ PW: %@", userName, password);
	
	//NSLog(@"CSGoldController Using Login:%@ and Password:*****", userName);

	[self updateAllCSGoldData];

	
	
}


- (NSData*)getCSGoldLineCountsWithUserName:(NSString*)user password:(NSString*)pass {
	
	// Sets the CSGold controllers UserName and Password
	self.userName = user;
	self.password = pass;
	
	
	//NSLog(@"CSGoldController Using Login:%@ and Password:%@", userName, password);
	
	[self createSOAPRequestWithEnvelope:[self returnSoapEnvelopeForService:@"<tem:GetCSGoldLineCountsHistogram/>"]];

	return storedDate;
	

}

- (NSData*)getCSGoldTransactionsWithUserName:(NSString*)user password:(NSString*)pass {
	
	NSLog(@"Getting CSGoldGLTransactions");
	
	// Sets the CSGold controllers UserName and Password
	self.userName = user;
	self.password = pass;
	
	
	//NSLog(@"CSGoldController Using Login:%@ and Password:%@", userName, password);
	
	[self createTransactionSOAPRequestWithEnvelope:[self returnSoapEnvelopeForService:@"<tem:GetCSGoldGLTrans/>"]];
	
	return transactionData;
	
	
}

- (void)updateAllCSGoldData{
	
	[self createSOAPRequestWithEnvelope:[self returnSoapEnvelopeForService:@"<tem:GetCSGoldMPBalances/>"]];
	[self createSOAPRequestWithEnvelope:[self returnSoapEnvelopeForService:@"<tem:GetCSGoldSVCBalances/>"]];
	[self createSOAPRequestWithEnvelope:[self returnSoapEnvelopeForService:@"<tem:GetCSGoldLineCounts/>"]];

	
	[[NSNotificationCenter defaultCenter] postNotificationName:@"CSGold DownloadCompleted" object:nil];

}

/***** CSGold SOAP request/actions *****/
// [soapEnvelope appendString:@"<tem:GetCSGoldGLTrans/>"];
// [soapEnvelope appendString:@"<tem:GetCSGoldSVCBalances/>"]; 
// [soapEnvelope appendString:@"<tem:GetCSGoldLineCounts/>"]; 
// [soapEnvelope appendString:@"<tem:GetCSGoldMPBalances/>"];

// Line Counts
// [soapEnvelope appendString:@"<tem:GetCSGoldLineCountsHistogram/>"]; 


- (NSMutableString*)returnSoapEnvelopeForService:(NSString*)serviceRequested{
	
	NSMutableString *soapEnvelope = [[NSMutableString alloc] initWithString:@""];
	
	[soapEnvelope appendString:@"<?xml version=\"1.0\"?>"];
	[soapEnvelope appendString:@"<soapenv:Envelope xmlns:soapenv=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:tem=\"http://tempuri.org/\">"];
	[soapEnvelope appendString:@"<soapenv:Header/>"];
	[soapEnvelope appendString:@"<soapenv:Body>"];
	[soapEnvelope appendString:serviceRequested];
	[soapEnvelope appendString:@"</soapenv:Body>"];
	[soapEnvelope appendString:@"</soapenv:Envelope>"];
	
	return soapEnvelope;
	
	
}

- (void)createSOAPRequestWithEnvelope:(NSMutableString*)SOAPEnvelope{
	
	
	ASIHTTPRequest *SOAPRequest = [[ASIHTTPRequest alloc]
									initWithURL:[NSURL URLWithString:@"https://owl.bowdoin.edu/ws-csGoldShim/Service.asmx"]];
	
	[SOAPRequest addRequestHeader:@"Content-Type" value:@"text/xml"];	
	[SOAPRequest addRequestHeader:@"Host" value:@"bowdoin.edu"];
    /* ***** values need to be set here ***** */
	
	//NSLog(@"Attaching Username: %@ and password: %@", userName, password);
	
	[SOAPRequest setUsername:self.userName];
	[SOAPRequest setPassword:self.password];
	[SOAPRequest setDomain:@"bowdoincollege"];
	[SOAPRequest setCachePolicy:ASIDoNotReadFromCacheCachePolicy];
	[SOAPRequest setUseSessionPersistence:YES];
	[SOAPRequest setCacheStoragePolicy:ASICacheForSessionDurationCacheStoragePolicy];
	[SOAPRequest setUseCookiePersistence:NO];
	[SOAPRequest setUseKeychainPersistence:NO];
	[SOAPRequest setValidatesSecureCertificate:YES];
	[SOAPRequest setPostBody:(NSMutableData*)[SOAPEnvelope dataUsingEncoding:NSUTF8StringEncoding]];
	[SOAPRequest startSynchronous];
		
	// Makes sure authentication was successful
	if (SOAPRequest.responseStatusCode == 200) {
		
		NSLog(@"Authenticated");
		
		CSGoldParser *parser = [[CSGoldParser alloc] init];
		NSData *responseData = [SOAPRequest responseData];
		NSLog(@"Data: %@", [SOAPRequest responseString]);
		[parser parseWithData:responseData];
		storedDate = responseData;
	//	[responseData release];
		[parser release];
		

	}
	
	NSLog(@"Request used Cached Response %d", [SOAPRequest didUseCachedResponse]);
	
	[SOAPRequest release];
	
}

- (void)createTransactionSOAPRequestWithEnvelope:(NSMutableString*)SOAPEnvelope{
	
	
	ASIHTTPRequest *SOAPRequest = [[ASIHTTPRequest alloc]
								   initWithURL:[NSURL URLWithString:@"https://owl.bowdoin.edu/ws-csGoldShim/Service.asmx"]];
	
	[SOAPRequest addRequestHeader:@"Content-Type" value:@"text/xml"];	
	[SOAPRequest addRequestHeader:@"Host" value:@"bowdoin.edu"];
    /* ***** values need to be set here ***** */
	
	//NSLog(@"Attaching Username: %@ and password: %@", userName, password);
	
	[SOAPRequest setUsername:self.userName];
	[SOAPRequest setPassword:self.password];
	[SOAPRequest setDomain:@"bowdoincollege"];
	[SOAPRequest setCachePolicy:ASIDoNotReadFromCacheCachePolicy];
	[SOAPRequest setUseSessionPersistence:YES];
	[SOAPRequest setCacheStoragePolicy:ASICacheForSessionDurationCacheStoragePolicy];
	[SOAPRequest setUseCookiePersistence:NO];
	[SOAPRequest setUseKeychainPersistence:NO];
	[SOAPRequest setValidatesSecureCertificate:YES];
	[SOAPRequest setPostBody:(NSMutableData*)[SOAPEnvelope dataUsingEncoding:NSUTF8StringEncoding]];
	[SOAPRequest startSynchronous];
	
	// Makes sure authentication was successful
	if (SOAPRequest.responseStatusCode == 200) {
				
		NSData *responseData = [SOAPRequest responseData];
		transactionData = responseData;
		//	[responseData release];
		
	}
	
	NSLog(@"Request used Cached Response? %d", [SOAPRequest didUseCachedResponse]);
	
	[SOAPRequest release];
	
}

- (void)dealloc {
	
	NSLog(@"Deallocating CSGoldController");
//	[lineCountData release];
	self.userName = NULL;
	self.password = NULL;
	[userName release];
	[password release];
    [super dealloc];
}

@end
