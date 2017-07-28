//
//  TestDrawView.m
//  test
//
//  Created by wanglei on 2017/7/28.
//  Copyright © 2017年 wanglei. All rights reserved.
//

#import "TestDrawView.h"

@implementation TestDrawView
{
    CAShapeLayer *shapeLayer;
}
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        shapeLayer = [[CAShapeLayer alloc] init];
        shapeLayer.frame = self.bounds;
        shapeLayer.lineWidth = 6;
        shapeLayer.strokeColor = [UIColor redColor].CGColor;
        shapeLayer.fillColor = [UIColor whiteColor].CGColor;
//        shapeLayer.strokeEnd = 1.0;
        [self.layer addSublayer:shapeLayer];
    }
    return self;
}

- (void)drawRect:(CGRect)rect{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [UIColor whiteColor].CGColor);
    CGContextFillRect(context, rect);
    CGContextSaveGState(context);
    
    CGMutablePathRef fillPath = CGPathCreateMutable();
    CGContextSetStrokeColorWithColor(context, [UIColor yellowColor].CGColor);
//    CGContextSetFillColorWithColor(context, [UIColor whiteColor].CGColor);
    CGContextSetLineWidth(context, 6);
    
    
    
    CGPathAddRect(fillPath, NULL, CGRectMake(20, 20, 100, 100));
    
    CGPathMoveToPoint(fillPath, NULL, 200, 100);
    
    CGPathAddArc(fillPath, NULL, 200, 100, 40, 0, 2*M_PI, NO);
    
    CGPathAddArc(fillPath, NULL, 300, 200, 50, 0, 2*M_PI, NO);
    
    CGContextAddPath(context, fillPath);

    CGContextStrokePath(context);
    CGContextClosePath(context);
    shapeLayer.path = CGPathCreateMutableCopy(fillPath);
    
    CGPathRelease(fillPath);
}

- (void)startAnimation{
    CABasicAnimation *pathAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    pathAnimation.duration = 15;
    pathAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    pathAnimation.fromValue = [NSNumber numberWithFloat:0.f];
    pathAnimation.toValue = [NSNumber numberWithFloat:1.f];
    pathAnimation.autoreverses = NO;
    pathAnimation.removedOnCompletion = NO;
    pathAnimation.fillMode = kCAFillModeForwards;
    [shapeLayer addAnimation:pathAnimation forKey:@"strokeEndAnimation"];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
