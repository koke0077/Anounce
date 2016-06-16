//
//  TerminalView.m
//  Nubija
//
//  Created by 이영록 on 2014. 7. 23..
//  Copyright (c) 2014년 Youngrok Lee. All rights reserved.
//

#import "TerminalView.h"
//#import "TerminalParser.h"
@interface TerminalView()
@property UIImageView *background;
@property UIImageView *imgReturn;
@property UIImageView *imgBicycle;
@property UILabel *lblName;
@property UILabel *lblReturn;
@property UILabel *lblRent;
@property UIButton *button;
@property UIImage *imgButton;
@property UIImage *imgNormal;
@property UIImage *ImgSelected;

@property UIActivityIndicatorView *indicator;

@end

@implementation TerminalView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {        
//        self.imgNormal=[UIImage imageNamed:@"a_1.png"];
//        self.ImgSelected=[UIImage imageNamed:@"c.png"];
//        
//        self.background = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 102, 85)];
//        
//        self.background.image =self.imgNormal;
//        [self addSubview:self.background];
//
//        self.lblName = [[UILabel alloc] initWithFrame:CGRectMake(1, 0, 100, 30)];
//        [self addSubview:self.lblName];
//        self.lblName.textAlignment =  NSTextAlignmentCenter;
//        
//        UIImageView *imgTerminal = [[UIImageView alloc] initWithFrame:CGRectMake(20, 30, 32, 20)];
//        imgTerminal.image = [UIImage imageNamed:@"a_2.png"];
//        [self addSubview:imgTerminal];
//        
//        UIImageView *imgBicycle = [[UIImageView alloc] initWithFrame:CGRectMake(20, 55, 32, 20)];
//        imgBicycle.image = [UIImage imageNamed:@"a_3.png"];
//        [self addSubview:imgBicycle];
//        
//        
//        self.lblReturn = [[UILabel alloc] initWithFrame:CGRectMake(65, 30, 20, 20)];
//        [self addSubview:self.lblReturn];
//        self.lblReturn.textAlignment = NSTextAlignmentRight;
//        
//        self.lblRent = [[UILabel alloc] initWithFrame:CGRectMake(65, 55, 20, 20)];
//        [self addSubview:self.lblRent];
//        self.lblRent.textAlignment = NSTextAlignmentRight;
//        
//        [self.lblName setFont:[UIFont fontWithName:@"Helvetica" size:12]];
//        [self.lblReturn setFont:[UIFont fontWithName:@"Helvetica" size:15]];
//        [self.lblRent setFont:[UIFont fontWithName:@"Helvetica" size:15]];
        
        self.imgButton = [UIImage imageNamed:@"a_4.png"];
        self.button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        //self.button.imageView.image = self.imgButton;
        [self.button setImage:self.imgButton forState:UIControlStateNormal];
        [self addSubview:self.button];
        [self bringSubviewToFront:self.button];
        
        [self.button addTarget:self action:@selector(clicked) forControlEvents:UIControlEventTouchUpInside];
        [self.button addTarget:self action:@selector(touched) forControlEvents:UIControlEventTouchDown];
        [self.button addTarget:self action:@selector(dragExit) forControlEvents:UIControlEventTouchDragExit];
        [self.button addTarget:self action:@selector(dragExit) forControlEvents:UIControlEventTouchUpOutside];
        [self.button addTarget:self action:@selector(dragExit) forControlEvents:UIControlEventTouchCancel];
        
        //self.backgroundColor=[UIColor clearColor];
    }
    return self;;
}

- (void)dragExit{
    self.background.image =self.imgNormal;
}

- (void)clicked{
    self.background.image =self.imgNormal;
    [self.delegate clickButton:self];
}

- (void)touched{

    self.background.image = self.ImgSelected;
}

//- (void)setTerminal:(Terminal *)value{
//    _terminal = value;
//    if (self.terminal!=nil) {
//        [self.button setImage:nil forState:UIControlStateNormal];
//        self.lblName.text = self.terminal.name;
//        TerminalParser* parser = [[TerminalParser alloc] init];
//        parser.delegate = self;
//        parser.terminal = self.terminal;
//        [parser parse];
//
//        if (self.indicator==nil) {
//            self.indicator  = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake((int)self.frame.size.width/2-25, (int)self.frame.size.height/2-25, 50, 50)];
//            self.indicator.hidesWhenStopped = YES;
//            self.indicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
//            [self addSubview:self.indicator];
//        }
//        [self.indicator startAnimating];
//    }
//}

//- (void)completeParsing:(NSString *)count1 count:(NSString *)count2{
//    self.lblReturn.text = [NSString stringWithFormat:@"%@", count1];
//    self.lblRent.text = [NSString stringWithFormat:@"%@", count2];
//    if (self.indicator!=nil) [self.indicator stopAnimating];
//}
//
//- (void)failParsing{
//    if (self.indicator!=nil) [self.indicator stopAnimating];
//    self.lblReturn.text = @"?";
//    self.lblRent.text = @"?";
//}

@end
