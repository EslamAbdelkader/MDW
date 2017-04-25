//
//  SessionDetailsViewController.m
//  MDW
//
//  Created by JETS on 4/23/17.
//  Copyright © 2017 MAD. All rights reserved.
//

#import "SessionDetailsViewController.h"
#import "SpeakerDTO.h"
#import "SpeakerDetailsViewController.h"
#import "UIImageView+ImageDownload.h"
#import "WebServiceDataProvider.h"


@implementation SessionDetailsViewController{
    NSMutableArray *speakers;
}

-(void)viewDidLoad{
    [super viewDidLoad];
    [self.storyboard instantiateViewControllerWithIdentifier:@"sessionDetailsView"];
    
    _alert = [[UIAlertView alloc] initWithTitle:@"Failed to register."
                                        message:@"You're already registered at another session at the same time."
                                       delegate:self
                              cancelButtonTitle:@"Cancel"
                              otherButtonTitles:nil];
    
    _connectionAlert = [[UIAlertView alloc] initWithTitle:@"Connection error"
                                               message:@"Please check your connection."
                                              delegate:self
                                     cancelButtonTitle:@"Cancel"
                                     otherButtonTitles:nil];

    _serviceAlert = [[UIAlertView alloc] initWithTitle:@"Service is down."
                                               message:@"Please try again in a few seconds."
                                              delegate:self
                                     cancelButtonTitle:@"Cancel"
                                     otherButtonTitles:nil];

    
    
    speakers = _session.speakers;
    
    NSDate *start = [NSDate dateWithTimeIntervalSince1970:_session.startDate /1000];
    NSDate *end = [NSDate dateWithTimeIntervalSince1970:_session.endDate /1000];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"EEE, dd MMM"];
    
    _dateLbl.text = [dateFormatter stringFromDate:start];
    
    [dateFormatter setDateFormat:@"hh:mm a"];
    NSString *formattedStart = [dateFormatter stringFromDate:start];
    NSString *formattedEnd = [dateFormatter stringFromDate:end];
    NSString *str = @"";
    str = [str stringByAppendingString:formattedStart];
    str = [str stringByAppendingString:@" - "];
    str = [str stringByAppendingString:formattedEnd];
    
    switch (_session.status) {
        case 0:
            _starImageView.image = [UIImage imageNamed:@"star"];
            break;
        case 1:
            _starImageView.image = [UIImage imageNamed:@"sessionpending"];
            break;
        case 2:
            _starImageView.image = [UIImage imageNamed:@"sessionapproved"];
            break;
        default:
            break;
    }
    
    _timeLbl.text = str;
    
    _locationLbl.text = _session.location;
    
    NSString *htmlString = _session.name;
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithData:[htmlString dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
    
    NSRange range = (NSRange){0, [attrStr length]};
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    
    [paragraphStyle setAlignment:NSTextAlignmentCenter];
    
    [attrStr enumerateAttribute:NSFontAttributeName inRange:range options:NSAttributedStringEnumerationLongestEffectiveRangeNotRequired usingBlock:^(id value, NSRange range, BOOL *stop) {
        UIFont *replacementFont =  [UIFont systemFontOfSize:18];
        [attrStr addAttribute:NSFontAttributeName value:replacementFont range:range];
        [attrStr addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:range];
    }];
    
    _titleLbl.attributedText = attrStr;
    
    htmlString = _session.desc;
    [_descWebview loadHTMLString:[NSString stringWithFormat:@"<div align='center'>%@<div>", _session.desc]
    baseURL:nil];
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
    [img setSpeakerImageByURLString:speaker.imageURL];
    
    name.text = [[speaker.firstName stringByAppendingString:@" "] stringByAppendingString:speaker.lastName];
    title.text = speaker.title;
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    SpeakerDTO *speaker = [speakers objectAtIndex:indexPath.row];
    SpeakerDetailsViewController *detailsView = [self.storyboard instantiateViewControllerWithIdentifier:@"speakerDetails"];
    detailsView.speaker = speaker;
    [self.navigationController pushViewController:detailsView animated:YES];
}

- (IBAction)registerSession:(id)sender {
    
    [WebServiceDataProvider registerSessionIntoViewController:self];
    
}
@end
