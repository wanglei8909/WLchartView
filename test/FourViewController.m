//
//  FourViewController.m
//  test
//
//  Created by wanglei on 2017/7/20.
//  Copyright © 2017年 wanglei. All rights reserved.
//

#import "FourViewController.h"

@interface FourViewController ()

@property (weak, nonatomic) IBOutlet UIButton *previousButton;
@end

@implementation FourViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self useNativeNavigationBar];
    [self setMTitleColor:[UIColor blueColor]];
    [self setTitle:@"第四页"];
    [self addLeftTextBtn:@"上一个" target:self action:@selector(previous:)];
    [self addRightTextBtn:@"回到首页" target:self action:@selector(goHome)];
}
- (IBAction)previous:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
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
