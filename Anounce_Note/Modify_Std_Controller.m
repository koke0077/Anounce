//
//  Modify_Std_Controller.m
//  Anounce_Note
//
//  Created by kimsung jun on 2016. 3. 27..
//  Copyright © 2016년 kimsung jun. All rights reserved.
//

#import "Modify_Std_Controller.h"
#import "Students_Data_Manager.h"
#import "AppDelegate.h"

@interface Modify_Std_Controller (){
    
    NSString *original_str;
    NSString *grade;
    NSString *class;
    NSMutableString *note_url;
}
@property (weak, nonatomic) IBOutlet UITextField *txtF_grade;
@property (weak, nonatomic) IBOutlet UITextField *txtF_class;
@property (weak, nonatomic) IBOutlet UITextField *txtF_name;
- (IBAction)btn_cancel:(UIButton *)sender;
- (IBAction)btn_save:(UIButton *)sender;

@end

@implementation Modify_Std_Controller
@synthesize std_dic;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
   }

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewWillAppear:(BOOL)animated{
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    
    std_dic = delegate.modi_dic;
    note_url = [[NSMutableString alloc]init];
    note_url = [std_dic objectForKey:@"note_url"];
   
        grade = [std_dic objectForKey:@"grade"];
        class = [std_dic objectForKey:@"class"];
//    original_str = [NSString stringWithFormat:@"%d00%d",[grade intValue]+1,[class intValue]+1];
    original_str = [note_url substringFromIndex: [note_url length] - 4];
    self.txtF_name.text = [std_dic objectForKey:@"name"];
    self.txtF_grade.text = grade;
    self.txtF_class.text = class;
    

}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)btn_cancel:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)btn_save:(UIButton *)sender {
    NSString *grade_2 = self.txtF_grade.text;
    NSString *class_2 = self.txtF_class.text;
    NSString *change_grade_str = [NSString stringWithFormat:@"%d00%d",[grade_2 intValue]+1, [class_2 intValue]+1];
    NSString *change_name_str = self.txtF_name.text;
    
    NSString *change_note_url = [note_url stringByReplacingOccurrencesOfString:original_str withString:change_grade_str];
    Students_Data_Manager *std_manager = [[Students_Data_Manager alloc]init];
    [std_manager upDateWithName:change_name_str School:[std_dic objectForKey:@"school"] Grade:grade_2 Class:class_2 School_Url:[std_dic objectForKey:@"school_url"] Food_Url:[std_dic objectForKey:@"food_url"] Note_Url:change_note_url News_Url:[std_dic objectForKey:@"news_url"] RowId:[[std_dic objectForKey:@"rowid"]intValue]];
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}
@end
