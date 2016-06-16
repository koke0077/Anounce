//
//  Class_Url_Make.m
//  Anounce_Note
//
//  Created by kimsung jun on 2015. 5. 17..
//  Copyright (c) 2015년 kimsung jun. All rights reserved.
//

#import "Class_Url_Make.h"
#import <CFNetwork/CFNetwork.h>
//#import "AFNetworking.h"

#define NSEUCKRStringEncoding -2147481280



@interface Class_Url_Make (){
    
    NSMutableURLRequest *urlRequest;
    NSString *str2;
    
    NSMutableData *receivedData;
    NSStringEncoding encoding;

}


@property NSMutableURLRequest *original;
@property NSMutableString *strUrl;
@property NSMutableData *receiveData;
@property NSMutableData *dataCache;

@property (nonatomic, assign, readonly)  BOOL                   isReceiving;
@property (nonatomic, retain, readwrite) NSURLConnection *      connection;
@property (nonatomic, retain, readwrite) NSTimer *              earlyTimeoutTimer;
@property (nonatomic, copy,   readwrite) NSString *             filePath;
@property (nonatomic, retain, readwrite) NSOutputStream *       fileStream;


//@property NSMutableArray *infoArray;
@property NSString *semi;
@property NSString *note_url;

@end

#if DEBUG

@interface NSMutableURLRequest (DummyInterface)
+(BOOL)allowsAnyHTTPSCertificateForHost:(NSString *)host;
+(void)setAllowsAnyHTTPSCertificate:(BOOL)allow forHost:(NSString *)host;
@end


#endif

@implementation Class_Url_Make

-(void)parsing:(NSString *)url{

    //----- SSL
    /*
    if (self.receiveData==nil) {
        self.receiveData = [[NSMutableData alloc] init];
        self.original = [[NSMutableURLRequest alloc]init];
    }
    str2 = url;
    NSURL *url_2 = [NSURL URLWithString:@"https://sso.geric.kr/token/requestToken.do"];

    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url_2];
    
    NSString *stringKey = @"Return_Url";
    
//    NSString *stringValue = @"http://lms.gnedu.net:80/mr_classroom/classroom.do.do?classno=40168";
    
    NSString *stringValue = url;
    
    NSString *stringData = [NSString stringWithFormat:@"%@=%@",stringKey, stringValue];
    
    request.HTTPBody = [stringData dataUsingEncoding:NSEUCKRStringEncoding];

    request.HTTPMethod = @"POST";
    
    self.dataCache = [NSMutableData data];
    
    [NSURLConnection connectionWithRequest:request delegate:self];
   */

}

BOOL _Authenticated;
NSURLRequest *_FailedRequest;

-(void)connection:(NSURLConnection *)connection willSendRequestForAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge {
    if ([challenge.protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust]) {
        NSURL* baseURL = [NSURL URLWithString:@"https://sso.geric.kr/token/requestToken.do"];
        if ([challenge.protectionSpace.host isEqualToString:baseURL.host]) {
            NSLog(@"trusting connection to host %@", challenge.protectionSpace.host);
            [challenge.sender useCredential:[NSURLCredential credentialForTrust:challenge.protectionSpace.serverTrust] forAuthenticationChallenge:challenge];
            

        } else
            NSLog(@"Not trusting connection to host %@", challenge.protectionSpace.host);
    }
    [challenge.sender continueWithoutCredentialForAuthenticationChallenge:challenge];
}



- (NSString *)devideHTMLSring:(NSString *)HTML{
    NSString *startTag = @"snbMain_list";
    NSString *secondTag = @"..";
    NSString *endTag = @"\">";
    
    NSMutableString *HTMLList = [[NSMutableString alloc] init];
    
//    [HTMLList appendString:self.semi];
    
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
        [HTMLList appendString:rangeBlock];
    }
    
    
    return HTMLList;
}

- (NSString *)devideHTMLSring2:(NSString *)HTML{
    NSString *startTag = @"body";
    NSString *secondTag = @"<input type=\"hidden\" name=\"";
    NSString *endTag = @"\" value";
    
    NSMutableString *HTMLList = [[NSMutableString alloc] init];
    
    //    [HTMLList appendString:self.semi];
    
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
        [HTMLList appendString:rangeBlock];
        break;
    }
    
    
    return HTMLList;
}


- (NSString *)devideHTMLSring3:(NSString *)HTML{
    NSString *startTag = @"body";
    NSString *secondTag = @"SSOTOKEN\" value=\"";
    NSString *endTag = @"\" />";
    
    NSMutableString *HTMLList = [[NSMutableString alloc] init];
    
    //    [HTMLList appendString:self.semi];
    
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
        [HTMLList appendString:rangeBlock];
        break;
    }
    
    
    return HTMLList;
}


-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
    
    [self.dataCache appendData:data];
}

-(void)connectionDidFinishLoading:(NSURLConnection *)connection{
     NSString *htmlData = [[NSString alloc] initWithData:self.dataCache encoding:NSEUCKRStringEncoding];
    
    NSString *key = [self devideHTMLSring2:htmlData];
    NSString *value = [self devideHTMLSring3:htmlData];
    
    /*
    Pass_lms_Class *p_class = [[Pass_lms_Class alloc]init];
    [p_class sendUserToken:key Value:value Url:str2];
    */
    
    [self.delegate CompliteParsingKey:key Value:value Lms_URl:str2];
    
}

BOOL _Authenticated;
NSURLRequest *_FailedRequest;

-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)pResponse {
    _Authenticated = YES;
    [self.connection start];
    
//    [webvw loadRequest:_FailedRequest];
}

-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{
    
    NSLog(@"error:%@", error);
    
    [self.delegate FailedParsing_Class];
    
}
@end
