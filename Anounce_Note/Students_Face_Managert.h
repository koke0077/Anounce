//
//  Students_Face_Managert.h
//  Anounce_Note
//
//  Created by kimsung jun on 2015. 5. 22..
//  Copyright (c) 2015년 kimsung jun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Students_Face_Managert : NSObject

-(void)addWithImageData:(NSData *)img_data ByName:(NSString *)name;

-(void)updateWithImageData:(NSData *)img_data ByName:(NSString *)name;

-(void)removeFaceWithStudents_Namd:(NSString *)name;

-(NSArray *)get_FaceImage;

@end
