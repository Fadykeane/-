//
//  HomeViewController.m
//  ZGSTApp
//
//  Created by tusm on 15/12/21.
//  Copyright © 2015年 fady. All rights reserved.
//

#import "HomeViewController.h"
#import <CoreLocation/CoreLocation.h>

#define Reuser @"reuser"
#define SellerReuser @"sellReuser"


#import "NearbySellerCell.h"
#import "SearchViewController.h"
#import "SecondListViewController.h"
#import "SellerViewController.h"
#import <MJRefresh.h>
#import "SDCycleScrollView.h"

@interface HomeViewController ()<UITableViewDataSource,UITableViewDelegate,CLLocationManagerDelegate,SDCycleScrollViewDelegate>

{
    CLLocationManager *_locationManager;
    
    CLGeocoder * _geocoder;
    
    UIScrollView *homeScrollView;
    
    UIPageControl *_pageControl;
    
    CGFloat offSet_scroll;
    
    UILabel *locationLabel;
    
    int num;
    
}

@property (nonatomic,strong)UITableView *homeTableView;
@property (nonatomic,strong) NSMutableArray *refreshImages;//刷新动画的图片数组
@property (nonatomic,strong) NSMutableArray *normalImages;//普通状态下的图片数组
@property (nonatomic,strong) NSTimer *timer;//模拟数据刷新需要的时间控制器
@property (nonatomic,assign) int time;

@end

@implementation HomeViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    self.tabBarController.tabBar.hidden = NO;

    _geocoder=[[CLGeocoder alloc]init];
    
    [self locationLayout];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    self.automaticallyAdjustsScrollViewInsets = NO;

    self.edgesForExtendedLayout = UIRectEdgeNone;

    [self initNavigationBar];
    
    [self initTableView];
    
    [self scrollViewLayout];
    
}
#pragma mark---定位
-(void)locationLayout{
    
        if (![CLLocationManager locationServicesEnabled]) {
        NSLog(@"定位服务当前可能尚未打开，请设置打开！");
        return;
    }
    
    //定位管理器
    _locationManager=[[CLLocationManager alloc]init];
    
    _locationManager.delegate = self;
    
    if ([_locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
        [_locationManager requestAlwaysAuthorization];
    }
    
    _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    
    _locationManager.distanceFilter = 10.f;
    
    
    [_locationManager startUpdatingLocation];

}

#pragma mark-----导航栏布局
-(void)initNavigationBar{
    //导航栏设置
     [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(0, -60)forBarMetrics:UIBarMetricsDefault];
    
    //中间显示定位的View
    UIView *locationView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 250, 30)];
  
    locationView.backgroundColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.1];
    locationView.layer.cornerRadius = 15;
    locationView.layer.masksToBounds = YES;
    //
    UIImageView *locationImage = [[UIImageView alloc]initWithFrame:CGRectMake(5, 5, 15, 20)];
    
    locationImage.image = [UIImage imageNamed:@"location_01"];
    [locationView addSubview:locationImage];
    
    locationLabel = [[UILabel alloc]initWithFrame:CGRectMake(30, 5, 200, 20)];
    
    locationLabel.font = [UIFont systemFontOfSize:15];
    locationLabel.textColor = [UIColor whiteColor];
    locationLabel.text = @"中山市东区大鳌溪新村十街8号";
    
    [locationView addSubview:locationLabel];
    
    self.navigationItem.titleView = locationView;
    
    //作为最右边的搜索图标
    UIButton *searchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    searchBtn.frame = CGRectMake(20, 0, 44, 44);
    
    [searchBtn setTitleShadowColor:[UIColor whiteColor] forState:UIControlStateSelected];
    
    [searchBtn setImage:[UIImage imageNamed:@"search_01"] forState:0];
    
    [searchBtn addTarget:self action:@selector(searchAction:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *searchBarBtn = [[UIBarButtonItem alloc] initWithCustomView:searchBtn];
    
    self.navigationItem.rightBarButtonItem = searchBarBtn;
    
}

#pragma mark----search搜索功能
-(void)searchAction:(UIButton *)sender{
    
    SearchViewController *searchVC = [[SearchViewController alloc]init];
    
    [self.navigationController pushViewController:searchVC animated:NO];
    
}




#pragma mark---tableview表视图
-(void)initTableView{
    
    _homeTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, Screen_Width, Screen_Height-64-44) style:UITableViewStylePlain];
    
    _homeTableView.delegate = self;
    _homeTableView.dataSource = self;
    
    [_homeTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:Reuser];
    
    [self.view addSubview:_homeTableView];
    
    [_homeTableView registerNib:[UINib nibWithNibName:@"NearbySellerCell" bundle:nil] forCellReuseIdentifier:SellerReuser];

    
#pragma mark - MJGIFRefresh
    
