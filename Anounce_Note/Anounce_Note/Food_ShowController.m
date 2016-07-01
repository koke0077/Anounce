//
//  Food_ShowController.m
//  Anounce_Note
//
//  Created by kimsung jun on 2015. 5. 22..
//  Copyright (c) 2015년 kimsung jun. All rights reserved.
//

#import "Food_ShowController.h"
//#import "AppDelegate.h"


@interface Food_ShowController (){
    
    int day_num[32];
    NSArray *food_arr;
    int start;
    
    int today;
    int toMonth;
}
//@property (weak, nonatomic) IBOutlet UITableView *tableView;


@property NSArray *food_arr;
@property NSArray *food_array;
@property NSArray *day_array;
@property NSArray *week_array;
@property NSString *mon_str;
//- (IBAction)back:(UIButton *)sender;
@property (strong, nonatomic) Food_Get *f_get;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segment;
@property (weak, nonatomic) IBOutlet UICollectionView *collection_View;
@property (weak, nonatomic) IBOutlet UITextView *txtView;

@end

@implementation Food_ShowController
@synthesize food_url, food_arr=_food_arr;

//-(Food_Get *)f_get{
//    if (_f_get == nil) {
//        _f_get = [[Food_Get alloc]init];
//        
//        _f_get.delegate = self;
//    }
//    return _f_get;
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    for (int i = 1; i<32; i++) {
        day_num[i] = i;
    }
    
    
    

    
}

-(void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:YES];
    start = 0;
    today = 0;
    
}

-(void)viewDidDisappear:(BOOL)animated{
    
    NSLog(@"%ld", CFGetRetainCount((__bridge CFTypeRef)self));
}
-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:YES];
//    today = 1;
    start = 1;
    
    self.f_get = [[Food_Get alloc]init];
    
    self.f_get.delegate = self;
    NSDate *date = [NSDate date];
    
    today = [[[self dateFormatter] stringFromDate:date] intValue];
    toMonth = [[[self dateFormatter2] stringFromDate:date]intValue];
    self.navigationItem.title = [NSString stringWithFormat:@"%d월 식단",toMonth];
    
    [self.f_get parsingWithSchoolCode:food_url];
    
    __weak Food_ShowController *selfWeak = self;
    self.f_get.blockAfterUpdate = ^void(void){
        selfWeak.food_arr = selfWeak.self.f_get.array_2;
        __strong Food_ShowController *selfStrong = selfWeak;
        if (selfStrong) {
            //            [selfWeak.collectView reloadData];
            [selfWeak.collection_View reloadData];
            //            [selfWeak test];
            
            //            today = 2;
            
        }
        
        
    };
    
    self.collection_View.delegate = self;
    self.collection_View.dataSource = self;
    
    
    self.navigationController.navigationBarHidden = NO;

}

-(void)compliteGetFood:(NSArray *)food_array{
    self.food_arr = food_array;
    [self.collection_View reloadData];
    
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 35;
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(self.segment.frame.size.width/7*0.7, 30); // This is my fixed Cell height
    
    //Before I am trying this below code also, but its not working
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, cell.frame.size.width, cell.frame.size.height)];
    
    label.textAlignment = NSTextAlignmentCenter;
    
    [cell addSubview:label];
    
//    if (today == 2) {
        if ([self.food_arr[indexPath.row] length] >0 ) {
            label.text = [NSString stringWithFormat:@"%d",day_num[start]];
            
            if (day_num[start] == today) {
                cell.backgroundColor = [UIColor greenColor];
                if ([self.food_arr[indexPath.row] length] <10) {
                    self.txtView.text = @"식단이 없거나 휴일입니다.";
                }else{
                    
                    NSString *str_txt = self.food_arr[indexPath.row];
                    
                    str_txt = [str_txt stringByReplacingOccurrencesOfString:@"<br />[중식]" withString:@"일 \n"];
                    str_txt = [str_txt stringByReplacingOccurrencesOfString:@"<br />" withString:@"\n"];
                    
                    self.txtView.text = str_txt;
                    
                }
            }
            
            start++;
            if ([self.food_arr[indexPath.row] length] <10) {
                label.textColor = [UIColor redColor];
            }else{
                label.textColor = [UIColor blackColor];
            }
        }else{
            label.text = @" ";
        }
