//
//  Add_Grade_Class.m
//  Anounce_Note
//
//  Created by kimsung jun on 2015. 5. 13..
//  Copyright (c) 2015년 kimsung jun. All rights reserved.
//

#import "Add_Grade_Class.h"
#import "AppDelegate.h"

#import "School_Data_Manager.h"

#import "Edit_School_Url.h"


@interface Add_Grade_Class (){
    NSArray *grade_arr;
    NSArray *class_arr;
    NSDictionary *class_dic;
    NSArray *class_arr2;
    
    NSString *class_lenth;
    
    NSString *cls_home;
    
    AppDelegate *delegate;
    
    NSString *save_class;
    
    NSArray *arr1;
    NSArray *arr2;
    NSArray *arr3;
    NSArray *arr4;
    NSArray *arr5;
    NSArray *arr6;
    
    NSString *class_code; //2018년 4월 22일 추가
    
    int com_1;
    int com_2;
    
    int dic_count;
    
    NSArray *school_data;
}

@property UIActivityIndicatorView *indicator;

@property (weak, nonatomic) IBOutlet UILabel *lbl_school;
@property (weak, nonatomic) IBOutlet UILabel *lbl_grade;
@property (weak, nonatomic) IBOutlet UILabel *lbl_class;
@property (weak, nonatomic) IBOutlet UIPickerView *picker;
- (IBAction)btn_back:(UIButton *)sender;
- (IBAction)btn_next:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIButton *btn_edit;
- (IBAction)btn_school_url:(UIButton *)sender;


@end

@implementation Add_Grade_Class

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self indi_start];
    
    com_2 = 0;
    
    self.lbl_grade.text = @"1학년";
    self.lbl_class.text = @"1반";
    
    delegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    
    SchoolCode_FoodURL_Make *s_f_make = [[SchoolCode_FoodURL_Make alloc]init];
    
    s_f_make.delegate = self;
    
    self.lbl_school.text = delegate.school_name;

    self.picker.delegate = self;
    self.picker.dataSource = self;
    
    grade_arr = @[@"1학년",@"2학년",@"3학년",@"4학년",@"5학년",@"6학년"];
    class_arr2 = @[@"1반",@"2반",@"3반",@"4반",@"5반",@"6반",@"7반",@"8반",@"9반",@"10반",@"11반", @"12반"];
    
    if(delegate.is_str == 0){
        
    }else{
        
    }
    [s_f_make parseWithSchool_URL:delegate.school_url];
    
    __weak Add_Grade_Class *selfWeak = self;
    __weak UIActivityIndicatorView *indicator2 = self.indicator;
  
    s_f_make.blockAfterUpdate = ^void(void){
        
        __strong Add_Grade_Class *selfStrong = selfWeak;
        __strong UIActivityIndicatorView *indi = indicator2;

        if (selfStrong) {
            [indi stopAnimating];
        }
        
        
    };
    
}

-(void)viewWillAppear:(BOOL)animated{
    
    self.btn_edit.hidden = YES;
    
    if (delegate.edit_ok != 0) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"학교정보 오류" message:@"학교정보를 수정하였습니다.\n이전 화면으로 이동합니다." delegate:self cancelButtonTitle:@"확인" otherButtonTitles:nil, nil];
        alertView.tag = 2;
        [alertView show];
    }
}

-(void) indi_start{
    
    if (self.indicator==nil) {
       
        self.indicator  = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake((int)self.view.frame.size.width/2-25, (int)self.view.frame.size.height/2-25, 50, 50)];
        self.indicator.hidesWhenStopped = YES;
        self.indicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
        [self.view addSubview:self.indicator];
    }
    [self.indicator startAnimating];
    
}

-(void)completeParsing2:(NSString *)food_url School:(NSString *)school_code Cls_page:(NSString *)cls_page News_url:(NSString *)news_url SchoolCode:(NSString *)school_code_noncode{
    delegate.school_code = school_code;
    delegate.food_url = food_url;
    delegate.news_url = news_url;
    delegate.school_code_noncode = school_code_noncode;
    cls_home = cls_page;
    if (delegate.is_str != 0) {
        Grade_Get *grade_get = [[Grade_Get alloc]init];
        grade_get.delegate = self;
        [grade_get parsingWithUrl:cls_home];
    }else{
        Grade_Get_2 *grade_get_2 = [[Grade_Get_2 alloc]init];
        grade_get_2.delegate = self;
        [grade_get_2 parsingWithUrl_2:delegate.school_url];
        
    }
   
}

//-(void)compliteGetGradeClass:(NSArray *)cls_num{
//    
//    class_arr = cls_num;
//    
//    [self.picker reloadAllComponents];
//    
//}

-(void)compliteGetGradeClass2:(NSArray *)cls_arr{
 
    class_arr = cls_arr;
    //
    //    [self.picker reloadAllComponents];
    
}

