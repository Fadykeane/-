
//
//  JoinVC.m
//  ZGSTApp
//
//  Created by tusm on 15/12/28.
//  Copyright © 2015年 fady. All rights reserved.
//

#import "JoinVC.h"

#define AddReuserOne @"addOneRes"
#define AddResSecond @"addSecondRes"

#import "AddressEditVC.h"
#import "AddOneCell.h"

@interface JoinVC ()<UITableViewDataSource,UITableViewDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate>
{
    UIImageView *addImage;
}
@property (nonatomic,strong)UITableView *addTableView;

@end

@implementation JoinVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.tabBarController.tabBar.hidden = NO;

    self.title = @"我要加盟";
    
    [self initNavigationBar];
    
    [self tableViewLayout];
    
    [self tableHeadLayout];
    
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

-(void)tableHeadLayout{
    UIView *headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, Screen_Width, 100)];
    
    headView.backgroundColor = [UIColor whiteColor];
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(photoAction)];
    headView.userInteractionEnabled = YES;
    [headView addGestureRecognizer:tapGesture];
    //

    addImage = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 80, 80)];
    addImage.image = [UIImage imageNamed:@"add"];
    
    [headView addSubview:addImage];
    //
    UILabel *addLB = [[UILabel alloc]initWithFrame:CGRectMake(100, 45, 150, 30)];
    
    addLB.text = @"点击上传店铺图片";
    addLB.textAlignment = 1;
    addLB.font = [UIFont boldSystemFontOfSize:17];
    addLB.textColor = [UIColor darkGrayColor];
    
    [headView addSubview:addLB];
    //
    _addTableView.tableHeaderView = headView;
}

#pragma mark----action
-(void)editsAction{
    
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)photoAction{
//    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil
//                                                             delegate:self
//                                                    cancelButtonTitle:@"取消"
//                                               destructiveButtonTitle:@"拍照上传"
//                                                    otherButtonTitles:@"本地照片上传",nil];
//    [actionSheet setBackgroundColor:[UIColor clearColor]];
    
//    [actionSheet showInView:self.view];
    
    UIAlertController *alertC = [UIAlertController alertControllerWithTitle:@"选择图片方式" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    [alertC addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    
     UIImagePickerController * picker = [[UIImagePickerController alloc]init];
    
    [alertC addAction:[UIAlertAction actionWithTitle:@"拍照上传" style:UIAlertActionStyleDefault handler:^(UIAlertAction *_Nonnull action){
        
        [self presentViewController:picker animated:YES completion:nil];
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        picker.allowsEditing = YES;
        picker.delegate = self;

    }]];
    
    [alertC addAction:[UIAlertAction actionWithTitle:@"本地图片上传" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        [self presentViewController:picker animated:YES completion:nil];
        //该控制器用何种方式
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        picker.allowsEditing = YES;
        picker.delegate = self;
        
    }]];
    
    [self presentViewController:alertC animated:YES completion:nil];
    
}

//照片完成选择后的代理方法
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo
{
    /*添加处理选中图像代码*/
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    addImage.image = image;
//    把照片存储到本地
//    NSData *imageData = [NSData dataWithData:UIImageJPEGRepresentation(image, 1)];
    
    //    [[NSUserDefaults standardUserDefaults]removeObjectForKey:@""];
//    
//    [[NSUserDefaults standardUserDefaults]setObject:imageData forKey:@"dataImage"];
//    
    
}

#pragma mark----tableview
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 6;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        NSArray *nameArr = @[@"商铺名:",@"详细地址:",@"商铺电话:",@"联系人姓名:",@"联系人电话:",@"电子邮箱:"];
        NSArray *inputArr = @[@"请填写商铺名",@"请填写详细地址",@"请填写详细地址",@"请填写详细地址",@"请填写详细地址",@"请填写详细地址"];
        
        AddOneCell *cell = [tableView dequeueReusableCellWithIdentifier:AddReuserOne];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.nameLB.text = nameArr[indexPath.row];
        cell.inputTF.placeholder = inputArr[indexPath.row];
        cell.inputTF.borderStyle = UITextBorderStyleNone;
        
        return cell;
    }else{
        
        NSArray *nameArr = @[@"营业执照号:",@"经营范围:",@"一般纳税人:",@"银行开户名:",@"开户账号:",@"支付宝账号:"];
        NSArray *inputArr = @[@"请填写商铺名",@"请填写详细地址",@"请填写详细地址",@"请填写详细地址",@"请填写详细地址",@"请填写详细地址"];
        
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
