//
//  Tools.m
//  StudyDrive
//
//  Created by Karma on 16/5/6.
//  Copyright © 2016年 陈昆涛. All rights reserved.
//

#import "Tools.h"

@implementation Tools
+(NSArray *)getAnswerWithString:(NSString *)str{
    NSMutableArray *array=[[NSMutableArray alloc]init];
    NSArray *arr = [str componentsSeparatedByString:@"<BR>"];
    [array addObject:arr[0]];
    for (int i=0; i<4; i++) {
        [array addObject:[arr[i+1] substringFromIndex:2]];
    }
    return array;
}
@end
