//
//  ShowViewContents.m
//  Anounce_Note
//
//  Created by kimsung jun on 2015. 5. 21..
//  Copyright (c) 2015년 kimsung jun. All rights reserved.
//

#import "ShowViewContents.h"

@interface ShowViewContents (){
    
    NSArray *files_arr;
    UIView *v1;
    
    NSThread *thread;
    dispatch_queue_t dQueue;
    NSTimer *timer;
    NSTimer *timer2;
    NSTimer *timer3;
    UIButton *btn_1;
    UIButton *btn_2;
    UIButton *btn_3;
    
    NSString *contents_str;
    NSString *en_str;
    NSString *vi_str;
    NSString *chi_str;
    NSString *jpn_str;
    
    int is_btn_num;
    
    BOOL is_hwp;
}
@property (strong, nonatomic) UIDocumentInteractionController *documentInteractionCntroller;
@property (weak, nonatomic) IBOutlet UILabel *lbl_title;
@property (weak, nonatomic) IBOutlet UITextView *txt_view;
@property (strong, nonatomic) Lms_Content_Get *lms_c_get;
@property (strong, nonatomic) Note_Content_Get *note_con_get;

@property UIActivityIndicatorView *indicator;
@property UILabel *loading;
@property UIView *indi_view;
- (IBAction)lang_segment:(UISegmentedControl *)sender;


@end

@implementation ShowViewContents
@synthesize con_url, title_txt, school_url_2;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    en_str = @"";
    vi_str = @"";
    chi_str = @"";
    jpn_str = @"";
    
    is_btn_num = 0;
    
    self.txt_view.hidden = YES;
    
    [self indi_start];
    
    self.lms_c_get = [[Lms_Content_Get alloc]init];
    self.lms_c_get.delegate = self;
    self.note_con_get = [[Note_Content_Get alloc]init];
    self.note_con_get.delegate = self;
    
    self.lbl_title.text = title_txt;
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"첨부파일" style:0 target:self action:@selector(bar_btn)];
    
    
    
    NSRange range_1 = [con_url rangeOfString:@"lms"];
    
    if (range_1.length == 0) {
        [self.note_con_get parsingWithUrl:con_url];
    }else{
        
        [self.lms_c_get parsingToGetWithUrl:con_url];
    }
    
    v1 = [[UIView alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height+100, self.view.frame.size.width, 100)];
    
    v1.backgroundColor = [UIColor whiteColor];
    //    v1.alpha = 0.7;
    [self.view addSubview:v1];
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, v1.frame.size.width, 7)];
    label.backgroundColor = [UIColor blueColor];
    [v1 addSubview:label];
    
    
    UIButton *btn_4 = [UIButton buttonWithType:1];
    btn_4.frame = CGRectMake(v1.frame.size.width-80, 10, 70, 40);
    [btn_4 setTitle:@"취소하기" forState:UIControlStateNormal];
    btn_4.titleLabel.font = [UIFont boldSystemFontOfSize:20];
    [v1 addSubview:btn_4];
    [btn_4 addTarget:self action:@selector(btn_action) forControlEvents:UIControlEventTouchUpInside];
    
    btn_1 = [UIButton buttonWithType:1];
    btn_1.frame = CGRectMake(20, 20, 80, 40);
    [btn_1 setTitle:@"첨부파일 1" forState:UIControlStateNormal];
    btn_1.titleLabel.font = [UIFont boldSystemFontOfSize:18];
    [v1 addSubview:btn_1];
    btn_1.tag = 1;
    [btn_1 addTarget:self action:@selector(btn2_action:) forControlEvents:UIControlEventTouchUpInside];
    
    btn_2 = [UIButton buttonWithType:1];
    btn_2.frame = CGRectMake(120, 20, 80, 40);
    [btn_2 setTitle:@"첨부파일 1" forState:UIControlStateNormal];
    btn_2.titleLabel.font = [UIFont boldSystemFontOfSize:18];
    [v1 addSubview:btn_2];
    btn_2.tag = 2;
    [btn_2 addTarget:self action:@selector(btn2_action:) forControlEvents:UIControlEventTouchUpInside];
    
    btn_3 = [UIButton buttonWithType:1];
    btn_3.frame = CGRectMake(220, 20, 80, 40);
    [btn_3 setTitle:@"첨부파일 1" forState:UIControlStateNormal];
    btn_3.titleLabel.font = [UIFont boldSystemFontOfSize:18];
    [v1 addSubview:btn_3];
    btn_3.tag = 3;
    [btn_3 addTarget:self action:@selector(btn2_action:) forControlEvents:UIControlEventTouchUpInside];
    
}

