//
//  ViewController.m
//  mapPushDown
//
//  Created by CYY033 on 16/4/21.
//  Copyright © 2016年 LYC. All rights reserved.
//

#import "ViewController.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.backView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (BackView *)backView{
    if (!_backView) {
        _backView = [[BackView alloc] initWithFrame:self.view.bounds];
    }
    return _backView;
}
@end
