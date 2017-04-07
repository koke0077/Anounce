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
    NSString *string = @"2017학년도가 시작되면 해당 학년으로 다시 등록해서 사용해야 합니다. 그리고 학생등록 이후 오류로 인해 잘못된 정보가 나타나는 경우에도 업데이트 이후 새로 학생을 등록해 이용하시기 바랍니다. \n  만약 새로 추가했음에도 이용하는데 문제가 생긴다면 문의하기에서 오류사항을 개발팀으로 알려주시면 최대한 빨리 조치하도록 하겠습니다. ";
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
    
    [self.view removeFromSuperview];
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
        [self.view removeFromSuperview];

    }
    
}
@end
