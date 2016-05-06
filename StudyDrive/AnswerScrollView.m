//
//  AnswerScrollView.m
//  StudyDrive
//
//  Created by Karma on 16/5/5.
//  Copyright © 2016年 陈昆涛. All rights reserved.
//

#import "AnswerScrollView.h"
#import "AnswerTableViewCell.h"
#define SIZE self.frame.size
@interface AnswerScrollView()<UIScrollViewDelegate,UITableViewDataSource,UITableViewDelegate>{
    
}
@end
@implementation AnswerScrollView
{
    UIScrollView *_scrollView;
    UITableView * _leftTableView;
    UITableView * _rightTableView;
    UITableView * _mainTableView;
    NSArray * _dataArray;
    
}
-(instancetype)initWithFrame:(CGRect)frame whiteDataArray:(NSArray *)array{
    self = [super initWithFrame:frame];
    if (self) {
        _dataArray = [[NSArray alloc]initWithArray:array];
        _scrollView = [[UIScrollView alloc]initWithFrame:frame];
        _scrollView.delegate=self;
        _leftTableView=[[UITableView alloc]initWithFrame:frame style:UITableViewStyleGrouped];
         _rightTableView=[[UITableView alloc]initWithFrame:frame style:UITableViewStyleGrouped];
         _mainTableView=[[UITableView alloc]initWithFrame:frame style:UITableViewStyleGrouped];
        _leftTableView.delegate=self;
        _rightTableView.delegate=self;
        _mainTableView.delegate=self;
        _leftTableView.dataSource=self;
        _rightTableView.dataSource=self;
        _mainTableView.dataSource=self;
        [self creatView];
        //翻页效果
        _scrollView.pagingEnabled=YES;
        //回弹效果取消
        _scrollView.showsHorizontalScrollIndicator=NO;
        _scrollView.showsVerticalScrollIndicator=NO;
        _scrollView.bounces=NO;
        if (_dataArray.count>1) {
            _scrollView.contentSize=CGSizeMake(SIZE.width*_dataArray.count, 0);
        }
        [self creatView];
    }
    return self;
}
-(void)creatView{
    _leftTableView.frame =CGRectMake(0, 0, SIZE.width, SIZE.height);
    _mainTableView.frame=CGRectMake(SIZE.width, 0,SIZE.width, SIZE.height);
    _rightTableView.frame=CGRectMake(SIZE.width*2, 0, SIZE.width, SIZE.height);
    [_scrollView addSubview:_leftTableView];
    [_scrollView addSubview:_rightTableView];
    [_scrollView addSubview:_mainTableView];
    [self addSubview:_scrollView];
}
#pragma mark -tableView Delegatr
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return  1;
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return  4;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 100;
}
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SIZE.width,100)];
    view.backgroundColor = [UIColor redColor];
    return view;
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellID = @"AnswerTableViewCell";
    AnswerTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cellID"];
    if (cell==nil) {
        cell =[[[NSBundle mainBundle]loadNibNamed:@"AnswerTableViewCell" owner:self options:nil]lastObject];
        cell.numberLabel.layer.masksToBounds=YES;
        cell.numberLabel.layer.cornerRadius=10;
    }
    cell.numberLabel.text=[NSString stringWithFormat:@"%c",(char)('A'+indexPath.row)];
    return cell;
    
    
}
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollVie
{
    CGPoint currentOffset= scrollVie.contentOffset;
    int page =(int)currentOffset.x/SIZE.width;
    if (page<_dataArray.count-1) {
        _scrollView.contentSize=CGSizeMake(currentOffset.x+ SIZE.width*2, 90);
        _mainTableView.frame=CGRectMake(currentOffset.x, 0, SIZE.width, SIZE.height);
        _leftTableView.frame=CGRectMake(currentOffset.x-SIZE.width, 0, SIZE.width, SIZE.height);
        _rightTableView.frame=CGRectMake(currentOffset.x+SIZE.width, 0, SIZE.width, SIZE.height);
    }
}
@end
