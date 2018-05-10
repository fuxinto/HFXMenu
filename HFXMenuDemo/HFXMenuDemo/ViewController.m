//
//  ViewController.m
//  HFXMenuDemo
//
//  Created by fuxinto on 2018/5/10.
//  Copyright © 2018年 fuxinto. All rights reserved.
//

#import "ViewController.h"
#import "HFXSwitchView.h"

@interface ViewController ()<HFXSwitchViewDelegate>{
    NSArray *array;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    array = @[@"语文",@"数学",@"语文",@"生物",@"化学",@"物理",@"ENGHLISH",@"历史",@"地理",@"体育"];
    NSMutableArray *vcs =[NSMutableArray array];
    for (int i =0; i< array.count; i++) {
        UIViewController *VC = [[UIViewController alloc]init];
        int R = (arc4random() % 256) ;
        int G = (arc4random() % 256) ;
        int B = (arc4random() % 256) ;
        VC.view.backgroundColor = [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:1];
        [vcs addObject:VC];
    }
    self.navigationItem.title = array.firstObject;
    HFXSwitchView *view = [[HFXSwitchView alloc]initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height) WithTitles:array WithController:vcs];
    view.delegate = self;
    [self.view addSubview:view];
}

/**
 返回当前控制器下标
 
 @param index 下标
 */
- (void)switchViewWithCurrentViewIndex:(NSInteger)index{
    NSLog(@"当前第%ld个",index);
    self.navigationItem.title = array[index];
}


@end
