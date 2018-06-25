//
//  HFXTitleView.h
//  Text
//
//  Created by fuxinto on 2017/11/30.
//  Copyright © 2017年 黄福鑫. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^TitleViewBlock) (NSInteger index);
@interface FXTitleView : UIScrollView
@property (nullable, nonatomic,copy) UIColor *      titleColor;
@property (nullable, nonatomic,copy) UIColor *      selectedTitleColor;
@property (nullable, nonatomic,copy) UIColor *      lineColor;
@property (nonatomic, strong, nonnull) NSArray <NSString *> *titleArray;
@property (nonatomic, assign) CGFloat               lineHeight;
@property (nonatomic, copy, nullable) TitleViewBlock  updateBlock;

/**
 滑动控制器更新菜单栏
 
 @param index 控制器下标
 */
- (void)slidingGesturesWithIndex:(NSInteger)index;
@end

