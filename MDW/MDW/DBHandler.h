//
//  DBHandler.h
//  testRelam
//
//  Created by marko on 4/14/17.
//  Copyright © 2017 marko. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AgendaDTO.h"
#import "SpeakerDTO.h"
#import "SessionDTO.h"
#import "ExhibitorDTO.h"

@interface DBHandler : NSObject
- (id) init __attribute__((unavailable("Must Use Factory Method getDB")));

+(instancetype) getDB;
- (void)addOrUpdateAgenda: (AgendaDTO *) agenda;
-(void)addOrUpdateSession: (SessionDTO *) session;
-(void) addOrUpdateSpeaker: (SpeakerDTO *) speaker;
-(void) addOrUpdateExhibitor: (ExhibitorDTO *) exhibitor;
-(AgendaDTO *) getAgendaByDate: (long) date;
-(SpeakerDTO *) getSpeakerById: (int) id;
-(SessionDTO *) getSessionById: (int) id;
-(ExhibitorDTO *) getExhibitorById: (int) id;
-(void) dropDatabase;
@end
