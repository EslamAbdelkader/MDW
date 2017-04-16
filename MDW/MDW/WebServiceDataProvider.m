//
//  WebServiceDataProvider.m
//  MDW
//
//  Created by JETS on 4/15/17.
//  Copyright © 2017 MAD. All rights reserved.
//

#import "WebServiceDataProvider.h"
#import <AFNetworking/AFNetworking.h>
#import "URLProvider.h"
#import "AgendaDTO.h"
#import "SpeakerDTO.h"
#import "SessionDTO.h"
#import "ExhibitorDTO.h"

@implementation WebServiceDataProvider
+(void)getAgendas{
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    
    //TODO
    //Change Mail To User Mail From NSUserDefaults
    
    NSURLRequest *request = [URLProvider getSessionsRequestByUsername:@"eng.medhat.cs.h@gmail.com"];
    
    NSURLSessionDataTask *dataTask = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        if (error) {
            NSLog(@"Error: %@", error);
        } else {
            //            NSLog(@"%@ ----  %@", response, responseObject);
            //            NSMutableArray * sessions = [NSMutableArray new];
            //            NSDictionary * result = [responseObject objectForKey:@"result"];
            //            NSArray * agendas = [result objectForKey:@"agendas"];
            NSLog(@"\nStatus: %@\n", [responseObject objectForKey:@"status"]);
            //            NSLog(@"\nResult: %@\n",[responseObject objectForKey:@"result"]);
            NSLog(@"tmam");
            
            if([[responseObject objectForKey:@"status"]isEqualToString:@"view.success"]){
                NSMutableArray * sessions = [NSMutableArray new];
                NSDictionary * result = [responseObject objectForKey:@"result"];
                NSArray * agendas = [result objectForKey:@"agendas"];
                NSMutableArray *agendaDTOS = [NSMutableArray new];
                
                NSLog(@"---------------- no.of days in resulsts is %lu", (unsigned long)[agendas count]);
                
                
                for (NSDictionary *day in agendas) {
                    
                    
                    AgendaDTO* agendaDTO = [AgendaDTO new];
                    agendaDTO.date = [day objectForKey:@"date"];
                    
                    NSArray * daySessions = [day objectForKey:@"sessions"];
                    
                    NSLog(@"---------------- no.of sessions in the day are is %lu", (unsigned long)[daySessions count]);
                    
                    //Getting list of sessions
                    for (NSDictionary * session in daySessions) {
                        
                        SessionDTO * sessionDTO = [SessionDTO new];
                        
                        //getting session speakers
                        NSMutableArray * sessionSpearkers;
                        NSArray * speakersList = [session objectForKey:@"speakers"];
                        if (![speakersList isKindOfClass:[NSNull class]]) {
                            for (NSDictionary * speaker in speakersList) {
                                
                                SpeakerDTO * speakerDTO = [SpeakerDTO new];
                                speakerDTO.id=[speaker objectForKey:@"id"];
                                speakerDTO.firstName=[speaker objectForKey:@"firstName"];
                                speakerDTO.middleName=[speaker objectForKey:@"middleName"];
                                speakerDTO.lastName=[speaker objectForKey:@"lastName"];
                                speakerDTO.title=[speaker objectForKey:@"title"];
                                speakerDTO.companyName=[speaker objectForKey:@"companyName"];
                                speakerDTO.imageURL=[speaker objectForKey:@"imageURL"];
                                speakerDTO.biography=[speaker objectForKey:@"biography"];
                                [sessionDTO.speakers addObject:speakerDTO];
                                
                            }
                        }
                        
                        
                        
                        sessionDTO.id = [session objectForKey:@"id"];
                        sessionDTO.sessionType = [session objectForKey:@"sessionType"];
                        sessionDTO.name = [session objectForKey:@"name"];
                        sessionDTO.location = [session objectForKey:@"location"];
                        sessionDTO.startDate = [session objectForKey:@"startDate"];
                        sessionDTO.endDate = [session objectForKey:@"endDate"];
                        sessionDTO.status = [session objectForKey:@"status"];
                        sessionDTO.desc = [session objectForKey:@"description"];
                        
                        
                        //                        NSLog(@"\n******Session********\n");
                        //                        [sessionDTO print];
                        
                        [agendaDTO.sessions addObject:sessionDTO];
                        [agendaDTOS addObject:agendaDTO];
                        
                        //                        NSLog(@"---------------- no.ofsessions inside is %lu", (unsigned long)[sessions count]);
                        
                    }
                }
                
                //                NSLog(@"---------------- no.ofsessions is %lu", (unsigned long)[sessions count]);
                //            for (SessionDTO * ses in sessions) {
                //                [ses printOject];
                //            }
                
                NSLog(@"\nAgenda*******\n");
                for(AgendaDTO* myAgendaDTO in agendaDTOS){
                    [myAgendaDTO print];
                }
                NSLog(@"\nAgenda*******\n");
                
                //TODO
                //Save agendaDTOS in DB
                //Replace array with agendaDTOS
                //Refresh Table
                
            }else{
                //Status = view.failed
                NSLog(@"Status = view.failed");
            }
        }
    }];
    
    [dataTask resume];
    
    
    
    
}

