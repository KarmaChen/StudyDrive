//
//  AnswerScrollView.m
//  StudyDrive
//
//  Created by Karma on 16/5/5.
//  Copyright © 2016年 陈昆涛. All rights reserved.
//

#import "AnswerScrollView.h"
#import "AnswerTableViewCell.h"
#import "AnswerModel.h"
#import "Tools.h"
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
    NSMutableArray *_hadAnswerArray;
    
}
-(instancetype)initWithFrame:(CGRect)frame whiteDataArray:(NSArray *)array{
    self = [super initWithFrame:frame];
    if (self) {
        _currentPages =0;
        _dataArray = [[NSArray alloc]initWithArray:array];
        _hadAnswerArray =[[NSMutableArray alloc]init];
        for (int i =0; i<array.count-1; i++) {
            [_hadAnswerArray addObject:@"0"];
        }
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
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    AnswerModel *model = [self getTheFitModel:tableView];
    UIFont *font =[UIFont systemFontOfSize:16];
    NSString *str =[NSString stringWithFormat:@"答案解析:%@",model.mdesc];
    return  [Tools getSizeWithString:str with:font withSize:CGSizeMake(tableView.frame.size.width-20, 400)].height+20;
  

}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    AnswerModel *model = [self getTheFitModel:tableView];
    //判断是选择还是判断题
    CGFloat hight;
    if ([model.mtype intValue]==1) {
        NSString *str =[[Tools getAnswerWithString:model.mquestion]objectAtIndex:0];
        UIFont *font =[UIFont systemFontOfSize:16];
        hight = [Tools getSizeWithString:str with:font withSize:CGSizeMake(tableView.frame.size.width-20, 400)].height+20;
    }else{
        NSString *str =model.mquestion;
        UIFont *font =[UIFont systemFontOfSize:16];
        hight = [Tools getSizeWithString:str with:font withSize:CGSizeMake(tableView.frame.size.width-20, 400)].height+20;
    }
    if (hight<=80) {
        return  80;
    }else{
        return hight;
    }
}
-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    AnswerModel *model = [self getTheFitModel:tableView];
    //判断是选择还是判断题
    CGFloat hight;
    NSString *str;
    str =[NSString stringWithFormat:@"答案解析:%@",model.mdesc];
    UIFont *font =[UIFont systemFontOfSize:16];
    hight = [Tools getSizeWithString:str with:font withSize:CGSizeMake(tableView.frame.size.width-20, 400)].height+20;
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SIZE.width,hight)];
    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(10, 10, tableView.frame.size.width-20, hight-20)];
    label.text=str;
    label.font=[UIFont systemFontOfSize:16];
    label.textColor=[UIColor greenColor];
    label.numberOfLines=0;
    [view addSubview:label];
    int page =[self getQuestionNumber:tableView andCurrentPage:_currentPages];
    if ([_hadAnswerArray[page-1] intValue]!=0) {
        return view;
    }
     return nil;

}
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    AnswerModel *model = [self getTheFitModel:tableView];
    //判断是选择还是判断题
    CGFloat hight;
    NSString *str;
    if ([model.mtype intValue]==1) {
        str =[[Tools getAnswerWithString:model.mquestion]objectAtIndex:0];
        UIFont *font =[UIFont systemFontOfSize:16];
        hight = [Tools getSizeWithString:str with:font withSize:CGSizeMake(tableView.frame.size.width-20, 400)].height+20;
    }else{
        str =model.mquestion;
        UIFont *font =[UIFont systemFontOfSize:16];
        hight = [Tools getSizeWithString:str with:font withSize:CGSizeMake(tableView.frame.size.width-20, 400)].height+20;
    }
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SIZE.width,hight)];
    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(10, 10, tableView.frame.size.width-20, hight-20)];
    label.text=[NSString stringWithFormat:@"%d.%@",[self getQuestionNumber:tableView andCurrentPage:_currentPages],str];
    label.font=[UIFont systemFontOfSize:16];
    label.numberOfLines=0;
    [view addSubview:label];
    return view;
    
}
-(int)getQuestionNumber:(UITableView *)tableView andCurrentPage:(int)page{
    if (tableView==_leftTableView&&page==0) {
        return 1;
    }else if(tableView==_leftTableView&&page>0){
        return page;
    }else if(tableView==_mainTableView&&page>0&&page<_dataArray.count-1){
        return  page+1;
    }else if(tableView==_mainTableView&&page==0){
        return 2;
    }else if(tableView==_mainTableView&&page==_dataArray.count-1){
        return page;
    }else if(tableView==_rightTableView&&page==0){
        return page+2;
    }else if(tableView==_rightTableView&&page<_dataArray.count-1){
        return page+1;
    }
    return 0;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    int page =[self getQuestionNumber:tableView andCurrentPage:_currentPages];
    if ([_hadAnswerArray[page-1] intValue]!=0) {
        return;
    }else{
        [_hadAnswerArray replaceObjectAtIndex:page-1 withObject:[NSString stringWithFormat:@"%ld",indexPath.row+1]];
    }
    [self reloadData];

}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellID = @"AnswerTableViewCell";
    AnswerTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cellID"];
    if (cell==nil) {
        cell =[[[NSBundle mainBundle]loadNibNamed:@"AnswerTableViewCell" owner:self options:nil]lastObject];
        cell.numberLabel.layer.masksToBounds=YES;
        cell.numberLabel.layer.cornerRadius=10;
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
    }
    cell.numberLabel.text=[NSString stringWithFormat:@"%c",(char)('A'+indexPath.row)];
    AnswerModel * model=[self getTheFitModel:tableView];
     //选择题
    if ( [model.mtype intValue]==1) {
        cell.answerLabel.text=[[Tools getAnswerWithString:model.mquestion]objectAtIndex:indexPath.row+1];
    }
    int page =[self getQuestionNumber:tableView andCurrentPage:_currentPages];
    if ([_hadAnswerArray[page-1]intValue]!=0) {
        if ([model.manswer isEqualToString:[NSString stringWithFormat:@"%c",'A'+(int)indexPath.row]]) {
            cell.numberImager.hidden = NO;
            cell.numberImager.image = [UIImage imageNamed:@"19.png"];
        } else if (![model.manswer isEqualToString:[NSString stringWithFormat:@"%c",'A'+[_hadAnswerArray[page-1]intValue]-1]]&&indexPath.row==[_hadAnswerArray[page-1]intValue]-1) {
            cell.numberImager.hidden = NO;
            cell.numberImager.image = [UIImage imageNamed:@"20.png"];
        } else {
            cell.numberImager.hidden = YES;
        }
    } else {
        cell.numberImager.hidden = YES;
    }    return cell;
    
}
//??
-(AnswerModel *)getTheFitModel:(UITableView *)tableView{
    AnswerModel *model;
    //左边分为两种情况1.第一页时
    //2.不是第一页是加载前一页的数据
    if (tableView==_leftTableView&&_currentPages==0) {
        model=_dataArray[_currentPages];
    }else if(tableView==_leftTableView&&_currentPages>0){
        model=_dataArray[_currentPages-1];
    }else if(tableView==_mainTableView&&_currentPages>0&&_currentPages<_dataArray.count-1){
        model=_dataArray[_currentPages];
    }else if(tableView==_mainTableView&&_currentPages==0){
        model=_dataArray[_currentPages+1];
    }else if(tableView==_mainTableView&&_currentPages==_dataArray.count-1){
        model=_dataArray[_currentPages-1];
    }else if(tableView==_rightTableView&&_currentPages==0){
        model=_dataArray[_currentPages+2];
    }else if(tableView==_rightTableView&&_currentPages<_dataArray.count-1){
        model=_dataArray[_currentPages+1];
    }
    return model; 

}
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollVie
{
    CGPoint currentOffset= scrollVie.contentOffset;
    int page =(int)currentOffset.x/SIZE.width;
    if (page<_dataArray.count-1&&page>0) {
        _scrollView.contentSize=CGSizeMake(currentOffset.x+ SIZE.width*2, 90);
        _mainTableView.frame=CGRectMake(currentOffset.x, 0, SIZE.width, SIZE.height);
        _leftTableView.frame=CGRectMake(currentOffset.x-SIZE.width, 0, SIZE.width, SIZE.height);
        _rightTableView.frame=CGRectMake(currentOffset.x+SIZE.width, 0, SIZE.width, SIZE.height);
    }
    _currentPages=page;
    [self reloadData];
}
-(void)reloadData{
    [_leftTableView reloadData];
    [_rightTableView reloadData];
    [_mainTableView reloadData];
}
@end
