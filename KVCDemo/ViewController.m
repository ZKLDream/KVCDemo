//
//  ViewController.m
//  KVCDemo
//
//  Created by 千锋 on 16/3/21.
//  Copyright © 2016年 mobiletrain. All rights reserved.
//

#import "ViewController.h"
#import "Person.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *TextFiled;
- (IBAction)ModifyAgeAction:(UIButton *)sender;

@property (nonatomic,strong)Person *luoPerson;
@end

@implementation ViewController

//KVC的用法1
-(void)KVCDemo1{
    
    Person *person=[[Person alloc]init];
    person.name=@"洛神";
    person.age=36;
    person.weight=80;
    NSLog(@"person %@",person);
    //通过KVC方式修改对象的成员变量的值
    
    //所有继承自NSObject类的子类都具备KVC的特性
    
    //参数1：给对象设置的值
    //参数2：成员变量的名称
    
    [person setValue:[NSNumber numberWithFloat:70] forKey:@"weight"];
    NSLog(@"person %@",person);
    
    //通过KVC方式获取成员变量的值
    NSString *name=[person valueForKey:@"name"];
    NSLog(@"%@",name);
    
//    通过KVC方式修改实现中定义的成员变量
    [person setValue:[NSNumber numberWithFloat:1.85] forKey:@"height"];
    NSLog(@"person %@",person);
}

//KVC用法2
-(void)KVCDemo2{
    
    Person *person=[[Person alloc]init];
    person.name=@"洛神";
    person.age=36;
    person.weight=80;
    NSLog(@"person %@",person);
    
    //当通过KVC方式访问改对象中不存在的成员变量时
    [person setValue:@"love" forKey:@"child"];
    
    //当通过KVC方式获取该对象中不存在的key
    [person valueForKey:@"child"];
    
    
    
}

//KVC用法3
-(void)KVCDemo3{
    
    Person *person=[[Person alloc]init];
    person.name=@"洛神";
    person.age=36;
    person.weight=80;
    NSLog(@"person %@",person);
    
    [person setValue:@"洛神是一个全栈工程师" forKey:@"id"];
    NSString *ID=[person valueForKey:@"id"];
    NSLog(@"ID = %@",ID);
    
}



//KVC的用法4
//将字典转换成模型对象
-(void)KVCDemo4{
    NSMutableDictionary *dict=[NSMutableDictionary dictionary];
    dict[@"name"]=@"EZ";
    dict[@"age"]=@22;
    dict[@"weight"]=@40;
    dict[@"id"]=@23;
    Person *person=[[Person alloc]init];
    //通过KVC方式将字典中的key和对象的key关联起来
    [person setValuesForKeysWithDictionary:dict];
    
    NSLog(@"%@",person);
    
}


-(void)KVODemo{
    self.luoPerson=[[Person alloc]init];
   self.luoPerson.name=@"洛神";
    self.luoPerson.age=36;
    self.luoPerson.weight=80;
    NSLog(@"person %@",self.luoPerson);
    
    //通过KVO观察该对象
    
    //添加一个观察者 观察该对象的成员变量值得变化情况
//    NSKeyValueObservingOptionNew 
//    NSKeyValueObservingOptionOld
    
    //参数2：观察该对象的值路径
    //参数3：当对象的值改变时 观察者接受到的值情况
    //参数4：上下文 语境
   
    [self.luoPerson addObserver:self forKeyPath:@"age" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
    //监听对象的属性的属性 car的light 监听路径
    [self.luoPerson addObserver:self forKeyPath:@"car.light" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
    //通过keypath设置或者获取值
    
    self.luoPerson.car=[[Car alloc]init];
    //通过KVC的keypath设置值
    [self.luoPerson setValue:[NSNumber numberWithFloat:1.5] forKeyPath:@"car.light"];
    //通过KVC的keypath获取值
    NSNumber *light=[self.luoPerson valueForKeyPath:@"car.light"];
    NSLog(@" car light %@",light);
}

//当当前对象检测到观察的值变化时 会调用该方法

//@param keyPath 值路径 观察对象的值路径
//@param object  被观察的值
//@param change 值变化的情况
//@param context  上下文环境

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{
    
    NSLog(@"keyPath %@  object %@ change %@",keyPath,object,change);
}


//需要移除观察者  否则会造成内存泄露
-(void)dealloc{
    [self.luoPerson removeObserver:self forKeyPath:@"age"];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self KVODemo];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)ModifyAgeAction:(UIButton *)sender {
    
    NSString *newAge=self.TextFiled.text;
    if (newAge.length>0) {
        self.luoPerson.age=[newAge integerValue];
    }
}
@end
