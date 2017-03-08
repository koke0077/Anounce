//
//  News_Contents_Get.m
//  Anounce_Note
//
//  Created by kimsung jun on 2015. 5. 27..
//  Copyright (c) 2015년 kimsung jun. All rights reserved.
//

#import "News_Contents_Get.h"

#define NSEUCKRStringEncoding -2147481280

@interface News_Contents_Get ()

@property NSMutableData *cacheData;
@property NSURLConnection *connection;
@property NSMutableArray *data_arr;

@end

@implementation News_Contents_Get

-(void)parsingWithUrl:(NSString *)news_url{
    
    if (self.cacheData ==nil) {
        self.cacheData = [[NSMutableData alloc] init];
        
        self.data_arr = [[NSMutableArray alloc]init];
    }
    
    self.cacheData = [NSMutableData data];
    NSString *Geturl = news_url;
    NSURL *url_1 = [NSURL URLWithString:Geturl];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url_1];
    
    self.connection = [NSURLConnection connectionWithRequest:request delegate:self];
}

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
    
    [self.cacheData appendData:data];
}

-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{
    
}

//뉴스 타이틀 가져오기
-(NSString *)devideString:(NSString *)HTML{
    
    NSString *startTag = @"</caption>";
    NSString *secondTag = @"목</th>";
    NSString *endTag = @"</td>";
    
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
//        rangeBlock = [rangeBlock stringByReplacingOccurrencesOfString:@"/r" withString:@""];
//        rangeBlock = [rangeBlock stringByReplacingOccurrencesOfString:@"/t" withString:@""];
//        rangeBlock = [rangeBlock stringByReplacingOccurrencesOfString:@"/n" withString:@""];
//        rangeBlock = [rangeBlock stringByReplacingOccurrencesOfString:@"\"" withString:@""];
//        rangeBlock = [rangeBlock stringByReplacingOccurrencesOfString:@">" withString:@""];
        rangeBlock = [self stripTags:rangeBlock];
        HTMLList = rangeBlock;
        
        break;
    }
    return HTMLList;
}

//뉴스기사 가져오기
-(NSString *)devideString2:(NSString *)HTML{
    
    NSString *startTag = @"등록일</th>";
    NSString *secondTag = @"m_content\">";
    NSString *endTag = @"</td>";
    
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
        rangeBlock = [rangeBlock stringByReplacingOccurrencesOfString:@"\n" withString:@""];
        rangeBlock = [rangeBlock stringByReplacingOccurrencesOfString:@"</span></p>" withString:@"\n"];
        rangeBlock = [rangeBlock stringByReplacingOccurrencesOfString:@"</p><p>" withString:@"\n"];
        rangeBlock = [self stripTags:rangeBlock];
        rangeBlock = [rangeBlock stringByReplacingOccurrencesOfString:@"&nbsp;" withString:@""];
        rangeBlock = [rangeBlock stringByReplacingOccurrencesOfString:@"#8228;" withString:@""];
//        rangeBlock = [rangeBlock stringByReplacingOccurrencesOfString:@"&" withString:@", "];
        rangeBlock = [rangeBlock stringByReplacingOccurrencesOfString:@"\r" withString:@""];
        rangeBlock = [rangeBlock stringByReplacingOccurrencesOfString:@"\t" withString:@""];
        rangeBlock = [rangeBlock stringByReplacingOccurrencesOfString:@"&#983709;" withString:@""];
        rangeBlock = [rangeBlock stringByReplacingOccurrencesOfString:@"&#983710;" withString:@""];
        rangeBlock = [rangeBlock stringByReplacingOccurrencesOfString:@"&#983711;" withString:@""];
        rangeBlock = [rangeBlock stringByReplacingOccurrencesOfString:@"&" withString:@""];
        rangeBlock = [rangeBlock stringByReplacingOccurrencesOfString:@"lt;" withString:@""];
        rangeBlock = [rangeBlock stringByReplacingOccurrencesOfString:@"gt;" withString:@""];
        rangeBlock = [rangeBlock stringByReplacingOccurrencesOfString:@"lsquo" withString:@""];
        rangeBlock = [rangeBlock stringByReplacingOccurrencesOfString:@"rsquo" withString:@""];





        
        
        rangeBlock = [rangeBlock stringByReplacingOccurrencesOfString:@"#61549;" withString:@""];
        HTMLList = rangeBlock;
    }
//
    return HTMLList;
    
}

//첨부파일 가져오기1
-(NSString *)devideStringAddFile:(NSString *)HTML{
    
    NSString *startTag = @"첨부파일<";
    NSString *secondTag = @"<td";
    NSString *endTag = @"</td>";
    
    NSString *HTMLList;
    
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
     
        HTMLList = rangeBlock;
        
        break;
    }
    return HTMLList;
}

//첨부파일 가져오기2
-(NSArray *)devideStringAddFile2:(NSString *)HTML{
    
    NSString *startTag = @"<p>";
    NSString *secondTag = @"href=";
    NSString *endTag = @"title";
    
    NSMutableArray *HTMLList = [[NSMutableArray alloc]init];
    
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
//        rangeBlock = [rangeBlock stringByReplacingOccurrencesOfString:@"/r" withString:@""];
//        rangeBlock = [rangeBlock stringByReplacingOccurrencesOfString:@"/t" withString:@""];
//        rangeBlock = [rangeBlock stringByReplacingOccurrencesOfString:@"/n" withString:@""];
        rangeBlock = [rangeBlock stringByReplacingOccurrencesOfString:@"\"" withString:@""];
//        rangeBlock = [rangeBlock stringByReplacingOccurrencesOfString:@">" withString:@""];
        rangeBlock = [rangeBlock stringByReplacingOccurrencesOfString:@"amp;" withString:@""];
        rangeBlock = [rangeBlock stringByReplacingOccurrencesOfString:@" " withString:@""];
        [HTMLList addObject:rangeBlock];
        
        
    }
    return HTMLList;
}

-(NSData *)devideStringToData:(NSString *)HTML{
    
    NSString *startTag = @"align:center";
    NSString *secondTag = @"src=";
    NSString *endTag = @"alt";
    
    NSData *HTMLList = [[NSData alloc]init];
    
    NSMutableString *m_str = [[NSMutableString alloc]initWithString:@"http://news.gne.go.kr"];
    
    if ([HTML rangeOfString:startTag].length == 0) {
        HTMLList = [NSData dataWithContentsOfFile:@"basic.bg.png"];
    }
    
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
        rangeBlock = [rangeBlock stringByReplacingOccurrencesOfString:@"\"" withString:@""];
        [m_str appendString:rangeBlock];
        HTMLList = [NSData dataWithContentsOfURL:[NSURL URLWithString:m_str]];
//        NSLog(@"range %@", rangeBlock);
        
        break;
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
    
    NSString *title = [self devideString:html];
    NSString *content = [self devideString2:html];
    NSString *files_str = [self devideStringAddFile:html];
    NSArray *files_arr = [self devideStringAddFile2:files_str];
//    NSData *img_data = [self devideStringToData:html];
    [self.delegate compliteGetContentsTitle:title Contents:content  Files:files_arr];
    
}

-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{
    
    NSLog(@"error:%@", error);

}


@end
