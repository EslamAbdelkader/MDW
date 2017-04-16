//
//  ExhibitorDTO.h
//  testRelam
//
//  Created by marko on 4/14/17.
//  Copyright © 2017 marko. All rights reserved.
//

#import <Realm/Realm.h>

@interface ExhibitorDTO : RLMObject
@property int id;
@property NSString * email;
@property NSString * countryName;
@property NSString * cityName;
//@property NSMutableArray<NSString *> *mobiles;
//@property NSMutableArray<NSString *> *phones;
@property NSString * companyName;
@property NSString * companyAbout;
@property NSString * imageURL;
@property NSString * fax;
@property NSString * contactName;
@property NSString * contactTitle;
@property NSString * companyUrl;
@property NSString * companyAddress;

-(void) print;
@end
