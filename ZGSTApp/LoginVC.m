//
//  LoginVC.m
//  ZGSTApp
//
//  Created by tusm on 15/12/24.
//  Copyright © 2015年 fady. All rights reserved.
//

#import "LoginVC.h"

#import "RegisterVC.h"

@interface LoginVC ()
{
    UIView *optionView;
    
    UIView *FirstLoginView;
    
    UIView *SecondLoginView;
    
    UIView *nameFirstLoginView;
    
    UIView *nameSecondLoginView;
    
}
@end

@implementation LoginVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"登录";
    self.view.backgroundColor = [UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:1.0];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    [self optionLayout];
    [self telLoginView];
    [self initNavigationBar];
    
}

-(void)initNavigationBar{
    //
    UIButton *registerBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    
    registerBtn.frame = CGRectMake(0, 0, 60, 30);
    
    [registerBtn setTitle:@"立即注册" forState:0];
    
    [registerBtn setTitleColor:[UIColor orangeColor] forState:0];
    
    [registerBtn addTarget:self action:@selector(registerAction) forControlEvents:UIControlEventTouchUpInside];
    
    registerBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    
    UIBarButtonItem *right = [[UIBarButtonItem alloc]initWithCustomView:registerBtn];
    
    self.navigationItem.rightBarButtonItem = right;
    
}

-(void)registerAction{
    
    RegisterVC *rVC = [[RegisterVC alloc]init];
    
    [self.navigationController pushViewController:rVC animated:YES];
    
}
-(void)optionLayout{
    
    NSArray *optionArr = @[@"手机号快捷登录",@"账号密码登录"];
    CGFloat perWidth = Screen_Width/2;
    for (int i = 0; i<2; i++) {
        //
       optionView  = [[UIView alloc]initWithFrame:CGRectMake(perWidth*i, 0, perWidth, 40)];
        
        optionView.layer.borderWidth = 1;
        optionView.layer.borderColor = [UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:1.0].CGColor;
        optionView.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:optionView];
        //增加手势
        UITapGestureRecognizer *tapVWGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapVWAction:)];
        optionView.userInteractionEnabled = YES;
        [optionView addGestureRecognizer:tapVWGesture];
        
        optionView.tag = i;
        //
        NSString *opStr = optionArr[i];
        CGSize size =[opStr sizeWithAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:15]}];
        
        UILabel *optionLB = [[UILabel alloc]initWithFrame:CGRectMake(perWidth/2-size.width/2, 10, size.width, 20)];
        optionLB.text = opStr;
        
        optionLB.textColor = [UIColor darkGrayColor];
        optionLB.textAlignment = 1;
        optionLB.font = [UIFont boldSystemFontOfSize:15];
        
        if (i == 0) {
            optionLB.textColor = [UIColor orangeColor];
        }
        [optionView addSubview:optionLB];

    }
    
    //登录按钮
    UIButton *loginBtn = [UIButton new];
    loginBtn.backgroundColor = [UIColor orangeColor];
    [loginBtn setTitleColor:[UIColor darkGrayColor] forState:0];
    [loginBtn setTitle:@"登录" forState:0];
    loginBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    loginBtn.frame = CGRectMake(10, 150, Screen_Width-20, 40);
    
    [self.view addSubview:loginBtn];
    
}
//点击事件实现
-(void)tapVWAction:(UITapGestureRecognizer *)sender{
    //移除所有
    [FirstLoginView removeFromSuperview];
    [SecondLoginView removeFromSuperview];
    [nameFirstLoginView removeFromSuperview];
    [nameSecondLoginView removeFromSuperview];
    //
    if (sender.view.tag == 0) {
//        选中时变色
        UILabel *transformLB = (UILabel*)[sender.view.subviews firstObject];
        transformLB.textColor = [UIColor orangeColor];
        //层层递进，拿到要变色的label
        UILabel *transformLB2 = (UILabel*)[((UIView*)[self.view.subviews objectAtIndex:1]).subviews firstObject];
        transformLB2.textColor = [UIColor darkGrayColor];
        //
        [self telLoginView];
    }else{
        //选中时变色
        UILabel *transformLB = (UILabel*)[sender.view.subviews firstObject];
        transformLB.textColor = [UIColor orangeColor];
        //层层递进，拿到要变色的label
        UILabel *transformLB2 = (UILabel*)[((UIView*)[self.view.subviews firstObject]).subviews firstObject];
        transformLB2.textColor = [UIColor darkGrayColor];
        //
        [self nameLoginView];
    }
    
}
//
-(void)telLoginView{
    
    FirstLoginView = [[UIView alloc]initWithFrame:CGRectMake(0, 50, Screen_Width, 40)];
    FirstLoginView.layer.borderColor = [UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:1.0].CGColor;
    
    FirstLoginView.layer.borderWidth = 0.5;
    
    FirstLoginView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:FirstLoginView];
    //
    UIImageView *image1 = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 20, 20)];
    
    image1.image = [UIImage imageNamed:@"my1"];
    [FirstLoginView addSubview:image1];
    //
    UITextField *firstTF = [[UITextField alloc]initWithFrame:CGRectMake(35, 10, Screen_Width-35-95, 20)];
    firstTF.placeholder = @"请输入您的手机号";
    [FirstLoginView addSubview:firstTF];
    //
    UIButton *resqBtn = [UIButton new];
    [resqBtn setTitleColor:[UIColor darkGrayColor] forState:0];
    [resqBtn setTitle:@"获取验证码" forState:0];
    resqBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    resqBtn.backgroundColor = [UIColor orangeColor];
    resqBtn.frame = CGRectMake(Screen_Width-90, 5, 80, 30);
    resqBtn.layer.cornerRadius = 10;
    resqBtn.layer.masksToBounds = YES;
    [FirstLoginView addSubview:resqBtn];
    //
    //第二个
    SecondLoginView = [[UIView alloc]initWithFrame:CGRectMake(0, 90, Screen_Width, 40)];
    SecondLoginView.layer.borderColor = [UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:1.0].CGColor;
    
    SecondLoginView.layer.borderWidth = 0.5;
    
    SecondLoginView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:SecondLoginView];
    //
    UIImageView *image2 = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 20, 20)];
    
    image2.image = [UIImage imageNamed:@"more1"];
    [SecondLoginView addSubview:image2];
    //
    UITextField *secondTF = [[UITextField alloc]initWithFrame:CGRectMake(35, 10, Screen_Width-35-85, 20)];
    secondTF.placeholder = @"请输入您收到的验证码";
    [SecondLoginView addSubview:secondTF];
    //

}

