//
//  AllDaysViewController.m
//  MDW
//
//  Created by JETS on 4/23/17.
//  Copyright © 2017 MAD. All rights reserved.
//

#import "AllDaysViewController.h"
#import "SessionDTO.h"
#import "SessionDetailsViewController.h"
#import "AgendaTabBarController.h"
#import "AgendaDTO.h"

@implementation AllDaysViewController{
    NSMutableArray *sessionsList;
}

-(void) viewDidLoad{
    [super viewDidLoad];
    
    self.title = @"All Days";
    [self.storyboard instantiateViewControllerWithIdentifier:@"allDaysView"];
    
//    sessionsList = [NSMutableArray new];
//    SessionDTO *session1 = [SessionDTO new];
//    session1.startDate = 1460617200000;
//    session1.endDate = 1460620800000;
//    //session1.name = @"Keynote Session";
//    session1.name = @"<Font name=\"verdana\" size=\"4\" color=\"Blue\">Registration</Font>";
//    session1.location = @"Main Hall";
//    session1.sessionType = @"Session";
//    
//    SessionDTO *session2 = [SessionDTO new];
//    session2.startDate = 1460617200000;
//    session2.endDate = 1460620800000;
//    session2.name = @"Workshop";
//    session2.location = @"1022";
//    session2.sessionType = @"Workshop";
//    
//    SessionDTO *session3 = [SessionDTO new];
//    session3.startDate = 1460617200000;
//    session3.endDate = 1460620800000;
//    session3.name = @"Break";
//    session3.sessionType = @"Break";
//    
//    [sessionsList addObject:session1];
//    [sessionsList addObject:session2];
//    [sessionsList addObject:session3];
    
    sessionsList = [NSMutableArray new];
    
    AgendaTabBarController *tabCont = self.tabBarController;
    for( AgendaDTO * agenda in tabCont.agendas){
        [sessionsList addObjectsFromArray:agenda.sessions];
        
    }
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [sessionsList count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AgendaCell" forIndexPath:indexPath];
    
    SessionDTO *currSession = [sessionsList objectAtIndex:indexPath.row];
    
    UIImageView *img = [cell viewWithTag:1];
    UILabel *title = [cell viewWithTag:2];
    UILabel *location = [cell viewWithTag:3];
    UILabel *time = [cell viewWithTag:4];
    
    if ([currSession.sessionType isEqualToString:@"Break"]) {
        [img setImage:[UIImage imageNamed:@"breakicon"]];
    }
    else if([currSession.sessionType isEqualToString:@"Session"]){
        [img setImage:[UIImage imageNamed:@"session"]];
    }
    else if([currSession.sessionType isEqualToString:@"Workshop"]){
        [img setImage:[UIImage imageNamed:@"workshop"]];
    }
    else{
        //handle
    }
    
    NSString * htmlString = currSession.name;
    NSAttributedString * attrStr = [[NSAttributedString alloc] initWithData:[htmlString dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
    title.attributedText = attrStr;
    
    location.text = currSession.location;
    NSDate *start = [NSDate dateWithTimeIntervalSince1970:currSession.startDate /1000];
    NSDate *end = [NSDate dateWithTimeIntervalSince1970:currSession.endDate / 1000];

    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"hh:mm a"];
    NSString *formattedStart = [dateFormatter stringFromDate:start];
    NSString *formattedEnd = [dateFormatter stringFromDate:end];
    NSString *str = @"";
    str = [str stringByAppendingString:formattedStart];
    str = [str stringByAppendingString:@" - "];
    str = [str stringByAppendingString:formattedEnd];
    
    time.text = str;
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    SessionDTO *session = [sessionsList objectAtIndex:indexPath.row];
    SessionDetailsViewController *detailsView = [self.storyboard instantiateViewControllerWithIdentifier:@"sessionDetailsView"];
    detailsView.session = session;
    [self.navigationController pushViewController:detailsView animated:YES];
}



@end
