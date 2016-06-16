//
//  EduNewsShow.m
//  Anounce_Note
//
//  Created by kimsung jun on 2015. 5. 27..
//  Copyright (c) 2015년 kimsung jun. All rights reserved.
//

#import "EduNewsShow.h"


@interface EduNewsShow ()
@property (weak, nonatomic) IBOutlet UILabel *lbl_title;
@property (weak, nonatomic) IBOutlet UITextView *txt_news;

@property (strong, nonatomic) UIDocumentInteractionController *documentInteractionCntroller;

@property UIActivityIndicatorView *indicator;
@property UILabel *loading;
@property UIView *indi_view;
- (IBAction)test_btn:(UIButton *)sender;

@end

@implementation EduNewsShow
@synthesize news_title, news, img_data, news_url;
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self indi_start];
    
    self.navigationItem.title = @"경남 e교육소식";
    
    Edu_News_Get *edu_get = [[Edu_News_Get alloc]init];
    
    edu_get.delegate = self;
    
    [edu_get parsingWithUrl:news_url];
    self.navigationController.navigationBarHidden = NO;
    
    self.txt_news.delegate = self;
    
}

-(void)compliteGetEduNewsWithTitle:(NSString *)title Contents:(NSString *)contents Img_data:(NSData *)data{
    
    [self.indicator stopAnimating];
    [self.indi_view removeFromSuperview];
    [self.loading removeFromSuperview];
    
    
    self.lbl_title.text = title;
    [self.lbl_title setLineBreakMode:NSLineBreakByTruncatingMiddle];
//    self.txt_news.text = contents;
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.minimumLineHeight = 35.f;
    paragraphStyle.maximumLineHeight = 35.f;
    
    
//    UIFont *font = [UIFont fontWithName:@"System-Bold" size:20];
    NSString *string = contents;
    NSDictionary *attributtes = @{
                                  NSParagraphStyleAttributeName : paragraphStyle,
                                  };
    self.txt_news.attributedText = [[NSAttributedString alloc] initWithString:string
                                                                   attributes:attributtes];
    
    [self.txt_news setFont:[UIFont systemFontOfSize:18]];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
- (IBAction)test_btn:(UIButton *)sender {
    
    
    NSString *stringURL = @"http://www.ara.es.kr/common/FileDownload.jsp?fid=c5f525f785811646a888125347c4caef&type=application/octet-stream&ext=hwp";
    NSURL  *url = [NSURL URLWithString:stringURL];
    NSData *urlData = [NSData dataWithContentsOfURL:url];
    if ( urlData )
    {
        NSArray       *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString  *documentsDirectory = [paths objectAtIndex:0];
        
        NSString *filePath = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@",@"test"]];
        
        BOOL isWrite = [urlData writeToFile:filePath atomically:YES];
        
        NSString *tempFilePath;
        
        if(isWrite){
            tempFilePath = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@",@"test"]];
        }
        
        NSURL *resultURL = [NSURL fileURLWithPath:tempFilePath];
        
        self.documentInteractionCntroller = [[UIDocumentInteractionController alloc]init];
        
        self.documentInteractionCntroller = [UIDocumentInteractionController interactionControllerWithURL:resultURL];
        self.documentInteractionCntroller.delegate = self;
        
        [self.documentInteractionCntroller presentOpenInMenuFromRect:CGRectZero inView:self.view animated:YES];
    }
    
    
    
     
    
//    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.geochang.es.kr/common/FileDownload.jsp?fid=47582ca76677d686a888125347c4caef&type=application/octet-stream&ext=hwp"]];
    
    
}


/*
 
 
 NSString *textToShare = @"Look at this awesome website for aspiring iOS Developers!";
 NSURL *myWebsite = [NSURL URLWithString:@"http://www.geochang.es.kr/common/FileDownload.jsp?fid=47582ca76677d686a888125347c4caef&type=application/octet-stream&ext=hwp"];
 
 NSArray *objectsToShare = @[textToShare, myWebsite];
 
 UIActivityViewController *activityVC = [[UIActivityViewController alloc] initWithActivityItems:objectsToShare applicationActivities:nil];
 
 NSArray *excludeActivities = @[UIActivityTypeAirDrop,
 UIActivityTypePrint,
 UIActivityTypeAssignToContact,
 UIActivityTypeSaveToCameraRoll,
 UIActivityTypeAddToReadingList,
 UIActivityTypePostToFlickr,
 UIActivityTypePostToVimeo,
 UIActivityTypePostToTencentWeibo];
 
 activityVC.excludedActivityTypes = excludeActivities;
 
 [self presentViewController:activityVC animated:YES completion:nil];*/

@end
