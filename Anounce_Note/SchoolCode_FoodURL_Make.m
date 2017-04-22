//
//  SchoolCode_FoodURL_Make.m
//  Anounce_Note
//
//  Created by kimsung jun on 2015. 5. 13..
//  Copyright (c) 2015년 kimsung jun. All rights reserved.
//

#import "SchoolCode_FoodURL_Make.h"
#import "AppDelegate.h"


#define NSEUCKRStringEncoding -2147481280

@interface SchoolCode_FoodURL_Make ()

@property NSMutableString *strUrl;
@property NSMutableData *receiveData;
@property NSURLConnection *connection;
@property NSMutableArray *infoArray;
@property NSString *food_url;
@property NSString *school_code;
@property NSString *sch_url;
@property NSString *school_code_nonCode;

@end


@implementation SchoolCode_FoodURL_Make


-(void)parseWithSchool_URL:(NSString *)school_url{
    
    if (self.receiveData==nil) {
        self.receiveData = [[NSMutableData alloc] init];
    }
    
    NSString *school_url_2;
    
    //school_url로 들어오는 학교 홈페이지 주소에 http://가 빠졌을 경우를 대비해서 hasPrefix를 이용해 검색한 후 없으면 Append해서 완성하여 school_url_2에 담아서 보냄.
    NSString *http_1 = @"http//";
    
    if ([school_url hasPrefix:http_1]) {
        school_url = [school_url stringByReplacingOccurrencesOfString:@"http//" withString:@""];
    }
    
    
    NSMutableString *http = [NSMutableString stringWithString:@"http://"];
    if ([school_url hasPrefix:http]) {
        school_url_2 = school_url;
    }else{
        [http appendString:school_url];
        school_url_2 = http;
    }
    
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    delegate.school_url = school_url_2;
    delegate.is_str = 0;
    
    self.sch_url = school_url_2;
    
    NSURL *url_1 = [NSURL URLWithString:school_url_2];//NSURL은 Foundation에서 표준 url로 사용하는 형식
    NSURLRequest *request = [NSURLRequest requestWithURL:url_1];
    self.connection = [NSURLConnection connectionWithRequest:request delegate:self];
    
    
}

//급식메뉴 URL만들기
- (NSString *)devideHTMLSring:(NSString *)HTML{
    NSString *startTag;
    NSString *secondTag;
    NSString *endTag;
    
    NSMutableString *HTMLList = [[NSMutableString alloc]init];
    
    if ([HTML rangeOfString:@"div id=\"s_lunch\""].length == 0) {
        startTag = @"급식";
        secondTag = @"index.jsp?";
        endTag = @",";
        [HTMLList appendString:self.sch_url];
        [HTMLList appendString:@"/index.jsp?"];
        
    }else{
        startTag = @"div id=\"s_lunch\"";
        secondTag = @"href=\"";
        endTag = @"\">";
        
        [HTMLList appendString:self.sch_url];
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
//        [HTMLList appendString:@"&frame=&year=2015&month=4&cmd=cal"];
        
        break;
    }
    return HTMLList;
}

//급식메뉴 URL만들기
- (NSString *)devideHTMLSringfood:(NSString *)HTML{
    NSString *startTag;
    NSString *secondTag;
    NSString *endTag;
    
    if ([self.sch_url rangeOfString:@"yegok"].length == 0 ) {//수정한 부분
        startTag = @"\"lunch\">";
        secondTag = @"s_tab1_2\"";
        endTag = @"onclick";
    }else{
        startTag = @"\"lunch\">";
        secondTag = @"비활성됨";
        endTag = @"\"><img";
    }
    
    

    
    NSMutableString *HTMLList = [[NSMutableString alloc] initWithString:self.sch_url];
    
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
        
        rangeBlock = [self stripTags:rangeBlock];
        rangeBlock = [rangeBlock stringByReplacingOccurrencesOfString:@"href=\"" withString:@""];
        rangeBlock = [rangeBlock stringByReplacingOccurrencesOfString:@" " withString:@""];
        rangeBlock = [rangeBlock stringByReplacingOccurrencesOfString:@"amp;" withString:@""];
        rangeBlock = [rangeBlock stringByReplacingOccurrencesOfString:@"\"" withString:@""];
        [HTMLList appendString:rangeBlock];
//        [HTMLList appendString:@"&frame=&year=2015&month=4&cmd=cal"];
        
        break;
    }
    return HTMLList;
}


