//
//  NoteURL_Make.m
//  Test_HtmlParsing
//
//  Created by kimsung jun on 2015. 4. 2..
//  Copyright (c) 2015년 kimsung jun. All rights reserved.
//

#import "NoteURL_Make.h"

#define NSEUCKRStringEncoding -2147481280

@interface NoteURL_Make ()

@property NSMutableString *strUrl;
@property NSMutableData *receiveData;
@property NSURLConnection *connection;
@property NSMutableArray *infoArray;
@property NSString *note_url;
@property NSString *class_code;
@property NSMutableString *class_str;

@property NSString *frame_str;//홈페이지 프레임소스를 보기위해 삽입할 주소
@property NSString *frame_str1;//홈페이지 페이지소스를 보기위해 삽입할 주소
@property NSString *frame_str2;
@property NSString *frame_str3;
@property int parse_cnt;


@end

@implementation NoteURL_Make

-(instancetype)init{
    
    self = [super init];
    
    NSDate *date = [NSDate date];
    //3월 26일 수정
    int month = [[[self dateFormatter] stringFromDate:date] intValue];
    int year = [[[self dateFormatter2] stringFromDate:date] intValue];
    int now_year = 0;
    if(month < 3){
        now_year = year - 1;
    }else{
        now_year = year;
    }
    
    
    
    if (self) {
        self.parse_cnt =1;
        self.frame_str1 = @"/modules/cafe/class/index.jsp";
        self.frame_str2 = [NSString stringWithFormat:@"&m_year=%d&m_code=G00800300300",now_year];
    }
    return  self;
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

- (NSDateFormatter *)dateFormatter
{
    static NSDateFormatter *dateFormatter;
    if(!dateFormatter){
        dateFormatter = [NSDateFormatter new];
        dateFormatter.dateFormat = @"MM";
    }
    
    return dateFormatter;
}


-(void)parseWithUrl:(NSString *)school_url{
    
    if (self.receiveData==nil) {
        self.receiveData = [[NSMutableData alloc] init];
    }
    
    self.class_str = [[NSMutableString alloc]init];
    
    NSString *school_url_2;

    //school_url로 들어오는 학교 홈페이지 주소에 http://가 빠졌을 경우를 대비해서 hasPrefix를 이용해 검색한 후 없으면 Append해서 완성하여 school_url_2에 담아서 보냄.
    
    NSMutableString *http = [NSMutableString stringWithString:@"http://"];
    if ([school_url hasPrefix:http]) {
        school_url_2 = school_url;
    }else{
        [http appendString:school_url];
        school_url_2 = http;
    }
    
    self.strUrl = [[NSMutableString alloc]initWithString:school_url_2];
    NSURL *url = [NSURL URLWithString:self.strUrl];//NSURL은 Foundation에서 표준 url로 사용하는 형식
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    self.connection = [NSURLConnection connectionWithRequest:request delegate:self];
}

-(void)parse2:(NSString *)url{
    
    self.parse_cnt++;
    
    
    NSURL *url_2 = [NSURL URLWithString:url];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url_2];
    
    self.connection = [NSURLConnection connectionWithRequest:request delegate:self];
    
}


//학교 코드 뽑아내기(ex : ?SCODE=S0000000237, 학급홈페이지 주소 뽑아내기
- (NSString *)devideHTMLSring:(NSString *)HTML{
    NSString *startTag = @"sub_2";
    NSString *secondTag = @"a href=\"";
    NSString *endTag = @"amp;";
    
//    NSMutableString *HTMLList = [[NSMutableString alloc] init];
    
    int startLoc;
    int endLoc;
     NSString *rangeBlock;
    
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

        
        endRange = NSMakeRange(startLoc, endLoc - startLoc);
        rangeBlock = [HTML substringWithRange:endRange];
        
//        rangeBlock = [rangeBlock stringByReplacingOccurrencesOfString:@"amp;" withString:@""];
        
//        [HTMLList appendString:self.strUrl];
//        
//        [HTMLList appendString:self.frame_str1];
//        
//        [HTMLList appendString:rangeBlock];
//        
//        [HTMLList appendString:self.frame_str2];
    }
    
    
    return rangeBlock;
}

- (NSString *)devideHTMLSring1:(NSString *)HTML{
    NSString *startTag = @"sub_2";
    NSString *secondTag = @"a href=\"";
    NSString *endTag = @"amp";
    
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
        
        //        rangeBlock = [rangeBlock stringByReplacingOccurrencesOfString:@"amp;" withString:@""];
        
        [HTMLList appendString:self.strUrl];
        
        [HTMLList appendString:self.frame_str3];
        
        [HTMLList appendString:rangeBlock];
        
        [HTMLList appendString:self.frame_str2];
    }
    
    
    return HTMLList;
}

- (NSString *)devideHTMLSring2:(NSString *)HTML{
    NSString *startTag = @"div id=\"s_lunch\">";
    NSString *secondTag = @"href=\"";
    NSString *endTag = @"\">";
    
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
        
        rangeBlock = [rangeBlock stringByReplacingOccurrencesOfString:@"<br />" withString:@""];
        rangeBlock = [rangeBlock stringByReplacingOccurrencesOfString:@"</div>" withString:@""];
        rangeBlock = [rangeBlock stringByReplacingOccurrencesOfString:@"amp;" withString:@""];
        
        [HTMLList appendString:rangeBlock];
        //            [HTMLList appendString:@"\n"];
    }
    
    
    return HTMLList;
}

- (NSString *)devideHTMLSring3:(NSString *)HTML{
    NSString *startTag = @"div id=\"s_lunch\">";
    NSString *secondTag = @"href=\"";
    NSString *endTag = @"\">";
    
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
        
        rangeBlock = [rangeBlock stringByReplacingOccurrencesOfString:@"<br />" withString:@""];
        rangeBlock = [rangeBlock stringByReplacingOccurrencesOfString:@"</div>" withString:@""];
        rangeBlock = [rangeBlock stringByReplacingOccurrencesOfString:@"amp;" withString:@""];
        
        [HTMLList appendString:rangeBlock];

    }
    
    
    return HTMLList;
}


-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
    
    [self.receiveData appendData:data];
}

-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{
    
    [self.receiveData setLength:0];
}

-(void)connectionDidFinishLoading:(NSURLConnection *)connection{
    
    NSString *htmlData = [[NSString alloc] initWithData:self.receiveData encoding:NSEUCKRStringEncoding];
    
    self.note_url = [self devideHTMLSring:htmlData];
    [self.delegate completeParsing3:self.note_url];
    
   
}
-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{
    
    NSLog(@"error:%@", error);
    [self.delegate failParsing];
}


@end
