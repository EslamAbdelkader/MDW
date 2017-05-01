//
//  AttendeeDTO.m
//  testRelam
//
//  Created by marko on 4/14/17.
//  Copyright © 2017 marko. All rights reserved.
//

#import "AttendeeDTO.h"

@implementation AttendeeDTO

-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    self.id=[aDecoder decodeIntForKey:@"id"];
    self.firstName=[aDecoder decodeObjectForKey:@"firstName"];
    self.middleName=[aDecoder decodeObjectForKey:@"middleName"];
    self.lastName=[aDecoder decodeObjectForKey:@"lastName"];
    self.email=[aDecoder decodeObjectForKey:@"email"];
    self.countryName=[aDecoder decodeObjectForKey:@"countryName"];
    self.cityName=[aDecoder decodeObjectForKey:@"cityName"];
    self.mobiles=[aDecoder decodeObjectForKey:@"mobiles"];
    self.phones=[aDecoder decodeObjectForKey:@"phones"];
    self.code=[aDecoder decodeObjectForKey:@"code"];
    self.companyName=[aDecoder decodeObjectForKey:@"companyName"];
    self.title=[aDecoder decodeObjectForKey:@"title"];
    self.imageURL=[aDecoder decodeObjectForKey:@"imageURL"];
    self.image=[aDecoder decodeObjectForKey:@"image"];
    self.gender=[aDecoder decodeBoolForKey:@"gender"];
    self.birthDate=[aDecoder decodeInt32ForKey:@"birthDate"];
    
    return self;
}
-(void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeInt:_id forKey:@"id"];
    [aCoder encodeObject:_firstName forKey:@"firstName"];
    [aCoder encodeObject:_middleName forKey:@"middleName"];
    [aCoder encodeObject:_lastName forKey:@"lastName"];
    [aCoder encodeObject:_email forKey:@"email"];
    [aCoder encodeObject:_countryName forKey:@"countryName"];
    [aCoder encodeObject:_cityName forKey:@"cityName"];
    [aCoder encodeObject:_mobiles forKey:@"mobiles"];
    [aCoder encodeObject:_phones forKey:@"phones"];
    [aCoder encodeObject:_code forKey:@"code"];
    [aCoder encodeObject:_companyName forKey:@"companyName"];
    [aCoder encodeObject:_title forKey:@"title"];
    [aCoder encodeObject:_imageURL forKey:@"imageURL"];
    [aCoder encodeObject:_image forKey:@"image"];
    [aCoder encodeBool:_gender forKey:@"gender"];
    [aCoder encodeInt32:_birthDate forKey:@"birthDate"];
    
}


@end
