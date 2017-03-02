//
//  Food_Get.m
//  Anounce_Note
//
//  Created by kimsung jun on 2015. 5. 21..
//  Copyright (c) 2015년 kimsung jun. All rights reserved.
//

#import "Food_Get.h"
#import "AppDelegate.h"

//#define NSEUCKRStringEncoding -2147481280

@interface Food_Get (){
    
     NSString *str[7][8];
}

@property NSArray *day_cnt;
@property NSMutableData *cacheData;
@property NSURLConnection *connection;

@end

@implementation Food_Get
//@synthesize delegate = _delegate;

-(void)parsingWithSchoolCode:(NSString *)schoolCode{
    
    if (self.cacheData ==nil) {
        self.cacheData = [[NSMutableData alloc] init];
    }
    
    NSDate *date = [NSDate date];
    
    int a = [[[self dateFormatter] stringFromDate:date] intValue];
    int b = [[[self dateFormatter2] stringFromDate:date]intValue];
    
    
    if (a<3) {
//        b -=1;
    }
    
    NSString *food_url;
    if (a<10) {
        
        food_url = [NSString stringWithFormat:@"http://par.gne.go.kr/spr_sci_md00_001.do?schYm=%d0%d&schulCode=%@&schulCrseScCode=2&schulKndScCode=02",b,a,schoolCode];
    }else{
        
        food_url = [NSString stringWithFormat:@"http://par.gne.go.kr/spr_sci_md00_001.do?schYm=%d%d&schulCode=%@&schulCrseScCode=2&schulKndScCode=02",b,a,schoolCode];
    }
    
    
    
    
    NSURL *url_1 = [NSURL URLWithString:food_url];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url_1];
    
    self.connection = [NSURLConnection connectionWithRequest:request delegate:self];


    /*
    
    NSDate *date = [NSDate date];
    
    
    int a = [[[self dateFormatter] stringFromDate:date] intValue];
    
    NSString *str = [NSString stringWithFormat:@"&frame=&year=2016&month=%d&cmd=cal",a-1];
    
    NSMutableString *food_url = [[NSMutableString alloc]initWithString:schoolCode];
    
    [food_url appendString:str];
    
    NSURL *url_1 = [NSURL URLWithString:food_url];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url_1];
    
    self.connection = [NSURLConnection connectionWithRequest:request delegate:self];
     */
    
}

- (NSDateFormatter *)dateFormatter
{
    static NSDateFormatter *dateFormatter;
    if(!dateFormatter){
        dateFormatter = [NSDateFormatter new];
        dateFormatter.dateFormat = @"MM";
    }
    
    return dateFormatter;
}

- (NSDateFormatter *)dateFormatter2
{
    static NSDateFormatter *dateFormatter;
    if(!dateFormatter){
        dateFormatter = [NSDateFormatter new];
        dateFormatter.dateFormat = @"Y";
    }
    
    return dateFormatter;
}

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
    
    [self.cacheData appendData:data];
}

-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{
    
}
/*
//날짜 뽑기
-(NSArray *)devideString:(NSString *)HTML{
    
    NSString *startTag = @"m_wrap";
    NSString *secondTag = @"id=\"";
    NSString *endTag = @"\">";
    
 
    
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
        rangeBlock = [rangeBlock stringByReplacingOccurrencesOfString:@"day_" withString:@""];
        [HTMLList addObject:rangeBlock];
    }
    self.day_cnt = HTMLList;
    return HTMLList;
}

//요일뽑기
-(NSArray *)devideString2:(NSString *)HTML{
    
    NSString *startTag = @"m_wrap";
    NSString *secondTag = @"</span>";
    NSString *endTag = @"</div>";
    
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
        rangeBlock = [rangeBlock stringByReplacingOccurrencesOfString:@"(" withString:@""];
        rangeBlock = [rangeBlock stringByReplacingOccurrencesOfString:@")" withString:@""];
        rangeBlock = [rangeBlock stringByReplacingOccurrencesOfString:@"\r\n\t\t\t\t\t\t" withString:@""];
        rangeBlock = [rangeBlock stringByReplacingOccurrencesOfString:@"\t\t\t\t\t\t\r\n\t\t\t\t\t" withString:@""];
        rangeBlock = [self stripTags:rangeBlock];
        [HTMLList addObject:rangeBlock];
        
    }
    
    
    return HTMLList;
    
}

//식단 뽑기
-(NSArray *)devideString3:(NSString *)HTML{
    
    NSString *startTag = @"m_wrap";
    NSString *secondTag = @"</div>";
    NSString *endTag = @"m_wrap";
    
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
        rangeBlock = [rangeBlock stringByReplacingOccurrencesOfString:@"day\">" withString:@""];
        rangeBlock = [rangeBlock stringByReplacingOccurrencesOfString:@"\r\n\t\t\t\t\t\r\n\t\t\t\t\r\n\t\t\t\r\n\t\t\t\r\n\t\t\r\n\t\t\t" withString:@""];
        rangeBlock = [rangeBlock stringByReplacingOccurrencesOfString:@"\t\t\t\t\t\r\n\t\t\t\t\t\t\t\t\r\n\t\t\t\t\r\n\t\t\t\t\r\n\t\t\t\t\t\r\n\t\t\t\t\t\r\n\t\t\t\t\t" withString:@""];
        rangeBlock = [rangeBlock stringByReplacingOccurrencesOfString:@"\t\t\t\t\t\r\n\t\t\t\t\t\t\t\t\r\n\t\t\t\t\r\n\t\t\t\r\n\t\t\r\n\t\t\t" withString:@""];
        rangeBlock = [rangeBlock stringByReplacingOccurrencesOfString:@"<div class=\"" withString:@""];
//        rangeBlock = [rangeBlock stringByReplacingOccurrencesOfString:@")" withString:@""];
        if ([rangeBlock isEqualToString:@""]) {
            [HTMLList addObject:@"식단이 없습니다."];
        }else{
             [HTMLList addObject:rangeBlock];
        }
    }
    if (self.day_cnt.count == HTMLList.count) {
        return HTMLList;
    }else{
        [HTMLList addObject:@"식단이 없습니다"];
        
        return HTMLList;
    }
}


//월 뽑기
-(NSString *)devideString4:(NSString *)HTML{
    
    NSString *startTag = @"select name=\"month\"";
    NSString *secondTag = @"selected\">";
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
        
        [HTMLList appendString:rangeBlock];
        break;
    }
    
    return HTMLList;
    
}
*/

