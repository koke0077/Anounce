//
//  Add_School_Region.m
//  Anounce_Note
//
//  Created by kimsung jun on 2015. 5. 12..
//  Copyright (c) 2015년 kimsung jun. All rights reserved.
//

#import "Add_School_Region.h"
#import "School_Data_Manager.h"
#import "AppDelegate.h"

@interface Add_School_Region (){
    
    NSArray *school_arr;
}
- (IBAction)btn_back:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UILabel *lbl_region;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (unsafe_unretained, nonatomic) IBOutlet UIButton *add_btn;

@end

@implementation Add_School_Region
@synthesize region;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.add_btn setImage:[UIImage imageNamed:@"add_btn.png"] forState:UIControlStateNormal];
    [self.add_btn setBackgroundImage:[UIImage imageNamed:@"add_btn.png"] forState:UIControlStateNormal];
    self.add_btn.layer.shadowColor = [UIColor grayColor].CGColor;
    self.add_btn.layer.shadowOffset = CGSizeMake(15, 15);
    self.add_btn.layer.shadowOpacity = 1.0;
    self.add_btn.layer.shadowRadius = 3.0;
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
}

-(void)viewWillAppear:(BOOL)animated{
    
     AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    
    delegate.edit_ok = 0;
    
    self.lbl_region.text = region;
    
    School_Data_Manager *s_data = [[School_Data_Manager alloc]init];
    
//    school_arr = [s_data loadDataWithSchool2:region];
    NSArray *sortArray = [s_data loadDataWithSchool2:region];
    
    school_arr = [sortArray sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
    
    [self.tableView reloadData];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return school_arr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    
    if (cell) {
       cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    }
    
    cell.textLabel.text = [school_arr objectAtIndex:indexPath.row];
    
    return cell;

    
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    
    School_Data_Manager *s_manager = [[School_Data_Manager alloc]init];
    
    delegate.school_url = [s_manager loadDataWithSchool_Url:cell.textLabel.text];
    
    delegate.school_name = cell.textLabel.text;
    
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    if ([segue.identifier isEqualToString:@"select_grade"]) {
        
        NSLog(@"select_grade");
        
    }else if ([segue.identifier isEqualToString:@"add_school"]){
        NSLog(@"add_school");
    }
    
}


- (IBAction)btn_back:(UIButton *)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}
@end
