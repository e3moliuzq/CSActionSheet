//
//  ViewController.m
//  CSActionSheet
//
//  Created by e3mo on 16/5/5.
//  Copyright © 2016年 e3mo. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    UIButton *btn0 = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn0 setFrame:CGRectMake(30, 180, 230, 80)];
    [btn0 setTitle:@"show actionsheet" forState:UIControlStateNormal];
    [btn0 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn0 setBackgroundColor:[UIColor redColor]];
    [btn0 addTarget:self action:@selector(btnTouched) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn0];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)btnTouched {
    if (as_view) {
        [as_view removeFromSuperview];
        as_view = nil;
    }
    
    CGSize winsize = [[UIScreen mainScreen] bounds].size;
    as_view = [[CSActionSheet alloc] initWithFrame:CGRectMake(0, 0, winsize.width, winsize.height) titles:[NSArray arrayWithObjects: @"拍照", @"从手机相册选择", nil] cancal:@"取消" normal_color:[UIColor colorWithRed:0 green:0.7 blue:0.1 alpha:1] highlighted_color:[UIColor colorWithRed:0 green:0.5 blue:0.1 alpha:1]];
    as_view.delegate = self;
    [self.view addSubview:as_view];
    [as_view showView];
}

#pragma mark = CSActionSheet delegate
- (void)csActionSheetClose:(id)sender {
    CSActionSheet *view = (CSActionSheet*)sender;
    if (view) {
        [view removeFromSuperview];
        view = nil;
    }
}

- (void)csActionSheetSure:(id)sender chooseIndex:(int)index {
    NSLog(@"choose_index = %d",index);
    
    CSActionSheet *view = (CSActionSheet*)sender;
    [view hideView];
}

@end