//    _homeTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
//    
//    _homeTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
//    
//    MJRefreshGifHeader *gifHeader = [[MJRefreshGifHeader alloc]init];
//    
//    NSArray *gifArray = @[@"btn_01",@"btn_02",@"btn_03",@"btn_04"];
//    [gifHeader setImages:gifArray forState:(MJRefreshStateRefreshing)];
////    [MJRefreshNormalHeader addGifHeaderWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    
//    [_homeTableView addGifFooterWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    
//    [_homeTableView.mj_header beginRefreshing];
    
    MJRefreshGifHeader *header =[MJRefreshGifHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    [header setImages:self.refreshImages forState:MJRefreshStateRefreshing];
    [header setImages:self.normalImages forState:MJRefreshStateIdle];
    [header setImages:self.refreshImages forState:MJRefreshStatePulling];
    header.lastUpdatedTimeLabel.hidden= YES;//如果不隐藏这个会默认 图片在最左边不是在中间
    header.stateLabel.hidden = YES;
    self.homeTableView.mj_header = header;
    
}


#pragma mark----轮播图scrollViewLayout
-(void)scrollViewLayout{
    
    //    表头
    UIView *headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, Screen_Width , 180)];
    
    _homeTableView.tableHeaderView = headView;
    
    //
    NSArray *imageArr = @[[UIImage imageNamed:@"1"],[UIImage imageNamed:@"2"],[UIImage imageNamed:@"3"]];
    
    SDCycleScrollView *cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, Screen_Width, 180) shouldInfiniteLoop:YES imageNamesGroup:imageArr];
    cycleScrollView.delegate = self;
    cycleScrollView.pageControlStyle = SDCycleScrollViewPageContolStyleAnimated;
    //    cycleScrollView.currentPageDotColor = [UIColor blackColor];
    cycleScrollView.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    //         --- 轮播时间间隔，默认1.0秒，可自定义
    cycleScrollView.autoScrollTimeInterval = 3.0;
    
    [headView addSubview:cycleScrollView];
    
}

#pragma mark - SDCycleScrollViewDelegate

- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    NSLog(@"---点击了第%ld张图片", (long)index);
    
    [self.navigationController pushViewController:[NSClassFromString(@"DemoVCWithXib") new] animated:YES];
}

#pragma mark - 懒加载
- (NSMutableArray *)normalImages
{
    if (_normalImages == nil) {
        _normalImages = [[NSMutableArray alloc] init];
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"btn_01"]];
        [self.normalImages addObject:image];
    }
    return _normalImages;
}
//正在刷新状态下的图片
- (NSMutableArray *)refreshImages
{
    if (_refreshImages == nil) {
        _refreshImages = [[NSMutableArray alloc] init];
        //				循环添加图片
        for (NSUInteger i = 1; i<9; i++) {
            UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"b_0%ld", i]];
            [self.refreshImages addObject:image];
        }
    }
    return _refreshImages;
}
//
//-(void)loadNewData{
//    
//    [_homeTableView.mj_header endRefreshing];
//    
//}
//-(void)loadMoreData{
//    
//    [_homeTableView.mj_footer endRefreshingWithNoMoreData];
//    
//}
-(void)loadNewData {
    //模拟刷新的时间
//    self.timer  =[NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timeAction1) userInfo:nil repeats:YES];
//    self.time = 3;
    
        [_homeTableView.mj_header endRefreshing];

}
-(void)timeAction1{
    self.time --;
    NSLog(@"%d",self.time);
    if (self.time == 0) {
        //		刷新数据
        [_homeTableView reloadData];
        //		停止刷新
        [_homeTableView.mj_header endRefreshing];
        [self.timer invalidate];//时间器作废
    }
}
//
//#pragma mark-----轮播scrollview
//-(void)scrollViewLayout{
//    //    表头
//    UIView *headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, Screen_Width, 150)];
//    
//    //scrollview图
//    homeScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, Screen_Width, 150)];
//    
//    homeScrollView.delegate = self;
//    
//    homeScrollView.contentSize = CGSizeMake(Screen_Width*3, 0);
//    
//    homeScrollView.pagingEnabled = YES;
//    
//    homeScrollView.showsHorizontalScrollIndicator = NO;
//    for (int i = 1; i<4; i++) {
//        NSString *str = [NSString stringWithFormat:@"%d",i];
//        
//        UIImageView *image = [[UIImageView alloc]initWithFrame:CGRectMake(Screen_Width*(i-1), 0, Screen_Width, 150)];
//        
//        image.image = [UIImage imageNamed:str];
//        
//        [homeScrollView addSubview:image];
//        
//    }
//    
//    [headView addSubview:homeScrollView];
//    
//    _homeTableView.tableHeaderView = headView;
//    
//    
//    //UIPageControl
//    
//    _pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(0, 130, Screen_Width, 20)];
//    
//    _pageControl.backgroundColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.1];
//    
//    _pageControl.currentPage  = 0 ;
//    
//    _pageControl.numberOfPages = 3;
//    
//    [headView addSubview:_pageControl];
//    
//    //NSTimer计时器轮播图
//    [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(timeAction) userInfo:nil repeats:YES];
//
//    
//}
//
//
//
//#pragma mark----时间器设置方法
//-(void)timeAction{
//    //使scrollview来回播放
//    offSet_scroll += Screen_Width;
//    
//    if (num == 1) {
//        offSet_scroll = 0;
//        num = 0;
//    }
//    if (offSet_scroll == 3*Screen_Width) {
//        offSet_scroll = Screen_Width;
//        num++;
//    }
//    
//    int index = fabs(offSet_scroll) / Screen_Width;
//    
//    _pageControl.currentPage = index;
//    
//    [UIView animateWithDuration:1 animations:^{
//        
//        homeScrollView.contentOffset = CGPointMake(offSet_scroll, 0);
//        
//    }];
//    
//}

