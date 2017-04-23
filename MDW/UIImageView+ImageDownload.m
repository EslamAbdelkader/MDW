//
//  UIImageView+ImageDownload.m
//  MDW
//
//  Created by JETS on 4/19/17.
//  Copyright © 2017 MAD. All rights reserved.
//

#import "UIImageView+ImageDownload.h"
#import "SpeakerDTO.h"
#import "ExhibitorDTO.h"
#import "WebServiceDataProvider.h"

@implementation UIImageView (ImageDownload)

-(void)setSpeakerImageByURLString:(NSString *)url{
    NSData * data = nil;
    NSString *query = [NSString stringWithFormat:@"%@%@", @"imageURL == ", url];
    SpeakerDTO *speaker = [[SpeakerDTO objectsWhere:query]firstObject];
    data = speaker.image;
    
    if(data){
        self.image = [UIImage imageWithData:data];
    }else{
        [WebServiceDataProvider setImageFromURLString:url intoImageView:self andSaveObject:speaker];
    }
    
}

-(void)setExhibitorImageByURLString:(NSString *)url{
    NSData * data = nil;
    NSString *query = [NSString stringWithFormat:@"%@%@", @"imageURL == ", url];
    ExhibitorDTO *exhibitor = [[ExhibitorDTO objectsWhere:query]firstObject];
    data = exhibitor.image;
    
    if(data){
        self.image = [UIImage imageWithData:data];
    }else{
        [WebServiceDataProvider setImageFromURLString:url intoImageView:self andSaveObject:exhibitor];
    }
    
    
}

@end
