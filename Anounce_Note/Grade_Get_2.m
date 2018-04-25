//
//  Grade_Get_2.m
//  Anounce_Note
//
//  Created by kimsung jun on 2016. 4. 27..
//  Copyright © 2016년 kimsung jun. All rights reserved.
//

#import "Grade_Get_2.h"

#define NSEUCKRStringEncoding -2147481280

@interface Grade_Get_2 ()

@property NSMutableData *cacheData;
@property NSURLConnection *connection;

@end

@implementation Grade_Get_2

-(void)parsingWithUrl_2:(NSString *)url{
    
    if (self.cacheData ==nil) {
        self.cacheData = [[NSMutableData alloc] init];
    }

    
    NSURL *url_1 = [NSURL URLWithString:url];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url_1];
    
    self.connection = [NSURLConnection connectionWithRequest:request delegate:self];
    
    
}

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
    
    [self.cacheData appendData:data];
}

-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{
    
}

-(NSArray *)devideString:(NSString *)HTML{
    // 3월 26일 수정
    NSString *startTag = @"반선택";
    NSString *secondTag = @"</option>";
    NSString *endTag = @"</select>";
    
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
        // 3월 26일 수정
//        rangeBlock = [self devideNewString:rangeBlock];
//        [HTMLList addObject:rangeBlock];
        [HTMLList addObject:[self devideNewString:rangeBlock]];
        
    }
    
    return HTMLList;
    
}

-(NSString *)devideString2:(NSString *)HTML{
    // 3월 26일 수정
    NSString *startTag = @"\n\t";
    NSString *secondTag = @"\t";
    NSString *endTag = @"</option>";
    
    NSMutableString *HTMLList = [[NSMutableString alloc] init];
    
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
        
        rangeBlock = [rangeBlock stringByReplacingOccurrencesOfString:@"반" withString:@""];
        rangeBlock = [rangeBlock stringByReplacingOccurrencesOfString:@"학급" withString:@""];
        rangeBlock = [rangeBlock stringByReplacingOccurrencesOfString:@"\n" withString:@""];
        rangeBlock = [rangeBlock stringByReplacingOccurrencesOfString:@"\t" withString:@""];
        rangeBlock = [rangeBlock stringByReplacingOccurrencesOfString:@"개별실" withString:@""];
        rangeBlock = [rangeBlock stringByReplacingOccurrencesOfString:@"과학" withString:@"1"];
        rangeBlock = [rangeBlock stringByReplacingOccurrencesOfString:@"영어" withString:@"1"];
        rangeBlock = [rangeBlock stringByReplacingOccurrencesOfString:@"체육" withString:@"1"];
        rangeBlock = [rangeBlock stringByReplacingOccurrencesOfString:@"음악" withString:@"1"];
        rangeBlock = [rangeBlock stringByReplacingOccurrencesOfString:@"미술" withString:@"1"];
        rangeBlock = [rangeBlock stringByReplacingOccurrencesOfString:@"영재" withString:@"1"];
        rangeBlock = [rangeBlock stringByReplacingOccurrencesOfString:@"발명" withString:@"1"];
        rangeBlock = [rangeBlock stringByReplacingOccurrencesOfString:@"전담" withString:@""];
        
        
//        NSLog(@"%d", rangeBlock.length);
        if(rangeBlock.length >1){ //10반이 넘어서는 경우 rangeBlock의 길이가 1에서 2로 늘어남에 따라 원래의 반 수보다 더 늘어나는 문제가 생겨 앱이 꺼져버림
            rangeBlock = [NSString stringWithFormat:@"%d",1];
        }
        
        [HTMLList appendString:rangeBlock];
        
    }
    
    return HTMLList;
    
}

