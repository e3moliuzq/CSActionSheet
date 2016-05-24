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
    
    CGSize winsize = [[UIScreen mainScreen] bounds].size;
    
    UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn1 setFrame:CGRectMake(30, winsize.height-200, 230, 80)];
    [btn1 setTitle:@"show actionsheet base bg color" forState:UIControlStateNormal];
    btn1.titleLabel.numberOfLines = 0;
    [btn1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn1 setBackgroundColor:[UIColor redColor]];
    [btn1 addTarget:self action:@selector(btn0Touched) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn1];
    
    
    UIButton *btn0 = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn0 setFrame:CGRectMake(30, winsize.height-100, 230, 80)];
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
    as_view = [[CSActionSheet alloc] initWithFrame:CGRectMake(0, 0, winsize.width, winsize.height) titles:[NSArray arrayWithObjects: @"拍照", @"从手机相册选择", nil] cancal:@"取消" normal_color:[UIColor colorWithRed:0 green:0.7 blue:0.1 alpha:1] highlighted_color:[UIColor colorWithRed:0 green:0.5 blue:0.1 alpha:1] tips:@"请选择方式\n点击其他空白处收起" tipsColor:[UIColor whiteColor] cellBgColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.8] cellLineColor:[UIColor colorWithRed:0.4 green:0.4 blue:0.4 alpha:1]];
    [self.view addSubview:as_view];
    [as_view showView:^(int index, id sender) {
        NSLog(@"choose_index = %d",index);
        
        CSActionSheet *view = (CSActionSheet*)sender;
        [view hideView];
        
    } close:^(id sender) {
        CSActionSheet *view = (CSActionSheet*)sender;
        if (view) {
            [view removeFromSuperview];
            view = nil;
        }
    }];
}

- (void)btn0Touched {
    if (as_view) {
        [as_view removeFromSuperview];
        as_view = nil;
    }
    
    CGSize winsize = [[UIScreen mainScreen] bounds].size;
    as_view = [[CSActionSheet alloc] initWithFrame:CGRectMake(0, 0, winsize.width, winsize.height) titles:[NSArray arrayWithObjects: @"拍照", @"从手机相册选择", nil] cancal:@"取消" normal_color:[UIColor colorWithRed:0 green:0.7 blue:0.1 alpha:1] highlighted_color:[UIColor colorWithRed:0 green:0.5 blue:0.1 alpha:1]];
    [as_view setCancalLabelColor:[UIColor redColor] highlightedColor:[UIColor colorWithRed:0.8 green:0 blue:0 alpha:1]];
    [self.view addSubview:as_view];
    [as_view showView:^(int index, id sender) {
        NSLog(@"choose_index = %d",index);
        
        CSActionSheet *view = (CSActionSheet*)sender;
        [view hideView];
        
    } close:^(id sender) {
        CSActionSheet *view = (CSActionSheet*)sender;
        if (view) {
            [view removeFromSuperview];
            view = nil;
        }
    }];
}

@end
