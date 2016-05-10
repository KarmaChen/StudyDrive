//
//  SelectModelView.h
//  StudyDrive
//
//  Created by Karma on 16/5/10.
//  Copyright © 2016年 陈昆涛. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    testModel,
    lookingModel
}SelectModel;
typedef void (^SelectTouch)(SelectModel model);
@interface SelectModelView : UIView
@property(nonatomic,assign)SelectModel model;
-(SelectModelView *)initWithFrame:(CGRect)frame addTouch:(SelectTouch)touch;
@end