-(NSArray *)devideNewString:(NSString *)HTML{
    // 3월 26일 수정
    NSString *startTag = @"<option";
    NSString *secondTag = @"\"";
    NSString *endTag = @"</";
    
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
        
        rangeBlock = [self stripTags:rangeBlock];
        
        NSArray *noNeedStr = @[@"개별실",@"과학",@"영어",@"체육",@"미술",@"영재",@"영재반",@"발명",@"발명반",@"전담"];
        
        int flag = 0;
        
        for(int  i= 0 ; i< noNeedStr.count ; i++){
            
            if([rangeBlock containsString:[noNeedStr objectAtIndex:i]]){
                
                flag++;
                
            }else{
                
               
            }
        }
        
        if(flag <1){
            rangeBlock = [rangeBlock stringByReplacingOccurrencesOfString:@"1반" withString:@""];
             rangeBlock = [rangeBlock stringByReplacingOccurrencesOfString:@"2반" withString:@""];
             rangeBlock = [rangeBlock stringByReplacingOccurrencesOfString:@"3반" withString:@""];
             rangeBlock = [rangeBlock stringByReplacingOccurrencesOfString:@"4반" withString:@""];
             rangeBlock = [rangeBlock stringByReplacingOccurrencesOfString:@"5반" withString:@""];
             rangeBlock = [rangeBlock stringByReplacingOccurrencesOfString:@"6반" withString:@""];
             rangeBlock = [rangeBlock stringByReplacingOccurrencesOfString:@"7반" withString:@""];
             rangeBlock = [rangeBlock stringByReplacingOccurrencesOfString:@"8반" withString:@""];
             rangeBlock = [rangeBlock stringByReplacingOccurrencesOfString:@"9반" withString:@""];
             rangeBlock = [rangeBlock stringByReplacingOccurrencesOfString:@"10반" withString:@""];
             rangeBlock = [rangeBlock stringByReplacingOccurrencesOfString:@"11반" withString:@""];
             rangeBlock = [rangeBlock stringByReplacingOccurrencesOfString:@"12반" withString:@""];
             rangeBlock = [rangeBlock stringByReplacingOccurrencesOfString:@"13반" withString:@""];
             rangeBlock = [rangeBlock stringByReplacingOccurrencesOfString:@"14반" withString:@""];
             rangeBlock = [rangeBlock stringByReplacingOccurrencesOfString:@"15반" withString:@""];
             rangeBlock = [rangeBlock stringByReplacingOccurrencesOfString:@"\"" withString:@""];
            rangeBlock = [rangeBlock stringByReplacingOccurrencesOfString:@"학급" withString:@""];
            rangeBlock = [rangeBlock stringByReplacingOccurrencesOfString:@"\n" withString:@""];
            rangeBlock = [rangeBlock stringByReplacingOccurrencesOfString:@"\t" withString:@""];
            [HTMLList addObject:rangeBlock];
//            [HTMLList appendString:rangeBlock];
        }
//        rangeBlock = [rangeBlock stringByReplacingOccurrencesOfString:@"개별실" withString:@""];
//        rangeBlock = [rangeBlock stringByReplacingOccurrencesOfString:@"과학" withString:@"1"];
//        rangeBlock = [rangeBlock stringByReplacingOccurrencesOfString:@"영어" withString:@"1"];
//        rangeBlock = [rangeBlock stringByReplacingOccurrencesOfString:@"체육" withString:@"1"];
//        rangeBlock = [rangeBlock stringByReplacingOccurrencesOfString:@"음악" withString:@"1"];
//        rangeBlock = [rangeBlock stringByReplacingOccurrencesOfString:@"미술" withString:@"1"];
//        rangeBlock = [rangeBlock stringByReplacingOccurrencesOfString:@"영재" withString:@"1"];
//        rangeBlock = [rangeBlock stringByReplacingOccurrencesOfString:@"발명" withString:@"1"];
//        rangeBlock = [rangeBlock stringByReplacingOccurrencesOfString:@"전담" withString:@""];
        
        
        //        NSLog(@"%d", rangeBlock.length);
//        if(rangeBlock.length >1){ //10반이 넘어서는 경우 rangeBlock의 길이가 1에서 2로 늘어남에 따라 원래의 반 수보다 더 늘어나는 문제가 생겨 앱이 꺼져버림
//            rangeBlock = [NSString stringWithFormat:@"%d",1];
//        }
    }
    
    return HTMLList;
    
}

-(NSString *)devideString3:(NSString *)HTML{
    // 2016년 6월 15일 수정
    NSString *startTag = @"\n\t";
    NSString *secondTag = @"\t";
    NSString *endTag = @"</option>";
    
    NSMutableString *HTMLList = [[NSMutableString alloc] init];
    
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
        
        rangeBlock = [rangeBlock stringByReplacingOccurrencesOfString:@"반" withString:@""];
        rangeBlock = [rangeBlock stringByReplacingOccurrencesOfString:@"\n" withString:@""];
        rangeBlock = [rangeBlock stringByReplacingOccurrencesOfString:@"\t" withString:@""];
        
        //        NSLog(@"%d", rangeBlock.length);
        
        [HTMLList appendString:rangeBlock];
        
    }
    
    return HTMLList;
    
}

