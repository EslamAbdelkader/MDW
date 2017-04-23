//
//  SidebarTableViewController.m
//  MDW
//
//  Created by JETS on 4/13/17.
//  Copyright © 2017 MAD. All rights reserved.
//

#import "SidebarTableViewController.h"
#import "SWRevealViewController.h"
#import "AgendaTabBarController.h"
#import "DBHandler.h"
#import "ExhibitorsViewController.h"
#import "SpeakersViewController.h"

@interface SidebarTableViewController ()

@end

@implementation SidebarTableViewController {
    NSArray *menuItems;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    menuItems = @[@"title", @"agenda", @"myAgenda", @"speakers", @"exhibitors", @"profile", @"logout"];
    
    UIImageView *bgImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"leftSideMenuBackground"]];
    bgImageView.frame = self.view.bounds;
    [self.view addSubview:bgImageView];
    [self.view sendSubviewToBack:bgImageView];
    self.tableView.opaque = NO;
    self.tableView.backgroundColor = [UIColor clearColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return menuItems.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *CellIdentifier = [menuItems objectAtIndex:indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    cell.contentView.backgroundColor = [UIColor clearColor];
    cell.backgroundColor = [UIColor clearColor];
    
    return cell;
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    // Set the title of navigation bar by using the menu items
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    UINavigationController *destViewController = (UINavigationController*)segue.destinationViewController;
    destViewController.title = [[menuItems objectAtIndex:indexPath.row] capitalizedString];
    
    // Prepare all the views with respect to the segue identifier
    if ([segue.identifier isEqualToString:@"agendaSeg"]) {
        UINavigationController *navController = segue.destinationViewController;
        AgendaTabBarController *agendaController = [navController childViewControllers].firstObject;
        agendaController.title = @"Agenda";
        agendaController.agendas = [[DBHandler getDB] getAllAgendas];
    }
    else if ([segue.identifier isEqualToString:@"myAgendaSeg"]) {
        UINavigationController *navController = segue.destinationViewController;
        AgendaTabBarController *agendaController = [navController childViewControllers].firstObject;
        agendaController.myTitle = @"My Agenda";
        agendaController.agendas = [[DBHandler getDB] getAllMyAgendas];
    }
    else if ([segue.identifier isEqualToString:@"speakersSeg"]) {
        UINavigationController *navController = segue.destinationViewController;
        SpeakersViewController *speakersController = [navController childViewControllers].firstObject;
        //speakersController.speakers = [[DBHandler getDB] ];
    }
    else if ([segue.identifier isEqualToString:@"exhibitorsSeg"]) {
        UINavigationController *navController = segue.destinationViewController;
        ExhibitorsViewController *exhibitorsController = [navController childViewControllers].firstObject;
        //exhibitorsController.exhibitors = [[DBHandler getDB] ];
    }
}

- (CGFloat)tableView:(UITableView *)aTableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    switch (indexPath.row){
        case 0:
            return 150.0; // first row is 150pt high

    }
    return 50.0; // all other rows are 50pt high
}


@end
