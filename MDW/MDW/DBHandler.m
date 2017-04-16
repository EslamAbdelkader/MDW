//
//  DBHandler.m
//  testRelam
//
//  Created by marko on 4/14/17.
//  Copyright © 2017 marko. All rights reserved.
//

#import "DBHandler.h"
#import <Realm/Realm.h>

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

-(void)dropDatabase{
    RLMRealm *realm = [RLMRealm defaultRealm];
    [realm beginWriteTransaction];
    [realm deleteAllObjects];
    [realm commitWriteTransaction];
}

@end
