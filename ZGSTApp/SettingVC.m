//
//  SettingVC.m
//  ZGSTApp
//
//  Created by tusm on 15/12/28.
//  Copyright © 2015年 fady. All rights reserved.
//

#import "SettingVC.h"

#define SetReuser @"setReusr"

#import "SetCell.h"

@interface SettingVC ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic ,strong)UITableView *settingTable;

@end

@implementation SettingVC

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"设置";
    
    [self tableViewLayout];

}

-(void)tableViewLayout{
    _settingTable = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    
    _settingTable.delegate = self;
    _settingTable.dataSource =self;
    
    [self.view addSubview:_settingTable];
    
    [_settingTable registerNib:[UINib nibWithNibName:@"SetCell" bundle:nil] forCellReuseIdentifier:SetReuser];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 3;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    SetCell *cell = [tableView dequeueReusableCellWithIdentifier:SetReuser];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    //    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    cell.optionSwitch.on = YES;
    [cell.optionSwitch addTarget:self action:@selector(setSwitchAction:) forControlEvents:UIControlEventValueChanged];
    if (indexPath.row == 0) {
        cell.setLB.text = @"红包到账提醒";
    }else if (indexPath.row == 1){
        cell.setLB.text = @"消息推送";
    }else{
        cell.setLB.text = @"送达提醒";
        
    }
    
    return cell;
    
}

#pragma mark---ActionButton
-(void)setSwitchAction:(UISwitch *)sender{
    if (sender.on == YES) {
        //        NSLog(@"yes");
    }else{
        //        NSLog(@"on");
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 15;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 80;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    
    
    
}


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
