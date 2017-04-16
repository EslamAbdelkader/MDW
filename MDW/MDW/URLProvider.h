//
//  URLProvider.h
//  testRelam
//
//  Created by JETS on 4/15/17.
//  Copyright © 2017 marko. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface URLProvider : NSObject
+(NSURLRequest*) getLoginRequestByUsername: (NSString *) userName andPasswrd: (NSString *) password;
+(NSURLRequest*) getSessionsRequestByUsername: (NSString *) userName;
+(NSURLRequest*) getExhibtiorsRequestByUsername: (NSString *) userName;
+(NSURLRequest*) getSpeakersRequestByUsername: (NSString *) userName;
+(NSURLRequest*) getProfileImageRequestByUsername: (NSString *) userName;
+(NSURLRequest*) getAttendeeProfileRequestByUsername: (NSString *) userName;
+(NSURLRequest*) getRegisterSessionRequestByUsername: (NSString *) userName sessionId: (int) sessionId status: (int) status;
@end
