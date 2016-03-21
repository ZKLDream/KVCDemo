//
//  Person.h
//  KVCDemo
//
//  Created by 千锋 on 16/3/21.
//  Copyright © 2016年 mobiletrain. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class Car;


@interface Person : NSObject

@property (nonatomic,copy)NSString *name;//名字
@property (nonatomic,assign)NSInteger age;//年龄

@property (nonatomic,assign)float weight;//体重

@property (nonatomic,copy)NSString *ID;//工牌号

@property (nonatomic,strong)Car *car;//车
@end

@interface Car : NSObject

@property (nonatomic,assign) float light;//排量

@property (nonatomic,strong)UIColor *color;//颜色



@end