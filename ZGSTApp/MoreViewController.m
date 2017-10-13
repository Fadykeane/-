//
//  MoreViewController.m
//  ZGSTApp
//
//  Created by tusm on 15/12/21.
//  Copyright © 2015年 fady. All rights reserved.
//

#import "MoreViewController.h"

#define CellReuser @"cellReuser"

#import "EntertainmentVC.h"
#import "JoinVC.h"

@interface MoreViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *sortTable;
}
@end

@implementation MoreViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    self.tabBarController.tabBar.hidden = NO;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"更多";
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self tableViewLayout];
    [self headViewLayout];
}

-(void)tableViewLayout{
    sortTable = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, Screen_Width, Screen_Height) style:UITableViewStyleGrouped];
    
    sortTable.delegate = self;
    sortTable.dataSource = self;
    
    [sortTable registerClass:[UITableViewCell class] forCellReuseIdentifier:CellReuser];
    
    [self.view addSubview:sortTable];
}

#pragma mark----headerview
-(void)headViewLayout{
    
    
    UIView *headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, Screen_Width, 200)];
    
    headView.backgroundColor = [UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:1.0];
   
    //
    UIImageView *logoimage = [[UIImageView alloc]initWithFrame:CGRectMake(Screen_Width/2-50, 40, 100, 100)];
    
    logoimage.image = [UIImage imageNamed:@"AppIcon120x120"];
    
    [headView addSubview:logoimage];
    
//    logoimage.layer.borderColor = [UIColor orangeColor].CGColor;
//    logoimage.layer.borderWidth = 1;
    logoimage.layer.cornerRadius = 10;
    logoimage.layer.masksToBounds = YES;
    //
    UILabel *loginLB = [[UILabel alloc]initWithFrame:CGRectMake(Screen_Width/2-50, 150, 100, 20)];
    loginLB.text = @"中港外卖V1.0";
    loginLB.textAlignment = 1;
    loginLB.textColor = [UIColor darkGrayColor];
    loginLB.font = [UIFont systemFontOfSize:15];
    
    [headView addSubview:loginLB];
    
    
    sortTable.tableHeaderView = headView;
}

#pragma mark----tableview
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 7;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellReuser];

    NSArray *nameArr = @[@"我要加盟",@"新闻在线",@"校园招聘",@"校园论坛",@"校园游戏",@"检查更新",@"分享好友"];
    
            cell.textLabel.text = nameArr[indexPath.row];
            cell.textLabel.font = [UIFont systemFontOfSize:15];

    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
    
    
    
}



-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 50;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
        
        JoinVC *joinVC = [[JoinVC alloc]init];
        
        [self.navigationController pushViewController:joinVC animated:YES];
    }
    
    if (indexPath.row == 1) {
        
        EntertainmentVC *etVC = [EntertainmentVC new];
        
        [self.navigationController pushViewController:etVC animated:YES];
        
    }
    if (indexPath.row == 5) {
       
        UIAlertController *alertC = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"您现在使用的已经是最新版本了！" preferredStyle:UIAlertControllerStyleAlert];
        
        [alertC addAction:[UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleCancel handler:^(UIAlertAction *_Nonnull action){
            
        }]];
        
        [self presentViewController:alertC animated:YES completion:nil];

    }
    
    if (indexPath.row == 6) {
       
        UIAlertController *alertC = [UIAlertController alertControllerWithTitle:@"分享到" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
        
        [alertC addAction:[UIAlertAction actionWithTitle:@"微信好友" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            SendMessageToWXReq* req = [[SendMessageToWXReq alloc] init];
            req.text = @"人文的东西并不是体现在你看得到的方面，它更多的体现在你看不到的那些方面，它会影响每一个功能，这才是最本质的。但是，对这点可能很多人没有思考过，以为人文的东西就是我们搞一个很小清新的图片什么的。”综合来看，人文的东西其实是贯穿整个产品的脉络，或者说是它的灵魂所在。";
            //只发送文本信息？YES
            req.bText = YES;
            
            //发送文本消息到好友
            req.scene = WXSceneSession;
            
            [WXApi sendReq:req];
            
        }]];
        
        [alertC addAction:[UIAlertAction actionWithTitle:@"微信朋友圈" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            SendMessageToWXReq* req = [[SendMessageToWXReq alloc] init];
            req.text = @"人文的东西并不是体现在你看得到的方面，它更多的体现在你看不到的那些方面，它会影响每一个功能，这才是最本质的。但是，对这点可能很多人没有思考过，以为人文的东西就是我们搞一个很小清新的图片什么的。”综合来看，人文的东西其实是贯穿整个产品的脉络，或者说是它的灵魂所在。";
            //只发送文本信息？YES
            req.bText = YES;
            //发送文本消息到朋友圈
            req.scene = WXSceneTimeline;
            
            [WXApi sendReq:req];
            
        }]];
        
        [alertC addAction:[UIAlertAction actionWithTitle:@"QQ好友" style:UIAlertActionStyleDefault handler:nil]];
        [alertC addAction:[UIAlertAction actionWithTitle:@"QQ空间" style:UIAlertActionStyleDefault handler:nil]];
        [alertC addAction:[UIAlertAction actionWithTitle:@"新浪微博" style:UIAlertActionStyleDefault handler:nil]];
        
        [alertC addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
        
        [self presentViewController:alertC animated:YES completion:nil];
    }
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
