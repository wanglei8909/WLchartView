//
//  TwoViewController.m
//  test
//
//  Created by wanglei on 2017/7/20.
//  Copyright © 2017年 wanglei. All rights reserved.
//

#import "TwoViewController.h"
#import "ThreeViewController.h"

@interface TwoViewController ()

@property (weak, nonatomic) IBOutlet UIButton *previousButton;
@property (weak, nonatomic) IBOutlet UIButton *NextButton;
@end

@implementation TwoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self UsePureColorNavigationBack:[UIColor redColor]];
    
    [self AddLeftTextBtn:@"上一个" target:self action:@selector(previous:)];
    [self AddRightTextBtn:@"下一个" target:self action:@selector(Next:)];
}
- (IBAction)previous:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)Next:(id)sender {
    ThreeViewController *ctrl = [[ThreeViewController alloc] init];
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
