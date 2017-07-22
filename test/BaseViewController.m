//
//  BaseViewController.m
//  test
//
//  Created by wanglei on 2017/7/20.
//  Copyright © 2017年 wanglei. All rights reserved.
//

#import "BaseViewController.h"

#define SafePerformSelector(Stuff) \
do { \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Warc-performSelector-leaks\"") \
Stuff; \
_Pragma("clang diagnostic pop") \
} while (0)

@interface BaseViewController ()

@end

@implementation BaseViewController

@synthesize mlbTitle, delegate, OnGoBack, mTopColor, mTopImage, mTitleColor, mFontSize, isCustomTopBar, customTopBar;

//- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
//{
//    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
//    if (self) {
//        [self Commit];
//    }
//    return self;
//}

- (instancetype)init{
    self = [super init];
    if (self) {
        [self Commit];
    }
    return self;
}

- (void)Commit{
    mFontSize = 20;
    mTopImage = [UIImage imageNamed:@"navimage"];
    mTitleColor = [UIColor whiteColor];
    isCustomTopBar = NO;
    mTopColor = [UIColor whiteColor];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:isCustomTopBar animated:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //去掉边缘化 适配 //从导航栏下边开始 self.view.height = screen.height - 64
    //系统导航栏不隐藏的时候 self.view.top从导航栏下开始
    //隐藏系统导航栏时  self.view.top从屏幕顶部开始  self.view.height = screen.height
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.extendedLayoutIncludesOpaqueBars = NO;
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.navigationController.navigationBar.translucent = NO;
    
    mlbTitle = [[UILabel alloc] initWithFrame:CGRectMake(50, 0, self.view.frame.size.width-100, 44)];
    mlbTitle.backgroundColor = [UIColor clearColor];
    mlbTitle.font = [UIFont fontWithName:@"Helvetica-Light" size:mFontSize];
    mlbTitle.textAlignment = NSTextAlignmentCenter;
    mlbTitle.textColor = self.mTitleColor;
    mlbTitle.text = self.title;
    self.navigationItem.titleView = mlbTitle;
    
    
    [self AddLeftImageBtn:nil target:nil action:nil];
    [self AddRightImageBtn:nil target:nil action:nil];

    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.delegate = nil;
    }
    
//    UIScrollView *scr = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 70)];
//    scr.backgroundColor = [UIColor whiteColor];
//    [self.view addSubview:scr];
}

- (void)UseImageNavigationBack{
    isCustomTopBar = NO;
    mTopColor = nil;
    mTopImage = [UIImage imageNamed:@"navimage"];
    if (self.customTopBar) {
        [self.customTopBar removeFromSuperview];
    }
    [self RefreshNavColor];
}

//此方法需要提前设置 mTopColor 的默认值
- (void)UsePureColorNavigationBack{
    [self UsePureColorNavigationBack:mTopColor];
}

- (void)UsePureColorNavigationBack:(UIColor *)color{
    isCustomTopBar = YES;
    mTopImage = nil;
    mTopColor = color;
    [self RefreshNavColor];
}

- (void)RefreshNavColor {
    if (mTopColor && isCustomTopBar) {
        [self CustomTopBar];
    }
    if (mTopImage && !isCustomTopBar) {
        [self.navigationController.navigationBar setBackgroundImage:mTopImage forBarMetrics:UIBarMetricsDefault];
    }
    if (mTitleColor) {
        mlbTitle.textColor = self.mTitleColor;
    }
}

- (void)CustomTopBar{
    customTopBar = [[BaseNavgationView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 64)];
    customTopBar.backgroundColor = mTopColor;
    [self.view addSubview:customTopBar];
}

- (void)GoHome {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)GoBack {
    if (delegate && OnGoBack) {
        SafePerformSelector([delegate performSelector:OnGoBack withObject:self]);
    }
    UIViewController *topCtrl = self.navigationController.topViewController;
    if (topCtrl == self) {
        [self.navigationController popViewControllerAnimated:YES];
    }
    else {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

- (void)setMTitleColor:(UIColor *)titleColor{
    mTitleColor = titleColor;
    mlbTitle.textColor = titleColor;
}

- (void)ClearNavItem {
    self.navigationItem.leftBarButtonItem = nil;
    self.navigationItem.rightBarButtonItem = nil;
}

- (void)AddRightTextBtn:(NSString *)name target:(id)target action:(SEL)action {
    if (self.isCustomTopBar) {
        [self.customTopBar AddRightTextBtn:name target:target action:action];
    }else{
        self.navigationItem.rightBarButtonItem = [self GetTextBarItem:name target:target action:action];
    }
}

- (void)AddLeftTextBtn:(NSString *)name target:(id)target action:(SEL)action{
    if (self.isCustomTopBar) {
        [self.customTopBar AddLeftTextBtn:name target:target action:action];
    }else{
        self.navigationItem.leftBarButtonItem = [self GetTextBarItem:name target:target action:action];
    }
}

- (void)AddRightImageBtn:(UIImage *)image target:(id)target action:(SEL)action  {
    if (self.isCustomTopBar) {
        [self.customTopBar AddRightImageBtn:image target:target action:action];
    }else{
        self.navigationItem.rightBarButtonItem = [self GetImageBarItem:image target:target action:action];
    }
}

- (void)AddLeftImageBtn:(UIImage *)image target:(id)target action:(SEL)action {
    if (self.isCustomTopBar) {
        [self.customTopBar AddLeftImageBtn:image target:target action:action];
    }else{
        self.navigationItem.leftBarButtonItem = [self GetImageBarItem:image target:target action:action];
    }
}

- (UIBarButtonItem *)GetTextBarItem:(NSString *)name target:(id)target action:(SEL)action {
    NSAttributedString *attString = [[NSAttributedString alloc] initWithString:name attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]}];
    CGFloat iWidth = attString.size.width;
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame = CGRectMake(0, 0, iWidth, 44);
    [rightBtn setTitle:name forState:UIControlStateNormal];
    [rightBtn setTitleColor:self.mTitleColor forState:UIControlStateNormal];
    rightBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [rightBtn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
}

- (UIBarButtonItem *)GetImageBarItem:(UIImage *)image target:(id)target action:(SEL)action {
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame = CGRectMake(0, 0, 50, 44);
    [rightBtn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    [rightBtn setImage:image forState:UIControlStateNormal];
    return [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
}

- (void)AddTitleView:(UIView *)titleView {
    self.navigationItem.titleView = titleView;
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
