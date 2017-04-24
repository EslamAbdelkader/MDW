//
//  ProfileTicketViewController.m
//  MDW
//
//  Created by JETS on 4/23/17.
//  Copyright © 2017 MAD. All rights reserved.
//

#import "ProfileTicketViewController.h"
#import <ZXingObjC.h>
#import "ProfileTabBarController.h"

@implementation ProfileTicketViewController{
    AttendeeDTO *attendee;
}

-(void)viewDidLoad{
    [super viewDidLoad];
    [self.storyboard instantiateViewControllerWithIdentifier:@"profileTicketView"];
    
    ProfileTabBarController *profCont = self.tabBarController;
    attendee = profCont.attendee;
    
    NSError *error = nil;
    ZXMultiFormatWriter *writer = [ZXMultiFormatWriter writer];
    ZXBitMatrix* result = [writer encode:attendee.code
                                  format:kBarcodeFormatQRCode
                                   width:500
                                  height:500
                                   error:&error];
    if (result) {
        CGImageRef image = [[ZXImage imageWithMatrix:result] cgimage];
        _barcodeImg.image = [[UIImage alloc] initWithCGImage:image];
        
        // This CGImageRef image can be placed in a UIImage, NSImage, or written to a file.
    } else {
        NSString *errorMessage = [error localizedDescription];
        NSLog(@"=====ERROR IN CREATING BARCODE: %@", errorMessage);
    }
}

@end