//요일뽑기
-(NSString *)devideString2:(NSString *)HTML{
    
    NSString *startTag = @"월간식단표 ";
    NSString *secondTag = @"-";
    NSString *endTag = @"</tbody>";
    
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
        //        rangeBlock = [self stripTags:rangeBlock];
        //        rangeBlock = [rangeBlock stringByReplacingOccurrencesOfString:@"(" withString:@""];
        //        rangeBlock = [rangeBlock stringByReplacingOccurrencesOfString:@")" withString:@""];
        //        rangeBlock = [rangeBlock stringByReplacingOccurrencesOfString:@"\r\n\t\t\t\t\t\t" withString:@""];
        //        rangeBlock = [rangeBlock stringByReplacingOccurrencesOfString:@"\t\t\t\t\t\t\r\n\t\t\t\t\t" withString:@""];
        //        rangeBlock = [self stripTags:rangeBlock];
        [HTMLList appendString:rangeBlock];
        
    }
    
    
    return HTMLList;
    
}


//월 뽑기
-(NSArray *)devideString4:(NSString *)HTML{
    
    NSString *startTag = @"<td";
    NSString *secondTag = @">";
    NSString *endTag = @"</td>";
    
    
    
    NSMutableArray *HTMLList = [[NSMutableArray alloc] init];
    
    int startLoc;
    int endLoc;
    
    int week = 1;
    int day = 1;
    
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
        
        
        if(day>7){
            
            week++;
            day = 1;
        }
        
        if ([rangeBlock isEqualToString:@" "]) {
            rangeBlock = @"";
        }
        
        str[week][day] = rangeBlock;
        [HTMLList addObject:rangeBlock];
        
        if ([rangeBlock length] == 0) {
            NSLog(@"nil str");
        }
        
        day++;
        
    }
    
    return HTMLList;
    
}



- (NSString *)stripTags:(NSString *)str_k
{
    NSMutableString *html = [NSMutableString stringWithCapacity:[str_k length]];
    
    NSScanner *scanner = [NSScanner scannerWithString:str_k];
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

/*

-(void)connectionDidFinishLoading:(NSURLConnection *)connection{
    
    NSString *html = [[NSString alloc]initWithData:self.cacheData encoding:NSEUCKRStringEncoding];
    
    NSArray *day_arr = [self devideString:html];
    NSArray *week_arr = [self devideString2:html];
    NSString *month_str = [self devideString4:html];
    NSArray *food_arr = [self devideString3:html];
    
//    NSLog(@" 음식 개수 : %d\n 날짜 개수 :  %d\n 요일 개수 :  %d\n",
//          food_arr.count, day_arr.count, week_arr.count);
    
    [self.delegate compliteGetFood:food_arr Day:day_arr Week:week_arr Month:month_str];

    
}
 
 */
-(void)connectionDidFinishLoading:(NSURLConnection *)connection{
    
    NSString *html = [[NSString alloc]initWithData:self.cacheData encoding:NSUTF8StringEncoding];
    
    //    NSArray *day_arr = [self devideString:html];
    NSString *str_1 = [self devideString2:html];
    NSArray *arr_2 = [self devideString4:str_1];
    
//    
//    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    
    self.array_2 = arr_2;
    
//    [self.delegate performSelector:@selector(compliteGetFood:) withObject:arr_2];
    

    
    if ([self.delegate respondsToSelector:@selector(compliteGetFood:)]) {
        [self.delegate compliteGetFood:arr_2];
    }else{
        if (self.blockAfterUpdate) {
            
            
            self.blockAfterUpdate();
        }
    }
   

}

-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{
    
    NSLog(@"error:%@", error);
    [self.delegate failParsingForFood];
    
    
}


@end
