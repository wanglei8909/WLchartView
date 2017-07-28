//
//  BaseViewController.h
//  test
//
//  Created by wanglei on 2017/7/20.
//  Copyright © 2017年 wanglei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HNBaseNavgationView.h"

@interface HNBaseViewController : UIViewController

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
@property (nonatomic, assign) SEL goBackSelector;

//topbar
@property (nonatomic, assign) BOOL isCustomTopBar;
@property (nonatomic, retain) UIColor *mTitleColor;
@property (nonatomic, retain, readonly) HNBaseNavgationView *customTopBar; // 可以支持 滑动显示隐藏
@property (nonatomic, retain) UIColor *mTopColor; //使用自定义bar时的背景颜色

- (void)goBack;
- (void)goHome;

- (void)clearNavItem;
- (void)addRightTextBtn:(NSString *)name target:(id)target action:(SEL)action;
- (void)addRightImageBtn:(UIImage *)image target:(id)target action:(SEL)action;
- (void)addLeftImageBtn:(UIImage *)image target:(id)target action:(SEL)action;
- (void)addLeftTextBtn:(NSString *)name target:(id)target action:(SEL)action;
- (void)addTitleView:(UIView *)titleView;

/**
 使用系统的图片背景导航栏
 */
- (void)useNativeNavigationBar;
/**
 使用自定义的纯色导航（默认白色）
 */
- (void)useCustomNavigationBar;

/**
 使用自定义的纯色导航
 @param color 导航颜色
 */
- (void)useCustomNavigationBar:(UIColor *)color;

/**
 隐藏导航  啥也没有了（只在使用自定义导航栏时使用）
 */
- (void)hiddenNavagationView;

/**
 设置导航栏渐变，（只在使用自定义导航栏时使用）
 @param alpha 透明度 0到1
 */
- (void)setNavigationAlaph:(CGFloat)alpha;

@end
