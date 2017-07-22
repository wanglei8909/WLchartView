//
//  BaseViewController.h
//  test
//
//  Created by wanglei on 2017/7/20.
//  Copyright © 2017年 wanglei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseNavgationView.h"

@interface BaseViewController : UIViewController

/**
 图片背景的导航栏用系统的  其他的 隐藏系统的 用自定义的
 */

/**
 只需要关注本页面是用系统的还是用自定义的
 */
/**
 系统的话 从导航栏下边开始 self.view.height = screen.height - 64
 自定义的 self.view.top从屏幕顶部开始  self.view.height = screen.height（布局时需要注意Y开始位置）
 */
@property (nonatomic, weak) id delegate;
@property (nonatomic, assign) SEL OnGoBack;

//topbar
@property (nonatomic, assign) BOOL isCustomTopBar;
@property (nonatomic, readonly) UILabel *mlbTitle;
@property (nonatomic, retain) UIColor *mTitleColor;
@property (nonatomic, retain) UIColor *mTopColor;
@property (nonatomic, retain) UIImage *mTopImage;
@property (nonatomic, assign) int mFontSize;
@property (nonatomic, retain) BaseNavgationView *customTopBar; // 可以支持 滑动显示隐藏


- (void)GoBack;
- (void)GoHome;

- (void)ClearNavItem;
- (void)AddRightTextBtn:(NSString *)name target:(id)target action:(SEL)action;
- (void)AddRightImageBtn:(UIImage *)image target:(id)target action:(SEL)action;
- (void)AddLeftImageBtn:(UIImage *)image target:(id)target action:(SEL)action;
- (void)AddLeftTextBtn:(NSString *)name target:(id)target action:(SEL)action;
- (void)AddTitleView:(UIView *)titleView;

/**
 使用系统的图片背景导航栏
 */
- (void)UseImageNavigationBack;
/**
 使用自定义的纯色导航（默认白色）
 */
- (void)UsePureColorNavigationBack;

/**
 使用自定义的纯色导航
 @param color 导航颜色
 */
- (void)UsePureColorNavigationBack:(UIColor *)color;

/**
 隐藏导航  啥也没有了
 */
- (void)HiddenNavagationView;


@end
