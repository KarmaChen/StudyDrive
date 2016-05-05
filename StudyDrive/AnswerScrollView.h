//
//  AnswerScrollView.h
//  StudyDrive
//
//  Created by Karma on 16/5/5.
//  Copyright © 2016年 陈昆涛. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AnswerScrollView : UIView
-(instancetype)initWithFrame:(CGRect)frame whiteDataArray:(NSArray *)array;
@property(nonatomic,assign,readonly)int currentPages;
@end
