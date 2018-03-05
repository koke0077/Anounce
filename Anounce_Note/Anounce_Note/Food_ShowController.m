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
    NSArray *day_arr;
    int start;
    int day_count;
    
    int today;
    int toMonth;
    
    int current_year;
    int current_month;
    int current_day;
    int first_num;
    int day_count2;
    int now_count;
    NSArray *mon_count;
    NSMutableArray *arr_day;
    NSMutableDictionary *food_dic;
}
//@property (weak, nonatomic) IBOutlet UITableView *tableView;


@property NSArray *food_arr;
@property NSArray *food_array;
@property NSArray *day_array;
@property NSArray *week_array;
@property NSString *mon_str;

@property NSMutableDictionary *food_dic;
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
    /*
    for (int i = 1; i<33; i++) {
        day_num[i] = i;
    }
*/
    day_count = 0;

    
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
    
    arr_day = [[NSMutableArray alloc]init];
    arr_day = @[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"11",@"12",@"13",@"14",@"15",@"16",@"17",@"18",@"19",@"20",@"21",@"22",@"23",@"24",@"25",@"26",@"27",@"28",@"29",@"30",@"31"];
    mon_count = @[@"31",@"28",@"31",@"30",@"31",@"30",@"31",@"31",@"30",@"31",@"30",@"31"];
    now_count = 0;
    
    current_year = [[[self dateFormatter2] stringFromDate:date] intValue];
    current_month = [[[self dateFormatter] stringFromDate:date] intValue];
    current_day = [[[self dateFormatter3] stringFromDate:date] intValue];
    first_num = [self make_calendarByYear:[[[self dateFormatter2] stringFromDate:date] intValue]
                                    Month:[[[self dateFormatter] stringFromDate:date] intValue]
                                      Day:[[[self dateFormatter3] stringFromDate:date] intValue]];

    if(current_month<8){
        if(current_month == 2){
            if(current_year%4 == 0 && current_year%100 != 0 && current_year%400 == 0){
                day_count2 = 29;
            }else{
                day_count2 = 28;
            }
        }else if(current_month%2 ==0){
            day_count2 = 30;
        }else if(current_month%2 != 0){
            day_count2 = 31;
        }
    }else{
        if(current_month%2 != 0){
            day_count2 = 30;
        }else{
            day_count2 = 31;
        }
    }
    
//    today = [[[self dateFormatter3] stringFromDate:date] intValue];
//    toMonth = [[[self dateFormatter2] stringFromDate:date]intValue];
    self.navigationItem.title = [NSString stringWithFormat:@"%d월 식단",current_month];
    
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

