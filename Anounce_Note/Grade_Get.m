//
//  Grade_Get.m
//  Anounce_Note
//
//  Created by kimsung jun on 2015. 5. 22..
//  Copyright (c) 2015년 kimsung jun. All rights reserved.
//

#import "Grade_Get.h"
#import "AppDelegate.h"

#define NSEUCKRStringEncoding -2147481280

@interface Grade_Get (){
    
    int year_now;
}

@property NSArray *day_cnt;
@property NSMutableData *cacheData;
@property NSURLConnection *connection;

@end

@implementation Grade_Get

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

-(void)parsingWithUrl:(NSString *)url{
    
    if (self.cacheData ==nil) {
        self.cacheData = [[NSMutableData alloc] init];
    }
    //3월 26일 수정
    NSDate *date = [NSDate date];
    int year = [[[self dateFormatter2] stringFromDate:date] intValue];
    int month = [[[self dateFormatter] stringFromDate:date] intValue];

    if (month<3) {
        year_now = year -1;
    }else{
        year_now = year;
    }
    
    
//    int year_now = [[[self dateFormatter2] stringFromDate:date] intValue];
    
    NSURL *url_1 = [NSURL URLWithString:url];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url_1];
    
    self.connection = [NSURLConnection connectionWithRequest:request delegate:self];

    
}

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
    
    [self.cacheData appendData:data];
}

-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{
    
}

-(NSString *)devideString:(NSString *)HTML TagStr1:(NSString *)tag1 TagStr2:(NSString *)tag2{
    // 3월 26일 수정
    NSString *startTag = [NSString stringWithFormat:@">%d 학년도<", year_now];
    NSString *secondTag = tag1;
    NSString *endTag = tag2;
    
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
         // 3월 26일 수정
        if ([rangeBlock rangeOfString:[NSString stringWithFormat:@"%d",year_now-1]].length !=0){
            break;
        }
        rangeBlock = [rangeBlock stringByReplacingOccurrencesOfString:@"반" withString:@""];
        rangeBlock = [rangeBlock stringByReplacingOccurrencesOfString:@"\r" withString:@""];
        rangeBlock = [rangeBlock stringByReplacingOccurrencesOfString:@"\n" withString:@""];
        rangeBlock = [rangeBlock stringByReplacingOccurrencesOfString:@"\t" withString:@""];
        rangeBlock = [rangeBlock stringByReplacingOccurrencesOfString:@"\p" withString:@""];
        rangeBlock = [self stripTags:rangeBlock];
        [HTMLList appendString:rangeBlock];

    }
    
    return HTMLList;
    
}

-(NSString *)devideString2:(NSString *)HTML{
    // 3월 26일 수정
    NSString *startTag = [NSString stringWithFormat:@">%d 학년도<", year_now];
    NSString *secondTag = @"year_line";
    NSString *endTag = [NSString stringWithFormat:@">%d 학년도<", year_now-1];
    
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
        // 3월 26일 수정
        if ([rangeBlock rangeOfString:[NSString stringWithFormat:@"%d",year_now-1]].length !=0){
            break;
        }

        [HTMLList appendString:rangeBlock];
        
    }
    
    return HTMLList;
    
}


-(NSArray *)devideString3:(NSString *)HTML{
    // 3월 26일 수정
    NSString *startTag = @"<ul>";
    NSString *secondTag = @"<li";
    NSString *endTag = @"</ul>";
    
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
            
        }else if([rangeBlock containsString:@"공통학년"]){ //명서초 에러
            
//        }else if([rangeBlock containsString:@"영재학급"]){ //호암초 에러
            
        }else{
            
            [HTMLList addObject:rangeBlock];
        }
        
    }
    if(HTMLList.count>0){
        NSString *test1 = [HTMLList objectAtIndex:0];
        while (![test1 containsString:@"1학년"]) {
            [HTMLList removeObjectAtIndex:0];
            test1 = [HTMLList objectAtIndex:0];
        }
    }
    
//    if([[HTMLList objectAtIndex:0] containsObject:@"1학년"]){
//        
//    }else{
//        [HTMLList removeObjectAtIndex:0];
//    }
    
    return HTMLList;
    
}

// 문제 발생 2016. 12.22 
-(NSArray *)devideString4:(NSString *)HTML{
    // 3월 26일 수정
    NSString *startTag = @"\"school_ban\"";
    NSString *secondTag = @"href=\"";
    NSString *endTag = @"\" onclick";
    
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
        // 3월 26일 수정
        
        if([HTML containsString:@"영재학급"]){
            
        }else if ([HTML containsString:@"소프트"]){
            
        } else{
            [HTMLList addObject:rangeBlock];
        }
        
        
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
    
//    NSString *str = [self devideString:html];
    NSMutableArray *class_arr = [[NSMutableArray alloc]init];
    NSString *tag_1;
    NSString *tag_2;
    
// 2016.6.15. 수정
    
    NSMutableDictionary *class_dic = [[NSMutableDictionary alloc]init];
    
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    
    
    //년도별 학년과 반 분리하기
    NSString *sstt = [self devideString2:html];
    
    
    NSArray *grade_Arr = [self devideString3:sstt];
    
    if(grade_Arr.count != 0){
        
        delegate.is_pass = YES;
        
        // key = 학년, value = 반별 홈페이지 주소
        for (int i = 0; i < 6; i++) {
            
            NSArray *arr = [self devideString4:[grade_Arr objectAtIndex:i]];
            NSString *dic_key = [NSString stringWithFormat:@"%d학년",i+1];
            [class_dic setObject:arr forKey:dic_key];
        }
        
        
        
       /*
        for (int i=1; i<7; i++) {
            tag_1 = [NSString stringWithFormat:@"[%d학년]",i];
            
            if (i < 6) {
                tag_2 = [NSString stringWithFormat:@"[%d학년]",i+1];
                
            }else{
                tag_2 = @"</ul>";
            }
            NSString *str = [self devideString:html TagStr1:tag_1 TagStr2:tag_2];
            
            [class_arr addObject:str];
        }
        
        */
    }else{
        delegate.is_pass = NO;
        
        for (int i=1; i<7; i++) {
            tag_1 = [NSString stringWithFormat:@"[%d학년]",i];
            
            if (i < 6) {
                tag_2 = [NSString stringWithFormat:@"[%d학년]",i+1];
                
            }else{
                tag_2 = @"</ul>";
            }
            NSString *str = [self devideString:html TagStr1:tag_1 TagStr2:tag_2];
            
            [class_arr addObject:str];
        }
    }
    
    NSArray * allKeys = [class_dic allKeys];
    NSLog(@"Count : %lu", (unsigned long)[allKeys count]);
    
    
    
    [self.delegate compliteGetGradeClass:class_dic classArr:class_arr];
    
    
    
   
}

@end
