//
//  Send_News.m
//  Anounce_Note
//
//  Created by sung jun kim on 2018. 4. 9..
//  Copyright © 2018년 kimsung jun. All rights reserved.
//

#import "Send_News.h"

#define NSEUCKRStringEncoding -2147481280

@interface Send_News(){
    NSString *myshool_url;
    NSMutableArray *url_arr;
    NSMutableArray *title_arr;
}
@property NSMutableData *cacheData;
@property NSURLConnection *connection;
@property NSMutableString *news_str;

@end

@implementation Send_News


-(void)parsingWithSchoolurl:(NSString *)school_url{
    
    self.cacheData = [NSMutableData data];
    
    myshool_url = school_url;
    
    NSURL *url_1 = [NSURL URLWithString:school_url];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url_1];
    
    self.connection = [NSURLConnection connectionWithRequest:request delegate:self];
}


-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
    
    [self.cacheData appendData:data];
}

-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{
    
}


//가정통신문 URL만들기 _1
- (NSString *)devideHTMLSringToNews_List:(NSString *)HTML{
    NSString *startTag;
    NSString *secondTag;
    NSString *endTag;
    
    if ([HTML rangeOfString:@"가정통신문,/"].length != 0) {
        startTag = @"가정통신문,";
        secondTag = @"/";
        endTag = @",";
    }else if([HTML rangeOfString:@">가정통신문<"].length != 0){
        startTag = @"sub_1";
        secondTag = @"<a href=\"";
        //        secondTag = @"\">";
        endTag = @"\">가정통신문";
        
    }else{
        startTag = @"가정";
        secondTag = @"amp;";
        endTag = @",";
    }
    
    NSString *HTMLList = @"";
    
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
        //        rangeBlock = [self stripTags:rangeBlock];
        
        rangeBlock = [rangeBlock stringByReplacingOccurrencesOfString:@"<br />" withString:@""];
        rangeBlock = [rangeBlock stringByReplacingOccurrencesOfString:@"</div>" withString:@""];
        rangeBlock = [rangeBlock stringByReplacingOccurrencesOfString:@"amp;" withString:@""];
        HTMLList = rangeBlock;
        break;
    }
    return HTMLList;
}

- (NSString *)devideHTMLSringToNews_List2:(NSString *)HTML{
    NSString *startTag;
    NSString *secondTag;
    NSString *endTag;
    
   
        startTag = @"s_menu_wrap";
        secondTag = @"href=\"";
        endTag = @"가정통신문";
    
    
    NSString *HTMLList = @"";

    
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
        //        rangeBlock = [self stripTags:rangeBlock];
        
//         rangeBlock = [rangeBlock stringByReplacingOccurrencesOfString:@" " withString:@""];
        rangeBlock = [rangeBlock stringByReplacingOccurrencesOfString:@"<br />" withString:@""];
        rangeBlock = [rangeBlock stringByReplacingOccurrencesOfString:@"</div>" withString:@""];
        rangeBlock = [rangeBlock stringByReplacingOccurrencesOfString:@"amp;" withString:@""];
        HTMLList = rangeBlock;
        break;
    }
//    HTMLList = [HTMLList2 lastObject];
    return HTMLList;
}

- (NSString *)devideHTMLSringToNews_List3:(NSString *)HTML{
    NSString *startTag;
    NSString *secondTag;
    NSString *endTag;
    
    
    startTag = @"<li";
    secondTag = @"href=\"";
    endTag = @"\">";
    
        NSMutableArray *HTMLList2 = [NSMutableArray array];
    NSString *HTMLList = @"";
    
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
        //        rangeBlock = [self stripTags:rangeBlock];
       
        rangeBlock = [rangeBlock stringByReplacingOccurrencesOfString:@"<br />" withString:@""];
        rangeBlock = [rangeBlock stringByReplacingOccurrencesOfString:@"</div>" withString:@""];
        rangeBlock = [rangeBlock stringByReplacingOccurrencesOfString:@"amp;" withString:@""];
        [HTMLList2 addObject:rangeBlock];
//        break;
    }
    
    HTMLList = [HTMLList2 lastObject];
    return HTMLList;
}


- (NSString *)stripTags:(NSString *)str
{
    NSMutableString *html = [NSMutableString string];
    html = [NSMutableString stringWithCapacity:[str length]];
    
    NSScanner *scanner = [NSScanner scannerWithString:str];
    scanner.charactersToBeSkipped = NULL;
    NSString *tempText = nil;
    
    while (![scanner isAtEnd])
    {
        [scanner scanUpToString:@"\">" intoString:&tempText];
        
        if (tempText != nil)
            [html appendString:tempText];
        
        [scanner scanUpToString:@"\"=" intoString:NULL];
        
        if (![scanner isAtEnd])
            [scanner setScanLocation:[scanner scanLocation] + 1];
        
        tempText = nil;
        
    }
    return html;
}


- (NSString *)stripTags2:(NSString *)str
{
    NSMutableString *html = [NSMutableString string];
    html = [NSMutableString stringWithCapacity:[str length]];
    
    NSScanner *scanner = [NSScanner scannerWithString:str];
    scanner.charactersToBeSkipped = NULL;
    NSString *tempText = nil;
    
    while (![scanner isAtEnd])
    {
        [scanner scanUpToString:@"<" intoString:&tempText];
        
        if (tempText != nil)
            [html appendString:tempText];
        
        [scanner scanUpToString:@">" intoString:NULL];
        
        if (![scanner isAtEnd])
            [scanner setScanLocation:[scanner scanLocation] + 1];
        
        tempText = nil;
        
    }
    return html;
}


-(void)connectionDidFinishLoading:(NSURLConnection *)connection{
    
    NSString *htmlData = [[NSString alloc] initWithData:self.cacheData encoding:NSEUCKRStringEncoding];
    
    
    self.news_str = [NSMutableString string];
    [self.news_str appendString:myshool_url];
    [self.news_str appendString:@"/"];
    
    if([htmlData containsString:@",,false"]){
        [self.news_str appendString:[self devideHTMLSringToNews_List:htmlData]];
    }else{
        NSString *test_str1 = [self devideHTMLSringToNews_List2:htmlData];
        NSString *test_str2 = [self devideHTMLSringToNews_List3:test_str1];
        [self.news_str appendString:test_str2];
        
    }
    
    
    
    NSLog(@"news_url = %@",self.news_str);
    [self.delegate compliteToGetSendNewsList:self.news_str];
    
}

@end
