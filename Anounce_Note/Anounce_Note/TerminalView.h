//
//  TerminalView.h
//  Nubija
//
//  Created by 이영록 on 2014. 7. 23..
//  Copyright (c) 2014년 Youngrok Lee. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "Terminal.h"
//#import "TerminalParser.h"

@class TerminalView;

@protocol TerminalViewDelegate
- (void)clickButton:(TerminalView *)terminalView;
@end

@interface TerminalView : UIView
//@property (nonatomic) Terminal *terminal;
@property int index;
@property id delegate;
@end
