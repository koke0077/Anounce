//
//  Students_ManageController.m
//  Anounce_Note
//
//  Created by kimsung jun on 2015. 5. 11..
//  Copyright (c) 2015년 kimsung jun. All rights reserved.
//

#import "Students_ManageController.h"
#import "Add_DataViewController.h"
#import "Students_Data_Manager.h"
#import "Students_Face_Managert.h"
#import "AppDelegate.h"
#include <dispatch/dispatch.h>

@interface Students_ManageController (){
    
    UIImage *image;
    BOOL is_photo;
    
    Students_Data_Manager *s_data;
    Students_Face_Managert *f_data;
    NSMutableArray *std_data;
    NSMutableArray *std_face_data;
    
    NSThread *thread;
    dispatch_queue_t dQueue;
    
    int index_num;
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) UIImagePickerController *cameraController;
@property UIActivityIndicatorView *myIndi;

- (IBAction)add_btn:(UIButton *)sender;
- (IBAction)edit_btn:(UIButton *)sender;

- (IBAction)back_btn:(id)sender;
- (IBAction)btn_Change_Face:(UIButton *)sender;

@end

@implementation Students_ManageController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    s_data = [[Students_Data_Manager alloc]init];
    f_data = [[Students_Face_Managert alloc]init];
    
    std_data = [[NSMutableArray alloc]init];
    std_face_data = [[NSMutableArray alloc]init];
    
    [std_data removeAllObjects];
    [std_face_data removeAllObjects];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    dQueue = dispatch_queue_create("test", NULL);
    
    [NSThread detachNewThreadSelector:@selector(thread_2) toTarget:self withObject:nil];
}

-(void)viewWillAppear:(BOOL)animated{
//    std_data = [NSMutableArray arrayWithArray: [s_data getRecords]];
//    std_face_data = [NSMutableArray arrayWithArray:[f_data get_FaceImage]];
//     [self.tableView reloadData];
    
    thread = [[NSThread alloc]initWithTarget:self selector:@selector(thread_2) object:nil];
    
    [thread start];
}

-(void)thread_2{
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        self.myIndi = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        self.myIndi.hidesWhenStopped = YES;
        
        self.myIndi.center = self.view.center;
        
        [self.view addSubview:self.myIndi];
        
        [self.myIndi startAnimating];
        
        id __weak selfweak = self;
        __weak UIActivityIndicatorView *indicator2 = self.myIndi;
        
        dispatch_async(dQueue, ^{
            std_data = (NSMutableArray *)[s_data getRecords];
            std_face_data = (NSMutableArray *)[f_data get_FaceImage];
            
            id __strong selfStrong = selfweak;
            __strong UIActivityIndicatorView *indi = indicator2;
            dispatch_async(dispatch_get_main_queue(), ^{
                if (selfStrong) {
                    [[selfStrong tableView] reloadData];
                    
                    [indi stopAnimating];
                    [indi removeFromSuperview];
                    
                }
                
                
            });
        });
        
    });
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)add_btn:(UIButton *)sender {
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
//    Add_DataViewController *add_view = [storyboard instantiateViewControllerWithIdentifier:@"Add_Data"];
    
    UIViewController *add_view = [storyboard instantiateViewControllerWithIdentifier:@"Navi"];
    
    [self presentViewController:add_view animated:YES completion:nil];
//    [self.navigationController pushViewController:add_view animated:YES];
}

- (IBAction)edit_btn:(UIButton *)sender {
    
     [self.tableView setEditing:!self.tableView.editing animated:YES];
}

- (IBAction)back_btn:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
    
//    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)btn_Change_Face:(UIButton *)sender {
    
    UITableViewCell *buttonCell = [self GetCellFromTableView:self.tableView Sender:sender];
    //    UITableView* table = (UITableView *)[buttonCell superview];
    NSIndexPath* pathOfTheCell = [self.tableView indexPathForCell:buttonCell];
    NSInteger rowOfTheCell = [pathOfTheCell row];
    
    index_num = (int)rowOfTheCell;

    
    UIActionSheet *actionSheet = [[UIActionSheet alloc]initWithTitle:@"이미지 가져오기" delegate:self cancelButtonTitle:@"취소하기" destructiveButtonTitle:@"사진찍기" otherButtonTitles:@"사진앨범", nil];
    
    [actionSheet showInView:self.view];
}

-(UITableViewCell*)GetCellFromTableView:(UITableView*)tableView Sender:(id)sender {
    CGPoint pos = [sender convertPoint:CGPointZero toView:tableView];
    NSIndexPath *indexPath = [tableView indexPathForRowAtPoint:pos];
    return [tableView cellForRowAtIndexPath:indexPath];
}

