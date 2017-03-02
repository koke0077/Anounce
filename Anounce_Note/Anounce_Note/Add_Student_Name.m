//
//  Add_Student_Name.m
//  Anounce_Note
//
//  Created by kimsung jun on 2015. 5. 13..
//  Copyright (c) 2015년 kimsung jun. All rights reserved.
//

#import "Add_Student_Name.h"
#import "AppDelegate.h"
#import "Students_Data_Manager.h"
#import "Students_Face_Managert.h"


@interface Add_Student_Name (){
    
    Class_Url_Make *cls_make;
    Pass_lms_Class *p_lms;
    Board_Url_1 *b_url_1;
    Board_Url_2 *b_url_2;
}

@property NSString *frame_str1;//홈페이지 페이지소스를 보기위해 삽입할 주소
@property NSString *frame_str2;
@property NSMutableString *note_url;
@property (weak, nonatomic) IBOutlet UITextField *name_txt;

@property UIActivityIndicatorView *indicator;
@property UILabel *loading;
@property UIView *indi_view;

- (IBAction)btn_save:(UIButton *)sender;
- (IBAction)btn_back:(UIButton *)sender;



@end

@implementation Add_Student_Name

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self indi_start];
    
    self.name_txt.hidden = YES;
    
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    
//    self.note_url = [[NSMutableString alloc]initWithString:delegate.school_url];
    
    self.note_url = [[NSMutableString alloc]initWithString:delegate.class_url];
    
//    delegate.school_grade = [delegate.school_grade stringByReplacingOccurrencesOfString:@"학년" withString:@""];
//    delegate.school_class = [delegate.school_class stringByReplacingOccurrencesOfString:@"반" withString:@""];
    
//    int grade_num = [delegate.school_grade intValue];
//    int class_num = [delegate.school_class intValue];
    
    //3월 26일 수정
    NSDate *date = [NSDate date];
    int month = [[[self dateFormatter] stringFromDate:date] intValue];
    int year = [[[self dateFormatter2] stringFromDate:date] intValue];
    
    int now_year = 0;
    
    if (month<3) {
        now_year = year -1;
    }else{
        now_year = year;
    }
    /*
    self.frame_str1 = @"/modules/cafe/class/index.jsp?";
    self.frame_str2 = [NSString stringWithFormat:@"&m_year=%d&m_code=G00800300300",now_year];
//
    self.frame_str2 = [NSString stringWithFormat:@"%@%d00%d",self.frame_str2,grade_num+1, class_num+1];
    [self.note_url appendString:self.frame_str1];
    [self.note_url appendString:delegate.school_code];
    [self.note_url appendString:self.frame_str2];
    */
     
    Class_Url_Select * cus = [[Class_Url_Select alloc]init];
    cus.delegate = self;
    
    [cus is_gen:self.note_url];
    
    p_lms = [[Pass_lms_Class alloc]init];
    
    p_lms.delegate = self;
    
    cls_make = [[ Class_Url_Make alloc]init];
    cls_make.delegate = self;
    
    b_url_1 = [[Board_Url_1 alloc]init];
    b_url_1.delegate = self;
    
    b_url_2 = [[Board_Url_2 alloc]init];
    b_url_2.delegate = self;

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

-(void)completeClassParsing:(NSString *)note_url Is_On:(BOOL)is_on{
    
    if (is_on) {
//        NSLog(@"note_url = %@", note_url);
        AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
        [b_url_1 parsingWithUrl:note_url School:delegate.school_url];
    }else{
//        [cls_make parsing:note_url];
        [p_lms start_ParseUrl:note_url];
    }
    
   
}

-(void)complite_Board_Parsing:(NSString *)url{
//    NSLog(@"%@", url);
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    [b_url_2 parsingWithUrl2:url School:delegate.school_url];
}


-(void)complite_Board2_Parsing:(NSString *)url{
//    NSLog(@"%@",url);
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    delegate.lms_url = url;
    self.name_txt.hidden = NO;
    [self.indicator stopAnimating];
    [self.indi_view removeFromSuperview];
    [self.loading removeFromSuperview];
    
}

-(void)CompliteParsingKey:(NSString *)key Value:(NSString *)value Lms_URl:(NSString *)lms_url{
    
    [p_lms sendUserToken:key Value:value Url:lms_url];
}

-(void)compliteParsing_return_url:(NSString *)url{
    
    self.name_txt.hidden = NO;
    
    self.note_url = [NSMutableString stringWithString:url];
    
    [self.indicator stopAnimating];
    [self.indi_view removeFromSuperview];
    [self.loading removeFromSuperview];
    
//    NSLog(@"알림장 게시판 return URL = %@", url);
}

-(void)FailedParsing_Class{
    
    [self.indicator stopAnimating];
    [self.indi_view removeFromSuperview];
    [self.loading removeFromSuperview];
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"학년정보 오류" message:@"학년정보가 잘못되었습니다.\n관리자에게 문의하십시오." delegate:self cancelButtonTitle:@"확인" otherButtonTitles:nil, nil];
    alertView.tag = 1;
    [alertView show];
    
}

-(void)failParsingForLmsClass{
    
    [self.indicator stopAnimating];
    [self.indi_view removeFromSuperview];
    [self.loading removeFromSuperview];
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"학년정보 오류" message:@"학년정보가 잘못되었습니다.\n관리자에게 문의하십시오." delegate:self cancelButtonTitle:@"확인" otherButtonTitles:nil, nil];
    alertView.tag = 1;
    [alertView show];
}

-(void)failParsing{
    [self.indicator stopAnimating];
    [self.indi_view removeFromSuperview];
    [self.loading removeFromSuperview];
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"코드 오류" message:@"홈페이지 관련 정보가 잘못되었습니다.\n관리자에게 문의하십시오." delegate:self cancelButtonTitle:@"확인" otherButtonTitles:nil, nil];
    alertView.tag = 1;
    [alertView show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0 && alertView.tag == 1) {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [self.name_txt resignFirstResponder];
    
    return YES;
}

-(NSData *)imgToDataMake{
    
    UIImage *img = [UIImage imageNamed:@"basic_face.png"];
    
    NSData *data = UIImagePNGRepresentation(img);
    
    return data;
}

- (IBAction)btn_save:(UIButton *)sender {
    
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    
    Students_Data_Manager *s_data = [[Students_Data_Manager alloc]init];
    Students_Face_Managert *f_data = [[Students_Face_Managert alloc]init];
    
    NSData *img_data = [self imgToDataMake];
    
//    [s_data addDataWithName:self.name_txt.text School:delegate.school_name Grade:delegate.school_grade Class:delegate.school_class School_Url:delegate.school_url Food_Url:delegate.food_url Note_Url:delegate.lms_url News_Url:delegate.news_url] ;
    
    [s_data addDataWithName:self.name_txt.text School:delegate.school_name Grade:delegate.school_grade Class:delegate.school_class School_Url:delegate.school_url Food_Url:delegate.school_code_noncode Note_Url:delegate.lms_url News_Url:delegate.news_url] ;
    
    [f_data addWithImageData:img_data ByName:self.name_txt.text];
    
    //multy ViewController dismiss
    [self.presentingViewController.presentingViewController.presentingViewController dismissViewControllerAnimated:YES completion:nil];
     [self.presentingViewController.presentingViewController dismissViewControllerAnimated:YES completion:nil];
     [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
     [self dismissViewControllerAnimated:YES completion:nil];

}

- (IBAction)btn_back:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
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

@end
