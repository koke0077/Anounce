//
//  ShowViewContents.m
//  Anounce_Note
//
//  Created by kimsung jun on 2015. 5. 21..
//  Copyright (c) 2015년 kimsung jun. All rights reserved.
//

#import "ShowViewContents.h"

@interface ShowViewContents ()
@property (weak, nonatomic) IBOutlet UILabel *lbl_title;
@property (weak, nonatomic) IBOutlet UITextView *txt_view;
@property (strong, nonatomic) Lms_Content_Get *lms_c_get;
@property (strong, nonatomic) Note_Content_Get *note_con_get;

@property UIActivityIndicatorView *indicator;
@property UILabel *loading;
@property UIView *indi_view;

@end

@implementation ShowViewContents
@synthesize con_url, title_txt;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.txt_view.hidden = YES;
    
    [self indi_start];
    
    self.lms_c_get = [[Lms_Content_Get alloc]init];
    self.lms_c_get.delegate = self;
    self.note_con_get = [[Note_Content_Get alloc]init];
    self.note_con_get.delegate = self;
    
    self.lbl_title.text = title_txt;
    
    NSRange range_1 = [con_url rangeOfString:@"lms"];
    
    if (range_1.length == 0) {
        [self.note_con_get parsingWithUrl:con_url];
    }else{
        
        [self.lms_c_get parsingToGetWithUrl:con_url];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)compliteGetContents:(NSString *)contents{
    self.txt_view.text = contents;
    
    [self.indicator stopAnimating];
    [self.indi_view removeFromSuperview];
    [self.loading removeFromSuperview];
    
    self.txt_view.hidden = NO;
}

-(void)compliteNote:(NSString *)note_str{
     self.txt_view.text = note_str;
    
    [self.indicator stopAnimating];
    [self.indi_view removeFromSuperview];
    [self.loading removeFromSuperview];
    
    self.txt_view.hidden = NO;
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

@end
