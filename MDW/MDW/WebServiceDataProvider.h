//
//  WebServiceDataProvider.h
//  MDW
//
//  Created by JETS on 4/15/17.
//  Copyright © 2017 MAD. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WebServiceDataProvider : NSObject
+(void) getAgendas;
+(void) getSpeakers;
+(void) getExhibitors;
+(void) getProfileImage;
+(void) login;
+(void) registerSession;
@end
