//
//  ChatViewController.m
//  MallApp
//
//  Created by tusm on 15/12/11.
//  Copyright © 2015年 fady. All rights reserved.
//

#import "ChatViewController.h"

#define chatReuser @"chatReuser"

@interface ChatViewController ()<UITableViewDelegate,UITableViewDataSource,UITextViewDelegate,UIScrollViewDelegate>

{
    NSMutableArray *_resultArray;
    
    UIView *textInputView;
    
    UITextView *inputTextView;
    
    CGFloat offsetHeight;
}

@property (nonatomic ,strong)UITableView *chatTable;


@end

@implementation ChatViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    self.tabBarController.tabBar.hidden = YES;
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    [textInputView removeFromSuperview];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    //数据源
    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:@"weixin",@"name",@"欢迎光临真功夫，请问需要什么帮助呢？",@"content", nil];
    NSDictionary *dict1 = [NSDictionary dictionaryWithObjectsAndKeys:@"rhl",@"name",@"hello，我要牛排~~~",@"content", nil];
    
    _resultArray = [NSMutableArray arrayWithObjects:dict,dict1, nil];
    
    [self chatTableLayout];
    
    [self textViewLayout];
    
}

-(void)chatTableLayout{
    _chatTable = [[UITableView alloc] initWithFrame:self.view.bounds];
    
    _chatTable.delegate = self;
    _chatTable.dataSource = self;
    
    [self.view addSubview:_chatTable];
    
    [_chatTable registerClass:[UITableViewCell class] forCellReuseIdentifier:chatReuser];
    
    _chatTable.separatorColor = [UIColor clearColor];
    
   
}


#pragma mark-----文本框输入部分
-(void)textViewLayout{
    
    CGFloat textOriginY = Screen_Height-44;
    CGFloat textHeight = 44;
    textInputView = [[UIView alloc]initWithFrame:CGRectMake(0, textOriginY, Screen_Width, textHeight)];
   
    textInputView.backgroundColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.5];
    
//加到window上
    [[[UIApplication sharedApplication]keyWindow] addSubview:textInputView];
    
    //输入的文本框
    inputTextView = [[UITextView alloc] initWithFrame:CGRectMake(10, 7, Screen_Width-80, 30)];

    inputTextView.delegate = self;//成为代理
    
    [textInputView addSubview:inputTextView];
    //发送按钮
    UIButton *sendBtn  = [UIButton new];
    sendBtn.frame = CGRectMake(Screen_Width-70, 5, 60, 30);
    [sendBtn setTitle:@"发送" forState:0];
    [sendBtn addTarget:self action:@selector(sendBtnActon:) forControlEvents:UIControlEventTouchUpInside];
    [textInputView addSubview:sendBtn];
    
    //注册观察者（观察键盘的动态）
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardShowAction:) name:UIKeyboardWillShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardHiddenAction:) name:UIKeyboardDidHideNotification object:nil];
}

-(void)sendBtnActon:(UIButton *)sender{
    
    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:@"rhl",@"name",inputTextView.text,@"content", nil];
    
    [_resultArray addObject:dict];
    
    inputTextView.text = nil;
    //隐藏键盘
    [self charKeyboardHidden];
    [self.chatTable reloadData];
//判断是否需要上移
    if (_chatTable.contentSize.height>Screen_Height-44) {
        offsetHeight += 60;
        _chatTable.contentOffset = CGPointMake(0, offsetHeight);

    }
   //
}

