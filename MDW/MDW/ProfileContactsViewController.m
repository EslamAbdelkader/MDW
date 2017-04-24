//
//  ProfileContactsViewController.m
//  MDW
//
//  Created by JETS on 4/23/17.
//  Copyright © 2017 MAD. All rights reserved.
//

#import "ProfileContactsViewController.h"
#import "ProfileTabBarController.h"
#import "AttendeeDTO.h"

@implementation ProfileContactsViewController{
    AttendeeDTO *attendee;
}

-(void)viewDidLoad{
    [super viewDidLoad];
    [self.storyboard instantiateViewControllerWithIdentifier:@"profileContactsView"];
    
    ProfileTabBarController *profCont = self.tabBarController;
    attendee = profCont.attendee;
    
    _emailLbl.text = attendee.email;
    //_phoneLbl.text = attendee.
    
    
}

@end
