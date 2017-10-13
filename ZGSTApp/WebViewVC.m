//
//  WebViewVC.m
//  ZGSTApp
//
//  Created by tusm on 15/12/28.
//  Copyright © 2015年 fady. All rights reserved.
//

#import "WebViewVC.h"

@interface WebViewVC ()<UIWebViewDelegate>
{
    UILabel *titleLB;
    
    NSMutableString *timeStr;
    
    UIProgressView *progessVW;
    
}
@end

@implementation WebViewVC

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    progessVW.hidden = YES;
    progessVW = nil;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    [self webViewLayout];
}

-(void)webViewLayout{
    
    titleLB = [[UILabel alloc]initWithFrame:CGRectMake(100, 11.5, Screen_Width-200, 21)];
    //属性传值
    titleLB.text = self.titleStr;
    
    self.navigationItem.titleView = titleLB;
    
    [NSTimer scheduledTimerWithTimeInterval:0.8f target:self selector:@selector(timeAction:) userInfo:nil repeats:YES];
    //
    UIWebView *webVC = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, Screen_Width, Screen_Height-64)];
    
    [self.view addSubview:webVC];
    
    //所有的网络请求都要进行网络检测
    [webVC loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.urlStr]]];
    
    webVC.delegate = self;
    
    progessVW = [[UIProgressView alloc]initWithFrame:CGRectMake(0, 43, Screen_Width, 1)];
    
    [self.navigationController.navigationBar addSubview:progessVW];
    
    
}

-(void)timeAction:(NSTimer *)sender{
    [timeStr deleteCharactersInRange:NSMakeRange(0, 1)];
    CGSize size = [timeStr sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17]}];
    if (size.width < Screen_Width-230) {
        timeStr = [NSMutableString stringWithFormat:@"%@",self.titleStr];
    }
    titleLB.text = timeStr;
    
}

-(void)webViewDidStartLoad:(UIWebView *)webView{
    [progessVW setProgress:0.5 animated:YES];

}

-(void)webViewDidFinishLoad:(UIWebView *)webView{
//    progessVW.progress = 1.0f;
    [progessVW setProgress:1 animated:YES];
    //隐藏
    [progessVW performSelector:@selector(setHidden:) withObject:@YES afterDelay:0.5];
    
}

-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    NSLog(@"%@",error.debugDescription);
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