#pragma mark--键盘弹出和隐藏响应的通知方法-----自定义方法，在通知中被调用
-(void)keyboardShowAction:(NSNotification *)sender{
   
    //拿到键盘弹出来前的rect
    CGRect beginRect = [sender.userInfo[UIKeyboardFrameBeginUserInfoKey] CGRectValue];
    //键盘弹出来后的rect
    CGRect endRect = [sender.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    //算出键盘它本身的高度
    CGFloat keyboardHeight = beginRect.origin.y - endRect.origin.y;
    
    //让文本View做上升动画
    [UIView animateWithDuration:0.5 animations:^{
        textInputView.frame = CGRectMake(0, Screen_Height-keyboardHeight-44, Screen_Width, 44);
        
        
    }];
    
    
}


-(void)keyboardHiddenAction:(NSNotification *)sender{
    //不需要拿到键盘高度，直接让它取消第一响应者即可
    
    
}

//- (void)textViewDidBeginEditing:(UITextView *)textView{
//
//    if (_chatTable.contentSize.height>(Screen_Height-keyboardHeight-44-64)) {
//    _chatTable.contentOffset = CGPointMake(0, 100);

//        }
//}

#pragma mark----  泡泡文本
- (UIView *)bubbleView:(NSString *)text from:(BOOL)fromSelf withPosition:(int)position{
    
    // build single chat bubble cell with given text
    UIView *returnView = [[UIView alloc] initWithFrame:CGRectZero];
    returnView.backgroundColor = [UIColor clearColor];
    
    //计算大小
    
    CGSize size = [text boundingRectWithSize:CGSizeMake(180.0f, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil].size;
    //(泡泡)背影图片(这个图片固定，不改变）
    
    UIImage *bubble = [UIImage imageNamed:fromSelf?@"SenderAppNodeBkg_HL":@"ReceiverTextNodeBkg"];
    
    //    不可拉升方法，此为原图左上一般不可拉升
    UIImageView *bubbleImageView = [[UIImageView alloc] initWithImage:[bubble stretchableImageWithLeftCapWidth:floorf(bubble.size.width/2) topCapHeight:floorf(bubble.size.height/2)]];
    //    NSLog(@"%f,%f",size.width,size.height);
    
    
    //添加文本信息
    UILabel *bubbleText = [[UILabel alloc] initWithFrame:CGRectMake(fromSelf?15.0f:22.0f, 20.0f, size.width+10, size.height+10)];
    bubbleText.backgroundColor = [UIColor clearColor];
    bubbleText.font = [UIFont systemFontOfSize:14];
    bubbleText.numberOfLines = 0;
    bubbleText.text = text;
    
    bubbleImageView.frame = CGRectMake(0.0f, 14.0f, bubbleText.frame.size.width+30.0f, bubbleText.frame.size.height+20.0f);
    
    //根据传进来的bool值来判断视图的frame
    if(fromSelf)
        returnView.frame = CGRectMake(self.view.frame.size.width-position-(bubbleText.frame.size.width+30.0f), 0.0f, bubbleText.frame.size.width+30.0f, bubbleText.frame.size.height+30.0f);
    else
        returnView.frame = CGRectMake(position, 0.0f, bubbleText.frame.size.width+30.0f, bubbleText.frame.size.height+30.0f);
    
    [returnView addSubview:bubbleImageView];
    [returnView addSubview:bubbleText];
    
    return returnView;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _resultArray.count;
    
}

-(UITableViewCell * )tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:chatReuser];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if (cell != nil) {
        for (UIView *view in cell.subviews) {
            [view removeFromSuperview];
        }
    }
    
    NSDictionary *dict = [_resultArray objectAtIndex:indexPath.row];
    
    //创建头像（这里的头像图片是更加网络上传进来的图片而改变的）
    UIImageView *photo ;
    if ([[dict objectForKey:@"name"]isEqualToString:@"rhl"]) {
        photo = [[UIImageView alloc]initWithFrame:CGRectMake(self.view.frame.size.width-60, 10, 50, 50)];
        [cell addSubview:photo];
        //此为设置图片(用户）
        photo.image = [UIImage imageNamed:@"responser_01"];
        
        
        [cell addSubview:[self bubbleView:[dict objectForKey:@"content"] from:YES withPosition:65]];
        
    }else{
        photo = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 50, 50)];
        [cell addSubview:photo];
        //        此为设置图片（商家）
        photo.image = [UIImage imageNamed:@"zhengongfu"];
        
        //在这里调用文本泡泡方法
        [cell addSubview:[self bubbleView:[dict objectForKey:@"content"] from:NO withPosition:65]];
        
    }
    
    return cell;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSDictionary *dict = [_resultArray objectAtIndex:indexPath.row];
    
    CGSize titleSize = [[dict objectForKey:@"content"] boundingRectWithSize:CGSizeMake(180.0f, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil].size;
    
    return titleSize.height+44;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [self charKeyboardHidden];
}
-(void)charKeyboardHidden{
//    [inputTextView resignFirstResponder];方法一
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];//方法二
    
    [UIView animateWithDuration:0.1 animations:^{
        textInputView.frame = CGRectMake(0, Screen_Height-44, Screen_Width, 44);
    }];

}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [inputTextView resignFirstResponder];
    [UIView animateWithDuration:0.1 animations:^{
        textInputView.frame = CGRectMake(0, Screen_Height-44, Screen_Width, 44);
    }];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
