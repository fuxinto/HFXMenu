//
//  HFXSwitchView.m
//  Text
//
//  Created by fuxinto on 2017/11/30.
//  Copyright © 2017年 黄福鑫. All rights reserved.
//

#import "HFXSwitchView.h"
#import "HFXTitleView.h"
@interface HFXSwitchView ()<UIPageViewControllerDelegate,UIPageViewControllerDataSource>


@property (nonatomic, assign) NSInteger vcIndex;
@property (nonatomic, strong) HFXTitleView *titleView;
@property (nonatomic, strong) UIPageViewController *pageVC;
@property (nonatomic, strong, nonnull) NSArray <UIViewController *>* controllers;
@end

@implementation HFXSwitchView


- (instancetype)initWithFrame:(CGRect)frame WithTitles:(NSArray *)titles WithController:(NSArray *)controllers {
    if (self = [super initWithFrame:frame]) {
        self.titleViewHeight = 46;
        self.vcIndex = 0;
        self.controllers = controllers;
        self.titleView.titleArray = titles;
        [self addSubview:self.titleView];
        [self setTitleViewBlock];
        [self addSubview:self.pageVC.view];
        [self.pageVC setViewControllers:@[[self.controllers firstObject]] direction:UIPageViewControllerNavigationDirectionForward animated:false completion:nil];
    }
    return self;
}



- (void)setTitleViewBlock {
    __weak typeof(self) weakSelf = self;
    self.titleView.updateBlock = ^(NSInteger index) {
        if (self.vcIndex == index) {
            return;
        }
        if (index > self.vcIndex) {
            [weakSelf.pageVC setViewControllers:@[weakSelf.controllers[index]] direction:UIPageViewControllerNavigationDirectionForward animated:true completion:nil];
        }else {
            [weakSelf.pageVC setViewControllers:@[weakSelf.controllers[index]] direction:UIPageViewControllerNavigationDirectionReverse animated:true completion:nil];
        }
        weakSelf.vcIndex = index;
        if (weakSelf.delegate) [weakSelf.delegate switchViewWithCurrentViewIndex:index];
    };

}

- (void)drawRect:(CGRect)rect {
   self.pageVC.view.frame = CGRectMake(0, self.titleView.frame.size.height, self.frame.size.width, self.frame.size.height - self.titleView.frame.size.height);
    
}

#pragma mark - set

- (void)setTitleViewHeight:(CGFloat)titleViewHeight {
    _titleViewHeight = titleViewHeight;
    
    CGRect frame = self.titleView.frame;
    frame.size.height = _titleViewHeight;
    self.titleView.frame = frame;
}

-(void)setLineHeight:(CGFloat)lineHeight {
    _lineHeight = lineHeight;
    self.titleView.lineHeight = lineHeight;
}

- (void)setTitleColor:(UIColor *)titleColor {
    _titleColor = titleColor;
    self.titleView.titleColor = titleColor;
}

- (void)setSelectedTitleColor:(UIColor *)selectedTitleColor {
    _selectedTitleColor = selectedTitleColor;
    self.titleView.selectedTitleColor = selectedTitleColor;
}

- (void)setLineColor:(UIColor *)lineColor {
    _lineColor = lineColor;
    self.titleView.lineColor = lineColor;
}
- (void)settitleViewColor:(UIColor *)titleViewColor{
    _titleViewColor = titleViewColor;
    self.titleView.backgroundColor = titleViewColor;
}


#pragma mark - UIPageViewControllerDataSource

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    
    NSInteger index = [self.controllers indexOfObject:viewController];
    if (index == 0 || index == NSNotFound) {
        return nil;
    }
    
    self.vcIndex = index;
    return self.controllers[self.vcIndex-1];
}


- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController{
    NSInteger index = [self.controllers indexOfObject:viewController];
    if (index == self.controllers.count - 1 || index == NSNotFound) {
        return nil;
    }
    self.vcIndex = index;
    return self.controllers[self.vcIndex+1];
}

- (void)pageViewController:(UIPageViewController *)pageViewController willTransitionToViewControllers:(NSArray<UIViewController *> *)pendingViewControllers{
    
    self.vcIndex = [self.controllers indexOfObject:[pendingViewControllers firstObject]];
}

- (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray<UIViewController *> *)previousViewControllers transitionCompleted:(BOOL)completed{
    
    if (completed) {
        [self.titleView slidingGesturesWithIndex:self.vcIndex];
        if (self.delegate) {
            [self.delegate switchViewWithCurrentViewIndex:self.vcIndex];
        }
    }
}
- (UIPageViewController *)pageVC {
    if (!_pageVC) {
        _pageVC = [[UIPageViewController alloc]initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
        _pageVC.delegate = self;
        _pageVC.dataSource = self;
    }
    return _pageVC;
}

- (HFXTitleView *)titleView {
    if (!_titleView) {
        _titleView = [[HFXTitleView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.titleViewHeight)];
        _titleView.backgroundColor = [UIColor whiteColor];
        _titleView.titleColor = [UIColor blackColor];
        _titleView.selectedTitleColor = [UIColor redColor];
        _titleView.lineColor = [UIColor redColor];
        _titleView.lineHeight = 2;
    }
    return _titleView;
}

@end
