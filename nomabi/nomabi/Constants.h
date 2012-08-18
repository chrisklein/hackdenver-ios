//
//  Constants.h
//  nomabi
//
//  Created by Phil Beadle on 8/17/12.
//  Copyright (c) 2012 nomabi. All rights reserved.
//

extern BOOL const kLoggingEnabled;

extern NSString *const kAccessTokenKeyName;
extern NSString *const kAccessToken;
extern NSString *const versionNumber;

extern int const kScreenWidth;
extern int const kScreenHeight;
extern int const kScreenHeightNoStatusBar;
extern int const kTabBarHeight;
extern int const kNavBarHeight;

//JSON STRINGS
extern NSString *const kJSONStatus;
extern NSString *const kJSONStatusSuccess;
extern NSString *const kJSONStatusError;
extern NSString *const kJSONResult;
extern NSString *const kJSONFriendlyError;
extern NSString *const kJSONLongitude;
extern NSString *const kJSONLatitude;


//ERROR TEXT
extern NSString *const kGeneralProblemErrorTitle;
extern NSString *const kConnectionErrorTitle;
extern NSString *const kConnectionErrorText;


//LIMITS
extern int kItemNameFieldLimit;


//FONT SIZES
extern int kDateFontSize;

//URLS
extern NSString *const kSendLocationUrl;


#define TEXT_BACKGROUND_COLOR [UIColor colorWithRed:199/255.0 green:227/255.0 blue:241/255.0 alpha:0.6]

#define COLOR_NOMABI_RED [UIColor colorWithRed:253/255.0 green:65/255.0 blue:40/255.0 alpha:1.0]

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]