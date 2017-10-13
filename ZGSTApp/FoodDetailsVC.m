//
//  FoodDetailsVC.m
//  ZGSTApp
//
//  Created by tusm on 15/12/24.
//  Copyright © 2015年 fady. All rights reserved.
//

#import "FoodDetailsVC.h"

#define FoodReusr @"foodReuser"
#define CellReuser @"cellReuser"

#import "FoodDetailsCell.h"
#import "PayViewController.h"

@interface FoodDetailsVC ()<UITableViewDelegate,UITableViewDataSource>
{
    UIView *totalBar;
    
    UILabel *totalLabel;
    
}
@property (nonatomic,strong)UITableView *tableView;

@property (nonatomic,strong)NSMutableArray *cellArr;

@end

@implementation FoodDetailsVC

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self totalBarLayout];
    
    for (FoodDetailsCell *cell in self.cellArr) {
        cell.numLB.text = @"0";
        cell.numLB.hidden = YES;
        cell.lessBtn.hidden = YES;
    }
     self.cellArr = [NSMutableArray array];
    [_tableView reloadData];
    
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    [totalBar removeFromSuperview];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"";
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    [self tableViewLayout];

    [self headerViewLayout];
    
    [self navigationLayout];
    
}

#pragma mark----导航栏布局
-(void)navigationLayout{
    
    //作为最右边的搜索图标
    UIButton *searchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    searchBtn.frame = CGRectMake(20, 0, 44, 44);
    
    [searchBtn setTitleShadowColor:[UIColor whiteColor] forState:UIControlStateSelected];
    
    [searchBtn setImage:[UIImage imageNamed:@"home1"] forState:0];
    
    [searchBtn addTarget:self action:@selector(searchAction) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *searchBarBtn = [[UIBarButtonItem alloc] initWithCustomView:searchBtn];
    
    self.navigationItem.rightBarButtonItem = searchBarBtn;
    
}

-(void)searchAction{
    [self.navigationController popToRootViewControllerAnimated:YES];
    
}
#pragma mark----tableViewLayout
-(void)tableViewLayout{
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, Screen_Width, Screen_Height) style:UITableViewStylePlain];
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    [self.view addSubview:_tableView];
    
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:CellReuser];
    
    [_tableView registerNib:[UINib nibWithNibName:@"FoodDetailsCell" bundle:nil] forCellReuseIdentifier:FoodReusr];
    
    
    _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    //    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
}

#pragma mark-----轮播scrollview
-(void)headerViewLayout{
    //    表头
    UIImageView *headerimage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, Screen_Width, 150)];
        
        headerimage.image = [UIImage imageNamed:@"food"];

    _tableView.tableHeaderView = headerimage;
    
}

#pragma mark----- 自定义去结算栏
-(void)totalBarLayout{
    
    totalBar = [[UIView alloc]initWithFrame:CGRectMake(0, Screen_Height-44, Screen_Width, 44)];
    totalBar.backgroundColor = [UIColor whiteColor];
    
    [self.tabBarController.view addSubview:totalBar];
    
    //
    CGFloat perWidth = (Screen_Width)/3;
    //合计显示
    totalLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, perWidth, 30)];
    totalLabel.text = @"合计￥0.00";
    totalLabel.textAlignment = 0 ;
    totalLabel.textColor = [UIColor redColor];
    totalLabel.font = [UIFont systemFontOfSize:18];
    [totalBar addSubview:totalLabel];
    //
    UILabel *servePrice = [[UILabel alloc]initWithFrame:CGRectMake(15+perWidth, 10, perWidth-25, 30)];
    servePrice.text = @"另需配送费5元";
    servePrice.textAlignment = 0 ;
    servePrice.textColor = [UIColor lightGrayColor];
    servePrice.font = [UIFont systemFontOfSize:13];
    [totalBar addSubview:servePrice];
    
    //去结算按键
    UIButton *payBtn = [UIButton new];
    
    payBtn.frame = CGRectMake(Screen_Width-perWidth, 0, perWidth, 44);
    payBtn.backgroundColor = [UIColor redColor];
    payBtn.tintColor = [UIColor whiteColor];
    payBtn.titleLabel.textColor = [UIColor blackColor];
    payBtn.titleLabel.textAlignment = 1;
    payBtn.titleLabel.font = [UIFont boldSystemFontOfSize:20];
    [totalBar addSubview:payBtn];
    [payBtn setTitle:@"去结算" forState:0];
    [payBtn addTarget:self action:@selector(payAction:) forControlEvents:UIControlEventTouchUpInside];
    
}

#pragma mark------金钱算法
//结算方法和全选
-(void)payAction:(UIButton *)sender{
    
    PayViewController *payView = [[PayViewController alloc]init];
    
    payView.totalValueStr = totalLabel.text;

    [self.navigationController pushViewController:payView animated:YES];
    
}

//数量减1
-(void)lessBtnAction:(UIButton *)sender{
    
    FoodDetailsCell *cell = [self.cellArr objectAtIndex:sender.tag];
    int i = [cell.numLB.text intValue];
    
    if (i >= 1) {
        
        i --;
        //点击后计算总金钱
        
        NSString *firstLabel = [totalLabel.text substringWithRange:NSMakeRange(4, totalLabel.text.length-4)];
        
        float _totalValue = [firstLabel floatValue];
        
        _totalValue = _totalValue - [cell.perPriceLB.text floatValue];
        
        totalLabel.text = [NSString stringWithFormat:@"合计:￥%0.2f",_totalValue];
        
       
        
    }
    
    //让Cell中num值等于i这个全局变量
    cell.numLB.text = [NSString stringWithFormat:@"%d",i];
    
}

//数量加1
-(void)moreBtnAction:(UIButton *)sender{
    
    FoodDetailsCell *cell = [self.cellArr objectAtIndex:sender.tag-1000];
    //显示出来
    cell.lessBtn.hidden = NO;
    cell.numLB.hidden = NO;
    
    int i = [cell.numLB.text intValue];
    i++;
    cell.numLB.text = [NSString stringWithFormat:@"%d",i];
    
    //计算总金钱
    NSString *firstLabel = [totalLabel.text substringWithRange:NSMakeRange(4, totalLabel.text.length-4)];
    
    float _totalValue = [firstLabel floatValue];
    
    _totalValue = _totalValue + [cell.perPriceLB.text floatValue];
    
    totalLabel.text = [NSString stringWithFormat:@"合计:￥%0.2f",_totalValue];
    
    
}

#pragma mark----tableview
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 2;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
        FoodDetailsCell *cell = [tableView dequeueReusableCellWithIdentifier:FoodReusr];
        
        cell.perPriceLB.text = @"16.00";
        cell.numLB.text = @"0";
        cell.lessBtn.tag = indexPath.row;
        cell.moreBtn.tag = indexPath.row +1000;
        
        [cell.lessBtn addTarget:self action:@selector(lessBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        
        [cell.moreBtn addTarget:self action:@selector(moreBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        //加入全局数组中
        [self.cellArr addObject:cell];
        //
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.textLabel.font = [UIFont systemFontOfSize:15];
        
        return cell;
    }else{
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellReuser];
        
        cell.textLabel.text = @"鲜辣排骨饭";
        cell.textLabel.font = [UIFont systemFontOfSize:15];
        
        return cell;
    }
    
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        return 105;
    }else{
        return 50;
    }
    
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