-(void)compliteGetGradeClass:(NSDictionary *)cls_num  classArr:(NSArray *)cls_arr{
    
    class_dic = cls_num;
    class_arr = cls_arr;
    
    if([class_dic allKeys].count == 0){
        dic_count = 0;
        
    }else{
                
        dic_count = 1;
                
        arr1 = [class_dic objectForKey:@"1학년"];
        arr2 = [class_dic objectForKey:@"2학년"];
        arr3 = [class_dic objectForKey:@"3학년"];
        arr4 = [class_dic objectForKey:@"4학년"];
        arr5 = [class_dic objectForKey:@"5학년"];
        arr6 = [class_dic objectForKey:@"6학년"];
    }
    
    
    
    [self.picker reloadAllComponents];
    
}

-(void)compliteGetGrade_2_Class:(NSArray *)cls_num{
    
    class_arr = cls_num;
    
    [self.picker reloadAllComponents];
}

-(void)failParsing{
    
    [self.indicator stopAnimating];


    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"학교정보 오류" message:@"학교정보가 잘못되었습니다.\n학교정보를 수정하십시오." delegate:self cancelButtonTitle:@"확인" otherButtonTitles:nil, nil];
    alertView.tag = 1;
    [alertView show];
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0 && alertView.tag == 1) {
//        [self.navigationController popViewControllerAnimated:YES];
        
        School_Data_Manager *s_manager = [[School_Data_Manager alloc]init];
        
        school_data = [s_manager loadAllDataWithSchool:delegate.school_name];

        NSLog(@"%@", delegate.school_name);
        self.btn_edit.hidden = NO;
        
    }else if(buttonIndex == 0 && alertView.tag == 2){
        [self.navigationController popViewControllerAnimated:YES];
    }
}


-(void)completeParsing3:(NSString *)note_url{
    
    delegate.school_code = note_url;
    
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    
    return 2;
}



// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    
    if (component == 0) {
        return 6;
    }else{
        
        if ([save_class isEqualToString: @"1학년"]) {
            
            if(dic_count == 0){
//                NSString *str = [class_arr objectAtIndex:0];
//                com_2 = (int)str.length;
                
                NSArray *arr = [class_arr objectAtIndex:0];//각 학년별 반 코드들을 담은 array를 학년에 맞춰서 반환받아와서 개수만큼 반을 보이게 한다.
                com_2 = (int)arr.count;
            }else{
                com_2 = (int)arr1.count;
            }
            
            if (com_2 == 0)com_2=10;
//            NSLog(@"%d",com_2);
        }else if ([save_class isEqualToString: @"2학년"]) {
            
            if(dic_count == 0){
//                NSString *str = [class_arr objectAtIndex:1];
//                com_2 = (int)str.length;
                NSArray *arr = [class_arr objectAtIndex:1];//각 학년별 반 코드들을 담은 array를 학년에 맞춰서 반환받아와서 개수만큼 반을 보이게 한다.
                com_2 = (int)arr.count;
            }else{
                com_2 = (int)arr2.count;
            }
            
            if (com_2 == 0)com_2=10;
//            NSLog(@"%d",com_2);
        }else if ([save_class isEqualToString: @"3학년"]) {
            
            if(dic_count == 0){
//                NSString *str = [class_arr objectAtIndex:2];
//                com_2 = (int)str.length;
                NSArray *arr = [class_arr objectAtIndex:2];//각 학년별 반 코드들을 담은 array를 학년에 맞춰서 반환받아와서 개수만큼 반을 보이게 한다.
                com_2 = (int)arr.count;
            }else{
                com_2 = (int)arr3.count;
            }
            
            if (com_2 == 0)com_2=10;
//            NSLog(@"%d",com_2);
        }else if ([save_class isEqualToString: @"4학년"]) {
            
            if(dic_count == 0){
//                NSString *str = [class_arr objectAtIndex:3];
//                com_2 = (int)str.length;
                NSArray *arr = [class_arr objectAtIndex:3];//각 학년별 반 코드들을 담은 array를 학년에 맞춰서 반환받아와서 개수만큼 반을 보이게 한다.
                com_2 = (int)arr.count;
            }else{
                com_2 = (int)arr4.count;
            }
            
            if (com_2 == 0)com_2=10;
//            NSLog(@"%d",com_2);
        }else if ([save_class isEqualToString: @"5학년"]) {
            if(dic_count == 0){
//                NSString *str = [class_arr objectAtIndex:4];
//                com_2 = (int)str.length;
                NSArray *arr = [class_arr objectAtIndex:4];//각 학년별 반 코드들을 담은 array를 학년에 맞춰서 반환받아와서 개수만큼 반을 보이게 한다.
                com_2 = (int)arr.count;
            }else{
                com_2 = (int)arr5.count;
            }
            
            if (com_2 == 0)com_2=10;
//            NSLog(@"%d",com_2);
        }else if ([save_class isEqualToString: @"6학년"]) {
            if(dic_count == 0){
//                NSString *str = [class_arr objectAtIndex:5];
//                com_2 = (int)str.length;
                NSArray *arr = [class_arr objectAtIndex:5];//각 학년별 반 코드들을 담은 array를 학년에 맞춰서 반환받아와서 개수만큼 반을 보이게 한다.
                com_2 = (int)arr.count;
            }else{
                com_2 = (int)arr6.count;
            }
            if (com_2 == 0)com_2=10;
//            NSLog(@"%d",com_2);
        }
        
        return com_2;
    }
    
}