//학교코드 뽑기
- (NSString *)devideHTMLSring2:(NSString *)HTML{
    
    NSString *startTag;
    NSString *secondTag;
    NSString *endTag;
    
    if ([HTML rangeOfString:@"?HG_"].length == 0) {
        startTag = @" href=\"/hosts";
        secondTag = @"el01";
        endTag = @"skin";
    }else{
        
        startTag = @"?HG_";
        secondTag = @"CD=";
        endTag = @"\"";
    }
    
    
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
        rangeBlock = [rangeBlock stringByReplacingOccurrencesOfString:@"/" withString:@""];
        if([rangeBlock isEqualToString:@"나이스학교코드"]){
        
        }else{
            [HTMLList appendString:rangeBlock];
            
            break;
        }
    }
    
    
    return HTMLList;
}

//학급홈페이지 주소옵션 뽑기
- (NSString *)devideHTMLSringClass:(NSString *)HTML{
    
//    NSRange is_ok_2 = [HTML rangeOfString:@"우리학급"];
//    NSRange is_ok_1 = [HTML rangeOfString:@"어린이마당"];
//    NSRange is_ok = [HTML rangeOfString:@"학급홈페이지"];
    NSString *startTag;
    
//    if (is_ok_2.length !=0) {
//        startTag = @"우리학급";
//    }else if (is_ok_1.length !=0) {
//        startTag = @"어린이마당";
//    }else if (is_ok.length !=0) {
//        startTag = @"학급홈페이지,/";
//    }else{
    
    
//        startTag = @"학급까페";
//    }
    
    if([HTML rangeOfString:@"우리학급,/"].length != 0){
        startTag = @"우리학급";
    }else if([HTML rangeOfString:@"학급홈페이지,/"].length !=0){
        startTag = @"학급홈페이지";
    }else if([HTML rangeOfString:@"어린이마당,/"].length !=0){
        startTag = @"어린이마당";
    }else if([HTML rangeOfString:@"학급 홈페이지,/"].length !=0){
        startTag = @"학급 홈페이지";
    }else if([HTML rangeOfString:@"우리학급홈페이지"].length !=0){
        startTag = @"우리학급홈페이지";
    }else if([HTML rangeOfString:@"우리반홈페이지"].length !=0){
        startTag = @"우리반홈페이지";
    }else{
        startTag = @"학급";
    }
    
    NSString *secondTag = @"mnu=";
    NSString *endTag = @",";
    
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

        break;
    }
    return rangeBlock;
}


//공지사항 URL만들기
- (NSString *)devideHTMLSringToNews_List:(NSString *)HTML{
    NSString *startTag;
    NSString *secondTag;
    NSString *endTag;
    

    
    if ([HTML rangeOfString:@"공지사항,/"].length != 0) {
        startTag = @"공지사항,";
        secondTag = @"/";
        endTag = @",";
    }else if([HTML rangeOfString:@">공지사항<"].length != 0){
        startTag = @"sub_1";
        secondTag = @"<a href=\"";
//        secondTag = @"\">";
        endTag = @"\">공지사항";

    }else{
        startTag = @"공지";
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
    NSString *sstt = [html stringByReplacingOccurrencesOfString:@"\">" withString:@""];
    return sstt;
}

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
    
    [self.receiveData appendData:data];
}

-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{
    
    [self.receiveData setLength:0];
}

