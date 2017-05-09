//
//  ShowViewController.m
//  Anounce_Note
//
//  Created by kimsung jun on 2015. 5. 10..
//  Copyright (c) 2015년 kimsung jun. All rights reserved.
//

#import "ShowViewController.h"
#import "ShowViewContents.h"
#import "Food_ShowController.h"

@interface ShowViewController (){
    
    Lms_List_Get *lms_get;
    
    NSArray *files_arr;
    UIView *v1;
    UIButton *btn_1;
    UIButton *btn_2;
    UIButton *btn_3;

}

@property NSArray *data_arr;
@property NSArray *url_arr;
- (IBAction)btn_food:(UIBarButtonItem *)sender;

@property UIActivityIndicatorView *indicator;
@property UILabel *loading;
@property UIView *indi_view;

@end

@implementation ShowViewController
@synthesize student_dic, school_url1;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
   //    NSLog(@"%@", student_dic);
    
    self.navigationController.navigationBarHidden = NO;
    
    [self indi_start];
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    //    self.navigationItem.title  = [NSString stringWithFormat:@"%@학년 %@반 %@ 알림장", [student_dic objectForKey:@"grade"], [student_dic objectForKey:@"class"], [student_dic objectForKey:@"name"]];
    
    self.navigationItem.title  = [NSString stringWithFormat:@"%@학년 %@반 %@ 알림장", [student_dic objectForKey:@"grade"], [student_dic objectForKey:@"class"], [student_dic objectForKey:@"name"]];
    
    
    
    Note_List_Get *note_get = [[Note_List_Get alloc]init];
    
    note_get.delegate = self;
    
    Class_Url_Make *c_make = [[Class_Url_Make alloc]init];
    
    c_make.delegate = self;
    
    lms_get = [[Lms_List_Get alloc]init];
    
    lms_get.delegate = self;
    
    
    
    NSString *url = [student_dic objectForKey:@"note_url"];
    
    NSRange range_1 = [url rangeOfString:@"lms"];
    
    if (range_1.length == 0) {
        [note_get parsing:url School_Url:[student_dic objectForKey:@"school_url"]];
    }else{
        //        [c_make parsing:url];
        
        //        [lms_get nonLmsParsingUrl:url];
        
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"학급정보 오류" message:@"새미학급과 더이상 연동하지 않습니다.\n 학급정보를 새로 등록하시면 제대로 동작합니다.\n 그래도 새미학급과 연동하기를 원하시면 확인을 눌러주세요." delegate:self cancelButtonTitle:@"취소" otherButtonTitles:@"확인", nil];
        alertView.tag = 2;
        [alertView show];
    }
    
    

}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
}




- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.data_arr.count;
}

-(void)compliteParsing:(NSArray *)arr_url Title:(NSArray *)arr_title{
    
    self.data_arr = arr_title;
    self.url_arr = arr_url;
    
    [self.indicator stopAnimating];
    [self.indi_view removeFromSuperview];
    [self.loading removeFromSuperview];
    
    if (self.data_arr.count == 0) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"알림장 없음" message:@"알림장이 기록되어 있지 않습니다.\n선생님에게 문의하십시오." delegate:self cancelButtonTitle:@"확인" otherButtonTitles:nil, nil];
        alertView.tag = 2;
        [alertView show];
    }else{
        [self.tableView reloadData];
    }
}

-(void)CompliteParsingKey:(NSString *)key Value:(NSString *)value Lms_URl:(NSString *)lms_url{
//    NSLog(@"key = %@ \n, vlaue = %@ \n, lms_url = %@", key, value, lms_url);
    
    Lms_List_Get *lms_get2 = [[Lms_List_Get alloc]init];
    
    lms_get2.delegate = self;
    
//    [lms_get parsingWithUserToken:key Value:value Url:lms_url];
    [lms_get2 nonLmsParsingUrl:lms_url];
}

-(void)compliteLmsParsingWithUrl_Array:(NSArray *)url_arr Tilte_Array:(NSArray *)title_array{
    if (url_arr.count != 0) {
        self.data_arr = title_array;
        self.url_arr = url_arr;
        [self.indicator stopAnimating];
        [self.indi_view removeFromSuperview];
        [self.loading removeFromSuperview];
        [self.tableView reloadData];
    }else{

        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"학교정보 오류" message:@"새미학급 게시판경로가 잘못되었습니다.\n관리자에게 문의하십시오." delegate:self cancelButtonTitle:@"확인" otherButtonTitles:nil, nil];
        alertView.tag = 1;
        [alertView show];
        
    }
}

-(void)failParsingForNoteList{
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"학교정보 오류" message:@"알림장을 로드할 수 없습니다.\n관리자에게 문의하십시오." delegate:self cancelButtonTitle:@"확인" otherButtonTitles:nil, nil];
    alertView.tag = 1;
    [alertView show];
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0 && alertView.tag == 1) {
        [self.navigationController popViewControllerAnimated:YES];
    }else if(buttonIndex == 0 && alertView.tag == 2){
        [self.navigationController popViewControllerAnimated:YES];
    }else if(buttonIndex == 1 && alertView.tag == 2){
        
        NSString *url = [student_dic objectForKey:@"note_url"];
        
        [lms_get nonLmsParsingUrl:url];
        
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    
    cell.textLabel.text = [self.data_arr objectAtIndex:indexPath.row];
    
    return cell;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"note"]) {
        NSIndexPath *indexpath = [self.tableView indexPathForSelectedRow];
        
        //    NSDictionary *dic = self.modelCinema.arrayResult[indexpath.row];
        NSString *title_str = [self.data_arr objectAtIndex:indexpath.row];
        NSString *url_str = [self.url_arr objectAtIndex:indexpath.row];
        
        [[segue destinationViewController] setTitle_txt:title_str];
        [[segue destinationViewController] setCon_url:url_str];
        [[segue destinationViewController] setSchool_url_2:school_url1];
    }else if([segue.identifier isEqualToString:@"food"]){
        
        NSString *food_url = [student_dic objectForKey:@"food_url"];
        [[segue destinationViewController] setFood_url:food_url];
    }
}


- (IBAction)btn_back:(UIButton *)sender {
}
- (IBAction)btn_food:(UIBarButtonItem *)sender {
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
