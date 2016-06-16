//
//  Lms_List_Get.m
//  Anounce_Note
//
//  Created by kimsung jun on 2015. 5. 21..
//  Copyright (c) 2015년 kimsung jun. All rights reserved.
//

#import "Lms_List_Get.h"

#define NSEUCKRStringEncoding -2147481280

@interface Lms_List_Get (){
    
    NSString *re_url;
    
    NSString *myschool_url;
}

@property NSMutableData *cacheData;
@property NSURLConnection *connection;
@property NSMutableArray *data_arr;

@end

@implementation Lms_List_Get

-(void)parsingWithUserToken:(NSString *)token Value:(NSString *)value Url:(NSString *)class_url{
    
    //SSL 리퀘스트
    /*    NSURL *url = [NSURL URLWithString:class_url];
    
    NSString *stringKey = token;
    
    NSString *stringValue = value;
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    
    NSString *stringData = [NSString stringWithFormat:@"%@=%@",stringKey, stringValue];
    
    request.HTTPBody = [stringData dataUsingEncoding:NSEUCKRStringEncoding];
    
    request.HTTPMethod = @"POST";
    
    self.cacheData = [NSMutableData data];
    
    [NSURLConnection connectionWithRequest:request delegate:self];
    
    
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    
    [NSURLConnection sendAsynchronousRequest:request queue:queue completionHandler:^(NSURLResponse *response, NSData *data, NSError *error)
     {
         if (error == nil) {
             [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"apnsTokenSentSuccessfully"];
             NSLog(@"Token is being sent successfully");
             //you can check server response here if you need
         }
     }];
     */
}

-(void)nonLmsParsingUrl:(NSString *)slass_url{
    NSURL *url = [NSURL URLWithString:slass_url];
    
    
    self.cacheData = [NSMutableData data];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    [NSURLConnection connectionWithRequest:request delegate:self];
}

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
    
    [self.cacheData appendData:data];
}

-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{
    
}

//개별 알림url
-(NSArray *)devideString:(NSString *)HTML{
    
    NSString *startTag = @"replyTle2";
    NSString *secondTag = @"read";
    NSString *endTag = @"\"";
    
    NSMutableString *url_list = [[NSMutableString alloc]init];
    
    
    NSMutableArray *HTMLList = [[NSMutableArray alloc] init];
    
    int startLoc;
    int endLoc;
    
    
    NSRange aRange = NSMakeRange(0, [HTML length]);
    
    while (YES) {
        
        [url_list appendString:@"http://lms.gnedu.net/mr_classroom/read"];
        
        aRange = [HTML rangeOfString:startTag options:NSCaseInsensitiveSearch range:aRange];
        
        
        //검색을 했을 때 검색 결과가 없으면 length가 0이 되므로 While 문을 종료한다.
        if (aRange.length == 0) break;
        
        //검색을 완료하였을 경우에 검색에서 찾은 부분의
        //가장 앞부분의 위치가 Location에 저장되고, 그 Location을 startLoc에 저장한다.
        startLoc = (int)aRange.location;
        
        //aRange의 length를 전체 HTML String에서 처음 검색된 부분의 위치를 뺀다.
        aRange.length = HTML.length - startLoc;
        
        aRange = [HTML rangeOfString:secondTag options:NSCaseInsensitiveSearch range:aRange];
        
        if (aRange.length == 0) {
            break;
        }
        
        startLoc = (int)aRange.location;
        aRange.length = HTML.length - startLoc;
        
        startLoc = startLoc + (int)secondTag.length;
        
        aRange = [HTML rangeOfString:endTag options:NSCaseInsensitiveSearch range:aRange];
        
        if (aRange.length == 0) {
            break;
        }
        
        endLoc = (int)aRange.location;
        
        aRange.length = HTML.length - endLoc;
        
        NSRange endRange;
        NSString *rangeBlock;
        
        endRange = NSMakeRange(startLoc, endLoc - startLoc);
        rangeBlock = [HTML substringWithRange:endRange];
        rangeBlock = [rangeBlock stringByReplacingOccurrencesOfString:@"\\\"" withString:@""];
        [url_list appendString:rangeBlock];
        [HTMLList addObject:url_list];
        url_list = [NSMutableString stringWithString:@""];
        
        
    }
    
    
    return HTMLList;
    
}

//개별 Title
-(NSArray *)devideString2:(NSString *)HTML{
    
    NSString *startTag = @"replyTle2";
    NSString *secondTag = @"use_loading";
    NSString *endTag = @"</a>";
    
    NSMutableArray *HTMLList = [[NSMutableArray alloc] init];
    
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
        
        if (aRange.length == 0) {
            break;
        }
        
        startLoc = (int)aRange.location;
        aRange.length = HTML.length - startLoc;
        
        startLoc = startLoc + (int)secondTag.length;
        
        aRange = [HTML rangeOfString:endTag options:NSCaseInsensitiveSearch range:aRange];
        
        if (aRange.length == 0) {
            break;
        }
        
        endLoc = (int)aRange.location;
        
        aRange.length = HTML.length - endLoc;
        
        NSRange endRange;
        NSString *rangeBlock;
        
        endRange = NSMakeRange(startLoc, endLoc - startLoc);
        rangeBlock = [HTML substringWithRange:endRange];
        rangeBlock = [rangeBlock stringByReplacingOccurrencesOfString:@"\">" withString:@""];
        rangeBlock = [rangeBlock stringByReplacingOccurrencesOfString:@"\r\n\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\r\n\t\t\t\t\t\t\t\t\t\t\t" withString:@""];
        rangeBlock = [rangeBlock stringByReplacingOccurrencesOfString:@"\r\n\t\t\t\t\t\t\t\t\t\t\t\r\n\t\t\t\t\t\t\t\t\t\t\t\r\n\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t" withString:@""];
        [HTMLList addObject:rangeBlock];
        
    }
    
    
    return HTMLList;
    
}

-(NSArray *)devideString3:(NSString *)HTML{
    
    NSString *startTag = @"replyTle2";
    NSString *secondTag = @"use_loading";
    NSString *endTag = @"</a>";
    
    NSMutableArray *HTMLList = [[NSMutableArray alloc] init];
    
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
        
        if (aRange.length == 0) {
            break;
        }
        
        startLoc = (int)aRange.location;
        aRange.length = HTML.length - startLoc;
        
        startLoc = startLoc + (int)secondTag.length;
        
        aRange = [HTML rangeOfString:endTag options:NSCaseInsensitiveSearch range:aRange];
        
        if (aRange.length == 0) {
            break;
        }
        
        endLoc = (int)aRange.location;
        
        aRange.length = HTML.length - endLoc;
        
        NSRange endRange;
        NSString *rangeBlock;
        
        endRange = NSMakeRange(startLoc, endLoc - startLoc);
        rangeBlock = [HTML substringWithRange:endRange];
        rangeBlock = [rangeBlock stringByReplacingOccurrencesOfString:@"amp;" withString:@""];
        [HTMLList addObject:rangeBlock];
        
    }
    
    
    return HTMLList;
    
}

-(void)connectionDidFinishLoading:(NSURLConnection *)connection{
    
    NSString *html = [[NSString alloc]initWithData:self.cacheData encoding:NSEUCKRStringEncoding];
    
    NSArray *array_url = [self devideString:html];
    NSArray *array_title = [ self devideString2:html];


//    NSLog(@"- %@ -", array_url);
//    NSLog(@"%@", array_title);
    
    [self.delegate compliteLmsParsingWithUrl_Array:array_url Tilte_Array:array_title];
    
    
}

@end
