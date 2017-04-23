//
//  ViewControllerDelegate.h
//  MDW
//
//  Created by JETS on 4/19/17.
//  Copyright © 2017 MAD. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ViewControllerDelegate <NSObject>

-(void) refreshTableUsingArray: (NSArray *) array;

@end
