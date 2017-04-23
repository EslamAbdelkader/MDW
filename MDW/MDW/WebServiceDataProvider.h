//
//  WebServiceDataProvider.h
//  MDW
//
//  Created by JETS on 4/15/17.
//  Copyright © 2017 MAD. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "ViewControllerDelegate.h"

@interface WebServiceDataProvider : NSObject

+(void) getAgendasIntoViewController: (id<ViewControllerDelegate>) viewController orLoginFromViewController :(UIViewController *) loginViewController ;
+(void) getSpeakersIntoViewController: (id<ViewControllerDelegate>) viewController;
+(void) getExhibitorsIntoViewController: (id<ViewControllerDelegate>) viewController;
+(void) setImageFromURLString: (NSString *) url intoImageView: (UIImageView *) imageView andSaveObject: (id) object;
+(void) loginWithUserName: (NSString *) userName andPassword: (NSString *) password andViewController: (id<ViewControllerDelegate>) viewController;
+(void) registerSessionIntoViewController: (id<ViewControllerDelegate>) viewController;
@end
