//
//  OrderDetailViewController.m
//  ZGSTApp
//
//  Created by tusm on 15/12/23.
//  Copyright © 2015年 fady. All rights reserved.
//

#import "OrderDetailViewController.h"

#define OrderOne @"orderOne"
#define OrderTwo @"orderTwo"
#define OrderThree @"orderThree"
#define OrderSendMesRes @"orderSendMesReuser"


#import "OrderDetailCell.h"
#import "SellerViewController.h"
#import "OrderTwoCell.h"
#import "OrderThreeCell.h"
#import "SellerViewController.h"
#import "OrderSendMesCell.h"

@interface OrderDetailViewController ()<UITableViewDataSource,UITableViewDelegate,UIActionSheetDelegate>
{
    UIView *oneMoreBar;
    
}
@property (nonatomic,strong)UITableView *tableView;

@end

@implementation OrderDetailViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    self.tabBarController.tabBar.hidden = YES;
    
    [self oneMoreLayout];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    self.tabBarController.tabBar.hidden = NO;
    
    [oneMoreBar removeFromSuperview];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"订单详情";
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self navigationLayout];
    [self tableViewLayout];

}
#pragma mark----share
-(void)navigationLayout{
    //
    UIButton *shareBtn = [UIButton new];
    
    shareBtn.frame = CGRectMake(0, 0, 30, 30);
    [shareBtn setImage:[[UIImage imageNamed:@"share_01"]  resizableImageWithCapInsets:UIEdgeInsetsMake(0, 0, 0, 0) resizingMode:UIImageResizingModeStretch] forState:0];
    
    [shareBtn addTarget:self action:@selector(shareAction:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *shareBarItem = [[UIBarButtonItem alloc]initWithCustomView:shareBtn];
    //
    UIButton *callBtn = [UIButton new];
    
    callBtn.frame = CGRectMake(0, 0, 60, 60);
    [callBtn setImage:[[UIImage imageNamed:@"call_01"]  resizableImageWithCapInsets:UIEdgeInsetsMake(0, 0, 0, 0) resizingMode:UIImageResizingModeStretch] forState:0];
    
    [callBtn addTarget:self action:@selector(callAction) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *callBarItem = [[UIBarButtonItem alloc]initWithCustomView:callBtn];
    self.navigationItem.rightBarButtonItems = @[callBarItem,shareBarItem];
    
}

#pragma mark -微信分享
-(void)shareAction:(UIButton *)sender{
    
//    新的Alert提示框写法
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

//
-(void)callAction{
        
    UIAlertController *alertC = [UIAlertController alertControllerWithTitle:@"联系卖家" message:@"确认呼叫189-289-10361" preferredStyle:UIAlertControllerStyleAlert];

    [alertC addAction:[UIAlertAction actionWithTitle:@"是的" style:UIAlertActionStyleDefault handler:^(UIAlertAction *_Nonnull action){
        
    }]];
    
    [alertC addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *_Nonnull action){
        
    }]];
    
    [self presentViewController:alertC animated:YES completion:nil];

}

#pragma mark----tableview
-(void)tableViewLayout{
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, Screen_Width, Screen_Height) style:UITableViewStyleGrouped];
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    [self.view addSubview:_tableView];
    
    [_tableView registerNib:[UINib nibWithNibName:@"OrderDetailCell" bundle:nil] forCellReuseIdentifier:OrderOne];
    
    [_tableView registerNib:[UINib nibWithNibName:@"OrderTwoCell" bundle:nil] forCellReuseIdentifier:OrderTwo];
    
    [_tableView registerNib:[UINib nibWithNibName:@"OrderThreeCell" bundle:nil] forCellReuseIdentifier:OrderThree];
    
    [_tableView registerNib:[UINib nibWithNibName:@"OrderSendMesCell" bundle:nil] forCellReuseIdentifier:OrderSendMesRes];
    
    _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];

}

