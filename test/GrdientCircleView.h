//
//  GrdientCircleView.h
//  test
//
//  Created by wanglei on 2017/7/22.
//  Copyright © 2017年 wanglei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GrdientCircleView : UIView

@property (nonatomic, strong) UIColor *startColor;
@property (nonatomic, strong) UIColor *endColor;
@property (nonatomic, assign) CGFloat iRadius;
@property (nonatomic, assign) CGFloat progressRingWidth;

- (void)setStartProgress:(CGFloat)startProgress endProgress:(CGFloat)endProgress animated:(BOOL)animated;

@end
