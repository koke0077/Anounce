//
//  F_Q_Controller.m
//  Anounce_Note
//
//  Created by kimsung jun on 2016. 3. 27..
//  Copyright © 2016년 kimsung jun. All rights reserved.
//

#import "F_Q_Controller.h"

@interface F_Q_Controller (){
    
    NSMutableArray *myArray2;
    NSMutableArray *myArray;
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;
- (IBAction)send_btn:(UIButton *)sender;

@end

@implementation F_Q_Controller

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated{
    
    myArray = [[NSMutableArray alloc]init];
    
    [myArray removeAllObjects];
    
    NSString *str1 = @"  사용자등록 - 지역으로 학교검색 또는 이름으로 검색 - 학교등록 버튼(➕)을 클릭하면 새로운 학교를 등록할 수 있습니다.";
    NSString *str2 = @"  담임선생님께서 학급홈페이지나 새미학급에 있는 알림장 게시판에 게시물을 올려놓지 않을경우 나오는 메세지 입니다. 간혹 앱에서 학급홈페이지에 있는 알림 내용을 가져오지 못하는 경우도 있습니다. 그럴 경우 지원팀에 연락을 취하셔서 도움을 받으십시오.";
    NSString *str3 = @"  현재 학교홈페이지의 게시판마다 각각의 ID가 부여되는데 그러다보니 프로그램만으로는 이를 모두 분류해내기가 다소 어려운 상황입니다. \n 따라서 다소 귀찮더라도 새로운 학년과 반으로 등록하셔서 사용해주시기 바랍니다.";
    NSString *str4 = @"  사용자분의 아이폰 메모리가 감당하는 범위 안에서 무제한으로 추가할 수 있습니다. 하지만 너무 많은 학생들을 등록하면 오히려 더 불편하실겁니다. 그러니 필요한 수만큼만 등록해서 사용하는 것이 좋겠죠?";
    NSString *str5 = @"  학교식단은 보이는데 나머지가 보이지 않는다는 것은 크게 두 가지일 가능성이 있습니다.\n  하나는 학교홈페이지 서버가 문제가 생겨 네트워크 장애가 생겼을 경우입니다. \n  다른 하나는 투데이 알림장 앱에서 그와 같은 정보를 제대로 처리하지 못할 경우입니다. 그러한 경우 지원팀에 장애와 관련한 사항을 보내주시면 다음 업데이트 때 반영하여 오류를 수정해 나갈 수 있도록 하겠습니다.";
    NSString *str6 = @"  등록된 사용자를 삭제하는 방법은 다음과 같습니다.\n  1.학생관리 - 편집 을 클릭하면 🔴와 비슷한 버튼이 생깁니다. 그것을 누르면 오른쪽에 Delete와 함께 삭제할 수 있는 버튼이 생깁니다. 이때 왼쪽으로 밀어주면 삭제가 됩니다. \n  2. 삭제하고자 하는 학생을 왼쪽으로 스위이프를 하면 오른쪽에 Delete와 함게 삭제할 수 있는 버튼이 생깁니다. 이때 왼쪽으로 밀어주면 삭제가 됩니다.";
    NSString *str7 = @"  학생관리에 들어가면 각 셀마다 i 가 있습니다. 이 버튼을 터치하면 사용자의 이름을 바꿀 수 있는 창이 열립니다. 단, 사용자의 이름만 바꿀 수 있습니다. 학년과 반이 같이 표시되지만 수정은 할 수 없습니다.ㅜ ㅜ";
    NSString *str8 = @"  배경이 촌스러워 죄송합니다.ㅜㅜ 향후 업데이트 될 때에는 다양한 배경을 사용자가 직접 선택해서 변경하여 사용할 수 있도록 할 방침에 있습니다. 조금만 기다려주세요.";
    NSString *str9 = @"  사용자 사진은 얼마든지 삽입, 변경이 가능합니다. \n  학생관리에 들어가시면 ⌈이미지바꾸기⌋가 있습니다. 이 버튼을 터치하면 원하는 사진으로 변경이 가능합니다.";
    NSString *str10 = @"  학교 공지사항에는 생각보다 많은 게시물이 올라옵니다. 그 중에는 첨부문서가 있는 경우도 많습니다. \n  학교 공지사항에 들어가보시면 오른쪽 상단에 ⌈첨부파일⌋ 버튼이 있습니다. 그것을 터치하면 아래쪽에 첨부파일을 볼 수 있는 작은 창이 올라옵니다. 그 중에서 보고자 하는 첨부파일을 터치하여 보시면 됩니다. 단, 첨부파일이 없는 게시물일 경우 ⌈첨부파일이 없습니다⌋라는 글이 나타납니다.";
    
    [myArray addObject:str1];
    [myArray addObject:str2];
    [myArray addObject:str3];
    [myArray addObject:str4];
    [myArray addObject:str5];
    [myArray addObject:str6];
    [myArray addObject:str7];
    [myArray addObject:str8];
    [myArray addObject:str9];
    [myArray addObject:str10];
    
    myArray2 = [NSMutableArray arrayWithCapacity:0]; //myArray2 초기화
    for (int a = 0; a < myArray.count; a++) {       //myArray2 초기화
        [myArray2 addObject:@"0"];                   //myArray2 초기화
    }
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self.tableView reloadData];
}



-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 10;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString* CellIdentifier = @"cell";
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
    }
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.minimumLineHeight = 35.f;
    paragraphStyle.maximumLineHeight = 35.f;
    
    UITextView *txtV = [[UITextView alloc]initWithFrame:CGRectMake(0, 0, cell.frame.size.width, 150)];
    txtV.delegate = self;
    NSString *string = [myArray objectAtIndex:indexPath.section];
    NSDictionary *attributtes = @{
                                  NSParagraphStyleAttributeName : paragraphStyle,
                                  };
    txtV.attributedText = [[NSAttributedString alloc] initWithString:string
                                                                   attributes:attributtes];
    
    [txtV setFont:[UIFont systemFontOfSize:18]];
    txtV.editable = NO;
    [cell addSubview:txtV];
   
