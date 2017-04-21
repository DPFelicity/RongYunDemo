//
//  DataTool.h
//  RongYunDemo
//
//  Created by duanpeng on 17/4/20.
//  Copyright © 2017年 duanpeng. All rights reserved.
//

#import <Foundation/Foundation.h>

#define DATATOOL   ([DataTool shareManager])

@interface DataTool : NSObject

@property (strong, nonatomic) FMDatabaseQueue *queue;

+ (DataTool*)shareManager;

/*! @brief 表示否存在 */
- (BOOL)tableExists:(NSString *)tableName;
/*! @brief 创建表 */
- (BOOL)createTable:(NSString *)sql;
/*! @brief 删除表 */
- (BOOL)remove:(NSString *)table;
/*! @brief 搜索 */
//- (NSMutableArray *)select:(NSString *)table where:(NSString *)where, ... NS_REQUIRES_NIL_TERMINATION;
- (NSMutableArray *)select:(NSString *)table where:(NSString *)where;
/*! @brief 搜索表数据 */
- (NSMutableArray *)select:(NSString *)table;
/*! @brief 插入数据 */
- (BOOL)insert:(NSString *)sql;
/*! @brief 更新数据 */
- (BOOL)update:(NSString *)sql;
/*! @brief 移除数据 */
- (BOOL)remove:(NSString *)table where:(NSString *)where;
/*! @brief 查询数量 */
- (NSInteger)totalRowOfTable:(NSString *)table where:(NSString *)where;


@end
