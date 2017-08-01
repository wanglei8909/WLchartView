//
//  ThreeViewController.m
//  test
//
//  Created by wanglei on 2017/7/20.
//  Copyright © 2017年 wanglei. All rights reserved.
//

#import "ThreeViewController.h"
#import "FourViewController.h"

@interface ThreeViewController ()<UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UIButton *previousButton;
@property (weak, nonatomic) IBOutlet UIButton *NextButton;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIView *headerView;


@end

@implementation ThreeViewController

- (UIView *)headerView{
    if (!_headerView) {
        _headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 65, self.view.frame.size.width, 100)];
        _headerView.backgroundColor = [UIColor purpleColor];
    }
    return _headerView;
}

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 65, self.view.frame.size.width, self.view.frame.size.height-65)];
        _tableView.contentInset = UIEdgeInsetsMake(100, 0, 0, 0);
        _tableView.dataSource = self;
        _tableView.refreshControl = [self refreshControl];
    }
    return _tableView;
}

- (UIRefreshControl *)refreshControl{
    UIRefreshControl *ctrl = [[UIRefreshControl alloc] init];
    return ctrl;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self useCustomNavigationBar:[UIColor cyanColor]];
    self.customTopBar.alpha = 1;
    [self setTitle:@"第三页"];
    [self addLeftTextBtn:@"上一个" target:self action:@selector(previous:)];
    [self addRightTextBtn:@"下一个" target:self action:@selector(Next:)];
    
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.headerView];
    
    [self.tableView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:nil];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
    CGFloat offsetY = self.tableView.contentOffset.y;
    NSLog(@"offsetY-------:%f",offsetY);
    
    if (offsetY > -100) {
        self.headerView.frame = CGRectMake(0, 65 - (offsetY + 100) , self.headerView.frame.size.width, self.headerView.frame.size.height);
    }
    if (offsetY < -100) {
        self.headerView.frame = CGRectMake(0, 65, self.view.frame.size.width, 100);
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 30;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellID = @"cellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"index:%ld",indexPath.row];
    return cell;
}

- (void)dealloc{
    [self.tableView removeObserver:self forKeyPath:@"contentOffset"];
}

- (IBAction)previous:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)Next:(id)sender {
    FourViewController *ctrl = [[FourViewController alloc] init];
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
