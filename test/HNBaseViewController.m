//
//  BaseViewController.m
//  test
//
//  Created by wanglei on 2017/7/20.
//  Copyright © 2017年 wanglei. All rights reserved.
//

#import "HNBaseViewController.h"

#define SafePerformSelector(Stuff) \
do { \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Warc-performSelector-leaks\"") \
Stuff; \
_Pragma("clang diagnostic pop") \
} while (0)

@interface HNBaseViewController ()<UIGestureRecognizerDelegate>

@property (nonatomic, retain) UIImage *mTopImage;
@property (nonatomic, assign) int mFontSize; //title 字体大小
@property (nonatomic, readonly) UILabel *mlbTitle;

@end

@implementation HNBaseViewController

@synthesize mlbTitle, delegate, goBackSelector, mTopColor, mTopImage, mTitleColor, mFontSize, isCustomTopBar, customTopBar;

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
    mFontSize = 19;
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
    
    mlbTitle = [[UILabel alloc] initWithFrame:CGRectMake(60, 0, self.view.frame.size.width-120, 44)];
    mlbTitle.backgroundColor = [UIColor clearColor];
    mlbTitle.font = [UIFont systemFontOfSize:mFontSize];
    mlbTitle.textAlignment = NSTextAlignmentCenter;
    mlbTitle.textColor = self.mTitleColor;
    mlbTitle.text = self.title;
    self.navigationItem.titleView = mlbTitle;
    
    [self addLeftImageBtn:nil target:nil action:nil];
    [self addRightImageBtn:nil target:nil action:nil];

    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.delegate = self;
    }
    
//    UIScrollView *scr = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 70)];
//    scr.backgroundColor = [UIColor whiteColor];
//    [self.view addSubview:scr];
}

- (void)setMTopColor:(UIColor *)topColor{
    self.customTopBar.backgroundColor = topColor;
}

- (void)useNativeNavigationBar{
    isCustomTopBar = NO;
    mTopColor = nil;
    mTopImage = [UIImage imageNamed:@"navimage"];
    if (self.customTopBar) {
        [self.customTopBar removeFromSuperview];
    }
    [self refreshNavColor];
}

//此方法需要提前设置 mTopColor 的默认值
- (void)useCustomNavigationBar{
    [self useCustomNavigationBar:mTopColor];
}

- (void)useCustomNavigationBar:(UIColor *)color{
    isCustomTopBar = YES;
    mTopImage = nil;
    mTopColor = color;
    [self refreshNavColor];
}

- (void)refreshNavColor {
    if (mTopColor && isCustomTopBar) {
        [self addCustomTopBar];
    }
    if (mTopImage && !isCustomTopBar) {
        [self.navigationController.navigationBar setBackgroundImage:mTopImage forBarMetrics:UIBarMetricsDefault];
    }
    if (mTitleColor) {
        mlbTitle.textColor = self.mTitleColor;
    }
}

- (void)addCustomTopBar{
    customTopBar = [[HNBaseNavgationView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 64)];
    customTopBar.backgroundColor = mTopColor;
    [self.view addSubview:customTopBar];
}

- (void)goHome {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)goBack {
    if (delegate && goBackSelector) {
        SafePerformSelector([delegate performSelector:goBackSelector withObject:self]);
    }
    UIViewController *topCtrl = self.navigationController.topViewController;
    if (topCtrl == self) {
        [self.navigationController popViewControllerAnimated:YES];
    }
    else {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

- (void)setTitle:(NSString *)title{
    if (self.isCustomTopBar) {
        [self.customTopBar setTitle:title];
    }else{
        mlbTitle.text = title;
    }
}

- (void)setMTitleColor:(UIColor *)titleColor{
    mTitleColor = titleColor;
    if (self.isCustomTopBar) {
        [customTopBar setMTitleColor:titleColor];
    }else{
        mlbTitle.textColor = titleColor;
        UIButton *leftButton = self.navigationItem.leftBarButtonItem.customView;
        if (leftButton && [leftButton isKindOfClass:[UIButton class]]) {
            [leftButton setTitleColor:titleColor forState:UIControlStateNormal];
        }
        UIButton *rightButton = self.navigationItem.rightBarButtonItem.customView;
        if (rightButton && [rightButton isKindOfClass:[UIButton class]]) {
            [rightButton setTitleColor:titleColor forState:UIControlStateNormal];
        }
    }
}

- (void)clearNavItem {
    if (self.isCustomTopBar) {
        [customTopBar clearNavItem];
    }else{
        self.navigationItem.leftBarButtonItem = nil;
        self.navigationItem.rightBarButtonItem = nil;
    }
}

- (void)addRightTextBtn:(NSString *)name target:(id)target action:(SEL)action {
    if (self.isCustomTopBar) {
        [self.customTopBar addRightTextBtn:name target:target action:action];
    }else{
        self.navigationItem.rightBarButtonItem = [self getTextBarItem:name target:target action:action];
    }
}

- (void)addLeftTextBtn:(NSString *)name target:(id)target action:(SEL)action{
    if (self.isCustomTopBar) {
        [self.customTopBar addLeftTextBtn:name target:target action:action];
    }else{
        self.navigationItem.leftBarButtonItem = [self getTextBarItem:name target:target action:action];
    }
}

- (void)addRightImageBtn:(UIImage *)image target:(id)target action:(SEL)action  {
    if (self.isCustomTopBar) {
        [self.customTopBar addRightImageBtn:image target:target action:action];
    }else{
        self.navigationItem.rightBarButtonItem = [self getImageBarItem:image target:target action:action];
    }
}

- (void)addLeftImageBtn:(UIImage *)image target:(id)target action:(SEL)action {
    if (self.isCustomTopBar) {
        [self.customTopBar addLeftImageBtn:image target:target action:action];
    }else{
        self.navigationItem.leftBarButtonItem = [self getImageBarItem:image target:target action:action];
    }
}

- (UIBarButtonItem *)getTextBarItem:(NSString *)name target:(id)target action:(SEL)action {
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

- (UIBarButtonItem *)getImageBarItem:(UIImage *)image target:(id)target action:(SEL)action {
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame = CGRectMake(0, 0, 50, 44);
    [rightBtn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    [rightBtn setImage:image forState:UIControlStateNormal];
    return [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
}

- (void)addTitleView:(UIView *)titleView {
    if (self.isCustomTopBar) {
        [self.customTopBar addTitleView:titleView];
    }else{
        self.navigationItem.titleView = titleView;
    }
}

- (void)hiddenNavagationView{
    self.customTopBar.hidden = YES;
}

- (void)setNavigationAlaph:(CGFloat)alpha{
    if (self.customTopBar) {
        [self.customTopBar setNavigationAlaph:alpha];
    }
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
