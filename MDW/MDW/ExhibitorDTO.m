//
//  ExhibitorDTO.m
//  testRelam
//
//  Created by marko on 4/14/17.
//  Copyright © 2017 marko. All rights reserved.
//

#import "ExhibitorDTO.h"

@implementation ExhibitorDTO

+(NSString *)primaryKey{
    return @"id";
}

-(void)print{
    NSLog(@"\nid= %d\n email= %@\n countryName= %@\n cityName= %@\n imageURL= %@\n companyName= %@\n companyAbout= %@\n fax= %@\n contactName= %@\n contactTitle= %@\n companyURL= %@\n companyAddress= %@",_id,_email,_countryName, _cityName, _imageURL, _companyName, _companyAbout, _fax, _contactName, _contactTitle, _companyUrl, _companyAddress);
}


@end
