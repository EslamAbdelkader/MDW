//
//  AgendaTabBarController.h
//  MDW
//
//  Created by JETS on 4/15/17.
//  Copyright © 2017 MAD. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AgendaTabBarController : UITabBarController

@property (strong, nonatomic) IBOutlet UIBarButtonItem *sidebarButton;

@property NSMutableArray *agendas;

@property NSString *myTitle;

@property NSString *agendaType;

@end
