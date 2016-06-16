//
//  ViewController.m
//  Anounce_Note
//
//  Created by kimsung jun on 2015. 5. 9..
//  Copyright (c) 2015년 kimsung jun. All rights reserved.
//
#import <SystemConfiguration/SystemConfiguration.h>
#import <netinet/in.h>
#import "ViewController.h"
#import "Add_DataViewController.h"
#import "Students_Data_Manager.h"
#import "Students_Face_Managert.h"
#import "ShowViewController.h"
#import "Food_ShowController.h"
#import "EduNewsShow.h"
#import "School_News_List.h"
#include <dispatch/dispatch.h>
#import "Students_ManageController.h"


@interface ViewController (){
    int pageIndex;
    NSArray *std_arr;
    NSArray *face_arr;
    Students_Data_Manager *s_data;
    Students_Face_Managert *f_data;
    NSDictionary *ok_dic;
    NSDictionary *dic;
    NSDictionary *face_dic;
    NSArray *news_title;
    NSArray *news_urls;
    NSString *news_str;
    NSThread *thread;
    dispatch_queue_t dQueue;
    BOOL is_load_data;
    BOOL is_pars_data;
    Edu_News_List *edu_list;
    int page;
    BOOL is_new;
}
@property (weak, nonatomic) IBOutlet UILabel *lbl_title;
@property (weak, nonatomic) IBOutlet UITableView *tableview;
@property (weak, nonatomic) IBOutlet UIView *view_1;
@property UIActivityIndicatorView *myIndi;
@property NSMutableArray *terminalViews;
@property (weak, nonatomic) IBOutlet UIScrollView *scroll;
@property (weak, nonatomic) IBOutlet UIButton *back_btn;
@property UIActivityIndicatorView *indicator;
@property (weak, nonatomic) IBOutlet UILabel *lbl_page;
@property UILabel *loading;
@property UIView *indi_view;
- (IBAction)reload_btn:(UIButton *)sender;
- (IBAction)btn_BackNew:(UIButton *)sender;
- (IBAction)btn_NextNew:(UIButton *)sender;

@end

NSInteger const SMEPGiPadViewControllerCellWidth = 300;

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
 
    is_load_data = NO;
    is_pars_data = NO;
    is_new = NO;
    
    if ([self isNetworkReachable]) {
        
        if ([self isCellNetwork]) {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"셀룰러 연결" message:@"WiFi로 연결되지 않았습니다.\n 셀룰러로 연결할 경우 요금이 부과될 수 있습니다." delegate:self cancelButtonTitle:@"확인" otherButtonTitles:nil, nil];
            alertView.tag = 2;
//            [alertView show];
            
        }else{
            NSLog(@"wifi");
        }
        
    }else{
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"네트워크 연결 오류" message:@"네트워크에 연결되지 않았습니다. \n 네트워크에 연결하고 다시 실행해주십시오." delegate:self cancelButtonTitle:@"확인" otherButtonTitles:nil, nil];
        alertView.tag = 1;
        [alertView show];
    }
    
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    
    edu_list = [[Edu_News_List alloc]init];
    
    edu_list.delegate = self;
    
    [self indi_start];
    
    [edu_list parsingWithEduNewsWith:@"http://news.gne.go.kr/allBoard.do?type=news&page=1&mcode=XM1401070728004&viewType=Y&addDay=24&boardseq=boardEJ1400460249735&recoType=N"];
    
    page = 1;
    
    self.lbl_page.text = [NSString stringWithFormat:@"%d",page];
    
    self.back_btn.hidden = YES;
    
    s_data = [[Students_Data_Manager alloc]init];
    f_data = [[Students_Face_Managert alloc]init];
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    
    dQueue = dispatch_queue_create("test", NULL);
    
    [NSThread detachNewThreadSelector:@selector(thread_2) toTarget:self withObject:nil];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0 && alertView.tag == 1) {
       
    }else{
        
    }
}

-(void)failParsing{
    
}

-(void)failLoadNew{
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"네트워크 오류" message:@"네트워크에 연결되어 있지 않습니다.\n 네트워크에 연결후 다시 시도해 주십시오." delegate:self cancelButtonTitle:@"확인" otherButtonTitles:nil, nil];
    alertView.tag = 1;
    [alertView show];
    
}

-(BOOL) isNetworkReachable //네트워크 연결 상태 확인
{
    struct sockaddr_in zeroAddr;
    bzero(&zeroAddr, sizeof(zeroAddr));
    zeroAddr.sin_len = sizeof(zeroAddr);
    zeroAddr.sin_family = AF_INET;
    
    SCNetworkReachabilityRef target = SCNetworkReachabilityCreateWithAddress(NULL, (struct sockaddr *)&zeroAddr);
    
    SCNetworkReachabilityFlags flag;
    SCNetworkReachabilityGetFlags(target, &flag);
    
    if(flag & kSCNetworkFlagsReachable){
        return YES;
        
        
    }else {
        return NO;
        
        
    }
}


