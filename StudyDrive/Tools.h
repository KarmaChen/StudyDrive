//
//  Tools.h
//  StudyDrive
//
//  Created by Karma on 16/5/6.
//  Copyright © 2016年 陈昆涛. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface Tools : NSObject
+(NSArray *)getAnswerWithString:(NSString*)str;
+(CGSize)getSizeWithString:(NSString *)str with:(UIFont *)font withSize:(CGSize)size;
@end