#pragma mark - CoreLocation 代理
#pragma mark 跟踪定位代理方法，每次位置发生变化即会执行（只要定位到相应位置）
//可以通过模拟器设置一个虚拟位置，否则在模拟器中无法调用此方法

- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status{//Authorization授权
    switch (status) {
            
        case kCLAuthorizationStatusNotDetermined:
            
            if ([manager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
                
                [manager requestAlwaysAuthorization];
            }
            
            break;
            
        default:
            
            break;
            
    }
}


- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation{
    if (newLocation.coordinate.latitude == oldLocation.coordinate.latitude &&newLocation.coordinate.longitude == oldLocation.coordinate.longitude) {
        [manager stopUpdatingLocation];
    }
    
    //将经度和纬度解析成地名
    if (!_geocoder) {
        _geocoder = [[CLGeocoder alloc] init];
    }
    [_geocoder reverseGeocodeLocation:newLocation completionHandler:^(NSArray *placemarks, NSError *error) {
        for (CLPlacemark *placemark in placemarks) {
            for (NSString *key in placemark.addressDictionary.allKeys) {
                NSLog(@"%@:%@",key,placemark.addressDictionary[key]);
            //
                if ([key isEqualToString:@"Name"]) {
#warning warning
//                    locationLabel.text = [placemark.addressDictionary[key] substringFromIndex:11];
                }
                
            }
   
        }
        
    }];//placemark  地标
}

#pragma mark----tableview代理方法
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (section == 0 ||section == 1) {
        return 1;
    }else
        
    return 15;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
#pragma mark----八个按钮
    if (indexPath.section == 0) {
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:Reuser];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        //重用前移除前面的视图
        if (cell != nil) {
            for (UIView *vi in cell.contentView.subviews) {
                [vi removeFromSuperview];
            }
        }
        
        CGFloat btn_height = 10;
        CGFloat btn_weight = (Screen_Width-4*60)/5;
        
        NSArray *eightBtnName = @[@"外卖",@"桶装水",@"便利店",@"快递配送",@"夜宵",@"礼品",@"进口食品",@"快速打印"];
        int k = 0;//遍历数组用
        
        for (int i = 0; i < 2; i++) {
            for (int j = 0 ; j < 4; j++) {
               
                //
                UIImageView *sortImageView = [[UIImageView alloc]initWithFrame:CGRectMake(btn_weight+(60+btn_weight)*j, btn_height, 60, 60)];
                
                NSString *btnName = [NSString stringWithFormat:@"b_0%d",k+1];
              
                sortImageView.image = [UIImage imageNamed:btnName];
                
                sortImageView.layer.cornerRadius = 30;
                sortImageView.layer.masksToBounds = YES;
                
                sortImageView.userInteractionEnabled = YES;
                
                UITapGestureRecognizer *tapImage = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(sortBtnAction:)];
                
                [sortImageView addGestureRecognizer:tapImage];
                
                [cell.contentView addSubview:sortImageView];
                
                //titleLabel
                UILabel *textLabel = [[UILabel alloc]initWithFrame:CGRectMake(btn_weight+(60+btn_weight)*j,btn_height+65, 60, 15)];
                
                textLabel.text = eightBtnName[k];
                k++;
                
                textLabel.textAlignment = 1;
                
                textLabel.font = [UIFont systemFontOfSize:15];
                
                textLabel.textColor = [UIColor lightGrayColor];
                
                [cell.contentView addSubview:textLabel];
            }
            btn_height += 100;
            
        }
        
        return cell;
    }else if(indexPath.section == 1){
#pragma mark---开始四个View可点击
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:Reuser];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        //重用前移除前面的视图
        if (cell != nil) {
            for (UIView *vi in cell.contentView.subviews) {
                [vi removeFromSuperview];
            }
        }

        //四个名字的数组
        NSArray *fourName = @[@"新店来袭",@"大额满减",@"今日特价菜",@"优惠风暴"];
        //
        NSArray *fourdsp = @[@"整点新鲜的",@"每日满减专区",@"怎么选，都划算",@"一大波优惠来袭"];
        //
        NSArray *fourImage = @[[UIImage imageNamed:@"b_03"],[UIImage imageNamed:@"b_05"],[UIImage imageNamed:@"b_01"],[UIImage imageNamed:@"b_06"]];
        //
        NSArray *fourColor = @[[UIColor cyanColor],[UIColor magentaColor],[UIColor orangeColor],[UIColor purpleColor]];
        //
        CGFloat perHeight = Screen_Width/4;
        int k = 0;
        for (int i  = 0; i<2; i++) {
            for (int j = 0; j<2; j++) {
                //四个View，其他控件放置在其上
                UIView *FV = [[UIView alloc]initWithFrame:CGRectMake(perHeight*2*j, 70*i,perHeight*2 , 70)];
                
                FV.layer.borderColor = [UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:1.0].CGColor;
                FV.layer.borderWidth = 1.0f;
                //给View添加点击事件
                UITapGestureRecognizer *tapViewGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapViewAction:)];
                FV.userInteractionEnabled = YES;
                [FV addGestureRecognizer:tapViewGesture];
                
                //
                UILabel *nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, perHeight, 20)];
                nameLabel.text = fourName[k];
                nameLabel.textColor = fourColor[k];
                nameLabel.textAlignment = 0;
                nameLabel.font = [UIFont boldSystemFontOfSize:16];
                [FV addSubview:nameLabel];
                //
                UILabel *desLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 40, perHeight+10, 15)];
                desLabel.text = fourdsp[k];
                desLabel.textColor = [UIColor lightGrayColor];
                desLabel.textAlignment = 0;
                desLabel.font = [UIFont systemFontOfSize:13];
                [FV addSubview:desLabel];
                //
                //空隙距离，40为图片边长
                CGFloat space = (perHeight-40)/2;
                
                UIImageView *showImage = [[UIImageView alloc]initWithFrame:CGRectMake(perHeight+space, 10, 40, 40)];
                
                showImage.image = fourImage[k];
                [FV addSubview:showImage];
                
                k++;
                //
                [cell.contentView addSubview:FV];
            }
        }
       
        
        
        return cell;
    }else{
        NSArray *imageArr = @[[UIImage imageNamed:@"zhengongfu"],[UIImage imageNamed:@"maidanglao"],[UIImage imageNamed:@"kendeji"]];
        NSArray *nameArr = @[@"真功夫（中山华润万家）",@"麦当劳",@"肯德基（宅急送）"];
        
            NearbySellerCell *cell = [tableView dequeueReusableCellWithIdentifier:SellerReuser];
        
        int lat = indexPath.row%3;
        
        cell.storeImageView.image = imageArr[lat];
        cell.storeName.text = nameArr[lat];
        
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            return cell;
        }
    
    
    
}

