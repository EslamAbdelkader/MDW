//
//  SessionDTO.h
//  testRelam
//
//  Created by marko on 4/14/17.
//  Copyright © 2017 marko. All rights reserved.
//

#import <Realm/Realm.h>
#import "SpeakerDTO.h"

@interface SessionDTO : RLMObject
@property int id;
@property NSString *sessionType;
@property NSString *name;
@property NSString *desc;
@property long startDate;
@property long endDate;
@property NSString *location;
@property BOOL liked;
@property int status;
@property RLMArray<SpeakerDTO *><SpeakerDTO> *speakers;

-(void) print;
@end

RLM_ARRAY_TYPE(SessionDTO)
