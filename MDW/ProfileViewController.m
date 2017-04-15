//
//  ProfileViewController.m
//  MDW
//
//  Created by JETS on 4/14/17.
//  Copyright © 2017 MAD. All rights reserved.
//

#import "ProfileViewController.h"
#import "SWRevealViewController.h"

@implementation ProfileViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Profile";
    
    SWRevealViewController *revealViewController = self.revealViewController;
    if ( revealViewController )
    {
        [self.sidebarButton setTarget: self.revealViewController];
        [self.sidebarButton setAction: @selector( revealToggle: )];
        [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
