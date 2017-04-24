//
//  ProfileTabBarController.h
//  MDW
//
//  Created by JETS on 4/20/17.
//  Copyright © 2017 MAD. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AttendeeDTO.h"

@interface ProfileTabBarController : UITabBarController

@property (strong, nonatomic) IBOutlet UIBarButtonItem *sidebarButton;

@property AttendeeDTO *attendee;

@end
