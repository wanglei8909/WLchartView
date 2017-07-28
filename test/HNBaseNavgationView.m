//
//  BaseNavgationView.m
//  test
//
//  Created by wanglei on 2017/7/20.
//  Copyright © 2017年 wanglei. All rights reserved.
//

#import "HNBaseNavgationView.h"

@interface HNBaseNavgationView()

@property (nonatomic, assign) int mFontSize;
@property (nonatomic, retain) UILabel *titleLabel;
@property (nonatomic, retain) UIImageView *backgroundImageView;

@end

@implementation HNBaseNavgationView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.mTitleColor = [UIColor blackColor];
        _mFontSize = 19;
        _mTopColor = [UIColor whiteColor];
        
        _backgroundImageView = [[UIImageView alloc] initWithFrame:frame];
        _backgroundImageView.backgroundColor = [UIColor clearColor];
        [self addSubview:_backgroundImageView];
        
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width-100, 44)];
        _titleLabel.backgroundColor = [UIColor clearColor];
        _titleLabel.font = [UIFont systemFontOfSize:_mFontSize];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.textColor = self.mTitleColor;
        self.titleView = _titleLabel;

        [self addLeftImageBtn:nil target:nil action:nil];
        [self addRightImageBtn:nil target:nil action:nil];
    }
    return self;
}

- (void)setBackgroundImage:(UIImage *)backgroundImage{
    _backgroundImage = backgroundImage;
    _backgroundImageView.image = backgroundImage;
}

- (void)clearNavItem{
    [self.leftButton removeFromSuperview];
    [self.rightButton removeFromSuperview];
    [self.titleView removeFromSuperview];
}

- (UIButton *)getTextBarItem:(NSString *)name target:(id)target action:(SEL)action {
    NSAttributedString *attString = [[NSAttributedString alloc] initWithString:name attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]}];
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame = CGRectMake(0, 0, attString.size.width, 44);
    [rightBtn setTitle:name forState:UIControlStateNormal];
    [rightBtn setTitleColor:self.mTitleColor forState:UIControlStateNormal];
    rightBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [rightBtn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return rightBtn;
}

- (UIButton *)getImageBarItem:(UIImage *)image target:(id)target action:(SEL)action{
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame = CGRectMake(0, 0, 50, 44);
    [rightBtn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    [rightBtn setImage:image forState:UIControlStateNormal];
    return rightBtn;
}

- (void)addRightTextBtn:(NSString *)name target:(id)target action:(SEL)action{
    self.rightButton = [self getTextBarItem:name target:target action:action];
}

- (void)addRightImageBtn:(UIImage *)image target:(id)target action:(SEL)action{
    self.rightButton = [self getImageBarItem:image target:target action:action];
}

- (void)addLeftTextBtn:(NSString *)text target:(id)target action:(SEL)action{
    self.leftButton = [self getTextBarItem:text target:target action:action];
}

- (void)addLeftImageBtn:(UIImage *)image target:(id)target action:(SEL)action{
    self.leftButton = [self getImageBarItem:image target:self action:action];
}

- (void)setLeftButton:(UIButton *)leftButton{
    if (_leftButton) {
        [_leftButton removeFromSuperview];
    }
    _leftButton = leftButton;
    _leftButton.center = CGPointMake(self.leftButton.frame.size.width*0.5+10, 20 + 22);
    [self addSubview:_leftButton];
}

- (void)setRightButton:(UIButton *)rightButton{
    if (_rightButton) {
        [_rightButton removeFromSuperview];
    }
    _rightButton = rightButton;
    _rightButton.center = CGPointMake(self.frame.size.width - (self.leftButton.frame.size.width*0.5+10), 20 + 22);
    [self addSubview:_rightButton];
}

- (void)addTitleView:(UIView *)titleView{
    [self setTitleView:titleView];
}

- (void)setTitleView:(UIView *)titleView{
    if (_titleView) {
        [_titleView removeFromSuperview];
    }
    _titleView = titleView;
    _titleView.center = CGPointMake(self.frame.size.width*0.5, 20+22);
    [self addSubview:_titleView];
}

- (void)setTitle:(NSString *)title{
    _title = title;
    if ([self.titleView isKindOfClass:[UILabel class]]) {
        UILabel *label = (UILabel *)self.titleView;
        [label setText:title];
    }
}

- (void)setMTitleColor:(UIColor *)mTitleColor{
    _mTitleColor = mTitleColor;
    if ([self.titleView isKindOfClass:[UILabel class]]) {
        UILabel *label = (UILabel *)self.titleView;
        [label setTextColor:mTitleColor];
    }
    [_leftButton setTitleColor:mTitleColor forState:UIControlStateNormal];
    [_rightButton setTitleColor:mTitleColor forState:UIControlStateNormal];
}

- (void)setNavigationAlaph:(CGFloat)alpha{
    self.alpha = alpha;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