-(void)nameLoginView{
    
    nameFirstLoginView = [[UIView alloc]initWithFrame:CGRectMake(0, 50, Screen_Width, 40)];
    nameFirstLoginView.layer.borderColor = [UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:1.0].CGColor;
    
    nameFirstLoginView.layer.borderWidth = 0.5;
    
    nameFirstLoginView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:nameFirstLoginView];
    //
    UIImageView *image1 = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 20, 20)];
    
    image1.image = [UIImage imageNamed:@"my1"];
    [nameFirstLoginView addSubview:image1];
    //
    UITextField *firstTF = [[UITextField alloc]initWithFrame:CGRectMake(35, 10, Screen_Width-35-85, 20)];
    firstTF.placeholder = @"美团网账号/手机号/邮箱";
    [nameFirstLoginView addSubview:firstTF];
    //
   
    //第二个
    nameSecondLoginView = [[UIView alloc]initWithFrame:CGRectMake(0, 90, Screen_Width, 40)];
    nameSecondLoginView.layer.borderColor = [UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:1.0].CGColor;
    
    nameSecondLoginView.layer.borderWidth = 0.5;
    
    nameSecondLoginView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:nameSecondLoginView];
    //
    UIImageView *image2 = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 20, 20)];
    
    image2.image = [UIImage imageNamed:@"more1"];
    [nameSecondLoginView addSubview:image2];
    //
    UITextField *secondTF = [[UITextField alloc]initWithFrame:CGRectMake(35, 10, Screen_Width-35-85, 20)];
    secondTF.placeholder = @"请输入密码";
    [nameSecondLoginView addSubview:secondTF];
    //
    //找回密码
    UIButton *findBackBtn = [UIButton new];
    [findBackBtn setTitleColor:[UIColor orangeColor] forState:0];
    [findBackBtn setTitle:@"找回密码" forState:0];
    findBackBtn.titleLabel.font = [UIFont systemFontOfSize:15];

    findBackBtn.frame = CGRectMake(Screen_Width-70, 205, 60, 20);

    [self.view addSubview:findBackBtn];
    //

    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
