//
//  AllDaysViewController.m
//  MDW
//
//  Created by JETS on 4/23/17.
//  Copyright © 2017 MAD. All rights reserved.
//

#import "DayOneViewController.h"
#import "SessionDTO.h"
#import "SessionDetailsViewController.h"
#import "AgendaTabBarController.h"
#import "AgendaDTO.h"
#import "WebServiceDataProvider.h"
#import "DBHandler.h"
#import "SidebarTableViewController.h"

@implementation DayOneViewController{
    NSMutableArray *sessionsList;
    UIRefreshControl *refreshControl;
    AgendaTabBarController *tabCont;
}

-(void) viewDidLoad{
    [super viewDidLoad];
    
    [self.storyboard instantiateViewControllerWithIdentifier:@"dayOneView"];
    
    refreshControl = [[UIRefreshControl alloc] init];
    NSAttributedString *text = [[NSAttributedString alloc]initWithString:@"Refreshing.."];
    [refreshControl setAttributedTitle:text];
    [refreshControl setBackgroundColor:[UIColor orangeColor]];
    [refreshControl addTarget:self action:@selector(refreshAgenda) forControlEvents:UIControlEventValueChanged];
    [self.tableView  addSubview:refreshControl];
    
    sessionsList = [NSMutableArray new];
    
    tabCont = self.tabBarController;
    AgendaDTO *firstDayAgenda = tabCont.agendas[0];

    NSLog(@"=====DAY 1 SESSIONS: %i", firstDayAgenda.sessions.count);
    [sessionsList addObjectsFromArray:firstDayAgenda.sessions];
    
    UIImageView *bgImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"background"]];
    bgImageView.frame = self.view.bounds;
    [self.view addSubview:bgImageView];
    [self.view sendSubviewToBack:bgImageView];
    //opaque is set to false, bg is set to clearcolor
    
}

-(void) refreshAgenda{
    //get sessions from service
    [WebServiceDataProvider getAgendasIntoViewController: self
                               orLoginFromViewController:nil];
}

-(void) refreshTable{
    NSLog(@"----------------------------------------%i", [SidebarTableViewController getAgendaType]);
    if ([SidebarTableViewController getAgendaType] == 0) {
        tabCont.agendas = [[DBHandler getDB] getAllAgendas];
    }
    else{
        tabCont.agendas = [[DBHandler getDB] getAllMyAgendas];
    }
    
    [sessionsList removeAllObjects];
    AgendaDTO *firstDayAgenda = tabCont.agendas[0];
    [sessionsList addObjectsFromArray:firstDayAgenda.sessions];
    NSLog(@"=====DAY 1 SESSIONS: %i", firstDayAgenda.sessions.count);
    
    [self.tableView reloadData];
    [refreshControl endRefreshing];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [sessionsList count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DayOneCell" forIndexPath:indexPath];
    
    cell.contentView.backgroundColor = [UIColor clearColor];
    cell.backgroundColor = [UIColor clearColor];
    
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


-(void)viewWillAppear:(BOOL)animated{
    [self refreshTable];
}

@end
