//
//  Board_Url_1.m
//  Anounce_Note
//
//  Created by kimsung jun on 2015. 5. 20..
//  Copyright (c) 2015년 kimsung jun. All rights reserved.
//

#import "Board_Url_1.h"

#define NSEUCKRStringEncoding -2147481280

@interface Board_Url_1 (){
    
    NSString *re_url;
    
    NSString *myschool_url;
}

@property NSMutableData *cacheData;
@property NSURLConnection *connection;

@end

@implementation Board_Url_1

-(void)parsingWithUrl:(NSString *)url School:(NSString *)school_url{
    
    if (self.cacheData==nil) {
        self.cacheData = [[NSMutableData alloc] init];
    }
    
    myschool_url = school_url;
    
    NSURL *url_2 = [NSURL URLWithString:url];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url_2];
    
    self.connection = [NSURLConnection connectionWithRequest:request delegate:self];
    
}

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
    
    [self.cacheData appendData:data];
}

-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{
    
}

-(NSString *)devideString:(NSString *)HTML{
    
    NSString *startTag = @"<div class=\"menu\">";
    NSString *secondTag = @"title\"><a href=\".";
    NSString *endTag = @"</a>";
    
    NSMutableString *HTMLList = [[NSMutableString alloc] init];

    [HTMLList appendString:myschool_url];
    [HTMLList appendFormat:@"/modules/cafe/class"];
    //    [HTMLList appendString:self.semi];
    
    int startLoc;
    int endLoc;
    
    
    NSRange aRange = NSMakeRange(0, [HTML length]);
    
    while (YES) {
        
        aRange = [HTML rangeOfString:startTag options:NSCaseInsensitiveSearch range:aRange];
        
        
        //검색을 했을 때 검색 결과가 없으면 length가 0이 되므로 While 문을 종료한다.
        if (aRange.length == 0) break;
        
        //검색을 완료하였을 경우에 검색에서 찾은 부분의
        //가장 앞부분의 위치가 Location에 저장되고, 그 Location을 startLoc에 저장한다.
        startLoc = (int)aRange.location;
        
        //aRange의 length를 전체 HTML String에서 처음 검색된 부분의 위치를 뺀다.
        aRange.length = HTML.length - startLoc;
        
        aRange = [HTML rangeOfString:secondTag options:NSCaseInsensitiveSearch range:aRange];
        
        startLoc = (int)aRange.location;
        aRange.length = HTML.length - startLoc;
        
        startLoc = (int)startLoc + (int)secondTag.length;
        
        aRange = [HTML rangeOfString:endTag options:NSCaseInsensitiveSearch range:aRange];
        endLoc = (int)aRange.location;
        
        aRange.length = HTML.length - endLoc;
        
        NSRange endRange;
        NSString *rangeBlock;
        
        endRange = NSMakeRange(startLoc, endLoc - startLoc);
        rangeBlock = [HTML substringWithRange:endRange];
        if ([rangeBlock containsString:@"알림"]) {
            rangeBlock = [rangeBlock stringByReplacingOccurrencesOfString:@"amp;" withString:@""];
            rangeBlock = [rangeBlock stringByReplacingOccurrencesOfString:@"알림장" withString:@""];
            rangeBlock = [rangeBlock stringByReplacingOccurrencesOfString:@"매일" withString:@""];//안골포초등학교 6-2 알림장 불러오기 오류해결
            rangeBlock = [rangeBlock stringByReplacingOccurrencesOfString:@"우리반" withString:@""];
            rangeBlock = [rangeBlock stringByReplacingOccurrencesOfString:@" " withString:@""];
            rangeBlock = [rangeBlock stringByReplacingOccurrencesOfString:@"\">" withString:@""];
            rangeBlock = [rangeBlock stringByReplacingOccurrencesOfString:@"기억해요" withString:@""];
            rangeBlock = [rangeBlock stringByReplacingOccurrencesOfString:@"오늘의" withString:@""];//용호초등학교 4-2 알림장 불러오기 오류해결
            rangeBlock = [rangeBlock stringByReplacingOccurrencesOfString:@"알림내용" withString:@""];
            rangeBlock = [rangeBlock stringByReplacingOccurrencesOfString:@"*" withString:@""];
            [HTMLList appendString:rangeBlock];
            [HTMLList appendString:@"%BE%CB%B8%B2%C0%E5"];
            break;
        }
        
    }
    

    
    
    return HTMLList;
    
}

-(void)connectionDidFinishLoading:(NSURLConnection *)connection{
    
    NSString *html = [[NSString alloc]initWithData:self.cacheData encoding:NSEUCKRStringEncoding];
    
    [self.delegate complite_Board_Parsing:[self devideString:html]];
    
//    NSLog(@"%@\n\n 끝난건가?", html);
}

@end
