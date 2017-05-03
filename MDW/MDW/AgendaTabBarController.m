//
//  AgendaTabBarController.m
//  MDW
//
//  Created by JETS on 4/15/17.
//  Copyright © 2017 MAD. All rights reserved.
//

#import "AgendaTabBarController.h"
#import "SWRevealViewController.h"

@implementation AgendaTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    SWRevealViewController *revealViewController = self.revealViewController;
    if ( revealViewController )
    {
        [self.sidebarButton setTarget: self.revealViewController];
        [self.sidebarButton setAction: @selector( revealToggle: )];
        [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
        
        UIImageView *bgImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"background"]];
        bgImageView.frame = self.view.bounds;
        [self.view addSubview:bgImageView];
        [self.view sendSubviewToBack:bgImageView];
    }
//    self.title = @"Agenda";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
