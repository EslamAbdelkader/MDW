//
//  ExhibitorsViewController.m
//  MDW
//
//  Created by JETS on 4/14/17.
//  Copyright © 2017 MAD. All rights reserved.
//

#import "ExhibitorsViewController.h"
#import "SWRevealViewController.h"
#import "ExhibitorDTO.h"
#import "UIImageView+ImageDownload.h"
#import "WebServiceDataProvider.h"
#import "DBHandler.h"

@implementation ExhibitorsViewController{
    UIRefreshControl *refreshControl;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.storyboard instantiateViewControllerWithIdentifier:@"ExhibitorsView"];
    
    self.title = @"Exhibitors";
    
    refreshControl = [[UIRefreshControl alloc] init];
    NSAttributedString *text = [[NSAttributedString alloc]initWithString:@"Refreshing.."];
    [refreshControl setAttributedTitle:text];
    [refreshControl setBackgroundColor:[UIColor orangeColor]];
    [refreshControl addTarget:self action:@selector(refreshExhibitors) forControlEvents:UIControlEventValueChanged];
    [self.tableView  addSubview:refreshControl];
    
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
    
}

-(void) refreshExhibitors{
    [WebServiceDataProvider getExhibitorsIntoViewController:self];
}

-(void) refreshTable{
    _exhibitors = [[DBHandler getDB] getAllExhibitors];
    [self.tableView reloadData];
    [refreshControl endRefreshing];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_exhibitors count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ExhibitorCell" forIndexPath:indexPath];
    
    ExhibitorDTO *currEx = [_exhibitors objectAtIndex:indexPath.row];
    
    UIImageView *img = [cell viewWithTag:1];
    UILabel *name = [cell viewWithTag:2];
    
    //set image
    [img setExhibitorImageByURLString:currEx.imageURL];
    
    name.text = currEx.companyName;

    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ExhibitorDTO *ex = [_exhibitors objectAtIndex:indexPath.row];
    NSString *url = ex.companyUrl;
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
}

-(void)viewWillAppear:(BOOL)animated{
    [self refreshTable];
    [WebServiceDataProvider getExhibitorsIntoViewController:self];
}

@end