-(void)bar_btn{
    
    int cnt = (int)[files_arr count];
    if (cnt == 0) {
        btn_1.hidden = YES;
        btn_2.hidden = YES;
        btn_3.hidden = YES;
        UILabel *lbl = [[UILabel alloc]initWithFrame:CGRectMake(20, 20, v1.frame.size.width-20, 80)];
        lbl.text = @"첨부파일이 없습니다.";
        lbl.textAlignment = 1;
        lbl.font = [UIFont boldSystemFontOfSize:20];
        lbl.textColor = [UIColor blueColor];
        [v1 addSubview:lbl];
    }else if(cnt == 1){
        
        btn_1.hidden = NO;
        btn_2.hidden = YES;
        btn_3.hidden = YES;
    }else if(cnt == 2){
        
        btn_1.hidden = NO;
        btn_2.hidden = NO;
        btn_3.hidden = YES;
    }else if(cnt == 3){
        
        btn_1.hidden = NO;
        btn_2.hidden = NO;
        btn_3.hidden = NO;
    }
    
    [UIView animateWithDuration:0.5
                          delay:0.1
                        options: 1
                     animations:^{
                         v1.frame = CGRectMake(0, self.view.frame.size.height-150, v1.frame.size.width , v1.frame.size.height);
                     }
                     completion:^(BOOL finished){
                     }];
    [self.view addSubview:v1];
    
}

-(void)btn_action{
    
    [UIView animateWithDuration:0.5
                          delay:0.1
                        options: 1
                     animations:^{
                         v1.frame = CGRectMake(0, self.view.frame.size.height+150, v1.frame.size.width , v1.frame.size.height);
                     }
                     completion:^(BOOL finished){
                     }];
    [self.view addSubview:v1];
    
}

-(void)btn2_action:(UIButton *)sender{
    
    [self indi_start];
    
    if(sender.tag == 1){
        timer = [NSTimer scheduledTimerWithTimeInterval:0.5f
                                                 target:self
                                               selector:@selector(subtracTime)
                                               userInfo:nil
                                                repeats:NO];
    }else if(sender.tag == 2){
        timer2 = [NSTimer scheduledTimerWithTimeInterval:0.5f
                                                  target:self
                                                selector:@selector(subtracTime2)
                                                userInfo:nil
                                                 repeats:NO];
    }else{
        timer3 = [NSTimer scheduledTimerWithTimeInterval:0.5f
                                                  target:self
                                                selector:@selector(subtracTime3)
                                                userInfo:nil
                                                 repeats:NO];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)compliteGetContents:(NSString *)contents{
    self.txt_view.text = contents;
    
    [self.indicator stopAnimating];
    [self.indi_view removeFromSuperview];
    [self.loading removeFromSuperview];
    
    self.txt_view.hidden = NO;
}

-(void)compliteNote:(NSString *)note_str Files:(NSArray *)files{
     self.txt_view.text = note_str;
    files_arr = files;
    contents_str = note_str;
    
    [self.indicator stopAnimating];
//    [self.indi_view removeFromSuperview];
//    [self.loading removeFromSuperview];
    [self.indi_view setHidden:YES];
    [self.loading setHidden:YES];
    
    self.txt_view.hidden = NO;
}
-(void) indi_start{
    
    if (self.indicator==nil) {
        
        self.indi_view = [[UIView alloc]initWithFrame:CGRectMake((int)self.view.frame.size.width/2-25-25, (int)self.view.frame.size.height/2-30, 100, 80)];
        self.indi_view.backgroundColor = [UIColor whiteColor];
        //        self.indi_view.alpha = 0.7;
        
        [self.view addSubview:self.indi_view];
        self.indicator  = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake((int)self.view.frame.size.width/2-25, (int)self.view.frame.size.height/2-25, 50, 50)];
        self.indicator.hidesWhenStopped = YES;
        self.indicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
        [self.view addSubview:self.indicator];
        self.loading = [[UILabel alloc]initWithFrame:CGRectMake(self.indicator.frame.origin.x, self.indicator.frame.origin.y+40, 80, 40)];
        self.loading.text = @"로딩중..";
        self.loading.font = [UIFont fontWithName:@"System-Bold" size:20];
        self.loading.textColor = [UIColor orangeColor];
        [self.view addSubview:self.loading];
        self.loading.hidden = YES;
    }
    [self.indicator startAnimating];
    self.loading.hidden = NO;
    self.indi_view.hidden = NO;
    
}

