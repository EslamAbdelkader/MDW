//
//  SessionDetailsViewController.m
//  MDW
//
//  Created by JETS on 4/23/17.
//  Copyright © 2017 MAD. All rights reserved.
//

#import "SessionDetailsViewController.h"
#import "SpeakerDTO.h"

@implementation SessionDetailsViewController{
    NSMutableArray *speakers;
}

-(void)viewDidLoad{
    [super viewDidLoad];
    [self.storyboard instantiateViewControllerWithIdentifier:@"sessionDetailsView"];
    
    NSString *htmlString = _session.name;
    NSAttributedString *attrStr = [[NSAttributedString alloc] initWithData:[htmlString dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
    _titleLbl.attributedText = attrStr;
    
    NSDate *start = [NSDate dateWithTimeIntervalSince1970:_session.startDate /1000];
    NSDate *end = [NSDate dateWithTimeIntervalSince1970:_session.endDate /1000];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"EEE, dd MMM"];
     NSString *formattedDate = [dateFormatter stringFromDate:start];
    _dateLbl.text = formattedDate;
    
    [dateFormatter setDateFormat:@"hh:mm a"];
    NSString *formattedStart = [dateFormatter stringFromDate:start];
    NSString *formattedEnd = [dateFormatter stringFromDate:end];
    NSString *str = @"";
    str = [str stringByAppendingString:formattedStart];
    str = [str stringByAppendingString:@" - "];
    str = [str stringByAppendingString:formattedEnd];
    
    _timeLbl.text = str;
    
    _locationLbl.text = _session.location;
    
    htmlString = _session.desc;
    attrStr = [[NSAttributedString alloc] initWithData:[htmlString dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
    _descLbl.attributedText = attrStr;
    
    speakers = _session.speakers;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [speakers count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"speakerSessionCell" forIndexPath:indexPath];
    
    SpeakerDTO *speaker = [speakers objectAtIndex:indexPath.row];
    
    UIImageView *img = [cell viewWithTag:1];
    UILabel *name = [cell viewWithTag:2];
    UILabel *title = [cell viewWithTag:3];
    
    //set image
    
    name.text = [[speaker.firstName stringByAppendingString:@" "] stringByAppendingString:speaker.lastName];
    title.text = speaker.title;
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
//    SessionDTO *session = [sessionsList objectAtIndex:indexPath.row];
//    SessionDetailsViewController *detailsView = [self.storyboard instantiateViewControllerWithIdentifier:@"sessionDetailsView"];
//    detailsView.session = session;
//    [self.navigationController pushViewController:detailsView animated:YES];
}

@end
