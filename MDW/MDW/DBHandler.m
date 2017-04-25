//
//  DBHandler.m
//  testRelam
//
//  Created by marko on 4/14/17.
//  Copyright © 2017 marko. All rights reserved.
//

#import "DBHandler.h"
#import "AttendeeDTO.h"
#import <UIKit/UIKit.h>
#import <Realm/Realm.h>
#import "WebServiceDataProvider.h"

@implementation DBHandler
static DBHandler *dbHandler;

+(instancetype) getDB{
    if (dbHandler == nil) {
        dbHandler = [DBHandler new];
    }
    return dbHandler;
}

-(void)addOrUpdateAgenda:(AgendaDTO *)agenda{
    RLMRealm *realm = [RLMRealm defaultRealm];
    [realm transactionWithBlock:^{
        [realm addOrUpdateObject:agenda];
    }];
    
}

-(void)addOrUpdateSession:(SessionDTO *)session{
    RLMRealm *realm = [RLMRealm defaultRealm];
    [realm transactionWithBlock:^{
        [realm addOrUpdateObject:session];
    }];
    
}

-(void)addOrUpdateSpeaker:(SpeakerDTO *)speaker{
    RLMRealm *realm = [RLMRealm defaultRealm];
    [realm transactionWithBlock:^{
        [realm addOrUpdateObject:speaker];
    }];
    
}

-(void)addOrUpdateExhibitor:(ExhibitorDTO *)exhibitor{
    RLMRealm *realm = [RLMRealm defaultRealm];
    [realm transactionWithBlock:^{
        [realm addOrUpdateObject:exhibitor];
    }];
    
}

-(void)addOrUpdateAgendas:(NSArray *)agendas{
    RLMRealm *realm = [RLMRealm defaultRealm];
    [realm transactionWithBlock:^{
        [realm addOrUpdateObjectsFromArray:agendas];
    }];
}

-(void)addOrUpdateSessions:(NSArray *)sessions{
    RLMRealm *realm = [RLMRealm defaultRealm];
    [realm transactionWithBlock:^{
        [realm addOrUpdateObjectsFromArray:sessions];
    }];
}

-(void)addOrUpdateExhibitors:(NSArray *)exhibitors{
    RLMRealm *realm = [RLMRealm defaultRealm];
    [realm transactionWithBlock:^{
        [realm addOrUpdateObjectsFromArray:exhibitors];
    }];
}

-(void)addOrUpdateSpeakers:(NSArray *)speakers{
    RLMRealm *realm = [RLMRealm defaultRealm];
    [realm transactionWithBlock:^{
        [realm addOrUpdateObjectsFromArray:speakers];
    }];
}

-(AgendaDTO *)getAgendaByDate: (long) date{
    NSString *query = [NSString stringWithFormat:@"%@%ld", @"date == ", date];
    AgendaDTO* agenda = [[AgendaDTO objectsWhere:query] firstObject];
    
    return agenda;
}


-(SpeakerDTO *)getSpeakerById:(int)id{
    NSString *query = [NSString stringWithFormat:@"%@%d", @"id == ", id];
    SpeakerDTO *speaker = [[SpeakerDTO objectsWhere:query]firstObject];
    return speaker;
}

-(SessionDTO *)getSessionById:(int)id{
    NSString *query = [NSString stringWithFormat:@"%@%d", @"id == ", id];
    SessionDTO* session = [[SessionDTO objectsWhere:query] firstObject];
    return session;
}

-(ExhibitorDTO *)getExhibitorById:(int)id{
    NSString *query = [NSString stringWithFormat:@"%@%d", @"id == ", id];
    ExhibitorDTO *exhibitor = [[ExhibitorDTO objectsWhere:query] firstObject];
    return exhibitor;
}

-(NSMutableArray *)getAllAgendas{
    RLMResults *results = [AgendaDTO allObjects];
    NSMutableArray *allAgendas = (NSMutableArray *) results;
    NSLog(@"%@",allAgendas);
    return allAgendas;
}

-(AgendaDTO *)getDay1Agenda:(long)date{
    long day1 = 1460584800000;
    return [self getAgendaByDate:day1];
}

