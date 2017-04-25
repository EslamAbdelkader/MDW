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
#import "SWRevealViewController.h"
#import "ViewController.h"

@implementation WebServiceDataProvider
+(void)getAgendasIntoViewController: (id<ViewControllerDelegate>) viewController orLoginFromViewController:(UIViewController *)loginViewController {
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    
    //Change Mail To User Mail From NSUserDefaults
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSData* userData = [userDefaults objectForKey:@"user"];
    AttendeeDTO* user = [NSKeyedUnarchiver unarchiveObjectWithData:userData];
    NSLog(@"%@",user);
    NSLog(@"%@",user.email);
    
    NSString* email = user.email;
    
    NSLog(@"email is %@",email);
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
                                speakerDTO.id=[[speaker objectForKey:@"id"]intValue];
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
                        
                        
                        
                        sessionDTO.id = [[session objectForKey:@"id"]intValue];
                        sessionDTO.sessionType = [session objectForKey:@"sessionType"];
                        sessionDTO.name = [session objectForKey:@"name"];
                        sessionDTO.location = [session objectForKey:@"location"];
                        sessionDTO.startDate = [[session objectForKey:@"startDate"]longLongValue];
                        sessionDTO.endDate = [[session objectForKey:@"endDate"]longLongValue];
                        sessionDTO.status = [[session objectForKey:@"status"]intValue];
                        sessionDTO.desc = [session objectForKey:@"description"];
                        
                        
                        //                        NSLog(@"\n******Session********\n");
                        //                        [sessionDTO print];
                        
                        [agendaDTO.sessions addObject:sessionDTO];
                        [agendaDTOS addObject:agendaDTO];
                        NSLog(@"%d",agendaDTOS.count);
                        
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
                if(viewController){
                    [viewController refreshTableUsingArray:agendaDTOS];
                }else{
                    
                    SWRevealViewController *vc = [loginViewController.storyboard instantiateViewControllerWithIdentifier:@"revealController"];
                    
                    
                    [loginViewController presentViewController:vc animated:YES completion:nil];
                }
                
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
                    exhibitorDTO.id=[[exhibitor objectForKey:@"id"]intValue];
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
            
            ViewController *myViewController = (ViewController*) viewController;
            [myViewController.indicator stopAnimating];
            
            [myViewController.networkAlert show];
            
            [myViewController.view setUserInteractionEnabled:YES];
            
            
        } else {
            
            if([[responseObject objectForKey:@"status"]isEqualToString:@"view.success"]){
                NSDictionary *result = [responseObject objectForKey:@"result"];
                AttendeeDTO * user = [AttendeeDTO new];
                user.firstName = [result objectForKey:@"firstName"];
                user.middleName = [result objectForKey:@"middleName"];
                user.lastName = [result objectForKey:@"lastName"];
                user.cityName = [result objectForKey:@"cityName"];
                user.companyName = [result objectForKey:@"companyName"];
                user.countryName = [result objectForKey:@"countryName"];
                user.imageURL = [result objectForKey:@"imageURL"];
                user.email = [result objectForKey:@"email"];
                user.code = [result objectForKey:@"code"];
                user.title = [result objectForKey:@"title"];
                user.gender = [result objectForKey:@"gender"];
                //                user.birthDate = [[result objectForKey:@"birthDate"]longLongValue];
                NSLog(@"%@",user);
                
                //Putting into UserDefaults
                NSData* userData = [NSKeyedArchiver archivedDataWithRootObject:user];
                NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
                [userDefaults setObject:userData forKey:@"user"];
                [userDefaults synchronize];
                
                //Getting Agendas
                
                UIViewController *myViewController = (UIViewController*) viewController;
                [self getAgendasIntoViewController:nil orLoginFromViewController:myViewController];
                
                //TODO
                //Dissmiss current viewController
                //push Home view controller
                
                
            }else{
                //Status = view.failed
                NSLog(@"Result: %@",[responseObject objectForKey:@"result"]);
                ViewController *myViewController = (ViewController*) viewController;
                [myViewController.indicator stopAnimating];
                
                [myViewController.alert show];
                
                [myViewController.view setUserInteractionEnabled:YES];
                
            }
        }
    }];
    
    
    [dataTask resume];
    
    
    
}


+(void)setImageFromURLString:(NSString *)url intoImageView:(UIImageView *)imageView andSaveObject: (id) object{
    NSString *imageID;
    
    if([object isKindOfClass:[ExhibitorDTO class]]){
        ExhibitorDTO* exhibitor = ((ExhibitorDTO *) object);
        imageID = [@"" stringByAppendingFormat:@"id_%d", exhibitor.id];
    }else if ([object isKindOfClass:[SpeakerDTO class]]){
        SpeakerDTO* speaker = ((SpeakerDTO *) object);
        imageID = [@"" stringByAppendingFormat:@"id_%d", speaker.id];
    };
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    
    NSURL *URL = [NSURL URLWithString:url];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    
    NSURLSessionDownloadTask *downloadTask = [manager downloadTaskWithRequest:request progress:nil destination:^NSURL *(NSURL *targetPath, NSURLResponse *response) {
        
        NSURL *documentsDirectoryURL = [[NSFileManager defaultManager] URLForDirectory:NSDocumentDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:NO error:nil];
        return [documentsDirectoryURL URLByAppendingPathComponent:imageID];
    } completionHandler:^(NSURLResponse *response, NSURL *filePath, NSError *error) {
        
        //Setting ImageView
        NSData *imageData = [[NSData alloc] initWithContentsOfURL:filePath];
        UIImage *image = [UIImage imageWithData: imageData];
        imageView.image = image;
        
        
        //Adding In DB
        if([object isKindOfClass:[ExhibitorDTO class]]){
            ExhibitorDTO* exhibitor = ((ExhibitorDTO *) object);
            [[DBHandler getDB] updataExhibitorImage:imageData forExhibitorID:exhibitor.id];
        }else if ([object isKindOfClass:[SpeakerDTO class]]){
            SpeakerDTO* speaker = ((SpeakerDTO *) object);
            [[DBHandler getDB] updataSpeakerImage:imageData forSpeakerID:speaker.id];
        }
        
    }];
    [downloadTask resume];
    
}

@end
