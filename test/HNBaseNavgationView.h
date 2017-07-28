//
//  BaseNavgationView.h
//  test
//
//  Created by wanglei on 2017/7/20.
//  Copyright © 2017年 wanglei. All rights reserved.
//

//#### 主题形式


#import <UIKit/UIKit.h>

@interface HNBaseNavgationView : UIView

@property (nonatomic, retain, readonly) UIButton *leftButton;
@property (nonatomic, retain, readonly) UIButton *rightButton;
@property (nonatomic, retain, readonly) UIView *titleView;
@property (nonatomic, retain) NSString *title;
@property (nonatomic, retain) UIColor *mTitleColor;//title 和左右按钮同一个颜色
@property (nonatomic, retain) UIColor *mTopColor;
@property (nonatomic, retain) UIImage *backgroundImage;

- (void)clearNavItem;
- (void)addRightTextBtn:(NSString *)name target:(id)target action:(SEL)action;
- (void)addRightImageBtn:(UIImage *)image target:(id)target action:(SEL)action;
- (void)addLeftTextBtn:(NSString *)text target:(id)target action:(SEL)action;
- (void)addLeftImageBtn:(UIImage *)image target:(id)target action:(SEL)action;
- (void)addTitleView:(UIView *)titleView;

- (void)setNavigationAlaph:(CGFloat)alpha;

@end
