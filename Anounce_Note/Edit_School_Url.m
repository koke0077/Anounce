//
//  Edit_School_Url.m
//  Anounce_Note
//
//  Created by kimsung jun on 2016. 3. 22..
//  Copyright © 2016년 kimsung jun. All rights reserved.
//

#import "Edit_School_Url.h"
#import "AppDelegate.h"
#import "School_Data_Manager.h"

@interface Edit_School_Url (){
    int cnt;
    
    School_Data_Manager *school_data_m;
    NSDictionary *dic;
}
- (IBAction)btn:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UITextField *txtF;
@property (weak, nonatomic) IBOutlet UILabel *lbl;
- (IBAction)btn_cancel:(UIButton *)sender;

@end

@implementation Edit_School_Url
@synthesize school_arr;

- (void)viewDidLoad {
    [super viewDidLoad];

    school_data_m = [[School_Data_Manager alloc]init];
    
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    
    delegate.edit_ok = 1;
    
    cnt = [school_data_m getSchoolCount];
    
    dic = [school_arr objectAtIndex:0];
    
    self.txtF.text = [NSString stringWithFormat:@"%@", [dic objectForKey:@"Web_Address"]];
    
    self.txtF.delegate = self;
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    self.txtF.text = [self.txtF.text stringByReplacingOccurrencesOfString:@"http://" withString:@""];
    self.txtF.text = [self.txtF.text stringByReplacingOccurrencesOfString:@"Http://" withString:@""];
    self.txtF.text = [self.txtF.text stringByReplacingOccurrencesOfString:@"HTTP://" withString:@""];
    self.txtF.text = [self.txtF.text stringByReplacingOccurrencesOfString:@"www." withString:@""];
    self.txtF.text = [self.txtF.text stringByReplacingOccurrencesOfString:@"Www." withString:@""];
    self.txtF.text = [self.txtF.text stringByReplacingOccurrencesOfString:@"WWW." withString:@""];
    
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
    
    self.txtF.text = [self.txtF.text stringByReplacingOccurrencesOfString:@"http" withString:@""];
    self.txtF.text = [self.txtF.text stringByReplacingOccurrencesOfString:@";" withString:@""];
    self.txtF.text = [self.txtF.text stringByReplacingOccurrencesOfString:@":" withString:@""];
    self.txtF.text = [self.txtF.text stringByReplacingOccurrencesOfString:@"//" withString:@""];
    self.txtF.text = [self.txtF.text stringByReplacingOccurrencesOfString:@"Http" withString:@""];
    self.txtF.text = [self.txtF.text stringByReplacingOccurrencesOfString:@"HTTP" withString:@""];
    self.txtF.text = [self.txtF.text stringByReplacingOccurrencesOfString:@"www." withString:@""];
    self.txtF.text = [self.txtF.text stringByReplacingOccurrencesOfString:@"Www." withString:@""];
    self.txtF.text = [self.txtF.text stringByReplacingOccurrencesOfString:@"WWW." withString:@""];
    
    [school_data_m upDateWithWithNo:cnt Region:[dic objectForKey:@"Region"] Name:[dic objectForKey:@"Name"] Web_Address:self.txtF.text];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)btn_cancel:(UIButton *)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
