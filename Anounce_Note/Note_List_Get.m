//
//  Note_List_Get.m
//  Anounce_Note
//
//  Created by kimsung jun on 2015. 5. 20..
//  Copyright (c) 2015년 kimsung jun. All rights reserved.
//

#import "Note_List_Get.h"

#define NSEUCKRStringEncoding -2147481280

@interface Note_List_Get (){
    
    NSString *re_url;
    
    NSString *myschool_url;
}

@property NSMutableData *cacheData;
@property NSURLConnection *connection;
@property NSMutableArray *data_arr;

@end

@implementation Note_List_Get

-(void)parsing:(NSString *)url School_Url:(NSString *)school{
    
    if (self.cacheData ==nil) {
        self.cacheData = [[NSMutableData alloc] init];
        
        self.data_arr = [[NSMutableArray alloc]init];
    }
    myschool_url = school;
    NSURL *url_1 = [NSURL URLWithString:url];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url_1];
    
    self.connection = [NSURLConnection connectionWithRequest:request delegate:self];
    
}

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
    
    [self.cacheData appendData:data];
}

-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{
    
}

//개별 알림url
-(NSArray *)devideString:(NSString *)HTML{
    // -- 4월 27일 수정---
    
//    NSString *startTag = @"<tr><td";
    NSString *startTag = @"<a href=\"./view";
//    NSString *secondTag = @"./view";
    NSString *secondTag = @".jsp?";
    NSString *endTag = @"\"";
    
    NSMutableString *url_list = [[NSMutableString alloc]init];
    
    
    NSMutableArray *HTMLList = [[NSMutableArray alloc] init];
    
    int startLoc;
    int endLoc;
    
    
    NSRange aRange = NSMakeRange(0, [HTML length]);
    
    while (YES) {
        
        [url_list appendString:myschool_url];
        [url_list appendString:@"/modules/cafe/class/menu/board/view.jsp?"];
        
        
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
-(NSArray *)devideString2:(NSString *)HTML{
    
    NSString *startTag = @"새창";
    NSString *secondTag = @"열림\">";
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
        rangeBlock = [self stripTags:rangeBlock];
        [HTMLList addObject:rangeBlock];
        
    }
    
    
    return HTMLList;
    
}

-(NSArray *)devideString3:(NSString *)HTML{
    
    NSString *startTag = @"./view";
    NSString *secondTag = @"\">";
    NSString *endTag = @"</a>";
    
    NSMutableArray *HTMLList = [[NSMutableArray alloc] init];
    NSMutableString *str_range = [[NSMutableString alloc]init];
    
    
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
        rangeBlock = [self stripTags:rangeBlock];
        
        str_range = [NSMutableString stringWithString:@""];
        
        if([rangeBlock rangeOfString:@"월"].length ==0 &&
           [rangeBlock rangeOfString:@"일"].length ==0 &&
           [rangeBlock rangeOfString:@"요일"].length ==0){
            
//            str_range = nil;
            [str_range appendString:@"[공지] "];
            [str_range appendString:rangeBlock];
        }else{
//            str_range = nil;
            [str_range appendString:rangeBlock];
        }
        
        [HTMLList addObject:str_range];
        
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


-(void)connectionDidFinishLoading:(NSURLConnection *)connection{
    
    NSString *html = [[NSString alloc]initWithData:self.cacheData encoding:NSEUCKRStringEncoding];

    NSArray *array_url = [self devideString:html];
    NSArray *array_title;
    
    int address_lenth = (int)[myschool_url rangeOfString:@"thread"].length;

    if (address_lenth == 0) {
         array_title = [ self devideString3:html];
    }else{
         array_title = [ self devideString2:html];
    }
    
//    if ([myschool_url hasSuffix:@"go.kr"]) {
//        array_title = [ self devideString2:html];
//    }else{
//        array_title = [ self devideString3:html];
//    }
    if (array_url.count != 0 && array_title.count == 0) {
        NSMutableArray *myarr = [NSMutableArray array];
        [myarr removeAllObjects];
        for (int i=0; i<array_url.count; i++) {
            [myarr addObject:[NSString stringWithFormat:@"알림장-%d",i]];
        }
        array_title = myarr;
    }
    
//    NSLog(@"%@", array_url);
//    NSLog(@"%@", array_title);
    
    [self.delegate compliteParsing:array_url Title:array_title];

    
}

-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{
    
    NSLog(@"error:%@", error);
    [self.delegate failParsingForNoteList];
    
    
}


@end
