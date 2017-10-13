//
//  MyViewController.m
//  分段控件UISegementContrll
//
//  Created by tusm on 15/11/27.
//  Copyright © 2015年 fady. All rights reserved.
//

#import "MyViewController.h"

#define Reuser @"reuser"
#define CellReuser @"cellReuser"

#import "MyTableViewCell.h"
#import "SettingVC.h"
#import "MessageViewController.h"
#import "AddressEditVC.h"
#import "MyCollectVC.h"
#import "HelpsVC.h"
#import "LoginVC.h"

@interface MyViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    
    UITableView *sortTable;
    
}
@end

@implementation MyViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    self.tabBarController.tabBar.hidden = NO;

}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的";
    self.view.backgroundColor = [UIColor whiteColor];
    self.edgesForExtendedLayout = UIRectEdgeNone;
  
    [self initNavigationBar];
    [self tableViewLayout];
    [self headViewLayout];
  

}

-(void)tableViewLayout{
    sortTable = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, Screen_Width, Screen_Height-44-64) style:UITableViewStyleGrouped];
    
    sortTable.delegate = self;
    sortTable.dataSource = self;
    
    [sortTable registerNib:[UINib nibWithNibName:@"MyTableViewCell" bundle:nil] forCellReuseIdentifier:Reuser];
    
    [sortTable registerClass:[UITableViewCell class] forCellReuseIdentifier:CellReuser];
    
    [self.view addSubview:sortTable];
}

#pragma mark----headerview
-(void)headViewLayout{

    
    UIView *headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, Screen_Width, 170)];
   
    headView.backgroundColor = [UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:1.0];
    //
    UIImageView *image = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, Screen_Width, 130)];
    
//    image.image = [UIImage imageNamed:@"mao"];
    
    [headView addSubview:image];
    //添加点击事件
    UITapGestureRecognizer *tapViewGes = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(loginAction)];
    image.userInteractionEnabled = YES;
    
    [image addGestureRecognizer:tapViewGes];
    //
    UIImageView *logoimage = [[UIImageView alloc]initWithFrame:CGRectMake(Screen_Width/2-40, 20, 80, 80)];
    
    logoimage.image = [UIImage imageNamed:@"AppIcon120x120"];
    
    [headView addSubview:logoimage];

//    logoimage.layer.borderColor = [UIColor orangeColor].CGColor;
//    logoimage.layer.borderWidth = 1;
    logoimage.layer.cornerRadius = 40;
    logoimage.layer.masksToBounds = YES;
//
    UILabel *loginLB = [[UILabel alloc]initWithFrame:CGRectMake(Screen_Width/2-40, 75, 80, 80)];
    loginLB.text = @"注册/登录";
    loginLB.textAlignment = 2;
    loginLB.textColor = [UIColor darkGrayColor];
    loginLB.font = [UIFont boldSystemFontOfSize:17];
    
    [headView addSubview:loginLB];
    //
    NSArray *arr = @[@"中港钱包:￥10元",@"中港红包: 18个",@"中港代金券:3张"];
    CGFloat threeBtnWidth = Screen_Width/3;
    
    for (int i = 0; i<3; i++) {
        
        UIButton *lognBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        lognBtn.backgroundColor = [UIColor colorWithRed: (0/255.0 ) green: (0/255.0) blue: (0/255.0) alpha:0.3];
        lognBtn.frame = CGRectMake(i*threeBtnWidth, 130, threeBtnWidth, 40);
        lognBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        
        [lognBtn addTarget:self action:@selector(threeAction:) forControlEvents:UIControlEventTouchUpInside];
        
        [lognBtn setTitleColor:[UIColor whiteColor] forState:0];
        [lognBtn setTitle:arr[i] forState:0];
        [headView addSubview:lognBtn];
    }
    
    
    sortTable.tableHeaderView = headView;
}
#pragma mark-----导航栏布局
-(void)initNavigationBar{
    //
    UIButton *leftNavi = [UIButton buttonWithType:UIButtonTypeSystem];
    
    leftNavi.frame = CGRectMake(0, 0, 40, 30);
    
    [leftNavi setTitle:@"设置" forState:0];
    
    [leftNavi setTitleColor:[UIColor lightGrayColor] forState:0];
    
    [leftNavi addTarget:self action:@selector(settingAction:) forControlEvents:UIControlEventTouchUpInside];
    
    leftNavi.titleLabel.font = [UIFont systemFontOfSize:15];
    
    UIBarButtonItem *left = [[UIBarButtonItem alloc]initWithCustomView:leftNavi];
    
    self.navigationItem.leftBarButtonItem = left;
    //
    UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    
    cancelBtn.frame = CGRectMake(0, 0, 40, 30);
    
    [cancelBtn setTitle:@"消息" forState:0];
    
    [cancelBtn setTitleColor:[UIColor lightGrayColor] forState:0];
    
    [cancelBtn addTarget:self action:@selector(messageAction) forControlEvents:UIControlEventTouchUpInside];
    
    cancelBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    
    UIBarButtonItem *right = [[UIBarButtonItem alloc]initWithCustomView:cancelBtn];
    
    self.navigationItem.rightBarButtonItem = right;
}
#pragma mark----action
-(void)settingAction:(UIButton *)sender{

    SettingVC *settingVC = [[SettingVC alloc]init];
    
    [self.navigationController pushViewController:settingVC animated:YES];
}