-(BOOL)isCellNetwork{ //셀룰러, wifi 확인
    struct sockaddr_in zeroAddr;
    bzero(&zeroAddr, sizeof(zeroAddr));
    zeroAddr.sin_len = sizeof(zeroAddr);
    zeroAddr.sin_family = AF_INET;
    
    SCNetworkReachabilityRef target = SCNetworkReachabilityCreateWithAddress(NULL, (struct sockaddr *)&zeroAddr);
    
    SCNetworkReachabilityFlags flag;
    SCNetworkReachabilityGetFlags(target, &flag);
    
    if(flag & kSCNetworkReachabilityFlagsIsWWAN){
        return YES;
        
        
    }else {
        return NO;
        
    }
}



-(void)thread_2{
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
//        self.myIndi = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
//        self.myIndi.hidesWhenStopped = YES;
//        
//        self.myIndi.center = self.view.center;
        
//        [self.view addSubview:self.myIndi];
//        
//        [self.myIndi startAnimating];
        
        id __weak selfweak = self;
//         __weak UIActivityIndicatorView *indicator2 = self.myIndi;
        
        dispatch_async(dQueue, ^{
            std_arr = [s_data getRecords];
            face_arr = [f_data get_FaceImage];
            
            is_load_data = YES;
            id __strong selfStrong = selfweak;
//            __strong UIActivityIndicatorView *indi = indicator2;
            dispatch_async(dispatch_get_main_queue(), ^{
                if (selfStrong) {
                    [[selfStrong collectionView] reloadData];
                    
//                        [indi stopAnimating];
//                        [indi removeFromSuperview];
                   /*
                    if (std_arr.count == 1) {
//                        NSString *col_H = [NSString stringWithFormat:@"H:[collview(%d)]", 110];
//                        NSString *col_V = [NSString stringWithFormat:@"V:[collview(%d)]", 110];
                        NSDictionary *viewsDictionary = @{@"collview":self.collectionView};
//                        NSArray *constraint_V =
//                        [NSLayoutConstraint constraintsWithVisualFormat:col_V
//                                                                options:0
//                                                                metrics:nil
//                                                                  views:viewsDictionary];
//                        NSArray *constraint_H =
//                        [NSLayoutConstraint constraintsWithVisualFormat:col_H
//                                                                options:0
//                                                                metrics:nil
//                                                                  views:viewsDictionary];
//                        [self.collectionView addConstraints:constraint_V];
//                        [self.collectionView addConstraints:constraint_H];
                        NSString *col_HH =
                        [NSString stringWithFormat:@"H:|-%d-[collview]-%d-|", (int)self.view.frame.size.width/2-55,(int)self.view.frame.size.width/2-55];
                        NSArray *constraint_POS_H =
                        [NSLayoutConstraint constraintsWithVisualFormat:col_HH
                                                                options:0
                                                                metrics:nil
                                                                  views:viewsDictionary];
                        [self.view addConstraints:constraint_POS_H];
                        
                        NSLog(@"origin %f", self.collectionView.frame.origin.x);
                        NSLog(@"size = %f", self.collectionView.frame.size.width);
                    }else if(std_arr.count == 2){
//                        NSString *col_H = [NSString stringWithFormat:@"H:[collview(%d)]", 220];
//                        NSString *col_V = [NSString stringWithFormat:@"V:[collview(%d)]", 110];
                        NSDictionary *viewsDictionary = @{@"collview":self.collectionView};
//                        NSArray *constraint_V =
//                        [NSLayoutConstraint constraintsWithVisualFormat:col_V
//                                                                options:0
//                                                                metrics:nil
//                                                                  views:viewsDictionary];
//                        NSArray *constraint_H =
//                        [NSLayoutConstraint constraintsWithVisualFormat:col_H
//                                                                options:0
//                                                                metrics:nil
//                                                                  views:viewsDictionary];
//                        [self.collectionView addConstraints:constraint_V];
//                        [self.collectionView addConstraints:constraint_H];
                        NSString *col_HH =
                        [NSString stringWithFormat:@"H:|-%d-[collview]-%d-|", (int)self.view.frame.size.width/2-110,(int)self.view.frame.size.width/2-110];
                        NSArray *constraint_POS_H =
                        [NSLayoutConstraint constraintsWithVisualFormat:col_HH
                                                                options:0
                                                                metrics:nil
                                                                  views:viewsDictionary];
                        [self.view addConstraints:constraint_POS_H];
                    }else if(std_arr.count >2){
//                        NSString *col_H = [NSString stringWithFormat:@"H:[collview(%d)]", 330];
//                        NSString *col_V = [NSString stringWithFormat:@"V:[collview(%d)]", 110];
                        NSDictionary *viewsDictionary = @{@"collview":self.collectionView};
//                        NSArray *constraint_V =
//                        [NSLayoutConstraint constraintsWithVisualFormat:col_V
//                                                                options:0
//                                                                metrics:nil
//                                                                  views:viewsDictionary];
//                        NSArray *constraint_H =
//                        [NSLayoutConstraint constraintsWithVisualFormat:col_H
//                                                                options:0
//                                                                metrics:nil
//                                                                  views:viewsDictionary];
//                        [self.collectionView addConstraints:constraint_V];
//                        [self.collectionView addConstraints:constraint_H];
                        NSString *col_HH =
                        [NSString stringWithFormat:@"H:|-%d-[collview]-%d-|", 10,10];
                        NSArray *constraint_POS_H =
                        [NSLayoutConstraint constraintsWithVisualFormat:col_HH
                                                                options:0
                                                                metrics:nil
                                                                  views:viewsDictionary];
                        [self.view addConstraints:constraint_POS_H];
                    }
                    */
                }
            });
        });
        
    });
    
}

