//
//  StockRectChartView.m
//  HNNniu
//
//  Created by wanglei on 2017/7/20.
//  Copyright © 2017年 HaiNa. All rights reserved.
//

#import "StockRectChartView.h"
#import "StockCircleItems.h"

@interface StockRectChartView ()

@property (nonatomic, assign) CGFloat maxValue;
@property (nonatomic, assign) CGFloat minValue;
@property (nonatomic, assign) CGFloat unitY;
@property (nonatomic, assign) CGFloat zeroY;

@end

@implementation StockRectChartView
{
    CGFloat startLeft;
    CGFloat contentBottom;
    CGFloat contentTop;
    CGFloat chartWidth;
    UIColor *riseColor;
    UIColor *failColor;
}
//17566756.0000,9391500.0000,0.0000,26090248.0000,20302440.0000,73104.0000,20170720

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        startLeft = 60;
        contentBottom = 50;
        contentTop = 68;
        chartWidth = (self.frame.size.width-2*startLeft)/4.f/2.f;
        
        riseColor = [UIColor colorWithRed:251/255.f green:84/255.f blue:94/255.f alpha:1];
        failColor = [UIColor colorWithRed:53/255.f green:196/255.f blue:132/255.f alpha:1];
        
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, contentTop)];
        titleLabel.text = @" 资金净流入额（万元）";
        titleLabel.textColor = [UIColor colorWithRed:136/255.f green:136/255.f blue:136/255.f alpha:1];
        titleLabel.font = [UIFont systemFontOfSize:14];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:titleLabel];
        
        NSArray *array = @[@"净超大单",@"净大单",@"净中单",@"净小单"];
        CGFloat iw = (self.frame.size.width-2*startLeft)/4.f;
        for (int i = 0; i < 4; i ++) {
            CGFloat left = startLeft + i * iw;
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(left, frame.size.height - contentBottom + 20, iw, 14)];
            label.text = array[i];
            label.textColor = [UIColor colorWithRed:136/255.f green:136/255.f blue:136/255.f alpha:1];
            label.font = [UIFont systemFontOfSize:14];
            label.textAlignment = NSTextAlignmentCenter;
            [self addSubview:label];
        }
        
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    //Draw BG
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextFillRect(context, rect);
    
    CGContextSetFillColorWithColor(context, [UIColor whiteColor].CGColor);
    CGContextFillRect(context, rect);
    CGContextSetLineWidth(context, 1);
    CGFloat arr[] = {3,1};
    CGContextSetLineDash(context, 0, arr, 2);
    CGContextSetStrokeColorWithColor(context,[UIColor redColor].CGColor);
    CGFloat iw = (self.frame.size.width-2*startLeft)/4.f;
    for (int i= 0; i < 5; i ++) {
        CGFloat left = startLeft + i * iw;
        [self drawline:context startPoint:CGPointMake(left, contentTop) stopPoint:CGPointMake(left, self.frame.size.height - 20) color:[UIColor colorWithRed:237/255.f green:237/255.f blue:237/255.f alpha:1] lineWidth:1];
        CGContextMoveToPoint(context, left, contentTop);
        CGContextAddLineToPoint(context, left, self.frame.size.height - 20);
    }
    [self drawline:context startPoint:CGPointMake(startLeft, _zeroY) stopPoint:CGPointMake(self.frame.size.width - startLeft, _zeroY) color:[UIColor colorWithRed:237/255.f green:237/255.f blue:237/255.f alpha:1] lineWidth:1];
}

- (void)setCurrectData{
    __block CGFloat max = CGFLOAT_MIN;
    __block CGFloat min = CGFLOAT_MAX;
    [_dataArray enumerateObjectsUsingBlock:^(StockCircleItems *item, NSUInteger idx, BOOL *stop) {
        max = item.value>max?item.value:max;
        min = item.value<min?item.value:min;
    }];
    _maxValue = max;
    _minValue = min;
    if (_minValue > 0) {
        _unitY = (self.frame.size.height - contentTop - contentBottom)/_maxValue;
        _zeroY = self.frame.size.height - contentBottom;
    }else{
        _unitY = (self.frame.size.height - contentTop - contentBottom)/(_maxValue - _minValue);
        _zeroY = self.frame.size.height - contentBottom - _unitY * ABS(_minValue);
    }
}

