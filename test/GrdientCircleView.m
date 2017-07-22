//
//  GrdientCircleView.m
//  test
//
//  Created by wanglei on 2017/7/22.
//  Copyright © 2017年 wanglei. All rights reserved.
//

#import "GrdientCircleView.h"

#import <CoreGraphics/CoreGraphics.h>

@interface GrdientCircleView ()
{
    CGFloat beginR;
    CGFloat beginG;
    CGFloat beginB;
    CGFloat endR;
    CGFloat endG;
    CGFloat endB;
}
@property (nonatomic, strong) UIColor *trackTintColor;

@property (nonatomic, assign) CGFloat startProgress;
@property (nonatomic, assign) CGFloat endProgress;
@property (nonatomic, assign) CGFloat backgroundRingWidth;



@property (nonatomic, strong) CAShapeLayer *backgroundLayer;

@end

@implementation GrdientCircleView

#pragma mark - Initializers -

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self initialize];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initialize];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)decoder
{
    self = [super initWithCoder:decoder];
    if (self) {
        [self initialize];
    }
    return self;
}

#pragma mark - Initialize -

- (void)initialize
{
    self.backgroundColor = [UIColor clearColor];
    _trackTintColor = [UIColor colorWithWhite:1 alpha:0.05f];
    
    [[UIColor yellowColor] getRed:&beginR green:&beginG blue:&beginB alpha:nil];
    [[UIColor redColor] getRed:&endR green:&endG blue:&endB alpha:nil];
    
    _backgroundRingWidth = 10.0f;
    _progressRingWidth = 10.0f;
    
    _backgroundLayer = [CAShapeLayer layer];
    _backgroundLayer.fillColor = [UIColor colorWithWhite:1 alpha:0.005f].CGColor;
    _backgroundLayer.strokeColor = [UIColor whiteColor].CGColor;
    _backgroundLayer.lineWidth = _backgroundRingWidth + 2;
    [self.layer addSublayer:_backgroundLayer];
}

#pragma mark - Override super methods -

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    
    [self drawBackground];
    [self drawProgress];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    _backgroundLayer.frame = self.bounds;
    
    [self setNeedsDisplay];
}

- (void)setStartColor:(UIColor *)startColor{
    _startColor = startColor;
    [startColor getRed:&beginR green:&beginG blue:&beginB alpha:nil];
}

- (void)setEndColor:(UIColor *)endColor{
    _endColor = endColor;
    [endColor getRed:&endR green:&endG blue:&endB alpha:nil];
}

- (void)setProgressRingWidth:(CGFloat)progressRingWidth
{
    _progressRingWidth = progressRingWidth;
    _backgroundRingWidth = progressRingWidth + 2;
    _backgroundLayer.lineWidth = _backgroundRingWidth;
}


#pragma mark - Progress -

- (void)setStartProgress:(CGFloat)startProgress endProgress:(CGFloat)endProgress animated:(BOOL)animated
{
    self.startProgress = startProgress;
    self.endProgress = endProgress;
    
    if (animated == NO) {
        [self setNeedsDisplay];
    } else {
        [self setNeedsDisplay];
        CABasicAnimation *pathAnimation = [CABasicAnimation animationWithKeyPath:@"strokeStart"];
        pathAnimation.duration = 1.5;
        pathAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        pathAnimation.fromValue = [NSNumber numberWithFloat:0.0f];
        pathAnimation.toValue = [NSNumber numberWithFloat:1.0f];
        pathAnimation.autoreverses = NO;
        pathAnimation.removedOnCompletion = NO;
        pathAnimation.fillMode = kCAFillModeForwards;
        [_backgroundLayer addAnimation:pathAnimation forKey:@"strokeEndAnimation"];
    }
}

- (void)drawBackground
{
    CGFloat startAngle = 2.0 * M_PI * self.startProgress;
    CGFloat endAngle =  (2.0 * M_PI * self.endProgress);
    CGPoint center = CGPointMake(self.bounds.size.width / 2.0, self.bounds.size.height / 2.0 - 20);
    CGFloat radius = self.iRadius;
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    path.lineWidth = _progressRingWidth;
    [path addArcWithCenter:center radius:radius startAngle:startAngle endAngle:endAngle clockwise:YES];
    _backgroundLayer.path = path.CGPath;
}

- (void)drawProgress
{
    CGFloat startAngle = 2.0 * M_PI * self.startProgress;
    CGFloat endAngle = (2.0 * M_PI * self.endProgress );
    CGPoint center = CGPointMake(self.bounds.size.width / 2.0, self.bounds.size.height / 2.0 - 20);
    CGFloat radius = self.iRadius;
    
    int sectors = 200;
    float angle ;
    
    CGFloat startAngleNeedDraw ;
    if (endAngle - startAngle >  2.0 * M_PI) {
        angle = 2 * M_PI/sectors;
        startAngleNeedDraw = endAngle - 2.0 * M_PI;
    } else {
        angle = (endAngle - startAngle) / sectors;
        startAngleNeedDraw = startAngle;
    }
    
    UIBezierPath *sectorPath;
    for (int i = 0; i < sectors; i ++) {
        CGFloat ratio = (float)i / (float)sectors ;
        CGFloat R = beginR + (endR - beginR) * ratio ;
        CGFloat G = beginG + (endG - beginG) * ratio ;
        CGFloat B = beginB + (endB - beginB) * ratio ;
        
        sectorPath = [UIBezierPath bezierPathWithArcCenter:center radius:radius startAngle:startAngleNeedDraw + i * angle endAngle:startAngleNeedDraw + (i + 1) * angle clockwise:YES];
        
        UIColor *color = [UIColor colorWithRed:R green:G blue:B alpha:1];
        [sectorPath setLineWidth:_progressRingWidth];
        [color setStroke];
        [sectorPath stroke];
    }
}

@end
