//
//  SessionDetailsViewController.h
//  MDW
//
//  Created by JETS on 4/23/17.
//  Copyright © 2017 MAD. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SessionDTO.h"

@interface SessionDetailsViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property SessionDTO *session;

@property (strong, nonatomic) IBOutlet UILabel *titleLbl;

@property (strong, nonatomic) IBOutlet UILabel *dateLbl;

@property (strong, nonatomic) IBOutlet UILabel *timeLbl;

@property (strong, nonatomic) IBOutlet UIImageView *starImg;

@property (strong, nonatomic) IBOutlet UILabel *locationLbl;

@property (strong, nonatomic) IBOutlet UILabel *descLbl;

@property (strong, nonatomic) IBOutlet UITableView *speakersTable;

@end
