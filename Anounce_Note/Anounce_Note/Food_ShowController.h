//
//  Food_ShowController.h
//  Anounce_Note
//
//  Created by kimsung jun on 2015. 5. 22..
//  Copyright (c) 2015년 kimsung jun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Food_Get.h"

@class Food_Get;
@interface Food_ShowController : UIViewController<FoodGetDelegate,UICollectionViewDataSource, UICollectionViewDelegate>

@property (strong, nonatomic) NSString *food_url;

//@property (strong, nonatomic) Food_Get *f_get;

@end
