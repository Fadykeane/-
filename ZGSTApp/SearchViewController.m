//
//  SearchViewController.m
//  MallApp
//
//  Created by tusm on 15/12/4.
//  Copyright © 2015年 fady. All rights reserved.
//

#import "SearchViewController.h"

#import "HomeViewController.h"

@interface SearchViewController ()<UISearchBarDelegate>

@property (nonatomic,strong)UISearchBar *search;

@end

@implementation SearchViewController

-(void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:YES];
    
    [_search resignFirstResponder];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];

//    self.navigationItem.hidesBackButton = YES;
    
    self.navigationController.tabBarController.tabBar.hidden = YES;
    
    [self initNavigationBar];
}

-(void)initNavigationBar{
    
        _search = [[UISearchBar alloc]initWithFrame:CGRectZero];
    
        [_search setPlaceholder:@"搜索商品名/商家名                      "];
    
    [_search becomeFirstResponder];
    
    self.navigationItem.titleView = _search;
    
    //
    UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    
    cancelBtn.frame = CGRectMake(0, 0, 40, 30);
    
    [cancelBtn setTitle:@"搜索" forState:0];
    
    [cancelBtn setTitleColor:[UIColor lightGrayColor] forState:0];

    [cancelBtn addTarget:self action:@selector(cancelAction:) forControlEvents:UIControlEventTouchUpInside];
    
    cancelBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    
    UIBarButtonItem *right = [[UIBarButtonItem alloc]initWithCustomView:cancelBtn];
    
    self.navigationItem.rightBarButtonItem = right;
    
}

#pragma mark---seachbarAction
-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    
    NSLog(@"aaaa");
}

-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
    
    [_search resignFirstResponder];
}

#pragma mark---cancelButton
-(void)cancelAction:(UIButton *)sender{
    
    [self.navigationController popToRootViewControllerAnimated:YES];
    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [_search resignFirstResponder];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
