#ArchiverDemo
* 主要实现了IOS的归档和接单
使用NSKeyedArichiver进行归档、NSKeyedUnarchiver进行接档，这种方式会在写入、读出数据之前对数据进行序列化、反序列化操作。

### 简单归档解档字符串

```
NSString *homeDictionary = NSHomeDirectory();//获取根目录  
NSString *homePath  = [homeDictionary stringByAppendingPathComponent:@"atany.archiver"];//添加储存的文件名  
BOOL flag = [NSKeyedArchiver archiveRootObject:@”归档” toFile:homePath];//归档一个字符串 

//解档
[NSKeyedUnarchiver unarchiveObjectWithFile:homePath] 
```
### 对多个对象的归档

```
//归档
//准备数据  
CGPoint point = CGPointMake(1.0, 2.0);  
NSString *info = @"坐标原点";  
NSInteger value = 10;  
NSString *multiHomePath = [NSHomeDirectory() stringByAppendingPathComponent:@"multi.archiver"];  
NSMutableData *data = [[NSMutableData alloc]init];  
NSKeyedArchiver *archvier = [[NSKeyedArchiver alloc]initForWritingWithMutableData:data];  
  
//对多个对象进行归档  
[archvier encodeCGPoint:point forKey:@"kPoint"];  
[archvier encodeObject:info forKey:@"kInfo"];  
[archvier encodeInteger:value forKey:@"kValue"];  
[archvier finishEncoding];  
[data writeToFile:multiHomePath atomically:YES];  

//解档

NSMutableData *dataR = [[NSMutableData alloc]initWithContentsOfFile:multiHomePath];  
NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc]initForReadingWithData:dateR];  
CGPoint pointR = [unarchiver decodeCGPointForKey:@"kPoint"];  
NSString *infoR = [unarchiver decodeObjectForKey:@"kInfo"];  
NSInteger valueR = [unarchiver decodeIntegerForKey:@"kValue"];  
[unarchiver finishDecoding];  
NSLog(@"%f,%f,%@,%d",pointR.x,pointR.y,infoR,valueR);
```
### 对自定义对象进行归档
```

#import <Foundation/Foundation.h>

@interface Person : NSObject<NSCoding>

@property (nonatomic, copy) NSString *name;

@property (nonatomic, assign) int age;

-(instancetype) initWithName:(NSString *) name;
@end
-----------------------------------
#import "Person.h"

@implementation Person

-(instancetype) initWithName:(NSString *) name{

    if ([super init]) {
        self.name = name;
    }
    return self;
}

#pragma -mark将对象转化为NSData的方法
-(void)encodeWithCoder:(NSCoder *)aCoder{

    [aCoder encodeObject:self.name forKey:@"name"];
    [aCoder encodeInt:self.age forKey:@"age"];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder{

    if ([self init]) {
        //解压过程
        self.name = [aDecoder decodeObjectForKey:@"name"];
        self.age = [[aDecoder decodeObjectForKey:@"age"] intValue];
    }
    return self;
}

- (instancetype) copyWithZone:(NSZone *) zone{
    Person *copy = [[[self class] allocWithZone:zone] init];
    copy.name = [self.name copyWithZone:zone];
    copy.age = self.age;
    return copy;
}


@end

-------------------------------------
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