//
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 1||section==2) {
        return 15;
    }
    return 0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        return 200;
    }else if(indexPath.section == 1){
        return 140;
    }else
    return 150;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 2) {
        SellerViewController *sellerVC = [[SellerViewController alloc]init];
    
    [self.navigationController pushViewController:sellerVC animated:YES];

    }
    
}
#pragma mark---Cell中按钮的事件和实现
-(void)sortBtnAction:(UITapGestureRecognizer *)sender{
    
    SecondListViewController *secondVC = [[SecondListViewController alloc]init];
    
    [self.navigationController pushViewController:secondVC animated:YES];
    
}

-(void)tapViewAction:(UITapGestureRecognizer *)sender{
    
    SecondListViewController *secondVC = [[SecondListViewController alloc]init];
    
    [self.navigationController pushViewController:secondVC animated:YES];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 去除粘性
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (homeScrollView == scrollView) {
        int index = fabs(scrollView.contentOffset.x) / scrollView.frame.size.width;
        
        _pageControl.currentPage = index;
    }
//    去除粘性
    CGFloat sectionHeaderHeight = 17;
    if (scrollView.contentOffset.y<=sectionHeaderHeight&&scrollView.contentOffset.y>=0)
    {
        scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, -sectionHeaderHeight, 0);
    }
    else if (scrollView.contentOffset.y>=sectionHeaderHeight)
    {
        scrollView.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, -sectionHeaderHeight, 0);
        
    }
    //变色
    if (_homeTableView == scrollView){
        if (scrollView.contentOffset.y > 250) {
            self.navigationController.navigationBar.backgroundColor = [UIColor redColor];
        }else{
            self.navigationController.navigationBar.backgroundColor = [[UIColor redColor] colorWithAlphaComponent:0];
        }
    }
    
}

@end
