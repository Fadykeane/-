//
//  SellerViewController.m
//  ZGSTApp
//
//  Created by tusm on 15/12/22.
//  Copyright © 2015年 fady. All rights reserved.
//

#import "SellerViewController.h"

#define Reuser @"cellReuser"
#define FoodReuser @"foodReuser"
#define CReuser @"cReuser"
#define CommentReuser @"commentReuser"
#define ShopReuser @"shopReuser"
#define ShopCellRes @"shopCellReusesr"

#import "FoodShowCell.h"
#import "PayViewController.h"
#import "CommentsCell.h"
#import "ShopCell.h"
#import "SearchViewController.h"
#import "FoodDetailsVC.h"

@interface SellerViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *sortTable;
    
    UITableView *foodTable;
    //
    UIView *totalBar;
    
    UILabel *totalLabel;
    //
    UITableView *commentTable;
    
    UITableView *shopTable;
    //作为传值用
    NSArray *SortArr;
    
    NSString *tmpHeadStr;
    
    float totalFloatValue;
    
    float _totalValue;
}
//中间变量和媒介
@property (nonatomic,strong)UIButton  *tmpBtn;

@property (nonatomic,strong)UIButton *centreBtn;

@property (nonatomic,strong)NSMutableArray *cellArr;

@property (nonatomic,strong)NSMutableArray *colorArr;

@end

@implementation SellerViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self totalBarLayout];
//
     totalLabel.text = [NSString stringWithFormat:@"合计:￥%0.2f",_totalValue];
//
    
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    [totalBar removeFromSuperview];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.title = @"真功夫（中山华润万家）";
    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(0, -60)forBarMetrics:UIBarMetricsDefault];
    //tabbar隐藏
    self.tabBarController.tabBar.hidden = YES;
    
    [self sortTableView];
    [self foodTableLayout];
    [self optionLayout];
    [self StoreIntroduceLayout];
    [self navigationLayout];

    //全部数据，到时候从网络请求，先写这里

    SortArr = @[@"销量排行",@"双人套餐",@"主餐菜单",@"米线粉丝",@"彩豆套餐",@"蒸汤",@"汤套餐",@"小吃分享"];
    
}

#pragma mark----Tableview
-(void)sortTableView{
    
    self.colorArr = [NSMutableArray array];

    sortTable = [[UITableView alloc]initWithFrame:CGRectMake(0, 160, 100, Screen_Height-44-64-160) style:UITableViewStylePlain];
    
    sortTable.delegate = self;
    sortTable.dataSource = self;
    
    [sortTable registerClass:[UITableViewCell class] forCellReuseIdentifier:Reuser];
    
    [self.view addSubview:sortTable];
    
}


-(void)foodTableLayout{
    
    self.cellArr = [NSMutableArray array];
    
    foodTable = [[UITableView alloc]initWithFrame:CGRectMake(100, 160, Screen_Width-100, Screen_Height-44-64-160) style:UITableViewStylePlain];
    
    foodTable.delegate = self;
    foodTable.dataSource = self;
    
    [foodTable registerNib:[UINib nibWithNibName:@"FoodShowCell" bundle:nil] forCellReuseIdentifier:FoodReuser];
    
    [self.view addSubview:foodTable];
    
}

-(void)commentTableLayout{
    
    commentTable = [[UITableView alloc]initWithFrame:CGRectMake(0, 160, Screen_Width, Screen_Height-64-160) style:UITableViewStylePlain];
    
    commentTable.delegate = self;
    commentTable.dataSource = self;
    
    [commentTable registerNib:[UINib nibWithNibName:@"CommentsCell" bundle:nil] forCellReuseIdentifier:CommentReuser];
    
    [commentTable registerClass:[UITableViewCell class] forCellReuseIdentifier:CReuser];
    
    [self.view addSubview:commentTable];
}

-(void)shopTableLayout{

    shopTable = [[UITableView alloc]initWithFrame:CGRectMake(0, 160, Screen_Width, Screen_Height-64-160) style:UITableViewStyleGrouped];
    
    shopTable.delegate = self;
    shopTable.dataSource = self;
    
    [shopTable registerNib:[UINib nibWithNibName:@"ShopCell" bundle:nil] forCellReuseIdentifier:ShopReuser];
    
    [shopTable registerClass:[UITableViewCell class] forCellReuseIdentifier:ShopCellRes];
    
    [self.view addSubview:shopTable];
}

