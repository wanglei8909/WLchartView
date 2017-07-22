//
//  BaseNavgationView.h
//  test
//
//  Created by wanglei on 2017/7/20.
//  Copyright © 2017年 wanglei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseNavgationView : UIView

@property (nonatomic, retain, readonly) UIButton *leftButton;
@property (nonatomic, retain, readonly) UIButton *rightButton;
@property (nonatomic, retain, readonly) UIView *titleView;

@property (nonatomic, retain) NSString *mlbTitle;
@property (nonatomic, retain) UIColor *mTitleColor;
@property (nonatomic, retain) UIColor *mTopColor;
@property (nonatomic, retain) UIImage *mTopImage;
@property (nonatomic, assign) int mFontSize;

- (void)ClearNavItem;
- (void)AddRightTextBtn:(NSString *)name target:(id)target action:(SEL)action;
- (void)AddRightImageBtn:(UIImage *)image target:(id)target action:(SEL)action;
- (void)AddLeftTextBtn:(NSString *)text target:(id)target action:(SEL)action;
- (void)AddLeftImageBtn:(UIImage *)image target:(id)target action:(SEL)action;
- (void)AddTitleView:(UIView *)titleView;


@end
