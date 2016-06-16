//
//  Add_DataViewController.m
//  Anounce_Note
//
//  Created by kimsung jun on 2015. 5. 10..
//  Copyright (c) 2015년 kimsung jun. All rights reserved.
//

#import "Add_DataViewController.h"
#import "Add_School.h"
#import "AppDelegate.h"
#import "Add_School_Region.h"

@interface Add_DataViewController (){
    
    NSArray *region_Arr;
    AppDelegate *delegate;

}
@property (weak, nonatomic) IBOutlet UIButton *school_btn;
- (IBAction)school_search:(UIButton *)sender;
- (IBAction)back_btn:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UILabel *school_lbl;
@property (weak, nonatomic) IBOutlet UILabel *grade_lbl;
@property (weak, nonatomic) IBOutlet UITextField *name_txt;
- (IBAction)select_course:(UISegmentedControl *)sender;
@property (weak, nonatomic) IBOutlet UISegmentedControl *select_seg;


@end

@implementation Add_DataViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    
    region_Arr = @[@"창원",@"진주",@"통영",@"사천",@"김해",@"거제"
                   ,@"양산",@"밀양",@"의령",@"함안",@"창녕",@"고성",@"남해",@"하동",@"산청",@"함양",@"거창",@"합천"];
}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:YES];
    
    NSLog(@"%ld",(long)self.select_seg.selectedSegmentIndex);
    
    delegate.school_course = [NSString stringWithFormat:
                              @"%ld", (long)self.select_seg.selectedSegmentIndex];
    
    delegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    
    
    
    self.school_lbl.text = delegate.school_name;
    self.grade_lbl.text = [NSString stringWithFormat:@"%@학년 %@반", delegate.school_grade, delegate.school_class];
    self.name_txt.text = delegate.stu_name;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return region_Arr.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"RegionCell" forIndexPath:indexPath];
    
//    UILabel *lbl = (UILabel *)[cell viewWithTag:10];
    UIImageView *img_view = (UIImageView *)[cell viewWithTag:10];
    
    NSString *img_str = [NSString stringWithFormat:@"%@.png",[region_Arr objectAtIndex:indexPath.row]];
    
    img_view.image = [UIImage imageNamed:img_str];
    
    return cell;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
   NSArray *arr = [self.collectionView indexPathsForSelectedItems];
    //        NSLog(@"%ld",(long)indexPath.row);
    NSIndexPath *indexpath = [[NSIndexPath alloc]init];
    indexpath = [arr objectAtIndex:0];
    NSString *region = [region_Arr objectAtIndex:indexpath.row];
    [[segue destinationViewController] setRegion:region];
    //        [[segue destinationViewController] setMyArray:myArray];

}



- (IBAction)school_search:(UIButton *)sender {
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    Add_School *add_next = [storyboard instantiateViewControllerWithIdentifier:@"School_Select"];
    
    
//    [self presentViewController:add_next animated:YES completion:nil];
    [self.navigationController pushViewController:add_next animated:YES];
}

- (IBAction)back_btn:(UIButton *)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)select_course:(UISegmentedControl *)sender {
    delegate.school_course = [NSString stringWithFormat:@"%ld", (long)sender.selectedSegmentIndex];

}
@end
