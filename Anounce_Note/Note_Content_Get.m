//
//  Note_Content_Get.m
//  Anounce_Note
//
//  Created by kimsung jun on 2015. 5. 21..
//  Copyright (c) 2015년 kimsung jun. All rights reserved.
//

#import "Note_Content_Get.h"


#define NSEUCKRStringEncoding -2147481280

@interface Note_Content_Get ()

@property NSMutableData *cacheData;
@property NSURLConnection *connection;

@end

@implementation Note_Content_Get

-(void)parsingWithUrl:(NSString *)clss_url{
    
    if (self.cacheData ==nil) {
        self.cacheData = [[NSMutableData alloc] init];
    }
    
    NSURL *url_1 = [NSURL URLWithString:clss_url];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url_1];
    
    self.connection = [NSURLConnection connectionWithRequest:request delegate:self];
}

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
    
    [self.cacheData appendData:data];
}

-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{
    
}

//개별 알림url
-(NSString *)devideString:(NSString *)HTML{
    
    NSString *startTag = @"<body";
    NSString *secondTag = @"content";
    NSString *endTag = @"</div>";
    
    NSMutableString *HTMLList = [[NSMutableString alloc] init];
    
    HTML = [HTML stringByReplacingOccurrencesOfString:@"</div><div>" withString:@"\n"];
    
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
//        rangeBlock = [self stripTags2:rangeBlock];
        rangeBlock = [rangeBlock stringByReplacingOccurrencesOfString:@"\t" withString:@""];
        rangeBlock = [rangeBlock stringByReplacingOccurrencesOfString:@"\r" withString:@""];
        rangeBlock = [rangeBlock stringByReplacingOccurrencesOfString:@"<p>" withString:@"\n\n"];
        rangeBlock = [rangeBlock stringByReplacingOccurrencesOfString:@"</p>" withString:@"\n\n"];
        rangeBlock = [rangeBlock stringByReplacingOccurrencesOfString:@"<br />" withString:@"\n\n"];
        rangeBlock = [rangeBlock stringByReplacingOccurrencesOfString:@"<br/>" withString:@"\n\n"];
        rangeBlock = [rangeBlock stringByReplacingOccurrencesOfString:@"<br>" withString:@"\n\n"];
        rangeBlock = [rangeBlock stringByReplacingOccurrencesOfString:@"&nbsp;" withString:@" "];
        rangeBlock = [rangeBlock stringByReplacingOccurrencesOfString:@"\"" withString:@""];
        rangeBlock = [rangeBlock stringByReplacingOccurrencesOfString:@"&#8203;" withString:@""];
        rangeBlock = [rangeBlock stringByReplacingOccurrencesOfString:@"&#8211;" withString:@""];
        rangeBlock = [rangeBlock stringByReplacingOccurrencesOfString:@"&lt;" withString:@"*"];
        rangeBlock = [rangeBlock stringByReplacingOccurrencesOfString:@"&gt;" withString:@"*"];
        rangeBlock = [rangeBlock stringByReplacingOccurrencesOfString:@"&amp;" withString:@"&"];
        rangeBlock = [rangeBlock stringByReplacingOccurrencesOfString:@"&guot;" withString:@"\""];
        rangeBlock = [self stripTags:rangeBlock];
        rangeBlock = [rangeBlock stringByReplacingOccurrencesOfString:@">" withString:@""];
        [HTMLList appendString:rangeBlock];
    }
    return HTMLList;
}

//첨부파일 가져오기2
-(NSArray *)devideStringAddFile:(NSString *)HTML{
    
    NSString *startTag = @"FileDown";
    NSString *secondTag = @"jsp?";
    NSString *endTag = @"title";
    
    NSMutableArray *HTMLList = [[NSMutableArray alloc]init];
    NSMutableString *file_str = [[NSMutableString alloc]init];
    
    int startLoc;
    int endLoc;
    
    
    NSRange aRange = NSMakeRange(0, [HTML length]);
    
    while (YES) {
        
        file_str = [NSMutableString stringWithString:@"/common/FileDownload.jsp?"];
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
        rangeBlock = [rangeBlock stringByReplacingOccurrencesOfString:@"  " withString:@""];
        //        rangeBlock = [rangeBlock stringByReplacingOccurrencesOfString:@"/t" withString:@""];
        //        rangeBlock = [rangeBlock stringByReplacingOccurrencesOfString:@"/n" withString:@""];
        rangeBlock = [rangeBlock stringByReplacingOccurrencesOfString:@"\"" withString:@""];
        //        rangeBlock = [rangeBlock stringByReplacingOccurrencesOfString:@">" withString:@""];
        rangeBlock = [rangeBlock stringByReplacingOccurrencesOfString:@"amp;" withString:@""];
        rangeBlock = [rangeBlock stringByReplacingOccurrencesOfString:@" " withString:@""];
        [file_str appendString:rangeBlock];
        [HTMLList addObject:file_str];
    }
    return HTMLList;
}

- (NSString *)stripTags:(NSString *)str
{
    NSMutableString *html = [NSMutableString stringWithCapacity:[str length]];
    
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
    NSString *sstt = [html stringByReplacingOccurrencesOfString:@">" withString:@""];
    return sstt;
}
- (NSString *)stripTags2:(NSString *)str
{
    NSMutableString *html = [NSMutableString stringWithCapacity:[str length]];
    
    NSScanner *scanner = [NSScanner scannerWithString:str];
    scanner.charactersToBeSkipped = NULL;
    NSString *tempText = nil;
    
    while (![scanner isAtEnd])
    {
        [scanner scanUpToString:@"&#" intoString:&tempText];
        
        if (tempText != nil)
            [html appendString:tempText];
        
        [scanner scanUpToString:@";" intoString:NULL];
        
        if (![scanner isAtEnd])
            [scanner setScanLocation:[scanner scanLocation] + 1];
        
        tempText = nil;
        
    }
    NSString *sstt = [html stringByReplacingOccurrencesOfString:@">" withString:@""];
    return sstt;
}

-(void)connectionDidFinishLoading:(NSURLConnection *)connection{
    
    NSString *html = [[NSString alloc]initWithData:self.cacheData encoding:NSEUCKRStringEncoding];
    
    NSString *str = [self devideString:html];
    
    NSArray *files_arr = [self devideStringAddFile:html];
    
    
    [self.delegate compliteNote:[self stripTags:str] Files:files_arr];
    
}


@end
