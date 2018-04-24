//
//  School_News_Show.m
//  Anounce_Note
//
//  Created by kimsung jun on 2015. 5. 27..
//  Copyright (c) 2015년 kimsung jun. All rights reserved.
//

#import "School_News_Show.h"
#import "Students_Data_Manager.h"
#include <dispatch/dispatch.h>

@interface School_News_Show (){
    
    NSArray *files_arr;
    UIView *v1;

    NSThread *thread;
    dispatch_queue_t dQueue;
    NSTimer *timer;
    NSTimer *timer2;
    NSTimer *timer3;
    UIButton *btn_2;
    UIButton *btn_3;
    UIButton *btn_4;
    
    BOOL is_hwp;
    
}
@property (weak, nonatomic) IBOutlet UILabel *lbl_title;
@property (weak, nonatomic) IBOutlet UITextView *txt_contents;
@property (strong, nonatomic) UIDocumentInteractionController *documentInteractionCntroller;
@property UIActivityIndicatorView *indicator;
@property UILabel *lbl;
@property UILabel *loading;
@property UIView *indi_view;
- (IBAction)btn_files:(UIButton *)sender;

@end

@implementation School_News_Show
@synthesize myContents_url, myTitle, str_title, school_url;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self indi_start];
//    str_title = [str_title stringByReplacingOccurrencesOfString:@"등학교" withString:@""];
    self.navigationItem.title = [NSString stringWithFormat:@"%@ 공지사항", str_title];
    
//    UINavigationItem *navi_item = [[UINavigationItem alloc]init];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"첨부파일" style:0 target:self action:@selector(bar_btn)];
    

    
    self.documentInteractionCntroller = [[UIDocumentInteractionController alloc]init];
    
    News_Contents_Get *news_get = [[News_Contents_Get alloc]init];
    news_get.delegate = self;
    [news_get parsingWithUrl:myContents_url];
    
        v1 = [[UIView alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height+100, self.view.frame.size.width, 100)];
    
    v1.backgroundColor = [UIColor whiteColor];
//    v1.alpha = 0.7;
    [self.view addSubview:v1];
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, v1.frame.size.width, 7)];
    label.backgroundColor = [UIColor blueColor];
    [v1 addSubview:label];
    
    
    UIButton *btn_1 = [UIButton buttonWithType:1];
    btn_1.frame = CGRectMake(v1.frame.size.width-80, 10, 70, 40);
    [btn_1 setTitle:@"취소하기" forState:UIControlStateNormal];
    btn_1.titleLabel.font = [UIFont boldSystemFontOfSize:20];
    [v1 addSubview:btn_1];
    [btn_1 addTarget:self action:@selector(btn_action) forControlEvents:UIControlEventTouchUpInside];
    
    btn_2 = [UIButton buttonWithType:1];
    btn_2.frame = CGRectMake(20, 20, 80, 40);
    [btn_2 setTitle:@"첨부파일 1" forState:UIControlStateNormal];
    btn_2.titleLabel.font = [UIFont boldSystemFontOfSize:18];
    [v1 addSubview:btn_2];
    btn_2.tag = 1;
    [btn_2 addTarget:self action:@selector(btn2_action:) forControlEvents:UIControlEventTouchUpInside];
    
    btn_3 = [UIButton buttonWithType:1];
    btn_3.frame = CGRectMake(120, 20, 80, 40);
    [btn_3 setTitle:@"첨부파일 1" forState:UIControlStateNormal];
    btn_3.titleLabel.font = [UIFont boldSystemFontOfSize:18];
    [v1 addSubview:btn_3];
    btn_3.tag = 2;
    [btn_3 addTarget:self action:@selector(btn2_action:) forControlEvents:UIControlEventTouchUpInside];
    
    btn_4 = [UIButton buttonWithType:1];
    btn_4.frame = CGRectMake(220, 20, 80, 40);
    [btn_4 setTitle:@"첨부파일 1" forState:UIControlStateNormal];
    btn_4.titleLabel.font = [UIFont boldSystemFontOfSize:18];
    [v1 addSubview:btn_4];
    btn_4.tag = 3;
    [btn_4 addTarget:self action:@selector(btn2_action:) forControlEvents:UIControlEventTouchUpInside];
    
}

-(void)thread_2{
    
    dispatch_queue_t aQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);

    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        self.indicator = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        self.indicator.hidesWhenStopped = YES;
        
        self.indicator.center = self.view.center;
        
        [self.view addSubview:self.indicator];
        self.lbl = [[UILabel alloc]initWithFrame:CGRectMake(self.view.center.x-60, self.view.center.y+20, 120, 40)];
        self.lbl.text = @"다운중입니다.";
        self.lbl.textColor = [UIColor redColor];
        self.lbl.textAlignment = 1;
        self.lbl.font = [UIFont systemFontOfSize:18];
        [self.view addSubview:self.lbl];
        
        [self.indicator startAnimating];
        
        id __weak selfweak = self;
        __weak UIActivityIndicatorView *indicator2 = self.indicator;
        __weak UILabel *lbl2 = self.lbl;
        
        dispatch_async(aQueue, ^{//작업시간이 많이 걸리는 작업
            NSString *stringURL2 = @"http://www.ara.es.kr/common/FileDownload.jsp?fid=c5f525f785811646a888125347c4caef&type=application/octet-stream&ext=hwp";
            
            NSURL  *url = [NSURL URLWithString:stringURL2];
            
            //    [[UIApplication sharedApplication]openURL:url];
            
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
                
                
            }
            
            id __strong selfStrong = selfweak;
            __strong UIActivityIndicatorView *indi = indicator2;
            __strong UILabel *lbl3 = lbl2;
            dispatch_async(dispatch_get_main_queue(), ^{
                if (selfStrong) {
                    [lbl3 removeFromSuperview];
                    [indi stopAnimating];
                    [indi removeFromSuperview];
                    
                }
                
                
            });
        });
        
    });
    
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

