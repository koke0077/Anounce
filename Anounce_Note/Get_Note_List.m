//
//  Get_Note_List.m
//  Anounce_Note
//
//  Created by kimsung jun on 2015. 5. 19..
//  Copyright (c) 2015년 kimsung jun. All rights reserved.
//

#import "Get_Note_List.h"

#define NSEUCKRStringEncoding -2147481280

@interface Get_Note_List ()

@property NSMutableData *receiveData;
@property NSURLConnection *connection;

@end

@implementation Get_Note_List

-(void)parsingWithUrl:(NSString *)url{
    
    if (self.receiveData==nil) {
        self.receiveData = [[NSMutableData alloc] init];
    }
    
    
    NSURL *url_2 = [NSURL URLWithString:url];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url_2];
    
    self.connection = [NSURLConnection connectionWithRequest:request delegate:self];
    
}

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
    
    [self.receiveData appendData:data];
}

-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{
    
}

-(void)connectionDidFinishLoading:(NSURLConnection *)connection{
    
//    NSString *html = [[NSString alloc]initWithData:self.receiveData encoding:NSEUCKRStringEncoding];
    
//    NSLog(@"%@\n\n 끝난건가?", html);
}

@end