+(void)getSpeakers{
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    
    //TODO
    //Change Mail To User Mail From NSUserDefaults
    
    NSURLRequest *request = [URLProvider getSpeakersRequestByUsername:@"eng.medhat.cs.h@gmail.com"];
    
    NSURLSessionDataTask *dataTask = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        if (error) {
            NSLog(@"Error: %@", error);
        } else {
            
            if([[responseObject objectForKey:@"status"]isEqualToString:@"view.success"]){
                
                NSArray * result = [responseObject objectForKey:@"result"];
                NSMutableArray *speakers = [NSMutableArray new];
                
                for (NSDictionary *speaker in result) {
                    
                    SpeakerDTO * speakerDTO = [SpeakerDTO new];
                    speakerDTO.id=[speaker objectForKey:@"id"];
                    speakerDTO.firstName=[speaker objectForKey:@"firstName"];
                    speakerDTO.middleName=[speaker objectForKey:@"middleName"];
                    speakerDTO.lastName=[speaker objectForKey:@"lastName"];
                    speakerDTO.title=[speaker objectForKey:@"title"];
                    speakerDTO.companyName=[speaker objectForKey:@"companyName"];
                    speakerDTO.imageURL=[speaker objectForKey:@"imageURL"];
                    speakerDTO.biography=[speaker objectForKey:@"biography"];
                    
                    [speakers addObject: speakerDTO];
                    
                }
                
//                for (SpeakerDTO* mySpeaker in speakers){
//                    [mySpeaker print];
//                }
                
                //TODO
                //Add Objects in DB
                //Refresh Array, Reload Table.
                
                
            }else{
                //Status = view.failed
                NSLog(@"Status = view.failed");
            }
        }
    }];
    
    [dataTask resume];
    
}

+(void)getExhibitors{
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    
    //TODO
    //Change Mail To User Mail From NSUserDefaults
    
    NSURLRequest *request = [URLProvider getExhibtiorsRequestByUsername:@"eng.medhat.cs.h@gmail.com"];
    
    NSURLSessionDataTask *dataTask = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        if (error) {
            NSLog(@"Error: %@", error);
        } else {
            
            if([[responseObject objectForKey:@"status"]isEqualToString:@"view.success"]){
                
                NSArray * result = [responseObject objectForKey:@"result"];
                NSMutableArray *exhibitors = [NSMutableArray new];
                
                for (NSDictionary * exhibitor in result) {
                    
                    ExhibitorDTO * exhibitorDTO = [ExhibitorDTO new];
                    exhibitorDTO.id=[exhibitor objectForKey:@"id"];
                    exhibitorDTO.email=[exhibitor objectForKey:@"email"];
                    exhibitorDTO.countryName=[exhibitor objectForKey:@"countryName"];
                    exhibitorDTO.cityName=[exhibitor objectForKey:@"cityName"];
                    exhibitorDTO.companyAbout=[exhibitor objectForKey:@"companyAbout"];
                    exhibitorDTO.companyName=[exhibitor objectForKey:@"companyName"];
                    exhibitorDTO.imageURL=[exhibitor objectForKey:@"imageURL"];
                    exhibitorDTO.contactName=[exhibitor objectForKey:@"contactName"];
                    exhibitorDTO.contactTitle=[exhibitor objectForKey:@"contactTitle"];
                    exhibitorDTO.fax=[exhibitor objectForKey:@"fax"];
                    exhibitorDTO.companyUrl=[exhibitor objectForKey:@"companyUrl"];
                    exhibitorDTO.companyAddress=[exhibitor objectForKey:@"companyAddress"];
                    
                    [exhibitors addObject: exhibitorDTO];
                    
                }
                
                for (ExhibitorDTO* myExhibitor in exhibitors){
                    [myExhibitor print];
                }
                
                //TODO
                //Add Objects in DB
                //Refresh Array, Reload Table.
                
                
            }else{
                //Status = view.failed
                NSLog(@"Status = view.failed");
            }
        }
    }];
    
    [dataTask resume];
    
}

@end
