//
//  AgendaDTO.h
//  testRelam
//
//  Created by marko on 4/14/17.
//  Copyright © 2017 marko. All rights reserved.
//

#import <Realm/Realm.h>
#import "SessionDTO.h"

@interface AgendaDTO : RLMObject
@property long date;
//@property Long endDate;
@property RLMArray<SessionDTO *><SessionDTO> *sessions;
-(void) print;
@end
