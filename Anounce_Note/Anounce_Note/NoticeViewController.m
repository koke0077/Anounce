//
//  NoticeViewController.m
//  Anounce_Note
//
//  Created by sung jun kim on 2017. 2. 5..
//  Copyright © 2017년 kimsung jun. All rights reserved.
//

#import "NoticeViewController.h"

@interface NoticeViewController ()
@property (weak, nonatomic) IBOutlet UITextView *txtView;
@property (weak, nonatomic) IBOutlet UISwitch *toggle;
@property (weak, nonatomic) IBOutlet UIButton *btn_close;
- (IBAction)close_act:(UIButton *)sender;
- (IBAction)on_off_toggle:(UISwitch *)sender;

@end

@implementation NoticeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.minimumLineHeight = 35.f;
    paragraphStyle.maximumLineHeight = 35.f;
    
    
    //    UIFont *font = [UIFont fontWithName:@"System-Bold" size:20];
    NSString *string = @"다문화 가정을 위하여 투데이 알림장 학급 알림에서 총 15개국어를 지원합니다.\n 알림장 내용이 보이지 않는 오류와 식단이 보이지 않거나 식단을 보려면 앱이 꺼지는 현상을 수정하였습니다.";
    NSDictionary *attributtes = @{
                                  NSParagraphStyleAttributeName : paragraphStyle,
                                  };
    self.txtView.attributedText = [[NSAttributedString alloc] initWithString:string
                                                                   attributes:attributtes];
    
    [self.txtView setFont:[UIFont systemFontOfSize:18]];
    
//    self.txtView.text = @"2017학년도가 시작되면 해당 학년으로 다시 등록해서 사용해야 합니다.";
    
    int state = (int)[[NSUserDefaults standardUserDefaults] integerForKey:@"notice"];
    if(state == 1){
        self.toggle.on = false;
//        NSLog(@"F");
    }else{
        self.toggle.on = true;
//        NSLog(@"T");
    }
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

- (IBAction)close_act:(UIButton *)sender {
    
    [self kill_view];
}

- (IBAction)on_off_toggle:(UISwitch *)sender {
    
    BOOL now_state = sender.isOn;
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    if(now_state == true){
        [defaults setInteger:0 forKey:@"notice"];
        
        NSLog(@"%d", (int)[defaults integerForKey:@"notice"]);
    }else{
        [defaults setInteger:1 forKey:@"notice"];
        NSLog(@"%d", (int)[defaults integerForKey:@"notice"]);
        [self kill_view];

    }
    
}

-(void) kill_view{
    [self.view removeFromSuperview];
}
@end