-(void)connectionDidFinishLoading:(NSURLConnection *)connection{
    
    NSString *htmlData = [[NSString alloc] initWithData:self.receiveData encoding:NSEUCKRStringEncoding];

//    NSLog(@"%@", htmlData);
    
    if ([htmlData rangeOfString:@"\"lunch\">"].length ==0) {
        self.food_url = [self devideHTMLSring:htmlData];
    }else{
        self.food_url = [self devideHTMLSringfood:htmlData];
    }
    
    if([self.sch_url rangeOfString:@"ganam"].length !=0){
        self.school_code = @"S100003883";
    }else if([self.sch_url rangeOfString:@"gamgye"].length !=0){  //S100003471
        self.school_code = @"S100003458";
    }else if([self.sch_url rangeOfString:@"handeul"].length !=0){  //
        self.school_code = @"S100003471";
    }else{
        self.school_code = [self devideHTMLSring2:htmlData];
    }
    
    self.school_code_nonCode =[self remove_Scode:self.school_code];
    
    NSMutableString *news_Url = [[NSMutableString alloc]initWithString:self.sch_url];
    [news_Url appendString:@"/index.jsp?"];
    [news_Url appendString:self.school_code];
    [news_Url appendString:@"&"];
    if([self.sch_url containsString:@"galjeon"] || [self.sch_url containsString:@"jyjungang"]){
        [news_Url appendString:@"mnu=M001006001"]; //갈전초 공지사항 url 추가  (임시방편..ㅜ.ㅜ) 2017.3.8., 진영중앙초등학교 역시...;;
    }else if([self.sch_url containsString:@"munsun"]){//문선초 공지사항 url 추가 (임시방편..ㅜㅜ) 2017.3.8.
        [news_Url appendString:@"mnu=M001010002"];
    }else{
        [news_Url appendString:[self devideHTMLSringToNews_List:htmlData]];
    }
    
    
    [self.strUrl appendString:self.food_url];
    NSMutableString *now_class = [[NSMutableString alloc]initWithString:self.sch_url];
    
    
    //------- 2016. 4월 25일 수정
    
    // 학교홈페이지에서 학급 홈페이지를 열거해 놓은 페이지가 없어 학급홈페이지 전체를 보여주는 페이지를 뽑아내는 과정을 생략하였다.
    // delegate에 변수를 하나 만들어 위의 페이지가 없을 경우에 대한 플래그로 활용한다. 즉 Grade_Get 클래스에서 delegate 변수를 이용해 학급홈페이지를 안내하는 페이지가 있는 경우와 없는 경우에 대한 분기를 달리하여 학년에 따른 학급의 수를 셀 수 있도록 한다.
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];

    if([htmlData rangeOfString:@"반선택"].length != 0 && [self.sch_url containsString:@"daecheong"]){
        
    }else if([self.sch_url containsString:@"md-p"]){
        [now_class appendString:@"/?SCODE=S0000000257&mnu=M001006001"];
        delegate.is_str = 1;
    }else{
        if([htmlData rangeOfString:@"학급홈페이지"].length !=0 || [htmlData rangeOfString:@"학급마당"].length !=0){
            [now_class appendString:@"/index.jsp?"];
            [now_class appendString:self.school_code];
            [now_class appendString:@"&mnu="];
            [now_class appendString:[self devideHTMLSringClass:htmlData]];
            
            
            delegate.is_str = 1;
        }
    }
    
    
    
//    if([htmlData rangeOfString:@"반선택"].length ==0 || [htmlData rangeOfString:@"학급홈페이지"].length !=0 || [htmlData rangeOfString:@"학급마당"].length !=0){
//        [now_class appendString:@"&mnu="];
//        [now_class appendString:[self devideHTMLSringClass:htmlData]];
//        
//        AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
//        
//        delegate.is_str = 1;
//    }
    
   
    
     [self.delegate completeParsing2:self.food_url  School:self.school_code Cls_page:now_class News_url:news_Url SchoolCode:self.school_code_nonCode];
    
    if (self.blockAfterUpdate) {
        self.blockAfterUpdate();
    }
    
}
-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{
    
    NSLog(@"error:%@", error);
    [self.delegate failParsing];
    

}

-(NSString *)remove_Scode:(NSString *)school_code{ 
    
    NSString *str = [school_code stringByReplacingOccurrencesOfString:@"SCODE=" withString:@""];
    
    return str;
    
}

@end