-(AgendaDTO *)getDay2Agenda{
    long day1 = 1460671200000;
    return [self getAgendaByDate:day1];
}

-(AgendaDTO *)getDay3Agenda{
    long day1 = 1460757600000;
    return [self getAgendaByDate:day1];

}


-(NSMutableArray *)getAllMyAgendas{
    NSMutableArray * allMyAgendas = [NSMutableArray new];
    RLMResults *results = [AgendaDTO allObjects];
    NSMutableArray *allAgendas = (NSMutableArray *) results;
    
    //Filtering Sessions and filling into the new object "myAgenda"
    for(AgendaDTO* agenda in allAgendas){
        AgendaDTO* myAgenda = [AgendaDTO new];
        myAgenda.date = agenda.date;
        
        for(SessionDTO *session in agenda.sessions){
            if(session.status != 0){
                [myAgenda.sessions addObject:session];
            }
        }
        [allMyAgendas addObject:myAgenda];
    }
    
    return allMyAgendas;
}

-(AgendaDTO *)getDay1MyAgenda{
    AgendaDTO* day1Agenda = [self getDay1Agenda];
    AgendaDTO* day1MyAgenda = [AgendaDTO new];
    day1MyAgenda.date = day1Agenda.date;
    
    for (SessionDTO* session in day1Agenda.sessions){
        if(session.status !=0){
            [day1MyAgenda.sessions addObject:session];
        }
    }
    
    return day1MyAgenda;
}

-(AgendaDTO *)getDay2MyAgenda{
    AgendaDTO* day2Agenda = [self getDay2Agenda];
    AgendaDTO* day2MyAgenda = [AgendaDTO new];
    day2MyAgenda.date = day2Agenda.date;
    
    for (SessionDTO* session in day2Agenda.sessions){
        if(session.status !=0){
            [day2MyAgenda.sessions addObject:session];
        }
    }
    
    return day2MyAgenda;
}

-(AgendaDTO *)getDay3MyAgenda{
    AgendaDTO* day3Agenda = [self getDay3Agenda];
    AgendaDTO* day3MyAgenda = [AgendaDTO new];
    day3MyAgenda.date = day3Agenda.date;
    
    for (SessionDTO* session in day3Agenda.sessions){
        if(session.status !=0){
            [day3MyAgenda.sessions addObject:session];
        }
    }
    
    return day3MyAgenda;
}

-(NSMutableArray *)getAllSpeakers{
    NSMutableArray * allSpeakers = (NSMutableArray *)[SpeakerDTO allObjects];
    return allSpeakers;
}

-(NSMutableArray *)getAllExhibitors{
    NSMutableArray * allExhibitors = (NSMutableArray *)[ExhibitorDTO allObjects];
    return allExhibitors;
}

-(void)updataSpeakerImage:(NSData *)imageData forSpeakerID:(int)speakerID{
    NSString *query = [NSString stringWithFormat:@"%@%d", @"id == ", speakerID];
    SpeakerDTO *speaker = [[SpeakerDTO objectsWhere:query]firstObject];
    
    RLMRealm *realm = [RLMRealm defaultRealm];
    [realm beginWriteTransaction];
    speaker.image = imageData;
    [realm addOrUpdateObject:speaker];
    [realm commitWriteTransaction];
}

-(void)updataExhibitorImage:(NSData *)imageData forExhibitorID:(int)exhibitorID{
    NSString *query = [NSString stringWithFormat:@"%@%d", @"id == ", exhibitorID];
    ExhibitorDTO *exhibitor = [[ExhibitorDTO objectsWhere:query]firstObject];
    
    RLMRealm *realm = [RLMRealm defaultRealm];
    [realm beginWriteTransaction];
    exhibitor.image = imageData;
    [realm addOrUpdateObject:exhibitor];
    [realm commitWriteTransaction];
}

-(void)dropDatabase{
    RLMRealm *realm = [RLMRealm defaultRealm];
    [realm beginWriteTransaction];
    [realm deleteAllObjects];
    [realm commitWriteTransaction];
}

@end
