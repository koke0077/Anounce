//
//  News_List_Get.m
//  Anounce_Note
//
//  Created by kimsung jun on 2015. 5. 27..
//  Copyright (c) 2015년 kimsung jun. All rights reserved.
//

#import "News_List_Get.h"

#define NSEUCKRStringEncoding -2147481280

@interface News_List_Get (){
    
    NSString *myshool_url;
    NSMutableArray *url_arr;
    NSMutableArray *title_arr;
}

@property NSMutableData *cacheData;
@property NSURLConnection *connection;
@property NSMutableArray *data_arr;

@end

@implementation News_List_Get


-(void)parsingWithSchoolurl:(NSString *)list_url WithSchool_url:(NSString *)school_url{
    

//        self.cacheData = [[NSMutableData alloc] init];
    
    self.cacheData = [NSMutableData data];
    list_url = [list_url stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    myshool_url = school_url;
    
    NSURL *url_1 = [NSURL URLWithString:list_url];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url_1];
    
    self.connection = [NSURLConnection connectionWithRequest:request delegate:self];
}


-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
    
    [self.cacheData appendData:data];
}

-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{
    
}

//뉴스 url생성
-(NSArray *)devideStringToUrl:(NSString *)HTML{
    
    NSString *startTag = @"m_ltitle";
    NSString *secondTag = @"href=\"";
    NSString *endTag = @"\">";
    
    NSMutableString *url_list = [[NSMutableString alloc]init];
    
    
    NSMutableArray *HTMLList = [[NSMutableArray alloc] init];
    [HTMLList removeAllObjects];
    
    int startLoc;
    int endLoc;
    
    
    NSRange aRange = NSMakeRange(0, [HTML length]);
    
    while (YES) {
        
        [url_list appendString:myshool_url];
        
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
        [url_list appendString:rangeBlock];
        [HTMLList addObject:url_list];
        url_list = [NSMutableString stringWithString:@""];
    }
    
    
    return HTMLList;
    
}

//뉴스 타이틀 만들기
-(NSArray *)devideStringToTitle:(NSString *)HTML{
    
    NSString *startTag = @"m_ltitle";
    NSString *secondTag = @"\">";
    NSString *endTag = @"</a>";
    
    NSMutableArray *HTMLList = [[NSMutableArray alloc] init];
    [HTMLList removeAllObjects];
    
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
        rangeBlock = [self stripTags:rangeBlock];
        rangeBlock = [rangeBlock stringByReplacingOccurrencesOfString:@"\t" withString:@""];
        rangeBlock = [rangeBlock stringByReplacingOccurrencesOfString:@"&#39;" withString:@""];
        rangeBlock = [rangeBlock stringByReplacingOccurrencesOfString:@"&#39" withString:@""];
        rangeBlock = [rangeBlock stringByReplacingOccurrencesOfString:@"&quot;" withString:@""];
        rangeBlock = [rangeBlock stringByReplacingOccurrencesOfString:@"\r" withString:@""];
        rangeBlock = [rangeBlock stringByReplacingOccurrencesOfString:@"\n" withString:@""];
        rangeBlock = [rangeBlock stringByReplacingOccurrencesOfString:@"&lt;" withString:@" "];
        rangeBlock = [rangeBlock stringByReplacingOccurrencesOfString:@"&gt;" withString:@" "];
        [HTMLList addObject:rangeBlock];
//        NSLog(@"range %@", rangeBlock);
    }
    
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
    
    NSString *html = [[NSString alloc]initWithData:self.cacheData encoding:NSEUCKRStringEncoding];
    
    url_arr = [NSMutableArray array];
    [url_arr removeAllObjects];
    title_arr = [NSMutableArray array];
    [title_arr removeAllObjects];
    url_arr = (NSMutableArray *)[self devideStringToUrl:html];
    title_arr = (NSMutableArray *)[self devideStringToTitle:html];
    
    [self.delegate compliteToGetNewsList:(NSArray *)title_arr News_Url:(NSArray *)url_arr];
    


}

-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{
    
    NSLog(@"error:%@", error);
    [self.delegate failedToGetList];
}

@end
