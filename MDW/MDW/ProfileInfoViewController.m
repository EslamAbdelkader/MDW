//
//  ProfileInfoViewController.m
//  MDW
//
//  Created by JETS on 4/23/17.
//  Copyright © 2017 MAD. All rights reserved.
//

#import "ProfileInfoViewController.h"
#import "ProfileTabBarController.h"
#import "AttendeeDTO.h"

@implementation ProfileInfoViewController{
    AttendeeDTO *attendee;
}

-(void)viewDidLoad{
    [super viewDidLoad];
    [self.storyboard instantiateViewControllerWithIdentifier:@"profileInfoView"];
    
    ProfileTabBarController *profCont = self.tabBarController;
    attendee = profCont.attendee;
    
    _nameLbl.text = [[[[attendee.firstName stringByAppendingString:@" "] stringByAppendingString:
    attendee.middleName] stringByAppendingString:@" "] stringByAppendingString:attendee.lastName];
    
    _titleLbl.text = attendee.title;
    
    _orgLbl.text = attendee.companyName;
}

@end