#pragma mark----导航栏布局
-(void)navigationLayout{
    
    //作为最右边的搜索图标
    UIButton *searchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    searchBtn.frame = CGRectMake(20, 0, 44, 44);
    
    [searchBtn setTitleShadowColor:[UIColor whiteColor] forState:UIControlStateSelected];
    
    [searchBtn setImage:[UIImage imageNamed:@"search_01"] forState:0];
    
    [searchBtn addTarget:self action:@selector(searchAction:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *searchBarBtn = [[UIBarButtonItem alloc] initWithCustomView:searchBtn];
    //like
    UIButton *likeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    likeBtn.frame = CGRectMake(0, 0, 44, 44);
    
    [likeBtn setTitleShadowColor:[UIColor whiteColor] forState:UIControlStateSelected];
    
    [likeBtn setImage:[UIImage imageNamed:@"like_01"] forState:0];
    
    [likeBtn addTarget:self action:@selector(likeAction) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *likeBarBtn = [[UIBarButtonItem alloc] initWithCustomView:likeBtn];
    
    self.navigationItem.rightBarButtonItems = @[likeBarBtn,searchBarBtn];
    
    
}
#pragma mark----search and like功能
-(void)searchAction:(UIButton *)sender{
    
    SearchViewController *searchVC = [[SearchViewController alloc]init];
    
    [self.navigationController pushViewController:searchVC animated:NO];
    
}
-(void)likeAction{
    
    [[[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"已关注该商家" delegate:nil cancelButtonTitle:@"好的" otherButtonTitles:nil, nil]show];
    
}
#pragma mark---前部布局
-(void)StoreIntroduceLayout{
    UIView *storeVW = [[UIView alloc]initWithFrame:CGRectMake(0, 0, Screen_Width, 120)];
    [self.view addSubview:storeVW];
    //背景毛玻璃
    UIImageView *backgroundImage = [[UIImageView alloc]initWithFrame:storeVW.bounds];
    backgroundImage.image = [UIImage imageNamed:@"mao"];
    [storeVW addSubview:backgroundImage];
    //头像
    UIImageView *HVImage = [[UIImageView alloc]initWithFrame:CGRectMake(25, 20, 80, 80)];
    HVImage.image = [UIImage imageNamed:@"zhengongfu"];
    HVImage.layer.cornerRadius = 40;
    HVImage.layer.masksToBounds = YES;
    HVImage.layer.borderColor = [UIColor whiteColor].CGColor;
    HVImage.layer.borderWidth = 1;
    [storeVW addSubview:HVImage];
    //店名
    NSString *opStr = @"真功夫（中山华润万家）";
    CGSize size =[opStr sizeWithAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:16]}];
    
    UILabel *optionLB = [[UILabel alloc]initWithFrame:CGRectMake(120, 20, size.width, size.height)];
    optionLB.text = opStr;
    optionLB.textColor = [UIColor whiteColor];
    optionLB.textAlignment = 0;
    optionLB.font = [UIFont boldSystemFontOfSize:16];
    [storeVW addSubview:optionLB];
    //店铺介绍
    NSString *stoStr = @"起送价￥5 | 配送费￥5 | 37分钟送达";
    CGSize StrSize =[stoStr sizeWithAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:13]}];
    
    UILabel *stoLB = [[UILabel alloc]initWithFrame:CGRectMake(120, size.height+30, StrSize.width, StrSize.height)];
    stoLB.text = stoStr;
    stoLB.textColor = [UIColor whiteColor];
    stoLB.textAlignment = 0;
    stoLB.font = [UIFont systemFontOfSize:13];
    [storeVW addSubview:stoLB];
    //消息说明
    UILabel *mesLB = [[UILabel alloc]initWithFrame:CGRectMake(120, size.height+StrSize.height+45, Screen_Width-120, StrSize.height)];
    mesLB.text = @"新用户首单立减10元（在线支付专项)";
    mesLB.textColor = [UIColor whiteColor];
    mesLB.textAlignment = 0;
    mesLB.font = [UIFont systemFontOfSize:13];
    [storeVW addSubview:mesLB];
    
}
#pragma mark----点菜、评价、商家
-(void)optionLayout{
    
    NSArray *optionArr = @[@"点菜",@"评价",@"商家"];
    CGFloat perWidth = Screen_Width/3;
    for (int i = 0; i<3; i++) {
        //
        UIView *optionView = [[UIView alloc]initWithFrame:CGRectMake(perWidth*i, 120, perWidth, 40)];
        
        //增加点击事件
        UIButton *tapBtn = [UIButton new];
        tapBtn.frame = optionView.bounds;
        [tapBtn addTarget:self action:@selector(tapBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        //把第一个值赋给中间变量
        if (i == 0) {
            tapBtn.selected = YES;
            _tmpBtn = tapBtn;
        }
        //
        tapBtn.titleLabel.font = [UIFont boldSystemFontOfSize:16];
        tapBtn.layer.borderWidth = 1;
        tapBtn.layer.borderColor = [UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:1.0].CGColor;
        [tapBtn setTitle:optionArr[i] forState:0];
        [tapBtn setTitleColor:[UIColor darkGrayColor] forState:0];
        [tapBtn setTitleColor:[UIColor orangeColor] forState:UIControlStateSelected];
        tapBtn.tag = i;
        [optionView addSubview:tapBtn];
        [self.view addSubview:optionView];
    }
    
}

-(void)tapBtnAction:(UIButton *)sender{
    
    if (_tmpBtn == nil){
        
        sender.selected = YES;
        
        _tmpBtn = sender;
        
    } else if (_tmpBtn !=nil && _tmpBtn == sender){
        
        sender.selected = YES;
        
    } else if (_tmpBtn!= sender && _tmpBtn!=nil){
        
        _tmpBtn.selected = NO;
        
        sender.selected = YES;
        
        _tmpBtn = sender;
    }
    //每点击一次就移除所有表视图
    [foodTable removeFromSuperview];
    [sortTable removeFromSuperview];
    [shopTable removeFromSuperview];
    [commentTable removeFromSuperview];
    [totalBar removeFromSuperview];
    //点菜
    if (sender.tag == 0) {
        
        [self sortTableView];
        [self foodTableLayout];
        [self totalBarLayout];
        
    }else if (sender.tag == 1){
        
        [self commentTableLayout];
        
    }else{
        
        [self shopTableLayout];
        
    }
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
    
    NSMutableDictionary *dic = _cellArr[sender.tag-100];
    
    int i = [dic[@"numLB"] intValue];
    
    if (i >= 1) {
        
        i --;

        dic[@"lessBtnHidden"] = @NO;
        dic[@"numLBHidden"] = @NO;

        //点击后计算总金钱
    
            NSString *firstLabel = [totalLabel.text substringWithRange:NSMakeRange(4, totalLabel.text.length-4)];
            
             _totalValue = [firstLabel floatValue];
            
            _totalValue = _totalValue - [dic[@"perPriceLB"] floatValue];
            
            totalLabel.text = [NSString stringWithFormat:@"合计:￥%0.2f",_totalValue];
        
        if (i == 0) {

            dic[@"lessBtnHidden"] = @YES;
            dic[@"numLBHidden"] = @YES;
        }

    }
    
    //让Cell中num值等于i这个全局变量
    dic[@"numLB"] = [NSString stringWithFormat:@"%d",i];
    
    [_cellArr replaceObjectAtIndex:sender.tag-100 withObject:dic];
    
    //让改变的那一个cell刷新
    NSIndexPath *indexPath=[NSIndexPath indexPathForRow:sender.tag-100 inSection:0];
    
    [foodTable reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
    
}

//数量加1
-(void)moreBtnAction:(UIButton *)sender{
    
    NSMutableDictionary *dic = _cellArr[sender.tag-1000];

    //显示出来
    dic[@"lessBtnHidden"] = @NO;
    dic[@"numLBHidden"] = @NO;

    int i = [dic[@"numLB"] intValue];

    i++;

    dic[@"numLB"] = [NSString stringWithFormat:@"%d",i];

    [_cellArr replaceObjectAtIndex:sender.tag-1000 withObject:dic];
    
    //计算总金钱
           NSString *firstLabel = [totalLabel.text substringWithRange:NSMakeRange(4, totalLabel.text.length-4)];
        
         _totalValue = [firstLabel floatValue];
        
        _totalValue = _totalValue + [dic[@"perPriceLB"] floatValue];
        
        totalLabel.text = [NSString stringWithFormat:@"合计:￥%0.2f",_totalValue];
    
    //让改变的那一个cell刷新
    
    NSIndexPath *indexPath=[NSIndexPath indexPathForRow:sender.tag-1000 inSection:0];
    
    [foodTable reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
    
}


#pragma mark-----tableview

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    if (tableView == commentTable || tableView == shopTable) {
        return 3;
    }else
        return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView == sortTable) {
        return SortArr.count;
    }else if(tableView == foodTable){
          return 20;
      
    }else if(tableView == commentTable){
        if (section == 2) {
            return 10;
        }else
            return 1;
    }else{
        if (section == 0) {
            return 4;
        }else if (section == 1){
            return 3;
        }else{
            return 3;
        }
    }

}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (tableView == sortTable) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:Reuser];

        cell.textLabel.text = SortArr[indexPath.row];
        
        cell.textLabel.font = [UIFont systemFontOfSize:15];
        
        cell.textLabel.textColor = [UIColor darkGrayColor];
        if (indexPath.row == 0) {
            cell.textLabel.textColor = [UIColor orangeColor];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [self.colorArr addObject:cell];
        return cell;
#pragma mark----食物添加减少算金钱
    }else if(tableView == foodTable){

        //此处为重点，各种添加操作
       FoodShowCell *cell = [tableView dequeueReusableCellWithIdentifier:FoodReuser];
        
        if (_cellArr.count > indexPath.row) {
            //
            NSDictionary *dic = _cellArr[indexPath.row];
            cell.perPriceLB.text = dic[@"perPriceLB"];
            cell.numLB.text = dic[@"numLB"];
            cell.lessBtn.hidden = [dic[@"lessBtnHidden"] boolValue];
            cell.numLB.hidden = [dic[@"numLBHidden"] boolValue];
            //
            
        cell.selectionStyle = UITableViewCellSelectionStyleNone;

        }else{
            

//            NSDictionary *dic = @{@"perPriceLB":@"16.00",@"numLB":@"0",@"lessBtnHidden":@NO,@"numLBHidden":@NO};
            NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"16.00",@"perPriceLB",@"0",@"numLB",@YES,@"lessBtnHidden",@YES,@"numLBHidden", nil];
  
            
            cell.perPriceLB.text = dic[@"perPriceLB"];
            cell.numLB.text = dic[@"numLB"];
            cell.lessBtn.hidden = [dic[@"lessBtnHidden"] boolValue];
            cell.numLB.hidden = [dic[@"numLBHidden"] boolValue];
            
                      //20为foodttable的Cell的个数
            if (self.cellArr.count <20) {
                //加入全局数组中
                [self.cellArr addObject:dic];
            }
        }
      
        cell.lessBtn.tag = indexPath.row+100;
        cell.moreBtn.tag = indexPath.row +1000;
       
        
        [cell.lessBtn addTarget:self action:@selector(lessBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        
        [cell.moreBtn addTarget:self action:@selector(moreBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;

         return cell;
       #pragma mark----commentTable
    }else if (tableView == commentTable){
        
        //section0
        if (indexPath.section == 0) {
            //
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CReuser];
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            //
            if (cell.contentView != nil) {
                for (UIView *vi in cell.contentView.subviews) {
                    [vi removeFromSuperview];
                }
            }
            //
            NSArray *cArr = @[@"总体评价",@"菜品口味",@"配送服务"];
            CGFloat perWidth = Screen_Width/3;
            for (int i = 0; i<3; i++) {
                //
                UIView *optionView = [[UIView alloc]initWithFrame:CGRectMake(perWidth*i, 0, perWidth, 80)];

                optionView.backgroundColor = [UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:1.0];
                //评分
                NSString *opStr = @"4.8";
                CGSize size =[opStr sizeWithAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:25]}];
                
                UILabel *optionLB = [[UILabel alloc]initWithFrame:CGRectMake(perWidth/2-size.width/2, 10, size.width, size.height)];
                optionLB.text = opStr;
                optionLB.textColor = [UIColor orangeColor];
                optionLB.textAlignment = 1;
                optionLB.font = [UIFont boldSystemFontOfSize:25];
                
                [optionView addSubview:optionLB];
                //菜品评价
                NSString *pjStr = cArr[i];
                CGSize pjSize =[pjStr sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]}];
                
                UILabel *pjLB = [[UILabel alloc]initWithFrame:CGRectMake(perWidth/2-pjSize.width/2, 20+size.height, pjSize.width, pjSize.height)];
                pjLB.text = pjStr;
                pjLB.textColor = [UIColor darkGrayColor];
                pjLB.textAlignment = 1;
                pjLB.font = [UIFont systemFontOfSize:15];
                
                [optionView addSubview:pjLB];
                //
                [cell.contentView addSubview:optionView];
            }
            return cell;
        }else if (indexPath.section == 1){
            
            //
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CReuser];
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            //
            if (cell.contentView != nil) {
                for (UIView *vi in cell.contentView.subviews) {
                    [vi removeFromSuperview];
                }
            }
            //四个按钮一行两排部分
            NSArray *colorArr = @[@"全部",@"好评",@"中评",@"差评",@"很方便",@"贴心"];
            CGFloat colorWidth = (Screen_Width-50)/4;
            NSInteger hangNum = colorArr.count/4;
            //
            if (colorArr.count%4 != 0) {
                hangNum ++;
            }
            //
            int count = 0;
            for (int i = 0; i<hangNum ; i++) {
                for (int j = 0; j<4; j++) {
                    //
                    if (count ==colorArr.count) {
                        break;
                    }
                    //
                    UIButton *colorBtn = [UIButton buttonWithType:UIButtonTypeSystem];
                    
                    [colorBtn setTitle:colorArr[count] forState:0];
                    [colorBtn setTitleColor:[UIColor darkGrayColor] forState:0];
                    [colorBtn setTitleColor:[UIColor orangeColor] forState:UIControlStateSelected];
                    
                    colorBtn.tintColor = [UIColor clearColor];
                    colorBtn.backgroundColor = [UIColor clearColor];
                    
                    colorBtn.frame = CGRectMake(10+j*(colorWidth+10), 10+40*i, colorWidth, 30);
                    
                    colorBtn.layer.cornerRadius = 15.f;
                    colorBtn.layer.masksToBounds = YES;
                    colorBtn.layer.borderWidth = 0.5;
                    colorBtn.layer.borderColor = [UIColor lightGrayColor].CGColor;
                    
                    [colorBtn addTarget:self action:@selector(commentAction:) forControlEvents:UIControlEventTouchUpInside];
                    
                    colorBtn.tag = count;
                    
                    [cell.contentView addSubview:colorBtn];
                    
                    //把第一个值赋给中间变量
                    if (count == 0) {
                        colorBtn.selected = YES;
                        _centreBtn = colorBtn;
                    }
                    //
                    count ++;
                    
                }//for1
            }//for2
            //4个按钮一排到此结束
            return cell;
        }else{
            CommentsCell *cell = [tableView dequeueReusableCellWithIdentifier:CommentReuser];
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            return cell;
        }
        
        
    }else{
#pragma mark--商家栏目
        //店铺详情
        if (indexPath.section == 0) {
            
            NSArray *titleArr = @[@"配送时间:",@"商家电话:",@"商家地址:",@"配送服务:"];
             NSArray *mesArr = @[@"10:00-20:00",@"40062927927",@"中山市东区大鳌溪新村10街8号",@"由中港速递提供配送服务"];
            ShopCell *cell = [tableView dequeueReusableCellWithIdentifier:ShopReuser];
            
            cell.titleLB.text = titleArr[indexPath.row];
            cell.mesLB.text = mesArr[indexPath.row];
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            return cell;
        }else if (indexPath.section == 1){
             NSArray *titleArr = @[@"满30减7；满55减12（在线支付专项",@"新用户首单立减10元（在线支付专项）",@"该商家支持在线支付"];
            ShopCell *cell = [tableView dequeueReusableCellWithIdentifier:ShopReuser];
            
            cell.titleLB.text = titleArr[indexPath.row];
            cell.mesLB.text = @"";
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            return cell;

        }else{
            
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ShopCellRes];
            
            if (indexPath.row == 0) {
                cell.textLabel.text = @"售后服务";
                cell.textLabel.font = [UIFont systemFontOfSize:17];
                cell.textLabel.textColor = [UIColor darkGrayColor];
            }else if (indexPath.row == 1){
                cell.textLabel.text = @"本商家为真功夫网合作商家，服务提供方为真功夫，客户服务电话：400-6930-5345";
                cell.textLabel.font = [UIFont systemFontOfSize:15];
                cell.textLabel.textColor = [UIColor darkGrayColor];
                cell.textLabel.numberOfLines = 0;
            }else{
                cell.textLabel.text = @"本商家为真功夫网合作商家，信息均来自合作方，其信息的真实性、准确性、合法性和服务质量有信息拥有方真功夫负责";
                cell.textLabel.font = [UIFont systemFontOfSize:13];
                cell.textLabel.textColor = [UIColor lightGrayColor];
                cell.textLabel.numberOfLines = 0;

            }
            return cell;
        }
        
        
    }
    
    
    
}
#pragma mark---好评、差评、中评等
-(void)commentAction:(UIButton *)sender{
    
    if (_centreBtn == nil){
        
        sender.selected = YES;
        
        _centreBtn = sender;
        
    } else if (_centreBtn !=nil && _centreBtn == sender){
        
        sender.selected = YES;
        
    } else if (_centreBtn!= sender && _centreBtn!=nil){
        
        _centreBtn.selected = NO;
        
        sender.selected = YES;
        
        _centreBtn = sender;
    }
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (tableView == sortTable) {
//        sortTable.contentSize = CGSizeMake(0, 50*12+44);
        return 50;
    }else if(tableView == foodTable){
//        foodTable.contentSize = CGSizeMake(0, 95*20+44);
    return 95;
    }else if(tableView == commentTable){
        if (indexPath.section == 0) {
            return 80;
        }else if(indexPath.section == 1){
            return 110;
        }else{
            return 100;
        }
    }else{
        if (indexPath.section == 2) {
            if (indexPath.row == 0) {
                return 40;
            }else if(indexPath.row == 1){
                return 50;
            }else{
                return 50;
            }
        }else
        return 40;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (tableView == shopTable||tableView == foodTable) {
        return 25;
    }else{
        return 0;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (tableView == shopTable||tableView == foodTable) {
        return 1;
    }else{
        return 0;
    }
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    if (tableView == foodTable) {
        UILabel *headLabel = [[UILabel alloc]initWithFrame:CGRectMake(25, 5, 100, 15)];
        
        headLabel.backgroundColor = [UIColor whiteColor];
        
        headLabel.font = [UIFont systemFontOfSize:14];
        
        headLabel.textAlignment = 0;
        
        headLabel.text = tmpHeadStr;
        if (tmpHeadStr == nil) {
            headLabel.text = SortArr[0];
        }
        headLabel.textColor = [UIColor grayColor];
        
        return headLabel;
    }
    
    return nil;
}

//
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (tableView == sortTable) {
        [foodTable removeFromSuperview];
        tmpHeadStr = SortArr[indexPath.row];
        [_cellArr removeAllObjects];
        [self foodTableLayout];
        //选中的Cell变成orange色，没选中的灰黑色
        for (UITableViewCell *cell in self.colorArr) {
            cell.textLabel.textColor = [UIColor darkGrayColor];
        
        }
        UITableViewCell *selectCell = self.colorArr[indexPath.row];
        selectCell.textLabel.textColor = [UIColor orangeColor];
        
    }
    if (tableView == foodTable) {
        FoodDetailsVC *foodVC = [[FoodDetailsVC alloc]init];
    
        [self.navigationController pushViewController:foodVC animated:YES];
        
    }
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
