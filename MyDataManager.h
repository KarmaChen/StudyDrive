//
//  MyDataManager.h
//  StudyDrive
//
//  Created by Karma on 16/5/4.
//  Copyright © 2016年 陈昆涛. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef enum {
    chapter//章节练习
}DataType;
@interface MyDataManager : NSObject
//?
+(NSArray *)getData:(DataType)type;
@end
