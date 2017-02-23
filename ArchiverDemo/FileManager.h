//
//  FileManager.h
//  ArchiverDemo
//
//  Created by 嵇明新 on 2017/2/23.
//  Copyright © 2017年 lanhe. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FileManager : NSObject

/**
 *  获取文件数据
 *
 *  @param path <#path description#>
 *
 *  @return <#return value description#>
 */
- (NSString *) getFilePath:(NSString *) path;

@end
