//
//  ViewController.h
//  Anounce_Note
//
//  Created by kimsung jun on 2015. 5. 9..
//  Copyright (c) 2015년 kimsung jun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NoteURL_Make.h"
#import "Edu_News_List.h"
@protocol TerminalViewDelegate;
@class NoteURL_Make;
@class Edu_News_List;

@interface ViewController : UIViewController<UICollectionViewDelegate, UICollectionViewDataSource, NoteURL_MakeDelegate, EduNewsListDelegate, UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UIImageView *sub_face_img;
@property (weak, nonatomic) IBOutlet UILabel *sub_std_name;

- (IBAction)add_btn:(id)sender;

@end

