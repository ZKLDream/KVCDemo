//
//  Person.m
//  KVCDemo
//
//  Created by 千锋 on 16/3/21.
//  Copyright © 2016年 mobiletrain. All rights reserved.
//

#import "Person.h"

@interface Person ()

@end

@implementation Person
{
    float _height;  //   身高
}

//返回字符串 当打印对象时 会调用该属性的方法
-(NSString *)description{
    
    NSString *str=[NSString stringWithFormat:@"%@ %ld %f height %.2f",self.name,self.age,self.weight,_height];
    return str;
    
}

//当通过KVC方式访问私有成员变量时 是否可以给私有成员变量赋值和取值
//默认为YES
+(BOOL)accessInstanceVariablesDirectly{
    
    return NO;
}

//当通过KVC方式访问对象中不存在的key时  对象会回调该方法
//如果不实现该方法 会导致程序崩溃
-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
    NSLog(@"undefine key:%@ vale:%@",key,value);
    if ([key isEqualToString:@"id"]) {
        self.ID=value;
    }
}

//通过KVC方式访问对象中不存在的key 若不实现会导致崩溃

-(id)valueForUndefinedKey:(NSString *)key{
    
    if ([key isEqualToString:@"id"]) {
        return self.ID;
        
    }
    return nil;
}
@end


@implementation Car


@end


