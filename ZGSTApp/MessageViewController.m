//
//  MessageViewController.m
//  MallApp
//
//  Created by tusm on 15/12/9.
//  Copyright © 2015年 fady. All rights reserved.
//

#import "MessageViewController.h"

#define messageReusr @"messagereser"

#import "MessageCell.h"
#import "ChatViewController.h"

@interface MessageViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong)UITableView *messageTable;

@end

@implementation MessageViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    self.tabBarController.tabBar.hidden = YES;
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    self.tabBarController.tabBar.hidden = NO;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"消息中心";
    
    [self messageTableLayout];
    
}

-(void)messageTableLayout{
    
    _messageTable = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    _messageTable.delegate = self;
    _messageTable.dataSource = self;
    
    [_messageTable registerNib:[UINib nibWithNibName:@"MessageCell" bundle:nil] forCellReuseIdentifier:messageReusr];
    
    [self.view addSubview:_messageTable];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 3;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSArray *nameArr = @[@"真功夫（中山华润万家）",@"麦当劳",@"肯德基（宅急送）"];
    NSArray *imageArr = @[[UIImage imageNamed:@"zhengongfu"],[UIImage imageNamed:@"maidanglao"],[UIImage imageNamed:@"kendeji"]];
    //
    MessageCell *cell = [tableView dequeueReusableCellWithIdentifier:messageReusr];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.headImage.image = imageArr[indexPath.row];
    cell.headLine.text = nameArr[indexPath.row];
    
    return cell;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 15;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 70;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
        ChatViewController *chatView = [[ChatViewController alloc]init];
        
        [self.navigationController pushViewController:chatView animated:YES];
        
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
