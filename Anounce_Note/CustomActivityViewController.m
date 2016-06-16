//
//  CustomActivityViewController.m
//  Anounce_Note
//
//  Created by kimsung jun on 2016. 3. 26..
//  Copyright © 2016년 kimsung jun. All rights reserved.
//

#import "CustomActivityViewController.h"

@implementation CustomActivityViewController

- (NSString *)activityType
{
    return @"한컴뷰어.App";
}

- (NSString *)activityTitle
{
    return @"한컴뷰어";
}

//- (UIImage *)activityImage
//{
//    // Note: These images need to have a transparent background and I recommend these sizes:
//    // iPadShare@2x should be 126 px, iPadShare should be 53 px, iPhoneShare@2x should be 100
//    // px, and iPhoneShare should be 50 px. I found these sizes to work for what I was making.
//    
////    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
////    {
////        return [UIImage imageNamed:@"iPadShare.png"];
////    }
////    else
////    {
////        return [UIImage imageNamed:@"iPhoneShare.png"];
////    }
//}

- (BOOL)canPerformWithActivityItems:(NSArray *)activityItems
{
    NSLog(@"%s", __FUNCTION__);
    return YES;
}

- (void)prepareWithActivityItems:(NSArray *)activityItems
{
    NSLog(@"%s",__FUNCTION__);
}

- (UIViewController *)activityViewController
{
    NSLog(@"%s",__FUNCTION__);
    return nil;
}

- (void)performActivity
{
    // This is where you can do anything you want, and is the whole reason for creating a custom
    // UIActivity
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.geochang.es.kr/common/FileDownload.jsp?fid=47582ca76677d686a888125347c4caef&type=application/octet-stream&ext=hwp"]];
    [self activityDidFinish:YES];
}

@end
