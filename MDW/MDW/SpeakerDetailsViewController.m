//
//  SpeakerDetailsViewController.m
//  MDW
//
//  Created by JETS on 4/20/17.
//  Copyright © 2017 MAD. All rights reserved.
//

#import "SpeakerDetailsViewController.h"

@implementation SpeakerDetailsViewController

-(void)viewDidLoad{
    [super viewDidLoad];
    [self.storyboard instantiateViewControllerWithIdentifier:@"speakerDetails"];
    
    _nameLbl.text = [[_speaker.firstName stringByAppendingString:@""] stringByAppendingString:_speaker.lastName];
    //set image
    _titleLbl.text = _speaker.title;
    _companyLbl.text = _speaker.companyName;
    
    [_bioWebview loadHTMLString:[NSString stringWithFormat:@"<div align='center'>%@<div>", _speaker.biography]
    baseURL:nil];
}

@end
