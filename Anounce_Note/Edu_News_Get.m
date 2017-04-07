//
//  Edu_News_Get.m
//  Anounce_Note
//
//  Created by kimsung jun on 2015. 5. 27..
//  Copyright (c) 2015년 kimsung jun. All rights reserved.
//

#import "Edu_News_Get.h"

@interface Edu_News_Get ()

@property NSMutableData *cacheData;
@property NSURLConnection *connection;
@property NSMutableArray *data_arr;

@end

@implementation Edu_News_Get

-(void)parsingWithUrl:(NSString *)url{
    
    if (self.cacheData ==nil) {
        self.cacheData = [[NSMutableData alloc] init];
        
        self.data_arr = [[NSMutableArray alloc]init];
    }
    NSString *Geturl = url;
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
    
    NSString *startTag = @"class=\"board\">";
    NSString *secondTag = @"class=\"topline\">";
    NSString *endTag = @"</th>";
    
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
        rangeBlock = [rangeBlock stringByReplacingOccurrencesOfString:@"/r" withString:@""];
        rangeBlock = [rangeBlock stringByReplacingOccurrencesOfString:@"/t" withString:@""];
        rangeBlock = [rangeBlock stringByReplacingOccurrencesOfString:@"/n" withString:@""];
        rangeBlock = [rangeBlock stringByReplacingOccurrencesOfString:@"\"" withString:@""];
        rangeBlock = [rangeBlock stringByReplacingOccurrencesOfString:@">" withString:@""];
        HTMLList = rangeBlock;
        
        break;
    }
    return HTMLList;
}

//뉴스기사 가져오기
-(NSArray *)devideString2:(NSString *)HTML{
    
    NSString *startTag = @"class=\"board\">";
    NSString *secondTag = @"colspan=\"4\">";
    NSString *endTag = @"</td>";
    
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
//        rangeBlock = [rangeBlock stringByReplacingOccurrencesOfString:@"\">" withString:@""];
        rangeBlock = [rangeBlock stringByReplacingOccurrencesOfString:@"\t" withString:@""];
        rangeBlock = [rangeBlock stringByReplacingOccurrencesOfString:@"\r" withString:@""];
        rangeBlock = [rangeBlock stringByReplacingOccurrencesOfString:@"\n" withString:@""];
        rangeBlock = [rangeBlock stringByReplacingOccurrencesOfString:@"<br><br>" withString:@"\n\n  "];
        rangeBlock = [rangeBlock stringByReplacingOccurrencesOfString:@"<br> <br>" withString:@"\n\n  "];
        rangeBlock = [rangeBlock stringByReplacingOccurrencesOfString:@"     " withString:@""];
        rangeBlock = [rangeBlock stringByReplacingOccurrencesOfString:@"  " withString:@""];
        rangeBlock = [rangeBlock stringByReplacingOccurrencesOfString:@"<br />" withString:@" "];
        rangeBlock = [rangeBlock stringByReplacingOccurrencesOfString:@"\" style=\"text-align:center\">" withString:@""];
        rangeBlock = [self stripTags:rangeBlock];
        
        [HTMLList addObject:rangeBlock];
    }
    if (HTMLList.count == 2) {
        [HTMLList removeObjectAtIndex:0];
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

-(void)connectionDidFinishLoading:(NSURLConnection *)connection{
    
    NSString *html = [[NSString alloc]initWithData:self.cacheData encoding:NSUTF8StringEncoding];
    
    NSString *title = [self devideString:html];
    NSString *content = [self devideString2:html][0];
    NSData *img_data = [self devideStringToData:html];
//    NSArray *files_arr = [self devideStringAddFile:html];
    [self.delegate compliteGetEduNewsWithTitle:title Contents:content Img_data:img_data];
    
}

-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{
    
    NSLog(@"error:%@", error);
    [self.delegate failGetEduNews];
}


@end
