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
    NSString *string = @"다문화 가정을 위하여 투데이 알림장 학급 알림에서 총 15개국어를 지원합니다.\n 이번 업데이트에서는 변경된 초등학교 홈페이지 주소를 대부분 반영하였습니다. 다만 신설학교나 홈페이지 주소 변경이 알려지지 않은 학교는 누락되었을 수도 있습니다. 그럴때에는 학교를 새로 등록하시면 이용이 가능하실것이라 예상합니다. \n 혹시라도 에러가 나거나 오류가 난다면 koke0077@gmail.com으로 알려주시면 가급적 빨리 수정하도록 하겠습니다.";
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
