//
//  FirstViewController.m
//  StudyDrive
//
//  Created by Karma on 16/5/4.
//  Copyright © 2016年 陈昆涛. All rights reserved.
//

#import "FirstViewController.h"
#import "FirstTableViewCell.h"
#import "TestSelectViewController.h"
#import "MyDataManager.h"

@interface FirstViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView * _tableView;
    NSArray * _dataArray;
}

@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.backgroundColor = [UIColor whiteColor];
    _dataArray = @[@"章节练习",@"顺序练习",@"随机练习",@"专项练习",@"仿真考试"];
    [self creatTableView];
    [self creatView];
}
-(void)creatView{
    UILabel *lable = [[UILabel alloc]initWithFrame:CGRectMake(self.view.frame.size.width/2-150, self.view.frame.size.height-64-170, 300, 30)];
    lable.textAlignment = NSTextAlignmentCenter;
    lable.text = @"....................我的考试分析....................";
    [self.view addSubview:lable];
    
    NSArray *arr = @[@"我的错题",@"我的收藏",@"我的成绩",@"练习统计"];
    for (int i =0; i<4; i++) {
        UIButton * btn=[UIButton buttonWithType:UIButtonTypeSystem];
        btn.frame = CGRectMake(self.view.frame.size.width/4*i+self.view.frame.size.width/4/2-30, self.view.frame.size.height-64-100, 60, 60);
        [btn setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"%d.png",12+i]] forState:UIControlStateNormal];
        [self.view addSubview:btn];
        
        
        UILabel  *lab = [[UILabel alloc]initWithFrame:CGRectMake(self.view.frame.size.width/4*i+self.view.frame.size.width/4/2-30, self.view.frame.size.height-64-25, 60, 20)];
        lab.textAlignment = NSTextAlignmentCenter;
        lab.text = arr[i];
        lab.font = [UIFont boldSystemFontOfSize:13];
        [self.view addSubview:lab];
        
        
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)creatTableView{
    _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 250) style:UITableViewStylePlain];
    _tableView.dataSource=self;
    _tableView.delegate=self;
    [self.view addSubview:_tableView];
}
#pragma mark -tableview delegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArray.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    //声明一个静态字符串
    static NSString * cellID = @"FirstTableViewCell";
    FirstTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell==nil) {
        cell=[[[NSBundle mainBundle]loadNibNamed:cellID owner:self options:nil]lastObject];
    }
    cell.myImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%ld.png",indexPath.row+7]];
    cell.myLable.text = _dataArray[indexPath.row];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.row) {
        case 0:
        {
            TestSelectViewController * con = [[TestSelectViewController alloc]init];
            con.dataArray =[MyDataManager getData:chapter];
            con.myTitle = @"章节练习";
            UIBarButtonItem * item = [[UIBarButtonItem alloc]init];
            item.title=@"返回";
            self.navigationItem.backBarButtonItem =item;
            [self.navigationController pushViewController:con animated:YES];
        }
            break;
            
        default:
            break;
    }
}


@end
