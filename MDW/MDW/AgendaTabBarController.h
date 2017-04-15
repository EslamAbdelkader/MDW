//
//  AgendaTabBarController.h
//  MDW
//
//  Created by JETS on 4/15/17.
//  Copyright © 2017 MAD. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AgendaTabBarController : UITabBarController <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) IBOutlet UIBarButtonItem *sidebarButton;

@end
