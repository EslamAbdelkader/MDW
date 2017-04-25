//
//  ViewController.h
//  MDW
//
//  Created by Michael on 4/12/17.
//  Copyright © 2017 MAD. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

- (IBAction)loginBtnAction:(id)sender;

@property (strong, nonatomic) IBOutlet UITextField *emailTxt;

@property (strong, nonatomic) IBOutlet UITextField *passwordTxt;

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *indicator;

@property UIAlertView *alert;

@property UIAlertView *networkAlert;

@end