#pragma mark---再来一单
-(void)oneMoreLayout{
    
    oneMoreBar = [[UIView alloc]initWithFrame:CGRectMake(0, Screen_Height-44, Screen_Width, 44)];
    oneMoreBar.backgroundColor = [UIColor whiteColor];
    
    [self.tabBarController.view addSubview:oneMoreBar];
    
    UIButton *oneMoreBtn = [UIButton new];
    
    [oneMoreBtn setTitle:@"再来一单" forState:0];
    [oneMoreBtn setTitleColor:[UIColor darkGrayColor] forState:0];
    [oneMoreBtn addTarget:self action:@selector(oneMoreAction) forControlEvents:UIControlEventTouchUpInside];
    oneMoreBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    oneMoreBtn.backgroundColor = [UIColor orangeColor];
    oneMoreBtn.frame = CGRectMake(10, 5, oneMoreBar.frame.size.width-20, oneMoreBar.frame.size.height-10);
    
    [oneMoreBar addSubview:oneMoreBtn];
    
}

-(void)oneMoreAction{
    
    SellerViewController *sellerVC = [[SellerViewController alloc]init];
    
    [self.navigationController pushViewController:sellerVC animated:YES];
    
}
#pragma mark----tableview
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (section == 0) {
        return 5;
    }else
    return 3;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            OrderDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:OrderOne];
            
            cell.nameLabel.text = @"台北·御·便当";
            cell.nameLabel.font = [UIFont systemFontOfSize:15];
            cell.perPrice.text = @"";
            cell.totalPrice.text = @"";
            
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            return cell;
        }else if(indexPath.row == 1){
            
            OrderDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:OrderOne];
            
            cell.nameLabel.text = @"辣鸡翅饭";
            cell.perPrice.text = @"￥16*2";
            cell.totalPrice.text = @"￥32";
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            return cell;
            
        }else if(indexPath.row == 2){
            OrderDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:OrderOne];
            
            cell.nameLabel.text = @"配送费";
            cell.perPrice.text = @"";
            cell.totalPrice.text = @"￥0";
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            return cell;
        }else if(indexPath.row == 3){
            OrderTwoCell *cell = [tableView dequeueReusableCellWithIdentifier:OrderTwo];
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            return cell;
            
        }else{
            OrderThreeCell *cell = [tableView dequeueReusableCellWithIdentifier:OrderThree];
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            return cell;
        }
        //第二分区
    }else if (indexPath.section == 1){
        NSArray *nameArr = @[@"期望时间",@"配送地址",@"配送服务"];
        NSArray *mesArr = @[@"立即配送",@"王先生 中山市东区大鳌溪新村十街八号",@"本订单由中港速递提供配送服务"];
        OrderSendMesCell *cell = [tableView dequeueReusableCellWithIdentifier:OrderSendMesRes];
        
        cell.nameLB.text = nameArr[indexPath.row];
        cell.mesLb.text = mesArr[indexPath.row];
        
        return cell;
        
        //第三分区
    }else{
        NSArray *nameArr = @[@"订单号码",@"订单时间",@"支付方式"];
        NSArray *mesArr = @[@"3155 6678 8890 8888",@"2015-12-24",@"在线支付"];
        OrderSendMesCell *cell = [tableView dequeueReusableCellWithIdentifier:OrderSendMesRes];
        
        cell.nameLB.text = nameArr[indexPath.row];
        cell.mesLb.text = mesArr[indexPath.row];
        
        return cell;
    }
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    NSArray *headArr = @[@"订单详情",@"配送信息",@"订单信息"];
    
    return headArr[section];
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 30;
    }else
    return 50;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 1;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row >=0&&indexPath.row <3){
        return 40;
    }else if(indexPath.row == 3){
        return 70;
    }else{
        return 45;
    }
   
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0&&indexPath.section == 0) {
        
        SellerViewController *sellerVC = [SellerViewController new];
        
        [self.navigationController pushViewController:sellerVC animated:YES];
        
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
