//
//  ViewController.m
//  MDW
//
//  Created by Michael on 4/12/17.
//  Copyright © 2017 MAD. All rights reserved.
//

#import "ViewController.h"
#import "SWRevealViewController.h"
#import "WebServiceDataProvider.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    UIImageView *bgImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"splash"]];
    bgImageView.frame = self.view.bounds;
    [self.view addSubview:bgImageView];
    [self.view sendSubviewToBack:bgImageView];
    
    _alert = [[UIAlertView alloc] initWithTitle:@"Failed to login"
                                                    message:@"Wrong username or password."
                                                   delegate:self
                                          cancelButtonTitle:@"Cancel"
                                          otherButtonTitles:nil];
    
    _networkAlert = [[UIAlertView alloc] initWithTitle:@"Connection error"
                                        message:@"Please check your connection."
                                       delegate:self
                              cancelButtonTitle:@"Cancel"
                              otherButtonTitles:nil];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)loginBtnAction:(id)sender {
    
    NSString *email = _emailTxt.text;
    NSString *pass = _passwordTxt.text;
    
//    SWRevealViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"revealController"];
    [WebServiceDataProvider loginWithUserName:email andPassword:pass andViewController:self];
    [_indicator startAnimating];
    [self.view setUserInteractionEnabled:NO];
    //[self presentViewController:vc animated:YES completion:nil];
}


/* Auto Login - BUG : Login Already Appeared
-(void)viewDidAppear:(BOOL)animated{
    //Checking for NSUserDefaults
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSData* userData = [userDefaults objectForKey:@"user"];
    if(userData != nil){
        NSLog(@"Let him in");
        SWRevealViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"revealController"];
        
        
        [self presentViewController:vc animated:YES completion:nil];
    }
}
 */

@end