-(void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex{
    
    if (buttonIndex == [actionSheet destructiveButtonIndex]){
        
        self.cameraController = [[UIImagePickerController alloc] init];
        [self.cameraController setDelegate:self];
        [self.cameraController setAllowsEditing:YES];
        [self.cameraController setSourceType:UIImagePickerControllerSourceTypeCamera];
        [self.cameraController setShowsCameraControls:YES];
        [self.cameraController setEditing:YES];
        
        CGAffineTransform transform = CGAffineTransformMakeTranslation(0.0f, 50.0f);
        transform = CGAffineTransformScale(transform, 1.2f, 1.2f);
        self.cameraController.cameraViewTransform = transform;
//        imagePicker.cameraViewTransform = transform;

//      self.cameraController.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height*0.8);
        //self.cameraController.modalPresentationStyle = UIModalPresentationCurrentContext;
        
        [self presentViewController:self.cameraController animated:YES completion:nil];
        
//        [self.view.superview bringSubviewToFront:self.cameraController.view];
        
    }else if(buttonIndex == [actionSheet firstOtherButtonIndex]){
        
        _cameraController = [[UIImagePickerController alloc]init];
        [_cameraController setDelegate:self];
        [_cameraController setAllowsEditing:YES];
        [_cameraController setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
        [self.cameraController setEditing:YES];
        
        [self presentViewController:_cameraController animated:YES completion:nil];
        
//        [self.view.superview bringSubviewToFront: self.presentationController];
        
    }
    
    
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    image = [info objectForKey:UIImagePickerControllerEditedImage];
    
    CGRect ret = CGRectMake(0, 0, image.size.width, image.size.width);
    
    UIImage *cropped = [self imageByCropping:image toRect:ret];
    
    image = cropped;
    
    NSData *data = UIImagePNGRepresentation(image);
    
    is_photo = YES;
    
    NSDictionary *dic = [std_face_data objectAtIndex:index_num];
    
    [f_data updateWithImageData:data ByName:[dic objectForKey:@"name"]];
    
    
}



- (UIImage*)imageByCropping:(UIImage *)imageToCrop toRect:(CGRect)rect
{
    CGImageRef imageRef = CGImageCreateWithImageInRect([imageToCrop CGImage], rect);
    UIImage *cropped = [UIImage imageWithCGImage:imageRef];
    CGImageRelease(imageRef);
    return cropped;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        NSDictionary *dic = std_data[indexPath.row];
        
        NSString *name_str = [dic objectForKey:@"name"];
        
        s_data = [[Students_Data_Manager alloc]init];
        
        [s_data removeDataWithStudents_Namd:name_str];
        [f_data removeFaceWithStudents_Namd:name_str];
        
        [std_data removeObjectAtIndex:indexPath.row];
        [std_face_data removeObjectAtIndex:indexPath.row];
        
//        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath]
//                         withRowAnimation:UITableViewRowAnimationFade];
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return std_data.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    NSDictionary *dic = [std_data objectAtIndex:indexPath.row];
    NSDictionary *face_dic = [std_face_data objectAtIndex:indexPath.row];
    
    UIImageView *img_face = (UIImageView *)[cell viewWithTag:10];
    UILabel *lbl_school = (UILabel *)[cell viewWithTag:20];
    UILabel *lbl_grade = (UILabel *)[cell viewWithTag:30];
    UILabel *lbl_name = (UILabel *)[cell viewWithTag:40];
    
    img_face.image = [UIImage imageWithData:[face_dic objectForKey:@"img_data"]];
    lbl_school.text = [dic objectForKey:@"school"];
    lbl_grade.text = [NSString stringWithFormat:@"%@학년 %@반",[dic objectForKey:@"grade"],[dic objectForKey:@"class"]];
    lbl_name.text = [dic objectForKey:@"name"];

    
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSDictionary *dd = [std_data objectAtIndex:indexPath.row];
    
    NSString *code = [[NSString stringWithFormat:@"%@",[dd objectForKey:@"note_url"]] substringFromIndex: [[NSString stringWithFormat:@"%@",[dd objectForKey:@"note_url"]] length] - 4];
    NSLog(@"%@",[std_data objectAtIndex:indexPath.row]);
    NSLog(@"code = %@", code);
}
- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath{
    
    
    NSDictionary *news_dic = [std_data objectAtIndex:indexPath.row];
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
   delegate.modi_dic = news_dic;
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    
}

@end
