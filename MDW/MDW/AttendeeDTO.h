//
//  AttendeeDTO.h
//  testRelam
//
//  Created by marko on 4/14/17.
//  Copyright © 2017 marko. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AttendeeDTO : NSObject <NSCoding>
@property int id;
@property NSString * firstName;
@property NSString * middleName;
@property NSString * lastName;
@property NSString * email;
@property NSString * countryName;
@property NSString * cityName;
@property NSMutableArray<NSString *> *mobiles;
@property NSMutableArray<NSString *> *phones;
@property NSString * code;
@property NSString * companyName;
@property NSString * title;
@property NSString * imageURL;
@property NSData * image;
@property BOOL gender;
@property long long *birthDate;
@end
