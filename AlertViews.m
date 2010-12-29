//
//  AlertViews.m
//  DiningTableViewTest
//
//  Created by Ben Johnson on 12/23/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "AlertViews.h"
#import <QuartzCore/QuartzCore.h>

@interface AlertViews (PrivateMethods)

+ (UIView*)smallAlertWithText:(NSString*)title subtitle:(NSString*)subtitle;
+ (UIView*)largeAlertWithText:(NSString*)title subtitle:(NSString*)subtitle;


@end



@implementation AlertViews

+ (UIView*)noMealAlert{
	
	NSString *title = @"No Menu";
	NSString *subtitle = @"This meal is closed or \n no menu was found";
	
	return [self smallAlertWithText:title subtitle:subtitle];
	
}

+ (UIView *)closedForSemesterAlert {
	
	
	NSString *title = @"No Menu";
	NSString *subtitle = @"Dining Halls are closed for Semester Break";
	
	return [self smallAlertWithText:title subtitle:subtitle];
		
}


+ (UIView *)noInternetAlert {
		
	NSString *title =@"No Connection";
	NSString *subtitle = @"The menus on your device are out of date and need to update. \n\nHowever, your device does not appear to be connected to the internet. Make sure your device is connected, then: ";
	
	return [self largeAlertWithText:title subtitle:subtitle];
	
}

+ (UIView *)noServerAlert {
	
	NSString *title =@"Server Error";
	NSString *subtitle = @"The menus on your device are out of date and need to update. \n\nHowever, the Bowdoin Dining servers are not responding. Press refresh if you'd like to try to download the menus again: ";
	
	
	return [self largeAlertWithText:title subtitle:subtitle];
	
}

+ (UIView*)smallAlertWithText:(NSString*)title subtitle:(NSString*)subtitle{
	
	UIView *smallAlertView = [[UIView alloc] initWithFrame:CGRectMake(60, 165, 200, 130)];
	smallAlertView.layer.cornerRadius = 10.0;
	smallAlertView.backgroundColor = [UIColor blackColor];
	
	smallAlertView.alpha = 0.0;	
	
	NSString *alertTitle = title;
	NSString *alertSubTitle = subtitle;
	
	
	UILabel *alertText_Title = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 80)];
	alertText_Title.textAlignment = UITextAlignmentCenter;
	alertText_Title.text = alertTitle;
	alertText_Title.font = [UIFont boldSystemFontOfSize:20.0];
	alertText_Title.textColor = [UIColor whiteColor];
	alertText_Title.backgroundColor = [UIColor clearColor];
	
	
	UILabel *alertText_Subtitile = [[UILabel alloc] initWithFrame:CGRectMake(0, 30, 200, 100)];
	alertText_Subtitile.textAlignment = UITextAlignmentCenter;
	alertText_Subtitile.text = alertSubTitle;
	alertText_Subtitile.numberOfLines = 2;
	alertText_Subtitile.font = [UIFont systemFontOfSize:16.0];
	alertText_Subtitile.textColor = [UIColor whiteColor];
	alertText_Subtitile.backgroundColor = [UIColor clearColor];
	
	[smallAlertView addSubview:alertText_Title];
	[smallAlertView addSubview:alertText_Subtitile];
	
	
	return smallAlertView;
	
	
}

+ (UIView*)largeAlertWithText:(NSString*)title subtitle:(NSString*)subtitle{
	
	UIView *largeAlertView = [[UIView alloc] initWithFrame:CGRectMake(40, 125, 240, 230)];
	largeAlertView.layer.cornerRadius = 10.0;
	largeAlertView.backgroundColor = [UIColor blackColor];
	
	NSString *alertTitle = title;
	NSString *alertSubTitle = subtitle;
	
	
	UIButton *refreshButton = [UIButton buttonWithType:UIButtonTypeCustom];
	[refreshButton setFrame:CGRectMake(0, 195,240, 30)];
	[refreshButton setTitle:@"Refresh" forState:UIControlStateNormal];
	[refreshButton.titleLabel setFont:[UIFont boldSystemFontOfSize:18.0]];
	[refreshButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
	[refreshButton setShowsTouchWhenHighlighted:YES];

	[largeAlertView addSubview:refreshButton];		
	
	
	
	UILabel *alertText_Title = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 240, 50)];
	alertText_Title.textAlignment = UITextAlignmentCenter;
	alertText_Title.text = alertTitle;
	alertText_Title.font = [UIFont boldSystemFontOfSize:20.0];
	alertText_Title.textColor = [UIColor whiteColor];
	alertText_Title.backgroundColor = [UIColor clearColor];
	
	
	UILabel *alertText_Subtitile = [[UILabel alloc] initWithFrame:CGRectMake(10, 15, 230, 200)];
	alertText_Subtitile.textAlignment = UITextAlignmentLeft;
	alertText_Subtitile.text = alertSubTitle;
	alertText_Subtitile.numberOfLines = 10;
	alertText_Subtitile.font = [UIFont systemFontOfSize:14.0];
	alertText_Subtitile.textColor = [UIColor whiteColor];
	alertText_Subtitile.backgroundColor = [UIColor clearColor];
	
	
	[largeAlertView addSubview:alertText_Title];
	[largeAlertView addSubview:alertText_Subtitile];
	
	
	return largeAlertView;
}


@end