-(void)subtracTime{
    NSMutableString *stringURL2 = [[NSMutableString alloc]initWithString:school_url_2];
    [stringURL2 appendString:[files_arr objectAtIndex:0]];
    
    NSURL  *url = [NSURL URLWithString:stringURL2];
    BOOL is_confirm_hwp = [self is_contain_hwp:stringURL2];
    if(is_confirm_hwp == false){
        [[UIApplication sharedApplication]openURL:url];
    }else{
        
        NSData *urlData = [NSData dataWithContentsOfURL:url];
        if ( urlData )
        {
            NSArray       *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
            NSString  *documentsDirectory = [paths objectAtIndex:0];
            
            NSString *filePath = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@",@"test"]];
            
            BOOL isWrite = [urlData writeToFile:filePath atomically:YES];
            
            NSString *tempFilePath;
            
            if(isWrite){
                tempFilePath = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@",@"test"]];
            }
            
            NSURL *resultURL = [NSURL fileURLWithPath:tempFilePath];
            
            self.documentInteractionCntroller = [UIDocumentInteractionController interactionControllerWithURL:resultURL];
            self.documentInteractionCntroller.delegate = self;
            [self.documentInteractionCntroller presentOptionsMenuFromRect:CGRectZero inView:self.view animated:YES];
            //
            
            [self.indicator stopAnimating];
//            [self.indi_view removeFromSuperview];
            [self.indi_view setHidden:YES];
            [self.loading setHidden:YES];
        }
    }
    
}

-(BOOL)is_contain_hwp:(NSString *)url{
    
    if([url rangeOfString:@"hwp"].location == NSNotFound){
        is_hwp = false;
    }else{
        is_hwp = true;
    }
    
    return is_hwp;
}

-(void)subtracTime2{
    NSMutableString *stringURL2 = [[NSMutableString alloc]initWithString:school_url_2];
    [stringURL2 appendString:[files_arr objectAtIndex:1]];
    
    NSURL  *url = [NSURL URLWithString:stringURL2];
    BOOL is_confirm_hwp = [self is_contain_hwp:stringURL2];
    if(is_confirm_hwp == false){
        [[UIApplication sharedApplication]openURL:url];
    }else{
        
        NSData *urlData = [NSData dataWithContentsOfURL:url];
        if ( urlData )
        {
            NSArray       *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
            NSString  *documentsDirectory = [paths objectAtIndex:0];
            
            NSString *filePath = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@",@"test"]];
            
            BOOL isWrite = [urlData writeToFile:filePath atomically:YES];
            
            NSString *tempFilePath;
            
            if(isWrite){
                tempFilePath = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@",@"test"]];
            }
            
            NSURL *resultURL = [NSURL fileURLWithPath:tempFilePath];
            
            self.documentInteractionCntroller = [UIDocumentInteractionController interactionControllerWithURL:resultURL];
            self.documentInteractionCntroller.delegate = self;
            [self.documentInteractionCntroller presentOptionsMenuFromRect:CGRectZero inView:self.view animated:YES];
            //
            
            [self.indicator stopAnimating];
//            [self.indi_view removeFromSuperview];
            [self.indi_view setHidden:YES];
            [self.loading setHidden:YES];
        }
        
    }
    
}

-(void)subtracTime3{
    NSMutableString *stringURL2 = [[NSMutableString alloc]initWithString:school_url_2];
    [stringURL2 appendString:[files_arr objectAtIndex:2]];
    
    NSURL  *url = [NSURL URLWithString:stringURL2];
    BOOL is_confirm_hwp = [self is_contain_hwp:stringURL2];
    if(is_confirm_hwp == false){
        [[UIApplication sharedApplication]openURL:url];
    }else{
        
        
        NSData *urlData = [NSData dataWithContentsOfURL:url];
        if ( urlData )
        {
            NSArray  *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
            NSString  *documentsDirectory = [paths objectAtIndex:0];
            
            NSString *filePath = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@",@"test"]];
            
            BOOL isWrite = [urlData writeToFile:filePath atomically:YES];
            
            NSString *tempFilePath;
            
            if(isWrite){
                tempFilePath = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@",@"test"]];
            }
            
            NSURL *resultURL = [NSURL fileURLWithPath:tempFilePath];
            
            self.documentInteractionCntroller = [UIDocumentInteractionController interactionControllerWithURL:resultURL];
            self.documentInteractionCntroller.delegate = self;
            [self.documentInteractionCntroller presentOptionsMenuFromRect:CGRectZero inView:self.view animated:YES];
            //
            
            [self.indicator stopAnimating];
//            [self.indi_view removeFromSuperview];
            [self.indi_view setHidden:YES];
            [self.loading setHidden:YES];
        }
    }
    
}