- (void)strokeChart{
    for (int i = 0; i < _dataArray.count; i ++) {
        
        StockCircleItems *item = _dataArray[i];
        
        UILabel *label = [[UILabel alloc] init];
        label.text = [NSString stringWithFormat:@"%ld",(NSInteger)item.value];
        label.font = [UIFont systemFontOfSize:13];
        label.textAlignment = NSTextAlignmentCenter;
        [self addSubview:label];
        
        CGFloat chartHeight     = _unitY * item.value;
        NSArray *colors;
        UIBezierPath *path;
        CGRect  chartRect       = CGRectMake(startLeft + i * chartWidth*2 + chartWidth*0.5,_zeroY - chartHeight, chartWidth, chartHeight);
        if (item.value < 0) {
            label.frame = CGRectMake(startLeft + i * chartWidth*2, _zeroY - 15, chartWidth*2, 13);
            label.textColor = [UIColor colorWithRed:53/255.f green:196/255.f blue:132/255.f alpha:1];
            chartHeight = -chartHeight;
            colors = @[(id)[UIColor colorWithRed:53/255.f green:196/255.f blue:132/255.f alpha:1].CGColor,(id)[UIColor colorWithRed:190/255.f green:250/255.f blue:208/255.f alpha:1].CGColor];
            chartRect       = CGRectMake(startLeft + i * chartWidth*2 + chartWidth*0.5,_zeroY, chartWidth, chartHeight);
            UIView *view = [[UIView alloc] initWithFrame:chartRect];
            [self addSubview:view];
            
            CAGradientLayer *gradientLayer = [CAGradientLayer layer];
            gradientLayer.colors = colors;
            gradientLayer.locations = @[@0,@1];
            gradientLayer.startPoint = CGPointMake(0.5, 1);
            gradientLayer.endPoint = CGPointMake(0.5, 0);
            gradientLayer.locations = @[@0,@1];
            gradientLayer.startPoint = CGPointMake(0.5, 0);
            gradientLayer.endPoint = CGPointMake(0.5, 1);
            gradientLayer.frame = CGRectMake(0, 0, chartWidth, chartHeight);
            [view.layer addSublayer:gradientLayer];
            path      = [UIBezierPath bezierPathWithRoundedRect:view.bounds byRoundingCorners:UIRectCornerBottomLeft|UIRectCornerBottomRight cornerRadii:CGSizeMake(7, 7)];
            CAShapeLayer *layer = [CAShapeLayer layer];
            layer.frame = view.bounds;
            layer.path  = path.CGPath;
            layer.masksToBounds = YES;
            view.layer.mask = layer;
            view.layer.masksToBounds = YES;
            view.frame = CGRectMake(view.frame.origin.x, view.frame.origin.y, view.frame.size.width, 0);
            [UIView animateWithDuration:1.5 /2 animations:^{
                view.frame = CGRectMake(view.frame.origin.x, view.frame.origin.y, view.frame.size.width, chartHeight);
            }];
        }else{
            label.textColor = [UIColor colorWithRed:251/255.f green:84/255.f blue:94/255.f alpha:1];
            label.frame = CGRectMake(startLeft + i * chartWidth*2, _zeroY +2, chartWidth*2, 13);
            colors = @[(id)[UIColor colorWithRed:251/255.f green:84/255.f blue:94/255.f alpha:1].CGColor,(id)[UIColor colorWithRed:253/255.f green:152/255.f blue:182/255.f alpha:1].CGColor];
            
            UIView *view = [[UIView alloc] initWithFrame:chartRect];
            [self addSubview:view];
            
            CAGradientLayer *gradientLayer = [CAGradientLayer layer];
            gradientLayer.colors = colors;
            gradientLayer.locations = @[@0,@1];
            gradientLayer.startPoint = CGPointMake(0.5, 1);
            gradientLayer.endPoint = CGPointMake(0.5, 0);
            gradientLayer.locations = @[@0,@1];
            gradientLayer.startPoint = CGPointMake(0.5, 1);
            gradientLayer.endPoint = CGPointMake(0.5, 0);
            gradientLayer.frame = CGRectMake(0, 0, chartWidth, chartHeight);
            [view.layer addSublayer:gradientLayer];
            path      = [UIBezierPath bezierPathWithRoundedRect:view.bounds byRoundingCorners:UIRectCornerTopLeft|UIRectCornerTopRight cornerRadii:CGSizeMake(7, 7)];
            CAShapeLayer *layer = [CAShapeLayer layer];
            layer.frame = view.bounds;
            layer.path  = path.CGPath;
            layer.masksToBounds = YES;
            view.layer.mask = layer;
            view.layer.masksToBounds = YES;
            
            view.frame =  CGRectMake(startLeft + i * chartWidth*2 + chartWidth*0.5,_zeroY, chartWidth, 1);
            [UIView animateWithDuration:1.5 /2 animations:^{
                view.frame = CGRectMake(view.frame.origin.x, view.frame.origin.y - chartHeight, view.frame.size.width, chartHeight);
            }];
        }
        /*
        UIView *view = [[UIView alloc] initWithFrame:chartRect];
        [self addSubview:view];
        
        CAGradientLayer *gradientLayer = [CAGradientLayer layer];
        gradientLayer.colors = colors;
        gradientLayer.locations = @[@0,@1];
        gradientLayer.startPoint = CGPointMake(0.5, 1);
        gradientLayer.endPoint = CGPointMake(0.5, 0);
        if (item.value < 0) {
            gradientLayer.locations = @[@0,@1];
            gradientLayer.startPoint = CGPointMake(0.5, 0);
            gradientLayer.endPoint = CGPointMake(0.5, 1);
        }else{
//            view.frame =  CGRectMake(startLeft + i * chartWidth*2 + chartWidth*0.5,_zeroY - chartHeight, chartWidth, chartHeight);
            gradientLayer.locations = @[@0,@1];
            gradientLayer.startPoint = CGPointMake(0.5, 1);
            gradientLayer.endPoint = CGPointMake(0.5, 0);
        }
        gradientLayer.frame = CGRectMake(0, 0, chartWidth, chartHeight);
        [view.layer addSublayer:gradientLayer];
        
        if (item.value < 0) {
            path      = [UIBezierPath bezierPathWithRoundedRect:view.bounds byRoundingCorners:UIRectCornerBottomLeft|UIRectCornerBottomRight cornerRadii:CGSizeMake(7, 7)];
        }else{
            path      = [UIBezierPath bezierPathWithRoundedRect:view.bounds byRoundingCorners:UIRectCornerTopLeft|UIRectCornerTopRight cornerRadii:CGSizeMake(7, 7)];
        }
        CAShapeLayer *layer = [CAShapeLayer layer];
        layer.frame = view.bounds;
        layer.path  = path.CGPath;
        layer.masksToBounds = YES;
        view.layer.mask = layer;
        view.layer.masksToBounds = YES;
        
        if (item.value<0) {
            view.frame = CGRectMake(view.frame.origin.x, view.frame.origin.y, view.frame.size.width, 0);
        }else{
            view.layer.anchorPoint = CGPointMake(0.5, 1);
            view.frame =  CGRectMake(startLeft + i * chartWidth*2 + chartWidth*0.5,_zeroY - chartHeight, chartWidth, 1);
        }
        
        [UIView animateWithDuration:4 animations:^{
           view.frame = CGRectMake(view.frame.origin.x, view.frame.origin.y, view.frame.size.width, chartHeight);
        }];*/
//
//        CABasicAnimation *pathAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
//        pathAnimation.duration = 1.5;
//        pathAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
//        pathAnimation.fromValue = [NSNumber numberWithFloat:0.0f];
//        pathAnimation.toValue = [NSNumber numberWithFloat:0.0f];
//        pathAnimation.autoreverses = NO;
//        [layer addAnimation:pathAnimation forKey:@"strokeEndAnimation"];
    }
}

- (void)setDataArray:(NSArray *)dataArray{
    _dataArray = dataArray;
    [self setCurrectData];
    [self strokeChart];
}

- (void)drawline:(CGContextRef)context
      startPoint:(CGPoint)startPoint
       stopPoint:(CGPoint)stopPoint
           color:(UIColor *)color
       lineWidth:(CGFloat)lineWitdth
{
    if (startPoint.x <0 ||stopPoint.x >self.frame.size.width|| startPoint.y <0 || stopPoint.y >self.frame.size.height) {
        return;
    }
    CGContextSetStrokeColorWithColor(context, color.CGColor);
    CGContextSetLineWidth(context, lineWitdth);
    CGContextBeginPath(context);
    CGContextMoveToPoint(context, startPoint.x, startPoint.y);
    CGContextAddLineToPoint(context, stopPoint.x,stopPoint.y);
    CGContextStrokePath(context);
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
