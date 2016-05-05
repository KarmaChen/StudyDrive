//
//  MyDataManager.m
//  StudyDrive
//
//  Created by Karma on 16/5/4.
//  Copyright © 2016年 陈昆涛. All rights reserved.
//

#import "MyDataManager.h"
#import "FMDatabase.h"
#import "TestSelectModle.h"
@implementation MyDataManager
+(NSArray *)getData:(DataType)type{
    NSMutableArray * array = [[NSMutableArray alloc]init];
    static FMDatabase *dataBase;
    if (dataBase==nil) {
        NSString * path = [[NSBundle mainBundle]pathForResource:@"data" ofType:@"sqlite"];
        dataBase = [[FMDatabase alloc]initWithPath:path];
        
        
    }
    //返回一个BOOL值
    if ([dataBase open]) {
        NSLog(@"open success");
    }else{
        return array;
    }
    switch (type) {
        case chapter:
        {
            NSString *sql = @"select pid ,pname,pcount from firstlevel";
            FMResultSet *rs = [dataBase executeQuery:sql];
            //返回的1的话继续读取 返回0的话停止读取
            while ([rs next]) {
                TestSelectModle * model = [[TestSelectModle alloc]init];
                model.pid = [NSString stringWithFormat:@"%d",[rs intForColumn:@"pid"]];
                model.pcount = [NSString stringWithFormat:@"%d",[rs intForColumn:@"pcount"]];
                model.pname = [rs stringForColumn:@"pname"];
                [array addObject:model];
                
            }
        }
            break;
            
        default:
            break;
    }
    return array;
    
}
@end
