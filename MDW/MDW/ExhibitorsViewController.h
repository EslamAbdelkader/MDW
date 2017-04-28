//
//  ExhibitorsViewController.h
//  MDW
//
//  Created by JETS on 4/14/17.
//  Copyright © 2017 MAD. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewControllerDelegate.h"

@interface ExhibitorsViewController : UITableViewController <UITableViewDelegate, UITableViewDataSource, ViewControllerDelegate>

@property (strong, nonatomic) IBOutlet UIBarButtonItem *sidebarButton;

@property NSMutableArray *exhibitors;

@end
