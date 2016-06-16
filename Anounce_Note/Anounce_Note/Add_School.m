//
//  Add_School.m
//  Anounce_Note
//
//  Created by kimsung jun on 2015. 5. 12..
//  Copyright (c) 2015년 kimsung jun. All rights reserved.
//

#import "Add_School.h"
#import "School_Data_Manager.h"
#import "AppDelegate.h"

@interface Add_School (){
    
    NSMutableArray *schools;
    BOOL now_course;
}
@property (weak, nonatomic) IBOutlet UILabel *school_name;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
- (IBAction)done:(id)sender;

@end

@implementation Add_School

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    // 유치원과 초등학교를 구분하는 것.
//    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
//    
//    if ([delegate.school_course intValue] == 0) {
//        now_course = NO;
//    }else{
//        now_course = YES;
//    }
//    delegate.edit_ok = 0;
    
    schools = [NSMutableArray array];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.searchBar.delegate = self;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:YES];
        
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
        
    delegate.edit_ok = 0;

    
    [self.tableView reloadData];
}

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    
    School_Data_Manager *s_manager = [[School_Data_Manager alloc]init];
    
    schools = (NSMutableArray *)[s_manager loadDataWithSchool:self.searchBar.text];
    
    [self.searchBar resignFirstResponder];
    
    [self.tableView reloadData];
}

-(void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar{
    
    self.searchBar.text = @"";
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return schools.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    
    UILabel *lbl = (UILabel *)[cell viewWithTag:10];
    
    lbl.text = [schools objectAtIndex:indexPath.row];
    
    return cell;
}




-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    
    UILabel *lbl = (UILabel *)[cell viewWithTag:10];
    
    self.school_name.text = lbl.text;
    
     AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    
    School_Data_Manager *s_manager = [[School_Data_Manager alloc]init];
    
    delegate.school_url = [s_manager loadDataWithSchool_Url:lbl.text];
    
    delegate.school_name = lbl.text;
    
    
    
}
/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

- (IBAction)done:(id)sender {
    
    //    [self dismissViewControllerAnimated:YES completion:nil];
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

@end
