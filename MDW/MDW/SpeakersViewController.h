//
//  SpeakersViewController.h
//  MDW
//
//  Created by JETS on 4/14/17.
//  Copyright © 2017 MAD. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SpeakersViewController : UITableViewController <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) IBOutlet UIBarButtonItem *sidebarButton;

@property NSMutableArray *speakers;

@end
