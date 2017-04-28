//
//  AllDaysViewController.m
//  MDW
//
//  Created by JETS on 4/23/17.
//  Copyright © 2017 MAD. All rights reserved.
//

#import "DayThreeViewController.h"
#import "SessionDTO.h"
#import "SessionDetailsViewController.h"
#import "AgendaTabBarController.h"
#import "AgendaDTO.h"

@implementation DayThreeViewController{
    NSMutableArray *sessionsList;
}

-(void) viewDidLoad{
    [super viewDidLoad];
    
    [self.storyboard instantiateViewControllerWithIdentifier:@"dayThreeView"];
    
    sessionsList = [NSMutableArray new];
    
    AgendaTabBarController *tabCont = self.tabBarController;
    AgendaDTO *thirdDayAgenda = tabCont.agendas[2];
    NSLog(@"=====DAY 3 SESSIONS: %i", thirdDayAgenda.sessions.count);
    [sessionsList addObjectsFromArray:thirdDayAgenda.sessions];
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [sessionsList count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DayThreeCell" forIndexPath:indexPath];
    
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
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithData:[htmlString dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
    
    NSRange range = (NSRange){0, [attrStr length]};
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    
    [attrStr enumerateAttribute:NSFontAttributeName inRange:range options:NSAttributedStringEnumerationLongestEffectiveRangeNotRequired usingBlock:^(id value, NSRange range, BOOL *stop) {
        UIFont *replacementFont =  [UIFont systemFontOfSize:14];
        [attrStr addAttribute:NSFontAttributeName value:replacementFont range:range];
        [attrStr addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:range];
    }];
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