-(void)completeParsing3:(NSString *)note_url{
//    NSLog(@"note_url = %@", note_url);
}

-(void)compliteLoadNewsListWithTitle:(NSArray *)title NewsUrl:(NSArray *)newsUrl{
    is_pars_data = YES;
    news_title = title;
    news_urls = newsUrl;
    
    [self.indicator stopAnimating];
    self.indicator = nil;
    [self.indi_view removeFromSuperview];
    [self.loading removeFromSuperview];
    
    [self.tableview reloadData];
    
//    if (is_pars_data == YES && is_load_data == YES) {
//        [self.myIndi stopAnimating];
//        [self.myIndi removeFromSuperview];
//    }
//    
//    if (is_new == YES) {
//        [self.indicator stopAnimating];
//        self.indicator = nil;
//        [self.indi_view removeFromSuperview];
//        [self.loading removeFromSuperview];
//    }
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return news_title.count;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    
    cell.textLabel.text = news_title[indexPath.row];
    [cell.textLabel setLineBreakMode:NSLineBreakByTruncatingMiddle];
    
    return cell;
}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:YES];
    
    NSString *view_1_H = [NSString stringWithFormat:@"H:[view1(%d)]", (int)self.view.frame.size.width];
    NSString *view_1_V = [NSString stringWithFormat:@"V:[view1(%d)]", (int)self.view.frame.size.height/3+50];
    
    NSDictionary *viewsDictionary = @{@"view1":self.view_1, @"title":self.lbl_title, @"tableview":self.tableview};
    //     NSDictionary *metrics = @{@"vSpacing":@10, @"hSpacing":@10};
    
    NSArray *constraint_V = [NSLayoutConstraint constraintsWithVisualFormat:view_1_V
                                                                    options:0
                                                                    metrics:nil
                                                                      views:viewsDictionary];
    
    NSArray *constraint_H = [NSLayoutConstraint constraintsWithVisualFormat:view_1_H
                                                                    options:0
                                                                    metrics:nil
                                                                      views:viewsDictionary];
    [self.view_1 addConstraints:constraint_V];
    
    [self.view_1 addConstraints:constraint_H];
    NSArray *constraint_POS_V = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-60-[view1]"
                                                                        options:0
                                                                        metrics:nil
                                                                          views:viewsDictionary];
    
    NSArray *constraint_POS_H = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-500-[view1]"
                                                                        options:0
                                                                        metrics:nil
                                                                          views:viewsDictionary];
    
    
    [self.view addConstraints:constraint_POS_H];
    [self.view addConstraints:constraint_POS_V];
    
//    [self replaceTopConstraintOnView:self.view_1 withConstant:self.view_1.frame.size.width];
    
    self.navigationController.navigationBarHidden = YES;
    
//    [self.collectionView reloadItemsAtIndexPaths:[self.collectionView indexPathsForVisibleItems]];
    
    thread = [[NSThread alloc]initWithTarget:self selector:@selector(thread_2) object:nil];
    
    [self thread_2];
    
    [thread start];
}

