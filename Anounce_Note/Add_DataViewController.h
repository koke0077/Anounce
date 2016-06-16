//
//  Add_DataViewController.h
//  Anounce_Note
//
//  Created by kimsung jun on 2015. 5. 10..
//  Copyright (c) 2015년 kimsung jun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Add_DataViewController : UIViewController<UICollectionViewDataSource, UICollectionViewDelegate>


@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@end