-(NSArray *)devideStringByOther:(NSString *)HTML{
    // 3월 26일 수정
    NSString *startTag = @":반선택:";
    NSString *secondTag = @":반선택:";
    NSString *endTag = @"}";
    
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
        // 3월 26일 수정
        
        if([rangeBlock containsString:@"유치원"]){
            
        }else{
            rangeBlock = [self devideStringByOther_2:rangeBlock];
             [HTMLList addObject:rangeBlock];
        }
        
       
        
    }
    
    return HTMLList;
    
}

-(NSArray *)devideStringByOther_2:(NSString *)HTML{
    // 3월 26일 수정
//    NSString *startTag = @"text";
    NSString *startTag = @"value";
    NSString *secondTag = @"\"";
    NSString *endTag = @";";
    
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
        
        rangeBlock = [self stripTags:rangeBlock];
        
//        rangeBlock = [rangeBlock stringByReplacingOccurrencesOfString:@"반" withString:@""];
//        rangeBlock = [rangeBlock stringByReplacingOccurrencesOfString:@"학급" withString:@""];
//        rangeBlock = [rangeBlock stringByReplacingOccurrencesOfString:@"\n" withString:@""];
//        rangeBlock = [rangeBlock stringByReplacingOccurrencesOfString:@"\t" withString:@""];
//        rangeBlock = [rangeBlock stringByReplacingOccurrencesOfString:@"개별실" withString:@""];
//        rangeBlock = [rangeBlock stringByReplacingOccurrencesOfString:@"과학" withString:@"1"];
//        rangeBlock = [rangeBlock stringByReplacingOccurrencesOfString:@"영어" withString:@"1"];
//        rangeBlock = [rangeBlock stringByReplacingOccurrencesOfString:@"체육" withString:@"1"];
//        rangeBlock = [rangeBlock stringByReplacingOccurrencesOfString:@"음악" withString:@"1"];
//        rangeBlock = [rangeBlock stringByReplacingOccurrencesOfString:@"미술" withString:@"1"];
//        rangeBlock = [rangeBlock stringByReplacingOccurrencesOfString:@"영재" withString:@"1"];
//        rangeBlock = [rangeBlock stringByReplacingOccurrencesOfString:@"발명" withString:@"1"];
//        rangeBlock = [rangeBlock stringByReplacingOccurrencesOfString:@"전담" withString:@""];
         rangeBlock = [rangeBlock stringByReplacingOccurrencesOfString:@"\"" withString:@""];
        
        
        //        NSLog(@"%d", rangeBlock.length);
        
//        if(rangeBlock.length >1){ //10반이 넘어서는 경우 rangeBlock의 길이가 1에서 2로 늘어남에 따라 원래의 반 수보다 더 늘어나는 문제가 생겨 앱이 꺼져버림
//            rangeBlock = [NSString stringWithFormat:@"%d",1];
//        }
        [HTMLList addObject:rangeBlock];
//        [HTMLList appendString:rangeBlock];
        
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
        [scanner scanUpToString:@"\"" intoString:&tempText];
        
        if (tempText != nil)
            [html appendString:tempText];
        
        [scanner scanUpToString:@"\"" intoString:NULL];
        
        if (![scanner isAtEnd])
            [scanner setScanLocation:[scanner scanLocation] + 1];
        
        tempText = nil;
        
    }
    
    return html;
}


-(void)connectionDidFinishLoading:(NSURLConnection *)connection{
    
    NSString *html = [[NSString alloc]initWithData:self.cacheData encoding:NSEUCKRStringEncoding];
    
    //    NSString *str = [self devideString:html];
//    NSMutableArray *class_arr = [[NSMutableArray alloc]init];
    NSArray *class_arr;
    
    if([html rangeOfString:@"banItem.options[0].text"].length !=0){
        class_arr = [self devideStringByOther:html];
    }else{
        class_arr = [self devideString:html];
    }
    
    [self.delegate compliteGetGrade_2_Class:class_arr];
}


-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{
    
    NSLog(@"error:%@", error);
    [self.delegate failParsingGrade_get2];
    
    
}

@end