//    NSLog(@"%d", (int)indexPath.row);
    
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
//    UIImage *img1 = [UIImage imageNamed:@"1592"];
//    UIImage *img2 = [UIImage imageNamed:@"1593"];
//    UIImage *img3 = [UIImage imageNamed:@"1594"];
//    UIImage *img4 = [UIImage imageNamed:@"1595"];
//    UIImage *img5 = [UIImage imageNamed:@"1596"];
//    UIImage *img6 = [UIImage imageNamed:@"1597"];
//    UIImage *img7 = [UIImage imageNamed:@"1598"];
    NSString *str1 = @"등록되어 있지 않는 학교라고 나와요.";
    NSString *str2 = @"알림장을 열면 담임선생님께 문의하라고 나와요.";
    NSString *str3 = @"학년이나 반이 바뀌게 되면 어떻게 하죠?";
    NSString *str4 = @"몇 명까지 추가하여 볼 수 있나요?";
    NSString *str5 = @"학교식단만 볼 수 있고 나머지는 안보여요.";
    NSString *str6 = @"등록된 사용자는 어떻게 삭제 하나요?";
    NSString *str7 = @"학생 이름을 바꾸고 싶어요.";
    NSString *str8 = @"배경이 촌스러워요. 사용자가 바꿀 수 없나요?";
    NSString *str9 = @"사용자 사진을 삽입할 수 있나요?";
    NSString *str10 = @"게시물에 있는 첨부파일은 어떻게 보나요?";
    
    NSArray *strArray = [[NSArray alloc]initWithObjects:str1, str2, str3, str4, str5, str6, str7, str8, str9, str10, nil];
    
    UIButton* buttonA = [UIButton buttonWithType:UIButtonTypeCustom];
    buttonA.frame = CGRectMake(0, 20, 320, 44);
 
    //    [buttonA setTitle:[self.arrayA objectAtIndex:section] forState:UIControlStateNormal];
//    [buttonA setTitle:[imgArray objectAtIndex:section] forState:UIControlStateNormal];
    if (section%2 == 0) {
        buttonA.backgroundColor = [UIColor darkGrayColor];
    }else{
        buttonA.backgroundColor = [UIColor lightGrayColor];
    }
    
    
    
    buttonA.titleLabel.textColor = [UIColor blackColor];
    buttonA.titleLabel.textAlignment = 0;
    buttonA.tag = section;
    
    [buttonA addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel *lbl = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, self.tableView.frame.size.width-5, 50)];
    lbl.text = [strArray objectAtIndex:section];
    lbl.textColor = [UIColor whiteColor];
    lbl.font = [UIFont boldSystemFontOfSize:19];
    [buttonA addSubview:lbl];
    
    [lbl setAdjustsFontSizeToFitWidth:YES];
    return buttonA;
    
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 60.0f;
    //    return 100;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}





- (void)buttonPressed:(UIButton *)sender {
    
    
    
    NSString* aKey = [myArray2 objectAtIndex:sender.tag];
    
    if ([aKey isEqualToString:@"0"]) {
        [myArray2 replaceObjectAtIndex:sender.tag withObject:@"1"];
        [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:sender.tag] withRowAnimation:UITableViewRowAnimationAutomatic];
        
//                _tableView.rowHeight = 0;
        
        
    } else {
        [myArray2 replaceObjectAtIndex:sender.tag withObject:@"0"];
        [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:sender.tag] withRowAnimation:UITableViewRowAnimationAutomatic];
        
//              _tableView.rowHeight = 343;
    }
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if ([[myArray2 objectAtIndex:section] isEqualToString:@"0"]) {
        return 0;
    } else {
 
        return 1;
    }
}

- (void)showEmail {
    
    NSString *emailTitle = @"투데이 알림장 문의";
    NSString *messageBody = @"오류학교:  \n\n\n 오류사항(자세히): \n\n\n 건의사항 : \n\n\n\n  이 외에 문제가 발견되면 자세히 적어서 보내주시면 향후 업데이트를 할 때 적극 반영하도록 하겠습니다.";
    NSArray *toRecipents = [NSArray arrayWithObject:@"medicochu@korea.kr"];
    NSArray *toRecipents2 = [NSArray arrayWithObject:@"koke0077@gmail.com"];
    
    MFMailComposeViewController *mc = [[MFMailComposeViewController alloc] init];
    
    mc.mailComposeDelegate = self;
    
    if ([MFMailComposeViewController canSendMail]) {
//    mc.mailComposeDelegate = self;
    [mc setSubject:emailTitle];
    [mc setMessageBody:messageBody isHTML:NO];
    [mc setToRecipients:toRecipents];
    [mc setCcRecipients:toRecipents2];
    

    [self presentViewController:mc animated:YES completion:NULL];
    }
    
}

- (void) mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    switch (result)
    {
        case MFMailComposeResultCancelled:
            NSLog(@"Mail cancelled");
            break;
        case MFMailComposeResultSaved:
            NSLog(@"Mail saved");
            break;
        case MFMailComposeResultSent:
            NSLog(@"Mail sent");
            break;
        case MFMailComposeResultFailed:
            NSLog(@"Mail sent failure: %@", [error localizedDescription]);
            break;
        default:
            break;
    }
    
    // Close the Mail Interface
    [self dismissViewControllerAnimated:YES completion:NULL];
}


- (IBAction)send_btn:(UIButton *)sender {
    
    [self showEmail];
}
@end