//- (NSInteger)numberOfRowsInComponent:(NSInteger)component{
//    
//}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    
    if (component == 0) {
        return [grade_arr objectAtIndex:row];
        
    }else{

        
        if ([self.lbl_grade.text isEqualToString: @"1학년"]) {
          
            return [class_arr2 objectAtIndex:row];
        }else if ([self.lbl_grade.text isEqualToString: @"2학년"]) {
            
            return [class_arr2 objectAtIndex:row];
        }else if ([self.lbl_grade.text isEqualToString: @"3학년"]) {
            
            return [class_arr2 objectAtIndex:row];
        }else if ([self.lbl_grade.text isEqualToString: @"4학년"]) {
            
            return [class_arr2 objectAtIndex:row];
        }else if ([self.lbl_grade.text isEqualToString: @"5학년"]) {
            
            return [class_arr2 objectAtIndex:row];
        }else if ([self.lbl_grade.text isEqualToString: @"6학년"]) {
            
            return [class_arr2 objectAtIndex:row];
        }
        
        
    }
    
    return 0;
}


-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{

    if (component == 0) {
        self.lbl_grade.text = [self pickerView:pickerView titleForRow:row forComponent:component];
        
        save_class = [self pickerView:pickerView titleForRow:row forComponent:component];
        
        [pickerView reloadComponent:1];

    }else{
        
        self.lbl_class.text = [self pickerView:pickerView titleForRow:row forComponent:component];
    }
    
    }

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btn_back:(UIButton *)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)btn_next:(UIButton *)sender {
    
    
    NSString *str_class = [self.lbl_class.text stringByReplacingOccurrencesOfString:@"반" withString:@""];
    
    NSString *class_url = [[class_dic objectForKey:self.lbl_grade.text] objectAtIndex:[str_class intValue]-1];
    
    NSString *str_grade = [self.lbl_grade.text stringByReplacingOccurrencesOfString:@"학년" withString:@""];
    
    delegate.school_grade = str_grade;
    delegate.school_class = str_class;
    
    NSMutableString *mutable_class_url = [[NSMutableString alloc]init];
    [mutable_class_url appendString:delegate.school_url];
    
    if(delegate.is_pass == YES){
        
        [mutable_class_url appendString:class_url];
        
        delegate.class_url = mutable_class_url;
    }else{
        
        NSDate *date = [NSDate date];
        int month = [[[self dateFormatter] stringFromDate:date] intValue];
        int year = [[[self dateFormatter2] stringFromDate:date] intValue];
        
        int now_year = 0;
        
        if (month<3) {
            now_year = year -1;
        }else{
            now_year = year;
        }
        
        class_code = [[class_arr objectAtIndex:[str_grade intValue]-1]objectAtIndex:[str_class intValue]-1] ;
        
        /* 2018년 4월 22일 수정
         NSString *frame_str1 = @"/modules/cafe/class/index.jsp?";
         NSString *frame_str2 = [NSString stringWithFormat:@"&m_year=%d&m_code=G00800300300",now_year];
        */
        NSString *frame_str1 = @"/modules/cafe/class/index.jsp?";
        NSString *frame_str2 = [NSString stringWithFormat:@"&m_year=%d&m_code=",now_year];
        /* 2018년 4월 22일 수정
        int grade_num = [str_grade intValue];
        int class_num = [str_class intValue];

        if(class_num>8){
            frame_str2 = [NSString stringWithFormat:@"%@%d0%d",frame_str2,grade_num+1, class_num+1];
        }else{
            if([delegate.school_url containsString:@"mudong-p"]){//무동초 학급코드 문제
                if(grade_num == 1 || grade_num == 2){
                    frame_str2 = [NSString stringWithFormat:@"%@%d00%d",frame_str2,grade_num+1, class_num+4];
                }else if(grade_num == 3){
                    frame_str2 = [NSString stringWithFormat:@"%@%d00%d",frame_str2,grade_num+1, class_num+3];
                }else{
                    frame_str2 = [NSString stringWithFormat:@"%@%d00%d",frame_str2,grade_num+1, class_num+2];
                }
                
                frame_str2 = [NSString stringWithFormat:@"%@%d00%d",frame_str2,grade_num+1, class_num+2];
            }else{
             frame_str2 = [NSString stringWithFormat:@"%@%d00%d",frame_str2,grade_num+1, class_num+1];
            }
        }
        */
        
         [mutable_class_url appendString:frame_str1];
         [mutable_class_url appendString:delegate.school_code];
         [mutable_class_url appendString:frame_str2];
        [mutable_class_url appendString:class_code];
        
        delegate.class_url = mutable_class_url;

    }
 
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

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"schoolUrl"]) {
        
        
        [[segue destinationViewController] setSchool_arr:school_data];
    }
}


- (IBAction)btn_school_url:(UIButton *)sender {
}
@end
