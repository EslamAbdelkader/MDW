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
#import "AttendeeDTO.h"
#import "DBHandler.h"

@implementation WebServiceDataProvider
+(void)getAgendasIntoViewController: (id<ViewControllerDelegate>) viewController {
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    
    //Change Mail To User Mail From NSUserDefaults
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSData* userData = [userDefaults objectForKey:@"user"];
    AttendeeDTO* user = [NSKeyedUnarchiver unarchiveObjectWithData:userData];
    NSString* email = user.email;
    
    
    NSURLRequest *request = [URLProvider getSessionsRequestByUsername:email];
    
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
               
                //TODO (DONE - NOT Tested)
                //Save agendaDTOS in DB
                DBHandler *dbHandler = [DBHandler getDB];
                [dbHandler addOrUpdateAgendas:agendaDTOS];
                
                //Replace array with agendaDTOS
                //Refresh Table
                [viewController refreshTableUsingArray:agendaDTOS];
                
            }else{
                //Status = view.failed
                NSLog(@"Status = view.failed");
                
                //Todo
                //Show Alert
            }
        }
    }];
    
    [dataTask resume];
    
    
    
    
}

+(void)getSpeakersIntoViewController: (id<ViewControllerDelegate>) viewController{
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    
    //Change Mail To User Mail From NSUserDefaults
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSData* userData = [userDefaults objectForKey:@"user"];
    AttendeeDTO* user = [NSKeyedUnarchiver unarchiveObjectWithData:userData];
    NSString* email = user.email;
    
    
    NSURLRequest *request = [URLProvider getSpeakersRequestByUsername:email];
    
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
                
                
                //TODO
                //Add Objects in DB
                DBHandler *dbHandler = [DBHandler new];
                [dbHandler addOrUpdateSpeakers:speakers];

                //Refresh Array, Reload Table.
                [viewController refreshTableUsingArray:speakers];
                
                
            }else{
                //Status = view.failed
                NSLog(@"Status = view.failed");
            }
        }
    }];
    
    [dataTask resume];
    
}

+(void)getExhibitorsIntoViewController: (id<ViewControllerDelegate>) viewController{
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    
    //Change Mail To User Mail From NSUserDefaults
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSData* userData = [userDefaults objectForKey:@"user"];
    AttendeeDTO* user = [NSKeyedUnarchiver unarchiveObjectWithData:userData];
    NSString* email = user.email;
    
    NSURLRequest *request = [URLProvider getExhibtiorsRequestByUsername:email];
    
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
                
                
                
                //TODO
                //Add Objects in DB
                DBHandler *dbHandler = [DBHandler new];
                [dbHandler addOrUpdateExhibitors:exhibitors];
                
                //Refresh Array, Reload Table.
                [viewController refreshTableUsingArray:exhibitors];
                
                
            }else{
                //Status = view.failed
                NSLog(@"Status = view.failed");
            }
        }
    }];
    
    [dataTask resume];
    
}

+(void)loginWithUserName:(NSString *)userName andPassword:(NSString *)password andViewController: (id<ViewControllerDelegate>) viewController{
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    
    NSURLRequest *request = [URLProvider getLoginRequestByUsername:userName andPasswrd:password];
    
    NSURLSessionDataTask *dataTask = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        if (error) {
            NSLog(@"Error: %@", error);
        } else {
            
            if([[responseObject objectForKey:@"status"]isEqualToString:@"view.success"]){
                AttendeeDTO * user = [responseObject objectForKey:@"result"];
                NSLog(@"%@",user);
                
                //Putting into UserDefaults
                NSData* userData = [NSKeyedArchiver archivedDataWithRootObject:user];
                NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
                [userDefaults setObject:userData forKey:@"user"];
                [userDefaults synchronize];
                
                //TODO
                //Dissmiss current viewController
                //push Home view controller
                
            }else{
                //Status = view.failed
                NSLog(@"Status = view.failed");
            }
        }
    }];
    
    
    [dataTask resume];
    
    
    
}


+(void)setImageFromURLString:(NSString *)url intoImageView:(UIImageView *)imageView andSaveObject: (id) object{
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    
    NSURL *URL = [NSURL URLWithString:url];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    
    NSURLSessionDownloadTask *downloadTask = [manager downloadTaskWithRequest:request progress:nil destination:^NSURL *(NSURL *targetPath, NSURLResponse *response) {
        NSURL *documentsDirectoryURL = [[NSFileManager defaultManager] URLForDirectory:NSDocumentDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:NO error:nil];
        return [documentsDirectoryURL URLByAppendingPathComponent:[response suggestedFilename]];
    } completionHandler:^(NSURLResponse *response, NSURL *filePath, NSError *error) {
        
        //Setting ImageView
        NSData *imageData = [[NSData alloc] initWithContentsOfURL:filePath];
        UIImage *image = [UIImage imageWithData: imageData];
        imageView.image = image;
        
        
        //Adding In DB
        if([object isKindOfClass:[ExhibitorDTO class]]){
            ((ExhibitorDTO *) object).image = imageData;
            [[DBHandler getDB] addOrUpdateExhibitor:object];
        }else if ([object isKindOfClass:[SpeakerDTO class]]){
            ((SpeakerDTO *) object).image = imageData;
            [[DBHandler getDB] addOrUpdateSpeaker:object];
        }
        
    }];
    [downloadTask resume];
    
}

@end
