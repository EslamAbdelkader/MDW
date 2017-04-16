//
//  SpeakerDTO.m
//  testRelam
//
//  Created by marko on 4/14/17.
//  Copyright © 2017 marko. All rights reserved.
//

#import "SpeakerDTO.h"

@implementation SpeakerDTO


+(NSString *)primaryKey{
    return @"id";
}

-(void)print{
    NSLog(@"\nid= %d\n firstName= %@\n middleName= %@\n lastName= %@\n imageURL= %@\n companyName= %@\n Title= %@\n biography= %d",_id,_firstName,_middleName, _lastName, _imageURL, _companyName, _title, _biography);
}

@end
