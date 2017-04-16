//
//  SessionDTO.m
//  testRelam
//
//  Created by marko on 4/14/17.
//  Copyright © 2017 marko. All rights reserved.
//

#import "SessionDTO.h"
#import "SpeakerDTO.h"

@implementation SessionDTO

+(NSString *)primaryKey{
    return @"id";
}

-(void)print{
    NSLog(@"\nid= %d\n Type= %@\n Name= %@\n Desc= %@\n startDate= %ld\n endData= %ld\n Location= %@\n Status= %d",_id,_sessionType,_name, _desc, _startDate, _endDate, _location, _status);
    for (SpeakerDTO *speaker in _speakers)
         [speaker print];
}

@end
