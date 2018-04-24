//
//  School_Comunity_List.m
//  Anounce_Note
//
//  Created by sung jun kim on 2018. 4. 16..
//  Copyright © 2018년 kimsung jun. All rights reserved.
//

#import "School_Comunity_List.h"
#import "School_Comunity_Show.h"

@interface School_Comunity_List (){
    
    int firstPage;
    int secondPage;
    
    School_Comunity_List_Get *list_get;
    
    NSMutableArray *title_arr;
    NSMutableArray *url_arr;
    
    NSMutableString *change_url;
}
//- (IBAction)btn_back:(UIButton *)sender;
- (IBAction)btn_nextPage:(UIButton *)sender;
- (IBAction)btn_beforePage:(UIButton *)sender;

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIButton *before_btn;
@property (weak, nonatomic) IBOutlet UILabel *school_small_name;
@property UIActivityIndicatorView *indicator;
@property UILabel *loading;
@property UIView *indi_view;

@end

@implementation School_Comunity_List
@synthesize comunity_url, school_url_1, school_name_ok;

- (void)viewDidLoad {
    [super viewDidLoad];
 
    [self indi_start];
    
    firstPage = 1;
    secondPage = 1;
    
    self.before_btn.hidden = YES;
    
    self.school_small_name.text = school_name_ok;
    
    school_name_ok = [school_name_ok stringByReplacingOccurrencesOfString:@"등학교" withString:@""];
    self.navigationItem.title = [NSString stringWithFormat:@"%@ 가정통신문", school_name_ok];
    
    
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    change_url = [[NSMutableString alloc]init];
    
    list_get = [[School_Comunity_List_Get alloc]init];
    list_get.delegate = self;
    [list_get parsingWithListUrl:comunity_url WithSchool_url:school_url_1];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    self.navigationController.navigationBarHidden = NO;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return title_arr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    
    [cell.textLabel setLineBreakMode:NSLineBreakByTruncatingMiddle];
    cell.textLabel.text = title_arr[indexPath.row];
    
    
    return cell;
}

-(void)compliteToGetComunityList:(NSArray *)title_list News_Url:(NSArray *)news_url{
    title_arr = [NSMutableArray array];
    [title_arr removeAllObjects];
    url_arr = [NSMutableArray array];
    [url_arr removeAllObjects];
    title_arr = (NSMutableArray *)title_list;
    url_arr = (NSMutableArray *) news_url;
    
    [self.indicator stopAnimating];
    [self.indi_view removeFromSuperview];
    [self.loading removeFromSuperview];
    
    
    [self.tableView reloadData];
}

- (IBAction)btn_nextPage:(UIButton *)sender {
    
    [self indi_start];
    firstPage++;
    secondPage = firstPage/10+1;
    
    self.before_btn.hidden = NO;
    change_url = [NSMutableString string];
    [change_url appendString:comunity_url];
    [change_url appendString:[NSString stringWithFormat:@"&frame=&search_field=&search_word=&category1=&category2=&category3=&wait_flag=&cmd=list&page=%d&nPage=%d",firstPage, secondPage]];
    [list_get parsingWithListUrl:change_url WithSchool_url:school_url_1];
    
}
- (IBAction)btn_beforePage:(UIButton *)sender {
    
    if (firstPage>1) {
        firstPage--;
        secondPage = firstPage/10+1;
        [self indi_start];
    }
    if(firstPage == 1){
        self.before_btn.hidden = YES;
    }
    change_url = [NSMutableString string];
    [change_url appendString:comunity_url];
    [change_url appendString:[NSString stringWithFormat:@"&frame=&search_field=&search_word=&category1=&category2=&category3=&wait_flag=&cmd=list&page=%d&nPage=%d",firstPage, secondPage]];
    //&frame=&search_field=&search_word=&category1=&category2=&category3=&cmd=list&page=11&nPage=2
    [list_get parsingWithListUrl:change_url WithSchool_url:school_url_1];
    
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

-(void)failedToGetComunityList{
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"학교정보 오류" message:@"가정통신문을 로드 할 수 없습니다.\n 관리자에게 문의하십시오." delegate:self cancelButtonTitle:@"확인" otherButtonTitles:nil, nil];
    alertView.tag = 1;
    [alertView show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0 && alertView.tag == 1) {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    NSIndexPath *indexpath = [self.tableView indexPathForSelectedRow];
    NSString *news_str = url_arr[indexpath.row];
    [[segue destinationViewController] setMyContents_url:news_str];
    [[segue destinationViewController] setStr_title:school_name_ok];
    [[segue destinationViewController] setSchool_url:school_url_1];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
