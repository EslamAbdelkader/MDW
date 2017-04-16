//
//  AgendaDTO.m
//  testRelam
//
//  Created by marko on 4/14/17.
//  Copyright © 2017 marko. All rights reserved.
//

#import "AgendaDTO.h"
#import "SessionDTO.h"

@implementation AgendaDTO

+(NSString *)primaryKey{
    return @"date";
}

-(void)print{
    NSLog(@"/n%ld/n",_date);
    for(SessionDTO *session in _sessions){
        [session print];
    }
}

@end
