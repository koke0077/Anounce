//
//  Class_Url_Select.m
//  Test_HtmlParsing
//
//  Created by kimsung jun on 2015. 4. 6..
//  Copyright (c) 2015년 kimsung jun. All rights reserved.
//

#import "Class_Url_Select.h"

#define NSEUCKRStringEncoding -2147481280

@interface Class_Url_Select ()

@property NSMutableString *strUrl;
@property NSMutableData *receiveData;
@property NSURLConnection *connection;
@property NSMutableArray *infoArray;
@property NSString *note_url;

//@property Class_Url_Make *cus;

@end


@implementation Class_Url_Select


-(void)is_gen:(NSString *)str{
    
//    self.parse_cnt++;
    
    if (self.receiveData==nil) {
        self.receiveData = [[NSMutableData alloc] init];
    }

//    self.cus = [[Class_Url_Make alloc]init];
    str = [str stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    self.note_url = str;
    
    NSURL *url_2 = [NSURL URLWithString:str];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url_2];
    
    self.connection = [NSURLConnection connectionWithRequest:request delegate:self];
    
   
}


-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
    
    [self.receiveData appendData:data];
}

-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{
    
    [self.receiveData setLength:0];
}


- (NSString *)devideHTMLSring2:(NSString *)HTML{
//    NSString *startTag = @"0737";
//    NSString *secondTag = @"href=\"";
//    NSString *endTag = @"\" target";
    
    NSString *startTag = @"http://lms";
    NSString *secondTag = @"net/";
    NSString *endTag = @"\"";
    
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
        NSString *original_url = @"http://lms.gnedu.net/";
        
        endRange = NSMakeRange(startLoc, endLoc - startLoc);
        rangeBlock = [HTML substringWithRange:endRange];
        [HTMLList appendString:original_url];
        [HTMLList appendString:rangeBlock];
    }
    
    
    return HTMLList;
}



-(void)connectionDidFinishLoading:(NSURLConnection *)connection{
    
   // NSString *htmlData = [[NSString alloc] initWithData:self.receiveData encoding:NSEUCKRStringEncoding];

    /*
//    int contain_num = (int)[htmlData rangeOfString:@"알림장"].length;
    int contain_num = (int)[htmlData rangeOfString:@"http://lms.gnedu.net"].length;
    int contain_num2 = (int)[htmlData rangeOfString:@"http://lms.gnedu.net/mr_classroom/"].length;
    
    if (contain_num != 0 && contain_num2 !=0) {
    
//        [self.delegate completeClassParsing:self.note_url Is_On:YES];
        
        [self.delegate completeClassParsing:[self devideHTMLSring2:htmlData] Is_On:NO];
        
    }else{
//        [self.cus parsing:[self devideHTMLSring2:htmlData]];
        [self.delegate completeClassParsing:self.note_url Is_On:YES];
//        [self.delegate completeClassParsing:[self devideHTMLSring2:htmlData] Is_On:NO];
    }
    */
     [self.delegate completeClassParsing:self.note_url Is_On:YES];
    
}
-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{
    
    NSLog(@"error:%@", error);
    
    [self.delegate failParsing];

}




@end
