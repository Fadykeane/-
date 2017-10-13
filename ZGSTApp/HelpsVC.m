//
//  HelpsVC.m
//  ZGSTApp
//
//  Created by tusm on 15/12/24.
//  Copyright © 2015年 fady. All rights reserved.
//

#import "HelpsVC.h"

#define HelpReuser @"helpReuser"

@interface HelpsVC ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong)UITableView *tableView;

@end

@implementation HelpsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"";
    self.view.backgroundColor = [UIColor whiteColor];
    

    [self tableViewLayout];
    
}

-(void)tableViewLayout{
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, Screen_Width, Screen_Height) style:UITableViewStylePlain];
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    [self.view addSubview:_tableView];
    
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:HelpReuser];
    
    _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    //    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
}

#pragma mark----tableview
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 3;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:HelpReuser];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    cell.textLabel.font = [UIFont systemFontOfSize:15];
    
    if (indexPath.row == 0) {
        
        cell.textLabel.text = @"在线客服";
        
    }else if (indexPath.row == 1){
        
        cell.textLabel.text = @"意见反馈";
        
    }else if (indexPath.row == 2){
        
        cell.textLabel.text = @"常见问题";
    }
    return cell;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 50;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