-(void)loginAction{
    
    LoginVC *loginVC = [LoginVC new];
    
    [self.navigationController pushViewController:loginVC animated:YES];
    
}

-(void)threeAction:(UIButton *)sender{
    
}

-(void)messageAction{
    
    MessageViewController *messageVC = [[MessageViewController alloc]init];
    
    [self.navigationController pushViewController:messageVC animated:YES];
    
}
#pragma mark----tableview
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 4;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section != 3) {
        MyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:Reuser];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        if (indexPath.section == 0) {
            cell.titleLabel.text = @"管理收货地址";
            cell.iconImage.image = [UIImage imageNamed:@"dizhi"];
            cell.moreLabel.text = @"查看我的收货地址";
            
        }else if (indexPath.section == 1){
            cell.titleLabel.text = @"我的收藏";
            cell.iconImage.image = [UIImage imageNamed:@"shoucang"];
            cell.moreLabel.text = @" 查看我的收藏";
        }else if (indexPath.section == 2){
            cell.titleLabel.text = @"帮助与反馈";
            cell.iconImage.image = [UIImage imageNamed:@"bangzhu"];
            cell.moreLabel.text = @" 查看详情";
        }
        return cell;

    }else{
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellReuser];
        
        cell.textLabel.textAlignment = 1;
        cell.textLabel.text = @"客服电话：400-850-7777";
        cell.textLabel.textColor = [UIColor orangeColor];
        cell.textLabel.font = [UIFont systemFontOfSize:15];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;

        return cell;
    }
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 15;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section == 3) {
        return 50;
    }else
        return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 50;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        AddressEditVC *addressVC = [[AddressEditVC alloc]init];
        
        [self.navigationController pushViewController:addressVC animated:YES];
        
    }
    
    if (indexPath.section == 1) {
        MyCollectVC *collectVC = [[MyCollectVC alloc]init];
        
        [self.navigationController pushViewController:collectVC animated:YES];
        
    }
    
    if (indexPath.section == 2) {
        HelpsVC *helpVC = [[HelpsVC alloc]init];
        
        [self.navigationController pushViewController:helpVC animated:YES ];
        
    }
 }

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    if (section == 3) {
        UILabel *loginLB = [[UILabel alloc]initWithFrame:CGRectMake(Screen_Width/2-50, 0, 100, 20)];
        loginLB.text = @"服务时间：9：00-23：00";
        loginLB.textAlignment = 1;
        loginLB.textColor = [UIColor lightGrayColor];
        loginLB.font = [UIFont boldSystemFontOfSize:15];
//        loginLB.backgroundColor = [UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:1.0];
        
        return loginLB;

    }else
        return nil;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
