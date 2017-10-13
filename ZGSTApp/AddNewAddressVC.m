//
//  AddNewAddressVC.m
//  ZGSTApp
//
//  Created by tusm on 15/12/24.
//  Copyright © 2015年 fady. All rights reserved.
//

#import "AddNewAddressVC.h"

#define AddReuserOne @"addOneRes"
#define AddResSecond @"addSecondRes"

#import "AddressEditVC.h"
#import "AddOneCell.h"

@interface AddNewAddressVC ()<UITableViewDataSource,UITableViewDelegate>
{
    
}

@property (nonatomic,strong)UITableView *addTableView;

@end

@implementation AddNewAddressVC

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"添加收货地址";
    
    [self tableViewLayout];

    [self initNavigationBar];
    
}

-(void)initNavigationBar{
    //
    UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    
    cancelBtn.frame = CGRectMake(0, 0, 40, 30);
    
    [cancelBtn setTitle:@"确认" forState:0];
    
    [cancelBtn setTitleColor:[UIColor orangeColor] forState:0];
    
    [cancelBtn addTarget:self action:@selector(editsAction) forControlEvents:UIControlEventTouchUpInside];
    
    cancelBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    
    UIBarButtonItem *right = [[UIBarButtonItem alloc]initWithCustomView:cancelBtn];
    
    self.navigationItem.rightBarButtonItem = right;
    
}

-(void)tableViewLayout{
    
    _addTableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    
    _addTableView.delegate = self;
    _addTableView.dataSource = self;
    
    [_addTableView registerNib:[UINib nibWithNibName:@"AddOneCell" bundle:nil] forCellReuseIdentifier:AddReuserOne];
    
    [self.view addSubview:_addTableView];
    
}

#pragma mark----action
-(void)editsAction{
    
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark----tableview
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 2;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        NSArray *nameArr = @[@"姓名:",@"手机:"];
        NSArray *inputArr = @[@"请填写收货人姓名",@"请填写收货人手机号码"];
        
        AddOneCell *cell = [tableView dequeueReusableCellWithIdentifier:AddReuserOne];

        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.nameLB.text = nameArr[indexPath.row];
        cell.inputTF.placeholder = inputArr[indexPath.row];
        cell.inputTF.borderStyle = UITextBorderStyleNone;
        
        return cell;
    }else{
        
        NSArray *nameArr = @[@"小区:",@"楼牌号:"];
        NSArray *inputArr = @[@"请填写小区名",@"请填写楼牌号"];
        
        AddOneCell *cell = [tableView dequeueReusableCellWithIdentifier:AddReuserOne];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.nameLB.text = nameArr[indexPath.row];
        cell.inputTF.placeholder = inputArr[indexPath.row];
        cell.inputTF.borderStyle = UITextBorderStyleNone;

        
        return cell;
    }
    
    
    
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    
    if (section == 0) {
        return @"联系人";
    }else
        return @"收货地址";
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 25;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 50;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
