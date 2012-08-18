//
//  Constants.m
//  nomabi
//
//  Created by Phil Beadle on 8/17/12.
//  Copyright (c) 2012 nomabi. All rights reserved.
//

#import "Constants.h"


BOOL const kLoggingEnabled = YES;

NSString *const kAccessTokenKeyName = @"";
NSString *const kAccessToken = @"";
NSString *const versionNumber = @"0.2";

int const kScreenWidth = 320;
int const kScreenHeight = 480;
int const kScreenHeightNoStatusBar = 460;
int const kTabBarHeight = 49;
int const kNavBarHeight = 44;

//JSON STRINGS
NSString *const kJSONStatus = @"status";
NSString *const kJSONStatusSuccess = @"success";
NSString *const kJSONStatusError = @"error";
NSString *const kJSONResult = @"result";
NSString *const kJSONFriendlyError = @"friendly_error";
NSString *const kJSONLongitude = @"longitude";
NSString *const kJSONLatitude = @"latitude";


//ERROR TEXT
NSString *const kGeneralProblemErrorTitle = @"Problem";
NSString *const kConnectionErrorTitle = @"Could Not Connect";
NSString *const kConnectionErrorText = @"Oops, we couldn't connect. Please try again later.";
NSString *const kMissingEmailError = @"You must enter an email address";


//LIMITS
int kItemNameFieldLimit = 15;


//FONT SIZES
int kDateFontSize = 14;

//LOCALHOST URLS

 NSString *const kSendLocationUrl                      = @"http://localhost:3000/mobile/user_login";


