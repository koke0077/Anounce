//
//  SchoolDataAdd.m
//  Anounce_Note
//
//  Created by kimsung jun on 2016. 3. 23..
//  Copyright © 2016년 kimsung jun. All rights reserved.
//

#import "SchoolDataAdd.h"
#import "School_Data_Manager.h"

@interface SchoolDataAdd (){
    
    School_Data_Manager *std_manager;
    
    int data_cnt;
}
@property (weak, nonatomic) IBOutlet UITextField *txtF_schoolName;
@property (weak, nonatomic) IBOutlet UITextField *txtF_schoolRegion;
@property (weak, nonatomic) IBOutlet UITextField *txtF_WebAddress;
- (IBAction)btn:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIButton *btn_save;
- (IBAction)btn_cancel:(UIButton *)sender;

@end

@implementation SchoolDataAdd

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.txtF_schoolName.delegate =self;
    self.txtF_schoolRegion.delegate = self;
    self.txtF_WebAddress.delegate = self;
    
    self.btn_save.hidden = YES;
    
//    [self.txtF_schoolName becomeFirstResponder];

    std_manager = [[School_Data_Manager alloc]init];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)textFieldDidEndEditing:(UITextField *)textField{
    
    if (textField == self.txtF_schoolName) {
        
            if ([textField.text rangeOfString:@"등학교"].length == 0 && textField.text.length != 0) {
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"학교이름 오류" message:@"학교이름은 정식명칭으로 해야합니다.\n○○초등학교 형식으로 입력해 주세요." delegate:self cancelButtonTitle:@"확인" otherButtonTitles:nil, nil];
                alertView.tag = 2;
                [alertView show];
            }
    }else if(textField == self.txtF_schoolRegion){
        
        if ([textField.text hasSuffix:@"시"] || [textField.text hasSuffix:@"군"]) {
            self.txtF_schoolRegion.text = [self.txtF_schoolRegion.text stringByReplacingOccurrencesOfString:@"군" withString:@""];
            self.txtF_schoolRegion.text = [self.txtF_schoolRegion.text stringByReplacingOccurrencesOfString:@"시" withString:@""];
        }
    }else if(textField == self.txtF_WebAddress){
        
        self.txtF_WebAddress.text = [self.txtF_WebAddress.text stringByReplacingOccurrencesOfString:@"http" withString:@""];
        
        self.txtF_WebAddress.text = [self.txtF_WebAddress.text stringByReplacingOccurrencesOfString:@":" withString:@""];
        self.txtF_WebAddress.text = [self.txtF_WebAddress.text stringByReplacingOccurrencesOfString:@";" withString:@""];
        self.txtF_WebAddress.text = [self.txtF_WebAddress.text stringByReplacingOccurrencesOfString:@"//" withString:@""];
         self.txtF_WebAddress.text = [self.txtF_WebAddress.text stringByReplacingOccurrencesOfString:@"Http" withString:@""];
         self.txtF_WebAddress.text = [self.txtF_WebAddress.text stringByReplacingOccurrencesOfString:@"HTTP" withString:@""];
        self.txtF_WebAddress.text = [self.txtF_WebAddress.text stringByReplacingOccurrencesOfString:@"www." withString:@""];
         self.txtF_WebAddress.text = [self.txtF_WebAddress.text stringByReplacingOccurrencesOfString:@"Www." withString:@""];
         self.txtF_WebAddress.text = [self.txtF_WebAddress.text stringByReplacingOccurrencesOfString:@"WWW." withString:@""];
    }
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    
    if (self.txtF_schoolName.text.length !=0 &&
        self.txtF_schoolRegion.text.length !=0 &&
        self.txtF_WebAddress.text.length !=0){
        
        int a = [std_manager exist_School:self.txtF_schoolName.text Region:self.txtF_schoolRegion.text];
       

        if ( a== 0) {
            self.btn_save.hidden = NO;
             data_cnt = [std_manager getSchoolCount];
        }else{
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"학교정보 오류" message:@"입력하신 학교는 존재합니다.\n학교를 검색하여 이용하세요." delegate:self cancelButtonTitle:@"확인" otherButtonTitles:nil, nil];
            alertView.tag = 1;
            [alertView show];
        }
    }
    return YES;
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0 && alertView.tag == 1) {
        [self dismissViewControllerAnimated:YES completion:nil];
        [self.txtF_WebAddress resignFirstResponder];
        [self.txtF_schoolRegion resignFirstResponder];
        [self.txtF_schoolName resignFirstResponder];
        
    }else if(buttonIndex == 0 && alertView.tag == 2){
        self.txtF_schoolName.text = @"";
        [self.txtF_schoolName becomeFirstResponder];
    }
}

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    
    self.btn_save.hidden=YES;
    
    return YES;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)btn:(UIButton *)sender {
    
    if (self.txtF_schoolName.text.length !=0 &&
        self.txtF_schoolRegion.text.length !=0 &&
        self.txtF_WebAddress.text.length !=0) {
        
        [std_manager addDataWithNo:data_cnt+1 Region:self.txtF_schoolRegion.text Name:self.txtF_schoolName.text Web_Address:self.txtF_WebAddress.text];
        [self dismissViewControllerAnimated:YES completion:nil];
        
    }
    
    
}
- (IBAction)btn_cancel:(UIButton *)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