-(void)compliteGetFood:(NSArray *)food_array day_cnt:(NSArray *)day_cnt{
    self.food_arr = food_array;
    day_arr = day_cnt;
    day_count = (int)food_array.count;
    now_count = 0;
    self.food_dic = [[NSMutableDictionary alloc]init];
    for(int i = 0 ; i<day_count ; i++){
        [self.food_dic setValue:[self.food_arr objectAtIndex:i] forKey:[day_arr objectAtIndex:i]];
    }
    [self.collection_View reloadData];
    
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
//    return day_count;
    if((current_month != 2 && first_num>5 && [mon_count[current_month-1] intValue] == 30)||(current_month != 2 && first_num >= 5 && [mon_count[current_month-1] intValue] == 31)){
        return 42;
    }else{
        return 35;
    }
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(self.segment.frame.size.width/7*0.7, 30); // This is my fixed Cell height
    
    //Before I am trying this below code also, but its not working
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    
    UILabel *lbl = (UILabel *)[cell viewWithTag:10];
    
    lbl.textAlignment = NSTextAlignmentCenter;
    if(indexPath.row < first_num){
        lbl.text = @"";

    }else{
        if(day_count2 >now_count && now_count<day_arr.count){
            lbl.text = [arr_day objectAtIndex:now_count];
           
//            NSLog(@"now_count = %d, day_count2 = %d, day_arr.count = %d", now_count, day_count2, day_arr.count);
            
            if ([[arr_day objectAtIndex:now_count] intValue] == current_day) {
                cell.backgroundColor = [UIColor greenColor];
                NSString *food = [self.food_dic objectForKey:[NSString stringWithFormat:@"%d",current_day]];
                if (food.length <10) {
                    self.txtView.text = @"식단이 없거나 휴일입니다.";
                }else{
                    NSString *str_txt = food;
                    str_txt = [str_txt stringByReplacingOccurrencesOfString:@"<br/>[중식]" withString:@"일 \n"];
                    str_txt = [str_txt stringByReplacingOccurrencesOfString:@"<br/>" withString:@"\n"];
                    self.txtView.text = str_txt;
                }
            }
             now_count++;
        }else{
            lbl.text = @"";
        }
    }
             
    
    /*
    int remain_num = 7 - [day_arr[6] intValue];
    
//    if (today == 2) {
        if ([self.food_arr[indexPath.row] length] >0 ) {
            label.text = [NSString stringWithFormat:@"%@", day_arr[indexPath.row]];
            
            if ([day_arr[indexPath.row] intValue] == today) {
                cell.backgroundColor = [UIColor greenColor];
                if ([self.food_arr[indexPath.row] length] <10) {
                    self.txtView.text = @"식단이 없거나 휴일입니다.";
                }else{
                    
                    NSString *str_txt = self.food_arr[indexPath.row];
                    
                    str_txt = [str_txt stringByReplacingOccurrencesOfString:@"<br/>[중식]" withString:@"일 \n"];
                    str_txt = [str_txt stringByReplacingOccurrencesOfString:@"<br/>" withString:@"\n"];
                    
                    self.txtView.text = str_txt;
                    
                }
            }
            
//            start++;
            if ([self.food_arr[indexPath.row] length] <10) {
                label.textColor = [UIColor redColor];
            }else{
                label.textColor = [UIColor blackColor];
            }
        }else{
            label.text = @" ";
        }
//    }
    
   
    
    */
    
    NSLog(@"cell size.width %f", cell.frame.size.width);
    NSLog(@"fffffff%d", day_num[indexPath.row]);
    
    
    
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    //    NSLog(@"%@",[food_arr objectAtIndex:indexPath.row]);
    
    UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
    UILabel *lbl = (UILabel *)[cell viewWithTag:10];
    
    if(lbl.text.length > 0){
        NSString *food = [self.food_dic objectForKey:lbl.text];
        if (food.length < 10) {
            self.txtView.text = @"식단이 없거나 휴일입니다.";
        }else{
            
            NSString *str_txt = food;
            
            str_txt = [str_txt stringByReplacingOccurrencesOfString:@"<br/>[중식]" withString:@"일 \n"];
            str_txt = [str_txt stringByReplacingOccurrencesOfString:@"<br/>" withString:@"\n"];
            
            self.txtView.text = str_txt;
            
        }
    }else{
        self.txtView.text = @"자료가 없습니다";
    }

    
    
    
//    [rangeBlock stringByReplacingOccurrencesOfString:@"<br />" withString:@""];
    
    NSLog(@"row = %ld", (long)indexPath.row);
    NSLog(@"section = %ld", (long)indexPath.section);
    
    
    if (indexPath.row-1 != current_day) {
        UICollectionViewCell* cell = [collectionView cellForItemAtIndexPath:indexPath];
        cell.backgroundColor = [UIColor orangeColor];
    }
}

-(void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    UICollectionViewCell* cell = [collectionView cellForItemAtIndexPath:indexPath];
    
    if (indexPath.row-1 != current_day) {
        cell.backgroundColor = [UIColor whiteColor];
    }
    
}

-(void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath{
    
    cell = [collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForRow:14 inSection:0]];
    
    [cell setSelected:YES];
    
}
/*
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
*/
-(int)make_calendarByYear:(int)year Month:(int)month Day:(int)day{
    int month_day_sum = 0;
    int mon_num[12] = {31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31};
    for(int i =0 ; i < month-1 ; i++) month_day_sum = month_day_sum + mon_num[i];
    int sum = (year)*365 + year/4 - year/100 + year/400-1 + month_day_sum + 1;
    NSLog(@"%d", mon_num[month-1]);
    NSLog(@"%d", sum);
    NSLog(@"%d", sum%7);
    NSLog(@"%d, %d, %d", year, month, day);
    return sum%7;
}

- (NSDateFormatter *)dateFormatter2
{
    static NSDateFormatter *dateFormatter;
    if(!dateFormatter){
        dateFormatter = [NSDateFormatter new];
        dateFormatter.dateFormat = @"Y";
    }
    return dateFormatter;
}

- (NSDateFormatter *)dateFormatter
{
    static NSDateFormatter *dateFormatter;
    if(!dateFormatter){
        dateFormatter = [NSDateFormatter new];
        dateFormatter.dateFormat = @"MM";
    }
    return dateFormatter;
}

- (NSDateFormatter *)dateFormatter3
{
    static NSDateFormatter *dateFormatter;
    if(!dateFormatter){
        dateFormatter = [NSDateFormatter new];
        dateFormatter.dateFormat = @"dd";
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
