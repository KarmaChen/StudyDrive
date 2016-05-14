//
//  SheetView.h
//  StudyDrive
//
//  Created by Karma on 16/5/11.
//  Copyright © 2016年 陈昆涛. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol SheetViewDelegate
-(void)SheetViewClick:(int)index;
@end
@interface SheetView : UIView
{
    @public
    UIView * _backView;
}
@property(nonatomic,weak)id<SheetViewDelegate>delegate;
- (instancetype)initWithFrame:(CGRect)frame withSuperView:(UIView *)superView andQuesCount:(int)count;
@end