#pragma mark - UICollectionViewDelegateFlowLayout

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return [std_arr count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];

    dic = std_arr[indexPath.row];
    face_dic = face_arr[indexPath.row];
    
    UILabel *lbl = (UILabel *)[cell viewWithTag:10];
    UIImageView *face_img = (UIImageView *)[cell viewWithTag:20];
    
    face_img.image = [UIImage imageWithData:face_dic[@"img_data"]];
    
    lbl.text = dic[@"name"];
    
    return cell;
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier  isEqual: @"Note"]) {
        
//        NSArray *arr = [self.collectionView indexPathsForSelectedItems];
//        
//        NSDictionary *ok_dic = [std_arr objectAtIndex:[[arr objectAtIndex:0]row]];
        
        [[segue destinationViewController] setStudent_dic:ok_dic];

    }else if([segue.identifier isEqual: @"Manage"]){
        
    }else if([segue.identifier isEqual: @"Food"]){
        NSString *food_url = [ok_dic objectForKey:@"food_url"];
        [[segue destinationViewController] setFood_url:food_url];
    }else if([segue.identifier isEqual: @"News"]){
       NSIndexPath *indexpath = [self.tableview indexPathForSelectedRow];
        news_str = news_urls[indexpath.row];
        [[segue destinationViewController] setNews_url:news_str];        
    }else if([segue.identifier isEqual:@"School_News"]){
        NSString *school_url = [ok_dic objectForKey:@"school_url"];
        NSString *news_url = [ok_dic objectForKey:@"news_url"];
        NSString *str_school_name = [ok_dic objectForKey:@"school"];
        [[segue destinationViewController] setSchool_url_1:school_url];
        [[segue destinationViewController] setNews_Url_1:news_url];
        [[segue destinationViewController] setSchool_name_ok:str_school_name];
        
    }
}


-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    ok_dic = [std_arr objectAtIndex:indexPath.row];
    self.sub_std_name.text = ok_dic[@"name"];
    self.sub_face_img.image = [UIImage imageWithData:face_arr[indexPath.row][@"img_data"]];
    [self replaceTopConstraintOnView:self.view_1 withConstant:0.0];
    [self animateConstraints];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)add_btn:(id)sender {

//    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
//    
//    //    Add_DataViewController *add_view = [storyboard instantiateViewControllerWithIdentifier:@"Add_Data"];
//    
//    UIViewController *add_view = [storyboard instantiateViewControllerWithIdentifier:@"Std_m"];
//    [self.view addSubview:add_view];
//    [self presentViewController:add_view animated:YES completion:nil];
//        [self.navigationController pushViewController:add_view animated:YES];
    
}
- (IBAction)reload_btn:(UIButton *)sender {
    
    [self replaceTopConstraintOnView:self.view_1 withConstant:self.view_1.frame.size.width];
    
    [self animateConstraints];
    
}

- (IBAction)btn_BackNew:(UIButton *)sender {
    
    if (page >1){
        page--;
        NSString *str = [NSString stringWithFormat:@"http://news.gne.go.kr/allBoard.do?type=news&page=%d&mcode=XM1401070728004&viewType=Y&addDay=24&boardseq=boardEJ1400460249735&recoType=N", page];
        [self indi_start];
        self.lbl_page.text = [NSString stringWithFormat:@"%d",page];
        [edu_list parsingWithEduNewsWith:str];
        if (page == 1) {
            self.back_btn.hidden = YES;
        }
    }
}

- (IBAction)btn_NextNew:(UIButton *)sender {
    page++;
    self.lbl_page.text = [NSString stringWithFormat:@"%d",page];
    is_new = YES;
    [self indi_start];
    NSString *str = [NSString stringWithFormat:@"http://news.gne.go.kr/allBoard.do?type=news&page=%d&mcode=XM1401070728004&viewType=Y&addDay=24&boardseq=boardEJ1400460249735&recoType=N", page];
    
    [edu_list parsingWithEduNewsWith:str];
    
    self.back_btn.hidden = NO;
    
}

- (void)replaceTopConstraintOnView:(UIView *)view withConstant:(float)constant
{
    [self.view.constraints enumerateObjectsUsingBlock:^(NSLayoutConstraint *constraint, NSUInteger idx, BOOL *stop) {
        if ((constraint.firstItem == view) && (constraint.firstAttribute == NSLayoutAttributeLeading)) {
            constraint.constant = constant;
            
//            NSLog(@"size = %f", self.view_1.frame.size.width);
        }
    }];
}

- (void)animateConstraints
{
    [UIView animateWithDuration:0.5 animations:^{
        [self.view layoutIfNeeded];
    }];
}

-(void) indi_start{
    
    if (self.indicator==nil) {
    
        self.indi_view = [[UIView alloc]initWithFrame:CGRectMake((int)self.view.frame.size.width/2-25-25, (int)self.view.frame.size.height/2, 100, 80)];
        self.indi_view.backgroundColor = [UIColor whiteColor];
        //        self.indi_view.alpha = 0.7;
        
        [self.view addSubview:self.indi_view];
        self.indicator  = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake((int)self.view.frame.size.width/2-25, (int)self.view.frame.size.height/2, 50, 50)];
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
