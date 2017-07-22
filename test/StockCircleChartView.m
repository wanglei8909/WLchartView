//
//  StockCircleChartView.m
//  test
//
//  Created by wanglei on 2017/7/21.
//  Copyright © 2017年 wanglei. All rights reserved.
//

#import "StockCircleChartView.h"
#import "StockCircleItems.h"
#import "GrdientCircleView.h"

@interface StockCircleChartView()

@property (nonatomic, strong) CAShapeLayer   *pieLayer;
@property (nonatomic, copy) NSArray *endPercentages;
@property (nonatomic, assign) CGFloat iRadius;
@property (nonatomic, assign) CGFloat iBorderWidth;
@property (nonatomic, assign) CGFloat startLeft;
@property (nonatomic, copy) NSArray *titles;
@end

@implementation StockCircleChartView

//17566756.0000,9391500.0000,0.0000,26090248.0000,20302440.0000,73104.0000

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        _startLeft = 40;
        _titles = @[@"主力流入",@"散户流入",@"主力流出",@"散户流出"];
    }
    return self;
}

- (void)setDataArray:(NSArray *)dataArray{
    _dataArray = dataArray;
    
    [_pieLayer removeFromSuperlayer];
    _pieLayer = [CAShapeLayer layer];
    [self.layer addSublayer:_pieLayer];
    
    [self setCurrectData];
}

- (void)setCurrectData{
    CGFloat total = [[_dataArray valueForKeyPath:@"@sum.value"] floatValue];
    
    __block CGFloat currentTotal = 0;
    NSMutableArray *endPercentages = [NSMutableArray new];
    [_dataArray enumerateObjectsUsingBlock:^(StockCircleItems *item, NSUInteger idx, BOOL *stop) {
        if (total == 0){
            [endPercentages addObject:@(1.0 / _dataArray.count * (idx + 1))];
        }else{
            currentTotal += item.value;
            [endPercentages addObject:@(currentTotal / total)];
        }
    }];
    self.endPercentages = [endPercentages copy];
    
    [self strokeChart];
}

- (void)strokeChart{
    
    for (int i = 0; i < _dataArray.count; i++) {
        StockCircleItems *item = [_dataArray objectAtIndex:i];
        CGFloat startPercnetage = [self startPercentageForItemAtIndex:i];
        CGFloat endPercentage   = [self endPercentageForItemAtIndex:i];
        
        CGFloat radius = item.radius;
        CGFloat borderWidth = item.lineWidth;
        
        GrdientCircleView *circle = [[GrdientCircleView alloc] initWithFrame:self.bounds];
        circle.iRadius = radius;
        circle.progressRingWidth =borderWidth;
        circle.startColor = item.startColor;
        circle.endColor = item.endColor;
        [self addSubview:circle];
        [circle setStartProgress:startPercnetage endProgress:endPercentage animated:YES];
        
        if (i < _titles.count) {
            [self drawLabel:i];
        }
    }
}

- (CGFloat)startPercentageForItemAtIndex:(NSUInteger)index{
    if(index == 0){
        return 0;
    }
    
    return [_endPercentages[index - 1] floatValue];
}

- (CGFloat)endPercentageForItemAtIndex:(NSUInteger)index{
    return [_endPercentages[index] floatValue];
}

- (NSString *)ratioForItemAtIndex:(NSUInteger)index{
    CGFloat ratio = [self endPercentageForItemAtIndex:index] - [self startPercentageForItemAtIndex:index];
    int percent = ratio * 100;
    return [NSString stringWithFormat:@"%d%%",percent];
}

- (void)drawRect:(CGRect)rect
{
    //Draw BG
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [UIColor whiteColor].CGColor);
    CGContextFillRect(context, rect);
    
    NSAttributedString *attString = [[NSAttributedString alloc] initWithString:@"今日资金" attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14],NSForegroundColorAttributeName:[UIColor colorWithRed:136/255.f green:136/255.f  blue:136/255.f  alpha:1]}];
    CGSize attSize = [attString size];
    [attString drawInRect:CGRectMake(0.5*(self.frame.size.width - attSize.width), (self.frame.size.height - attSize.height)*0.5 - 20, attSize.width, attSize.height)];
}

- (void)drawLabel:(int) index{
    StockCircleItems *item = [_dataArray objectAtIndex:index];
    CGFloat iW = (self.frame.size.width - 2*_startLeft)/_titles.count;
    CGFloat left = _startLeft + index * iW;
    CGFloat top = self.frame.size.height - 45;
    UIView *icon = [[UIView alloc] initWithFrame:CGRectMake(left, top, 10, 10)];
    icon.backgroundColor = item.startColor;
    icon.layer.masksToBounds = YES;
    icon.layer.cornerRadius = icon.frame.size.width*0.5;
    [self addSubview:icon];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(left + 15, top - 3, iW-15, 16)];
    label.font = [UIFont systemFontOfSize:16];
    label.textColor = [UIColor colorWithRed:68/255.f green:68/255.f blue:68/255.f alpha:1];
    label.text = [self ratioForItemAtIndex:index];
    [self addSubview:label];
    
    label = [[UILabel alloc] initWithFrame:CGRectMake(left + 15, top + 17, iW-15, 12)];
    label.font = [UIFont systemFontOfSize:12];
    label.textColor = [UIColor colorWithRed:136/255.f green:136/255.f blue:136/255.f alpha:1];
    label.text = _titles[index];
    [self addSubview:label];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
