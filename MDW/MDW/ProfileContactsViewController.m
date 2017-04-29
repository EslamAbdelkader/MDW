//
//  ProfileContactsViewController.m
//  MDW
//
//  Created by JETS on 4/23/17.
//  Copyright © 2017 MAD. All rights reserved.
//

#import "ProfileContactsViewController.h"
#import "ProfileTabBarController.h"
#import "AttendeeDTO.h"
#import <ZXingObjC.h>

@implementation ProfileContactsViewController{
    AttendeeDTO *attendee;
}

-(void)viewDidLoad{
    [super viewDidLoad];
    [self.storyboard instantiateViewControllerWithIdentifier:@"profileContactsView"];
    
    ProfileTabBarController *profCont = self.tabBarController;
    attendee = profCont.attendee;
    
    _emailLbl.text = attendee.email;
    //_phoneLbl.text = attendee.
    
    NSString *encodedData=[ NSString stringWithFormat:@"BEGIN:VCARD\nVERSION:3.0\nN:%@;%@\nFN:\nORG:%@\nTITLE:%@\nTEL;CELL:%@\nEMAIL;WORK;INTERNET:%@\nURL:\nEND:VCARD", attendee.firstName, attendee.lastName, attendee.companyName, attendee.title, @"123", attendee.email];

    NSError *error = nil;
    CGImageRef image = nil;
    ZXMultiFormatWriter *writer = [ZXMultiFormatWriter writer];
    ZXBitMatrix* result = [writer encode:encodedData
                                  format:kBarcodeFormatQRCode
                                   width:500
                                  height:500
                                   error:&error];
    if (result) {
        image = [[ZXImage imageWithMatrix:result] cgimage];
        [_qrImg setImage:[[UIImage alloc]initWithCGImage:image]];
    }
}

@end
