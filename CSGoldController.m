//
//  CSGoldController.m
//  DiningTableViewTest
//
//  Created by Ben Johnson on 9/23/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "CSGoldController.h"
#import "ASIHTTPRequest.h"
#import "CSGoldParser.h"

@implementation CSGoldController


- (void)getCSGoldDataWithUserName:(NSString*)user password:(NSString*)pass {
	
	// Sets the CSGold controllers UserName and Password
	userName = user;
	password = pass;
	
	
	NSLog(@"CSGoldController Using Login:%@ and Password:*****", userName);

	[self updateAllCSGoldData];

	
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
	
	
	ASIHTTPRequest *SOAPRequest = [[[ASIHTTPRequest alloc]
									initWithURL:[NSURL URLWithString:@"https://owl.bowdoin.edu/ws-csGoldShim/Service.asmx"]] autorelease];
	
	[SOAPRequest addRequestHeader:@"Content-Type" value:@"text/xml"];	
	[SOAPRequest addRequestHeader:@"Host" value:@"bowdoin.edu"];
    /* ***** values need to be set here ***** */
	[SOAPRequest setUsername:userName];
	[SOAPRequest setPassword:password];
	[SOAPRequest setDomain:@"bowdoincollege"];
	
	[SOAPRequest setUseSessionPersistence:NO];
	[SOAPRequest setValidatesSecureCertificate:YES];
	[SOAPRequest setPostBody:(NSMutableData*)[SOAPEnvelope dataUsingEncoding:NSUTF8StringEncoding]];
	[SOAPRequest startSynchronous];
		
	// Makes sure authentication was successful
	if (SOAPRequest.responseStatusCode == 200) {
		
		CSGoldParser *parser = [[CSGoldParser alloc] init];
		[parser parseWithData:[SOAPRequest responseData]];
		[parser release];
		

	}

	//[SOAPRequest clearSession];

	
}

- (void)dealloc {
    [super dealloc];
}

@end
