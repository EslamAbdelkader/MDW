//
//  SpeakerDTO.h
//  testRelam
//
//  Created by marko on 4/14/17.
//  Copyright © 2017 marko. All rights reserved.
//

#import <Realm/Realm.h>

@interface SpeakerDTO : RLMObject

@property int id;
@property NSString * firstName;
@property NSString * middleName;
@property NSString * lastName;
@property NSString * imageURL;
@property NSData * image;
@property NSString * companyName;
@property NSString * title;
@property BOOL gender ;
@property NSString * biography;
//@property NSMutableArray *mobiles;
//@property NSMutableArray *phones;

-(void)print;

@end
RLM_ARRAY_TYPE(SpeakerDTO)
