//
//  SpeakersViewController.m
//  MDW
//
//  Created by JETS on 4/14/17.
//  Copyright © 2017 MAD. All rights reserved.
//

#import "SpeakersViewController.h"
#import "SWRevealViewController.h"
#import "SpeakerDTO.h"
#import "SpeakerDetailsViewController.h"
#import "UIImageView+ImageDownload.h"
#import "WebServiceDataProvider.h"
#import "DBHandler.h"

@implementation SpeakersViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Speakers";
    
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_speakers count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SpeakerCell" forIndexPath:indexPath];
    
    SpeakerDTO *speaker = [_speakers objectAtIndex:indexPath.row];
    
    UIImageView *img = [cell viewWithTag:1];
    UILabel *name = [cell viewWithTag:2];
    UILabel *title = [cell viewWithTag:3];
    
    //set image
    [img setSpeakerImageByURLString:speaker.imageURL];
    
    name.text =[[speaker.firstName stringByAppendingString:@" "] stringByAppendingString:speaker.lastName];
    
    title.text = speaker.title;
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    SpeakerDTO *speaker = [_speakers objectAtIndex:indexPath.row];
    SpeakerDetailsViewController *detailsView = [self.storyboard instantiateViewControllerWithIdentifier:@"speakerDetails"];
    detailsView.speaker = speaker;
    [self.navigationController pushViewController:detailsView animated:YES];
}

-(void)viewWillAppear:(BOOL)animated{
    [self refreshTable];
    [WebServiceDataProvider getSpeakersIntoViewController:self];
}

-(void)refreshTable{
    _speakers = [[DBHandler getDB] getAllSpeakers];
    [self.tableView reloadData];
}


@end
