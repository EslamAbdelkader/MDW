//
//  SpeakerDetailsViewController.h
//  MDW
//
//  Created by JETS on 4/20/17.
//  Copyright © 2017 MAD. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SpeakerDTO.h"

@interface SpeakerDetailsViewController : UIViewController

@property SpeakerDTO *speaker;

@property (strong, nonatomic) IBOutlet UILabel *nameLbl;

@property (strong, nonatomic) IBOutlet UIImageView *imgView;

@property (strong, nonatomic) IBOutlet UILabel *titleLbl;

@property (strong, nonatomic) IBOutlet UILabel *companyLbl;

@property (strong, nonatomic) IBOutlet UIWebView *bioWebview;

@end
