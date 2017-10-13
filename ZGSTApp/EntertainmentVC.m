//
//  EntertainmentVC.m
//  ZGSTApp
//
//  Created by tusm on 15/12/26.
//  Copyright © 2015年 fady. All rights reserved.
//

#import "EntertainmentVC.h"

#define CellIdentifier @"CellIdentifier"

#import <UIImageView+WebCache.h>
#import <MJRefresh.h>
#import "WebViewVC.h"
#import "TableViewCell.h"

@interface EntertainmentVC ()<UITableViewDataSource,UITableViewDelegate>
{
    NSMutableArray *dataSource;
    
    int num;
    int page;
    
}

@property (nonatomic,strong)UITableView *showTable;

@end

@implementation EntertainmentVC

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    self.tabBarController.tabBar.hidden = YES;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"每日娱乐";

    self.view.backgroundColor = [UIColor whiteColor];
    
    dataSource = [NSMutableArray array];
    
    //    先查找数据库中是否有元素，如果为空，就加载
    if (dataSource.count == 0) {
        NSString *httpUrl = @"http://apis.baidu.com/txapi/huabian/newtop";
        NSString *httpArg = @"num=10&page=1";
        [self request: httpUrl withHttpArg: httpArg];
        
    }
    
    [self tableViewLayout];
    
}

-(void)tableViewLayout{
    _showTable = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    
    _showTable.delegate = self;
    _showTable.dataSource =self;
    
    [self.view addSubview:_showTable];
    
    [_showTable registerNib:[UINib nibWithNibName:@"TableViewCell" bundle:nil] forCellReuseIdentifier:CellIdentifier];
    
    _showTable.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    
    _showTable.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    
    [_showTable.mj_header beginRefreshing];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return dataSource.count;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if (dataSource.count != 0) {
        
        NSDictionary *dic = dataSource[indexPath.row];
        [cell.pic sd_setImageWithURL:[NSURL URLWithString:dic[@"picUrl"]] placeholderImage:[UIImage imageNamed:@"Untitledllll.jpg"]];
        cell.titleLabel.text = dic[@"title"];
        cell.desLabel.text = dic[@"description"];
    }

    
    
    return cell;
    
}

#pragma mark---tableviewheight

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 5;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 80;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    WebViewVC *webVC = [[WebViewVC alloc]init];
    
    webVC.titleStr = dataSource[indexPath.row][@"title"];
    
    webVC.urlStr = dataSource[indexPath.row][@"url"];
    
    [self.navigationController pushViewController:webVC animated:YES];
    
}

#pragma mark----loaddata
-(void)loadNewData{
    NSLog(@"下拉刷新");
    num = 10;
    page = 1;
    [dataSource removeAllObjects];//移除所有之后就释放掉了，所有要重新初始化
    dataSource = [NSMutableArray array];
    NSString *httpUrl = @"http://apis.baidu.com/txapi/huabian/newtop";
    NSString *httpArg = [NSString stringWithFormat:@"num=%d&page=%d",num,page];
    [self request: httpUrl withHttpArg: httpArg];
    
}

//

-(void)loadMoreData{
page ++;
NSString *httpUrl = @"http://apis.baidu.com/txapi/huabian/newtop";
NSString *httpArg = [NSString stringWithFormat:@"num=%d&page=%d",num,page];
    [self request:httpUrl withHttpArg:httpArg];

}
//
-(void)request: (NSString*)httpUrl withHttpArg: (NSString*)HttpArg  {
    NSString *urlStr = [[NSString alloc]initWithFormat: @"%@?%@", httpUrl, HttpArg];
    NSURL *url = [NSURL URLWithString: urlStr];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL: url cachePolicy: NSURLRequestUseProtocolCachePolicy timeoutInterval: 10];
    [request setHTTPMethod: @"GET"];
    [request addValue: @"2710edf7f34cea105985297edc8995a1" forHTTPHeaderField: @"apikey"];
    
    [NSURLConnection sendAsynchronousRequest: request
                                       queue: [NSOperationQueue mainQueue]
                           completionHandler: ^(NSURLResponse *response, NSData *data, NSError *error){
                               if (error) {

                               } else {
                                   //百度API返回的参数data
                                   NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];

                                   for (id ele in dic.allValues) {
                                       if ([ele isKindOfClass:[NSDictionary class]]) {
                                           [dataSource addObject:ele];
                                       }
                                   }
                                   
                                   [_showTable reloadData];
                                   
                                   [_showTable.mj_header endRefreshing];
                                   [_showTable.mj_footer endRefreshing];
                               }
                           }];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
