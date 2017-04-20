//
//  ProfileTabBarController.m
//  MDW
//
//  Created by JETS on 4/20/17.
//  Copyright © 2017 MAD. All rights reserved.
//

#import "ProfileTabBarController.h"
#import "SWRevealViewController.h"

@implementation ProfileTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //Or My Agenda, depending on the segue
    self.title = @"Profile";
    
    SWRevealViewController *revealViewController = self.revealViewController;
    if ( revealViewController )
    {
        [self.sidebarButton setTarget: self.revealViewController];
        [self.sidebarButton setAction: @selector( revealToggle: )];
        [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
        
//        UIImageView *bgImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"background"]];
//        bgImageView.frame = self.view.bounds;
//        [self.view addSubview:bgImageView];
//        [self.view sendSubviewToBack:bgImageView];
    }
    
}

@end