- (IBAction)lang_segment:(UISegmentedControl *)sender {
    
    int now_select = (int)sender.selectedSegmentIndex;
    contents_str = [contents_str stringByReplacingOccurrencesOfString:@"&" withString:@","];
    if (now_select == 0){
            self.txt_view.text = contents_str;
    }else if(now_select == 1){
            is_btn_num = 1;
        if([en_str isEqualToString:@""]){
            [self indi_start];
            [self translateWithString:contents_str Nation:@"en"];
    }else{
            self.txt_view.text = en_str;
        }
    }else if (now_select == 2){
        is_btn_num = 2;
        if([vi_str isEqualToString:@""]){
            [self indi_start];
            [self translateWithString:contents_str Nation:@"vi"];
        }else{
            self.txt_view.text = vi_str;
        }
    }else if (now_select == 3){
        is_btn_num = 3;
        if([chi_str isEqualToString:@""]){
            [self indi_start];
            [self translateWithString:contents_str Nation:@"zh"];
        }else{
            self.txt_view.text = chi_str;
        }
    }else if (now_select == 4){
        is_btn_num = 4;
        if([jpn_str isEqualToString:@""]){
            [self indi_start];
            [self translateWithString:contents_str Nation:@"ja"];
        }else{
            self.txt_view.text = jpn_str;
        }
    }
}


-(void)translateWithString:(NSString *)str Nation:(NSString *)nation{
    NSString *dataUrl = [NSString stringWithFormat:@"https://translation.googleapis.com/language/translate/v2?key=AIzaSyBqMdVQWlo7-xMeilJ9R0lvWKXGD8IV1bg&source=ko&target=%@&q=%@",nation,str];
    NSString * encodedString = [dataUrl stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLFragmentAllowedCharacterSet]];
    NSURL *url = [NSURL URLWithString: encodedString];
    NSURLSessionDataTask *downloadTask = [[NSURLSession sharedSession]
                                          dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                              NSDictionary *result = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
//                                              NSLog(@"Result = %@",result);
                                              NSDictionary *data1 = result[@"data"];
                                              NSDictionary *translations = data1[@"translations"];
                                              NSString *translatedText;
                                              for (NSMutableDictionary *dic in translations)
                                              {
                                                  translatedText = dic[@"translatedText"];
                                              }
                                              dispatch_async(dispatch_get_main_queue(), ^{
                                                  if ([[NSThread currentThread] isMainThread]){
//                                                      NSLog(@"%@", translatedText);
                                                      NSString *temp_str =translatedText;
//                                                      if([translatedText containsString:@"2."]){
                                                          temp_str = [temp_str stringByReplacingOccurrencesOfString:@"&#39" withString:@"'"];
                                                          temp_str = [temp_str stringByReplacingOccurrencesOfString:@"1." withString:@"\n1."];
                                                          temp_str = [temp_str stringByReplacingOccurrencesOfString:@"2." withString:@"\n2."];
                                                          temp_str = [temp_str stringByReplacingOccurrencesOfString:@"3." withString:@"\n3."];
                                                          temp_str = [temp_str stringByReplacingOccurrencesOfString:@"4." withString:@"\n4."];
                                                          temp_str = [temp_str stringByReplacingOccurrencesOfString:@"5." withString:@"\n5."];
                                                          temp_str = [temp_str stringByReplacingOccurrencesOfString:@"6." withString:@"\n6."];
                                                          temp_str = [temp_str stringByReplacingOccurrencesOfString:@"7." withString:@"\n7."];
                                                          temp_str = [temp_str stringByReplacingOccurrencesOfString:@"8." withString:@"\n8."];
                                                          temp_str = [temp_str stringByReplacingOccurrencesOfString:@"9." withString:@"\n9."];
//                                                      }
                                                      if(is_btn_num == 1){
                                                          en_str = temp_str;
                                                          self.txt_view.text = en_str;
                                                      }else if(is_btn_num == 2){
                                                          vi_str = temp_str;
                                                          self.txt_view.text = vi_str;
                                                      }else if(is_btn_num == 3){
                                                          chi_str = temp_str;
                                                          self.txt_view.text = chi_str;
                                                      }else if(is_btn_num == 4){
                                                          jpn_str = temp_str;
                                                          self.txt_view.text = jpn_str;
                                                      }
                                                      
                                                      [self.indicator stopAnimating];
//                                                      [self.indi_view removeFromSuperview];
                                                      [self.indi_view setHidden:YES];
                                                      [self.loading setHidden:YES];
//                                                      NSLog(@"In main thread--completion handler");
                                                  }
                                                  else{
//                                                      NSLog(@"Not in main thread--completion handler");
                                                  }
                                              });
                                          }];
    [downloadTask resume];
}




@end
