//
//  Pass_lms_Class.m
//  Anounce_Note
//
//  Created by kimsung jun on 2015. 5. 18..
//  Copyright (c) 2015년 kimsung jun. All rights reserved.
//

#import "Pass_lms_Class.h"
#import "AppDelegate.h"

#define NSEUCKRStringEncoding -2147481280


@interface Pass_lms_Class (){

}




@property NSMutableData *cacheData;

@end

@implementation Pass_lms_Class

- (void)sendUserToken:(NSString *)token Value:(NSString *)value Url:(NSString *)class_url{
//    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"apnsTokenSentSuccessfully"]) {
//        NSLog(@"apnsTokenSentSuccessfully already");
//        return;
//    }
    //----- SSL 인증 리다이렉트
    /*
    NSURL *url = [NSURL URLWithString:class_url]; //set here your URL
    
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

-(void)start_ParseUrl:(NSString *)class_url{
    
    NSURL *url = [NSURL URLWithString:class_url];
    
    self.cacheData = [NSMutableData data];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    [NSURLConnection connectionWithRequest:request delegate:self];
    
}

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
    
    [self.cacheData appendData:data];
}

-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{
    

    
}

- (NSString *)devideHTMLSring:(NSString *)HTML{
    NSString *startTag = @"snbMain_list";
    NSString *secondTag = @"..";
    NSString *endTag = @"</a>";
    
    NSMutableString *HTMLList = [[NSMutableString alloc] init];
    
    [HTMLList appendString:@"http://lms.gnedu.net"];
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
        
        if ([rangeBlock rangeOfString:@"알림장"].length !=0) {

            rangeBlock = [rangeBlock stringByReplacingOccurrencesOfString:@"\">" withString:@""];
            rangeBlock = [rangeBlock stringByReplacingOccurrencesOfString:@"알림장" withString:@""];
            rangeBlock = [rangeBlock stringByReplacingOccurrencesOfString:@"(모바일)" withString:@""];
            rangeBlock = [rangeBlock stringByReplacingOccurrencesOfString:@"공지사항()" withString:@""];
            [HTMLList appendString:rangeBlock];
            break;
        }
        
    }
    
    
    return HTMLList;
}

- (NSString *)devideHTMLSringToLms:(NSString *)HTML{
    NSString *startTag = @"snbMain_list";
    NSString *secondTag = @"..";
    NSString *endTag = @"\">";
    
    NSMutableString *HTMLList = [[NSMutableString alloc] init];
    
    [HTMLList appendString:@"http://lms.gnedu.net"];
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
        [HTMLList appendString:rangeBlock];
    }
    
    
    return HTMLList;
}


-(void)connectionDidFinishLoading:(NSURLConnection *)connection{
    NSString *html = [[NSString alloc]initWithData:self.cacheData encoding:NSEUCKRStringEncoding];
    
//    NSLog(@"%@", html);
    
    NSString *html_str = [self devideHTMLSring:html];
    
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    
    delegate.lms_url = html_str;
    
    [self.delegate compliteParsing_return_url:html_str];
    
    if (self.blockAfterUpdate) {
        self.blockAfterUpdate();
    }
}

-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{
    
     NSLog(@"error:%@", error);
    [self.delegate failParsingForLmsClass];
}

@end
