//
//  HFXTitleView.m
//  Text
//
//  Created by fuxinto on 2017/11/30.
//  Copyright © 2017年 黄福鑫. All rights reserved.
//

#import "HFXTitleView.h"
/**
 *  设备的高
 */
#define DEVICE_HEIGHT ([UIScreen mainScreen].bounds.size.height)
/**
 *  设备的寛
 */
#define DEVICE_WIDTH ([UIScreen mainScreen].bounds.size.width)

@interface HFXTitleView ()

@property (nonatomic, assign) NSInteger             currentIndex;
@property (nonatomic, assign) CGFloat               btnWidth;
@property (nonatomic, strong) NSMutableArray <UIButton *> *btnArray;
@property (nonatomic, strong) UIView *lineView;

@end

@implementation HFXTitleView


- (void)drawRect:(CGRect)rect {
    if (self.titleArray.count * self.btnWidth < DEVICE_WIDTH) {
        self.btnWidth = DEVICE_WIDTH/self.titleArray.count;
    }
    self.contentSize = CGSizeMake(self.titleArray.count * self.btnWidth, self.frame.size.height);
    
    for (int i = 0; i < self.titleArray.count; i++) {
        NSString *title = self.titleArray[i];
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitle:title forState:UIControlStateNormal];
        [btn setTitleColor:self.titleColor forState:UIControlStateNormal];
        [btn setTitleColor:self.selectedTitleColor forState:UIControlStateSelected];
        btn.accessibilityValue = [NSString stringWithFormat:@"%d",i];
        btn.frame = CGRectMake(self.btnWidth * i, 0, self.btnWidth, self.frame.size.height - self.lineHeight);
        [btn addTarget:self action:@selector(buttonActionWithButton:) forControlEvents:UIControlEventTouchUpInside];
        [self.btnArray addObject:btn];
        
        if (i == 0) {
            btn.selected = true;
            CGRect frame = btn.frame;
            frame.origin.y = btn.frame.size.height;
            frame.size.height = self.lineHeight;
            self.lineView = [[UIView alloc]initWithFrame:frame];
            self.lineView.backgroundColor = self.lineColor;
            [self addSubview:self.lineView];
        }
        [self addSubview:btn];
    }
}


- (void)buttonActionWithButton:(UIButton *)sender {
    
    if (self.updateBlock) self.updateBlock([sender.accessibilityValue integerValue]);
    
    [self updateViewWithButton:sender];
}

- (void)updateViewWithButton:(UIButton *)sender {
    
    NSInteger index = [sender.accessibilityValue integerValue];
    if (index == self.currentIndex) return;
    
    for (UIButton *btn in self.btnArray) {
        btn.selected = false;
    }
    sender.selected = true;
    CGRect frame = sender.frame;
    frame.origin.y = sender.frame.size.height;
    frame.size.height = self.lineHeight;
    [UIView animateWithDuration:0.5 animations:^{
        self.lineView.frame = frame;
    }];
    if (self.btnWidth != 60) {
        self.currentIndex = index;
        return;
    }
    CGFloat btnOffsetX = self.contentOffset.x;
    //判断滚动方向
    if (index > self.currentIndex) {
        //向左
        btnOffsetX += self.btnWidth;
        if (self.btnWidth*(index+3) > DEVICE_WIDTH && self.contentSize.width - btnOffsetX > DEVICE_WIDTH) {
            CGPoint offset = self.contentOffset;
            offset.x = self.btnWidth + offset.x;
            [self setContentOffset:offset animated:YES];
        }
    }else if(sender.frame.origin.x - self.btnWidth * 3 < self.contentOffset.x && self.contentOffset.x > 0){
        //向右
        CGPoint offset = self.contentOffset;
        offset.x = offset.x - self.btnWidth;
        [self setContentOffset:offset animated:YES];
    }
    self.currentIndex = index;
}

- (void)slidingGesturesWithIndex:(NSInteger)index {
    UIButton *btn = self.btnArray[index];
    [self updateViewWithButton:btn];
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.currentIndex = 0;
        self.btnWidth = 60;
        self.btnArray = [NSMutableArray array];
        self.showsHorizontalScrollIndicator = false;
        self.showsVerticalScrollIndicator = false;

    }
    return self;
}

@end
