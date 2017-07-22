//
//  OneViewController.m
//  test
//
//  Created by wanglei on 2017/7/20.
//  Copyright © 2017年 wanglei. All rights reserved.
//

#import "OneViewController.h"
#import "SunViewController.h"
#import "TwoViewController.h"
#import "StockCircleChartView.h"
#import "StockRectChartView.h"
#import "StockCircleItems.h"

@interface OneViewController ()

@property (weak, nonatomic) IBOutlet UIButton *NextButton;
@end

@implementation OneViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    NSArray *startColors = @[[UIColor colorWithRed:255/255.f green:8/255.f  blue:68/255.f  alpha:1],
                             [UIColor colorWithRed:162/255.f green:234/255.f  blue:132/255.f  alpha:1],
                             [UIColor colorWithRed:168/255.f green:214/255.f  blue:93/255.f  alpha:1],
                             [UIColor colorWithRed:247/255.f green:107/255.f  blue:28/255.f  alpha:1]];
    NSArray *endColors = @[[UIColor colorWithRed:255/255.f green:177/255.f  blue:153/255.f  alpha:1],
                           [UIColor colorWithRed:218/255.f green:249/255.f  blue:206/255.f  alpha:1],
                           [UIColor colorWithRed:126/255.f green:238/255.f  blue:228/255.f  alpha:1],
                           [UIColor colorWithRed:250/255.f green:217/255.f  blue:97/255.f  alpha:1]];
    NSArray *array = @[@(3000),@(2000),@(3000),@(2000)];
    NSMutableArray *items = [[NSMutableArray alloc] initWithCapacity:array.count];
    for (int i = 0; i < array.count; i++) {
        StockCircleItems *item = [[StockCircleItems alloc] init];
        item.value = [array[i] floatValue];
        item.lineWidth = i%2!=0?32:40;
        item.radius = i%2!=0?70:70+4;
        item.startColor = startColors[i];
        item.endColor = endColors[i];
        [items addObject:item];
    }
    
    StockCircleChartView *circleChartView = [[StockCircleChartView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height * 0.5 - 20)];
    [circleChartView setDataArray:items];
    [self.view addSubview:circleChartView];
    
    StockRectChartView *rectChartView = [[StockRectChartView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height * 0.5, self.view.frame.size.width, self.view.frame.size.height * 0.5)];
    [rectChartView setDataArray:items];
    [self.view addSubview:rectChartView];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self UseImageNavigationBack];
    [self AddRightTextBtn:@"下一页" target:self action:@selector(Next:)];
    
}

- (IBAction)Next:(id)sender {
    SunViewController *ctrl = [[SunViewController alloc] init];
    [self.navigationController pushViewController:ctrl animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
