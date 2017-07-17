//
//  ViewController.m
//  ss
//
//  Created by 楚简约 on 17/7/17.
//  Copyright © 2017年 楚简约. All rights reserved.
//

#import "ViewController.h"
#import "FBKVOController.h"
#import "Person.h"


NS_ASSUME_NONNULL_BEGIN

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSString * _myTitle;
}

//FBKVOController
@property (nonatomic,strong) FBKVOController *KVOController;
//person
@property (nonatomic,strong) Person *person;

@property (nonatomic, assign) NSInteger kimiNum;

@property (strong, nonatomic)  UIView *colorView;



@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"FaceBook";
    self.view.backgroundColor = [UIColor redColor];
    
    
    
    _person = [Person new];
    _person.name = @"脸书";
    _person.age = 1987;
    self.kimiNum = 0;
//    NSLog(@"--40-- %@",_person.name);
   
    FBKVOController *KVOController = [FBKVOController controllerWithObserver:self];
    self.KVOController = KVOController;
    
#pragma mark -- 监听单个Key改变
//    [self.KVOController observe:_person keyPath:@"name" options: NSKeyValueObservingOptionNew block:^(id  _Nullable observer, id  _Nonnull object, NSDictionary<NSString *,id> * _Nonnull change) {
//        
//        self.title = change[NSKeyValueChangeNewKey];
//    }];
    
#pragma mark -- 监听多个key改变
//    [self.KVOController observe:_person keyPaths:@[@"name",@"age"] options:NSKeyValueObservingOptionOld | NSKeyValueObservingOptionNew block:^(id observer, id object, NSDictionary* change) {
//        
//        NSString *changedKeyPath = change[FBKVONotificationKeyPathKey];
//        
//        if ([changedKeyPath isEqualToString:@"name"]) {
//            NSLog(@"修改了名字");
//        }else if ([changedKeyPath isEqualToString:@"age"]) {
//            NSLog(@"修改了年龄");
//        }
//        
//        NSLog(@"旧值是:%@",change[NSKeyValueChangeOldKey]);
//        NSLog(@"新值是:%@",change[NSKeyValueChangeNewKey]);
//        
//        if ([changedKeyPath isEqualToString:@"name"]) {
//            self.title = change[NSKeyValueChangeNewKey];
//        }
//
//    }];
    
    
    UITableView *tableVeiw = [[UITableView alloc] init];
    tableVeiw.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    tableVeiw.delegate = self;
    tableVeiw.dataSource = self;
    [self.view addSubview:tableVeiw];
    
    _colorView = [[UIView alloc] initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height - 100, 100, 100)];
    _colorView.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:_colorView];
    
#pragma mark -- 监听改变调用方法
    [_KVOController observe:self keyPath:@"kimiNum" options:0 action:@selector(changeColor)];
}


- (void)changeColor {
    int R = (arc4random() % 256) ;
    int G = (arc4random() % 256) ;
    int B = (arc4random() % 256) ;
    self.colorView.backgroundColor = [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:1];
}

#pragma mark -- UITableView 代理方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *JH = @"CELL";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:JH];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:JH];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"%zd----%zd",indexPath.section,indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    _person.name = [NSString stringWithFormat:@"脸书--%zd--改变",indexPath.row];
    _person.age = indexPath.row + 1900;
    
    self.kimiNum = indexPath.row;
    
//    NSLog(@"new----%@",_person.name);
}
@end


NS_ASSUME_NONNULL_END















