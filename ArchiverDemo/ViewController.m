//
//  ViewController.m
//  ArchiverDemo
//
//  Created by 嵇明新 on 2017/2/23.
//  Copyright © 2017年 lanhe. All rights reserved.
//

#import "ViewController.h"
#import "Person.h"
#import "FileManager.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    
    //一、使用archiveRootObject进行简单的归档
    NSString *homeDictionary = NSHomeDirectory();//获取根目录
    NSString *homePath  = [homeDictionary stringByAppendingPathComponent:@"atany.archiver"];//添加储存的文件名
    BOOL flag = [NSKeyedArchiver archiveRootObject:@"归档" toFile:homePath];//归档一个字符串
    
    NSString * string = [NSKeyedUnarchiver unarchiveObjectWithFile:homePath];
    
    //二、对多个对象的归档
    //准备数据
    CGPoint point = CGPointMake(1.0, 2.0);
    NSString *info = @"坐标原点";
    NSInteger value = 10;
    NSString *multiHomePath = [NSHomeDirectory() stringByAppendingPathComponent:@"multi.archiver"];
    NSMutableData *dataStr = [[NSMutableData alloc]init];
    NSKeyedArchiver *archvier = [[NSKeyedArchiver alloc]initForWritingWithMutableData:dataStr];
    
    //对多个对象进行归档
    [archvier encodeCGPoint:point forKey:@"kPoint"];
    [archvier encodeObject:info forKey:@"kInfo"];
    [archvier encodeInteger:value forKey:@"kValue"];
    [archvier finishEncoding];
    [dataStr writeToFile:multiHomePath atomically:YES];
    
    //解档
    NSMutableData *dataR = [[NSMutableData alloc]initWithContentsOfFile:multiHomePath];
    NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc]initForReadingWithData:dataR];
    CGPoint pointR = [unarchiver decodeCGPointForKey:@"kPoint"];
    NSString *infoR = [unarchiver decodeObjectForKey:@"kInfo"];
    NSInteger valueR = [unarchiver decodeIntegerForKey:@"kValue"];
    [unarchiver finishDecoding];
    NSLog(@"%f,%f,%@,%d",pointR.x,pointR.y,infoR,valueR);
    
    //***********自定义对象归档，序列化****************
    Person *p = [[Person alloc] init];
    p.name = @"abc";
    p.age = 12;
    
    
    //1.创建一个可变的二进制流
    NSMutableData *data=[[NSMutableData alloc]init];
    //2.创建一个归档对象(有将自定义类转化为二进制流的功能)
    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
    //3.用该归档对象，把自定义类的对象，转为二进制流
    [archiver encodeObject:p forKey:@"person"];
    //4归档完毕
    [archiver finishEncoding];
    
    //将data写入文件
    [data writeToFile:[self getFilePath:@"person.archiver"] atomically:YES];
    NSLog(@"%@",data);
    
    
    //******************反归档******************
    NSMutableData *mData=[NSMutableData dataWithContentsOfFile:[self getFilePath:@"person.archiver"]];
    //2.创建一个反归档对象，将二进制数据解成正行的oc数据
    NSKeyedUnarchiver *unArchiver=[[NSKeyedUnarchiver alloc]initForReadingWithData:mData];
    Person *p2= [unArchiver decodeObjectForKey:@"person"];
    
    NSLog(@"名字:%@",p2.name);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSString *) getFilePath:(NSString *) path{
    
    //设定文本框存储文件的位置
    NSString *strFilePath=[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)objectAtIndex:0];
    //指定存储文件的文件名
    NSString *fileName=[strFilePath stringByAppendingPathComponent:path];
    
    return  fileName;
}

@end