//    }
    
   
    
    
    
    NSLog(@"cell size.width %f", cell.frame.size.width);
    NSLog(@"fffffff%d", day_num[indexPath.row]);
    
    
    
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    //    NSLog(@"%@",[food_arr objectAtIndex:indexPath.row]);
    if ([[self.food_arr objectAtIndex:indexPath.row] length] <10) {
        self.txtView.text = @"식단이 없거나 휴일입니다.";
    }else{
        
        NSString *str_txt = [self.food_arr objectAtIndex:indexPath.row];
        
        str_txt = [str_txt stringByReplacingOccurrencesOfString:@"<br />[중식]" withString:@"일 \n"];
        str_txt = [str_txt stringByReplacingOccurrencesOfString:@"<br />" withString:@"\n"];
        
        self.txtView.text = str_txt;
        
    }
    
//    [rangeBlock stringByReplacingOccurrencesOfString:@"<br />" withString:@""];
    
    NSLog(@"row = %ld", (long)indexPath.row);
    NSLog(@"section = %ld", (long)indexPath.section);
    
    
    if (indexPath.row-1 != today) {
        UICollectionViewCell* cell = [collectionView cellForItemAtIndexPath:indexPath];
        cell.backgroundColor = [UIColor orangeColor];
    }
}

-(void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    UICollectionViewCell* cell = [collectionView cellForItemAtIndexPath:indexPath];
    
    if (indexPath.row-1 != today) {
        cell.backgroundColor = [UIColor whiteColor];
    }
    
}

-(void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath{
    
    cell = [collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForRow:14 inSection:0]];
    
    [cell setSelected:YES];
    
}


- (NSDateFormatter *)dateFormatter
{
    static NSDateFormatter *dateFormatter;
    if(!dateFormatter){
        dateFormatter = [NSDateFormatter new];
        dateFormatter.dateFormat = @"d";
    }
    
    return dateFormatter;
}

- (NSDateFormatter *)dateFormatter2
{
    static NSDateFormatter *dateFormatter;
    if(!dateFormatter){
        dateFormatter = [NSDateFormatter new];
        dateFormatter.dateFormat = @"MM";
    }
    
    return dateFormatter;
}

-(void)test{
    

}

/*
-(void)compliteGetFood:(NSArray *)food Day:(NSArray *)day Week:(NSArray *)week Month:(NSString *)montn_str{
    
    self.food_array = food;
    self.day_array = day;
    self.week_array = week;
    self.mon_str = montn_str;
    
    if (self.food_array.count == 0) {
        
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"학교정보 오류" message:@"식단표를 로드할 수 없습니다.\n 관리자에게 문의하십시오." delegate:self cancelButtonTitle:@"확인" otherButtonTitles:nil, nil];
        alertView.tag = 1;
        [alertView show];
    }else{
         [self.tableView reloadData];
    }
    
   
    
    self.navigationItem.title = [NSString stringWithFormat:@"%@ 식단",self.mon_str];

}
 
 
 */


//-(void)compliteGetFood:(NSArray *)food_array{
//    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
//    
//    NSLog(@"%@", delegate.food_array);
//}

-(void)failParsingForFood{
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"학교정보 오류" message:@"식단표를 로드할 수 없습니다.\n 관리자에게 문의하십시오." delegate:self cancelButtonTitle:@"확인" otherButtonTitles:nil, nil];
    alertView.tag = 1;
    [alertView show];
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0 && alertView.tag == 1) {
        [self.navigationController popViewControllerAnimated:YES];
    }
}



/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    
    UILabel *lbl_day = (UILabel *)[cell viewWithTag:10];
    UILabel *lbl_week = (UILabel *)[cell viewWithTag:20];
    UITextView *txt_food = (UITextView *)[cell viewWithTag:30];
    
    lbl_day.text = self.day_array[indexPath.row];
    lbl_week.text = self.week_array[indexPath.row];
    txt_food.text = self.food_array[indexPath.row];
    
    return cell;
}

 */
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

@end
