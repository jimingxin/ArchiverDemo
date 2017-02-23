//
//  FileManager.m
//  ArchiverDemo
//
//  Created by 嵇明新 on 2017/2/23.
//  Copyright © 2017年 lanhe. All rights reserved.
//

#import "FileManager.h"

@interface FileManager ()

@property (nonatomic, strong) NSFileManager *fileManager;


@end

@implementation FileManager


- (NSFileManager *)fileManager{

    if (_fileManager == nil) {
        
        _fileManager = [NSFileManager defaultManager];
    }
    return _fileManager;
}

- (NSString *) getFilePath:(NSString *) path{

    //设定文本框存储文件的位置
    NSString *strFilePath=[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)objectAtIndex:0];
    //指定存储文件的文件名
    NSString *fileName=[strFilePath stringByAppendingPathComponent:path];
    
    return  fileName;
}


- (void)writeToFile:(NSString *) content{

    [content writeToFile:[self getFilePath:@"test.txt"] atomically:YES encoding:NSUTF8StringEncoding error:nil];
}

@end
