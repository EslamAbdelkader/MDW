//
//  SessionDetailsViewController.m
//  MDW
//
//  Created by JETS on 4/23/17.
//  Copyright © 2017 MAD. All rights reserved.
//

#import "SessionDetailsViewController.h"

@implementation SessionDetailsViewController

-(void)viewDidLoad{
    [super viewDidLoad];
    [self.storyboard instantiateViewControllerWithIdentifier:@"sessionDetailsView"];
    
    _titleLbl.text = _session.name;
    
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
    
    NSString *htmlString = _session.desc;
    NSAttributedString *attrStr = [[NSAttributedString alloc] initWithData:[htmlString dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
    _descLbl.attributedText = attrStr;
    
    //handle speakers in table
}

@end
