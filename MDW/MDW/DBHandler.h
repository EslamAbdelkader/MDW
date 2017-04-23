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
#import <UIKit/UIKit.h>

@interface DBHandler : NSObject
- (id) init __attribute__((unavailable("Must Use Factory Method getDB")));

+(instancetype) getDB;
- (void)addOrUpdateAgenda: (AgendaDTO *) agenda;
-(void)addOrUpdateSession: (SessionDTO *) session;
-(void) addOrUpdateSpeaker: (SpeakerDTO *) speaker;
-(void) addOrUpdateExhibitor: (ExhibitorDTO *) exhibitor;

- (void)addOrUpdateAgendas: (NSArray *) agendas;
-(void)addOrUpdateSessions: (NSArray *) sessions;
-(void) addOrUpdateSpeakers: (NSArray *) speakers;
-(void) addOrUpdateExhibitors: (NSArray *) exhibitors;


-(AgendaDTO *) getAgendaByDate: (long) date;
-(SpeakerDTO *) getSpeakerById: (int) id;
-(SessionDTO *) getSessionById: (int) id;
-(ExhibitorDTO *) getExhibitorById: (int) id;

-(NSMutableArray *)getAllAgendas;
-(AgendaDTO *)getDay1Agenda;
-(AgendaDTO *)getDay2Agenda;
-(AgendaDTO *)getDay3Agenda;

-(NSMutableArray *)getAllMyAgendas;
-(AgendaDTO *)getDay1MyAgenda;
-(AgendaDTO *)getDay2MyAgenda;
-(AgendaDTO *)getDay3MyAgenda;

-(NSMutableArray *) getAllSpeakers;
-(NSMutableArray *) getAllExhibitors;

-(void) dropDatabase;

@end
