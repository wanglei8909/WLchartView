//
//  BaseNavgationView.m
//  test
//
//  Created by wanglei on 2017/7/20.
//  Copyright © 2017年 wanglei. All rights reserved.
//

#import "BaseNavgationView.h"

@implementation BaseNavgationView

@synthesize mTopColor, mTopImage, mTitleColor, mFontSize;

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, 0, self.frame.size.width-100, 44)];
        titleLabel.backgroundColor = [UIColor clearColor];
        titleLabel.font = [UIFont fontWithName:@"Helvetica-Light" size:mFontSize];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.textColor = self.mTitleColor;
        self.titleView = titleLabel;
        
        [self AddLeftImageBtn:nil target:nil action:nil];
        [self AddRightImageBtn:nil target:nil action:nil];
    }
    return self;
}

- (void)ClearNavItem{
    [self.leftButton removeFromSuperview];
    [self.rightButton removeFromSuperview];
    [self.titleView removeFromSuperview];
}


- (UIButton *)GetTextBarItem:(NSString *)name target:(id)target action:(SEL)action {
    NSAttributedString *attString = [[NSAttributedString alloc] initWithString:name attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]}];
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame = CGRectMake(0, 0, attString.size.width, 44);
    [rightBtn setTitle:name forState:UIControlStateNormal];
    [rightBtn setTitleColor:self.mTitleColor forState:UIControlStateNormal];
    rightBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [rightBtn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return rightBtn;
}

- (UIButton *)GetImageBarItem:(UIImage *)image target:(id)target action:(SEL)action{
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame = CGRectMake(0, 0, 50, 44);
    [rightBtn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    [rightBtn setImage:image forState:UIControlStateNormal];
    return rightBtn;
}

- (void)AddRightTextBtn:(NSString *)name target:(id)target action:(SEL)action{
    self.rightButton = [self GetTextBarItem:name target:target action:action];
}

- (void)AddRightImageBtn:(UIImage *)image target:(id)target action:(SEL)action{
    self.rightButton = [self GetImageBarItem:image target:target action:action];
}

- (void)AddLeftTextBtn:(NSString *)text target:(id)target action:(SEL)action{
    self.leftButton = [self GetTextBarItem:text target:target action:action];
}

- (void)AddLeftImageBtn:(UIImage *)image target:(id)target action:(SEL)action{
    self.leftButton = [self GetImageBarItem:image target:self action:action];
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

- (void)AddTitleView:(UIView *)titleView{
    [self setTitleView:titleView];
}

- (void)setTitleView:(UIView *)titleView{
    if (_titleView) {
        [_titleView removeFromSuperview];
    }
    _titleView = titleView;
    [self addSubview:_titleView];
}

- (void)setMlbTitle:(NSString *)mlbTitle{
    _mlbTitle = mlbTitle;
    if ([self.titleView isKindOfClass:[UILabel class]]) {
        UILabel *label = (UILabel *)self.titleView;
        [label setText:mlbTitle];
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
