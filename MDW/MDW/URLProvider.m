//
//  URLProvider.m
//  testRelam
//
//  Created by JETS on 4/15/17.
//  Copyright © 2017 marko. All rights reserved.
//

#import "URLProvider.h"

@implementation URLProvider

+(NSURLRequest *)getLoginRequestByUsername:(NSString *)userName andPasswrd:(NSString *)password{
    NSURL *URL = [NSURL URLWithString: [NSString stringWithFormat: @"http://www.mobiledeveloperweekend.net/MDW/service/login?userName=%@&password=%@",userName, password]];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    return request;
}

+(NSURLRequest *)getSessionsRequestByUsername:(NSString *)userName{
    NSURL *URL = [NSURL URLWithString: [NSString stringWithFormat: @"http://www.mobiledeveloperweekend.net/MDW/service/getSessions?userName=%@",userName]];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    return request;
}

+(NSURLRequest *)getSpeakersRequestByUsername:(NSString *)userName{
    NSURL *URL = [NSURL URLWithString: [NSString stringWithFormat: @"http://www.mobiledeveloperweekend.net/MDW/service/getSpeakers?userName=%@",userName]];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    return request;
}

+(NSURLRequest *)getExhibtiorsRequestByUsername:(NSString *)userName{
    NSURL *URL = [NSURL URLWithString: [NSString stringWithFormat: @"http://www.mobiledeveloperweekend.net/MDW/service/getExhibitors?userName=%@",userName]];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    return request;
}

+(NSURLRequest *)getProfileImageRequestByUsername:(NSString *)userName{
    NSURL *URL = [NSURL URLWithString: [NSString stringWithFormat: @"http://www.mobiledeveloperweekend.net/MDW/service/profileImage?userName=%@",userName]];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    return request;
}

+(NSURLRequest *)getAttendeeProfileRequestByUsername:(NSString *)userName{
    NSURL *URL = [NSURL URLWithString: [NSString stringWithFormat: @"http://www.mobiledeveloperweekend.net/MDW/service/getAttendeeProfile?userName=%@",userName]];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    return request;
}

+(NSURLRequest *)getRegisterSessionRequestByUsername:(NSString *)userName sessionId:(int)sessionId status:(int)status{
    NSURL *URL = [NSURL URLWithString: [NSString stringWithFormat: @"http://www.mobiledeveloperweekend.net/MDW/service/registerSession?userName=%@&sessionId=%d&enforce=false&status=%d",userName, sessionId, status]];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    return request;
}

@end