-(void)subtracTime{
    NSMutableString *stringURL2 = [[NSMutableString alloc]initWithString:school_url];
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
            [self.indi_view removeFromSuperview];
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
    NSMutableString *stringURL2 = [[NSMutableString alloc]initWithString:school_url];
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
            [self.indi_view removeFromSuperview];
            [self.loading setHidden:YES];
        }
        
    }
    
}

-(void)subtracTime3{
    NSMutableString *stringURL2 = [[NSMutableString alloc]initWithString:school_url];
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
            [self.indi_view removeFromSuperview];
            [self.loading setHidden:YES];
        }
    }
    
}
                                   
-(void)bar_btn{
    
    int cnt = (int)[files_arr count];
    if (cnt == 0) {
        btn_2.hidden = YES;
        btn_3.hidden = YES;
        btn_4.hidden = YES;
        UILabel *lbl = [[UILabel alloc]initWithFrame:CGRectMake(20, 20, v1.frame.size.width-20, 80)];
        lbl.text = @"첨부파일이 없습니다.";
        lbl.textAlignment = 1;
        lbl.font = [UIFont boldSystemFontOfSize:20];
        lbl.textColor = [UIColor blueColor];
        [v1 addSubview:lbl];
    }else if(cnt == 1){
        
        btn_2.hidden = NO;
        btn_3.hidden = YES;
        btn_4.hidden = YES;
    }else if(cnt == 2){
        
        btn_2.hidden = NO;
        btn_3.hidden = NO;
        btn_4.hidden = YES;
    }else if(cnt == 3){
        
        btn_2.hidden = NO;
        btn_3.hidden = NO;
        btn_4.hidden = NO;
    }
    
    [UIView animateWithDuration:0.5
                          delay:0.1
                        options: 1
                     animations:^{
                         self->v1.frame = CGRectMake(0, self.view.frame.size.height-150, self->v1.frame.size.width , self->v1.frame.size.height);
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
                         self->v1.frame = CGRectMake(0, self.view.frame.size.height+150, self->v1.frame.size.width , self->v1.frame.size.height);
                     }
                     completion:^(BOOL finished){
                     }];
    [self.view addSubview:v1];
    
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    self.navigationController.navigationBarHidden = NO;
}


-(void)compliteGetContentsTitle:(NSString *)con_title Contents:(NSString *)contents  Files:(NSArray *)files{

    [self.indicator stopAnimating];
    [self.indi_view removeFromSuperview];
    [self.loading removeFromSuperview];
    
    self.indicator = nil;
    
//    NSLog(@"%d",(int)[files count]);
    files_arr = files;
    
    self.lbl_title.text = con_title;
    [self.lbl_title setNumberOfLines:2];
    [self.lbl_title setAdjustsFontSizeToFitWidth:YES];
    self.txt_contents.text = contents;
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
}
//--- 3월 27일 수정
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    NSMutableString *stringURL = [NSMutableString stringWithFormat:@"%@",self.school_url];
    if(files_arr.count >0 && buttonIndex == 0)
    {
        [stringURL appendString:[files_arr objectAtIndex:0]];
    }
    else if(buttonIndex == 1)
    {
       [stringURL appendString:[files_arr objectAtIndex:1]];
    }
    else if(buttonIndex == 2)
    {
       [stringURL appendString:[files_arr objectAtIndex:2]];
    }
    else if(buttonIndex == 3)
    {
        [stringURL appendString:[files_arr objectAtIndex:3]];
    }
    else if(buttonIndex == 4)
    {
        [stringURL appendString:[files_arr objectAtIndex:4]];
    }
    NSString *stringURL2 = @"http://www.ara.es.kr/common/FileDownload.jsp?fid=c5f525f785811646a888125347c4caef&type=application/octet-stream&ext=hwp";
    
    NSURL  *url = [NSURL URLWithString:stringURL2];
    
    [[UIApplication sharedApplication]openURL:url];
    
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
        
        [self.documentInteractionCntroller presentOpenInMenuFromRect:CGRectZero inView:self.view animated:YES];
    }

    
}


- (IBAction)btn_files:(UIButton *)sender {
    
//    btn_2.hidden = YES;
   

}

#pragma mark - UIDocumentInteractionControllerDelegate

//===================================================================
- (UIViewController *)documentInteractionControllerViewControllerForPreview:(UIDocumentInteractionController *)controller
{
    return self;
}

- (UIView *)documentInteractionControllerViewForPreview:(UIDocumentInteractionController *)controller
{
    return self.view;
}

- (CGRect)documentInteractionControllerRectForPreview:(UIDocumentInteractionController *)controller
{
    return self.view.frame;
}

@end
