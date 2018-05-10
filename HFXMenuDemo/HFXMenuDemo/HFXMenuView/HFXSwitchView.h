//
//  HFXSwitchView.h
//  Text
//
//  Created by fuxinto on 2017/11/30.
//  Copyright © 2017年 黄福鑫. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol HFXSwitchViewDelegate <NSObject>
@required

/**
 返回当前控制器下标

 @param index 下标
 */
- (void)switchViewWithCurrentViewIndex:(NSInteger)index;

@end
@interface HFXSwitchView : UIView

/**
 上方文字颜色
 */
@property (nullable, nonatomic,copy) UIColor *      titleColor;
/**
 选择文字颜色
 */
@property (nullable, nonatomic,copy) UIColor *      selectedTitleColor;
/**
 下划线颜色
 */
@property (nullable, nonatomic,copy) UIColor *      lineColor;
/**
 菜单背景颜色
 */
@property (nullable, nonatomic,copy) UIColor *      titleViewColor;
/**
 下划线高度
 */
@property (nonatomic, assign) CGFloat               lineHeight;
/**
 上方菜单高度
 */
@property (nonatomic, assign) CGFloat               titleViewHeight;
/**
 获取选中控制器下标代理
 */
@property (nonatomic, weak, nullable) id<HFXSwitchViewDelegate> delegate;


/**
 初始化方法

 @param frame view的Frame
 @param titles 上方菜单的标题数组
 @param controllers 控制器数组
 @return self
 */
- (instancetype _Nonnull )initWithFrame:(CGRect)frame WithTitles:(NSArray *_Nonnull)titles WithController:(NSArray *_Nonnull)controllers;

@end
