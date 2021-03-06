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
    
    self.title = @"CSActionSheet&Picker";
    self.view.backgroundColor = [UIColor whiteColor];
    
    CGSize winsize = [[UIScreen mainScreen] bounds].size;
    
    
    
    UIButton *save_btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [save_btn setFrame:CGRectMake(0, 0, 90, 30)];
    [save_btn setTitle:@"ActionPicker" forState:UIControlStateNormal];
    [save_btn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [save_btn.titleLabel setFont:[UIFont systemFontOfSize:15]];
    [save_btn setBackgroundColor:[UIColor clearColor]];
    [save_btn addTarget:self action:@selector(showActionPicker) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:save_btn];
    [self.navigationItem setRightBarButtonItems:[NSArray arrayWithObjects: rightItem, nil]];
    
    
    
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

- (void)showActionPicker {
    if (as_view) {
        [as_view removeFromSuperview];
        as_view = nil;
    }
    if (action_picker) {
        [action_picker hideView];
        return;
    }
    
    CGSize winsize = [[UIScreen mainScreen] bounds].size;
    NSArray *array = [NSArray arrayWithObjects: @"所有条件", @"已完成", @"未完成", @"有附件", @"有定时提醒", @"有密码", nil];
    action_picker = [[CSActionPicker alloc] initWithFrame:CGRectMake(0, 64, winsize.width, winsize.height) cellX:winsize.width/3*2 cellSize:CGSizeMake(winsize.width/3, 30) titles:array normalColor:nil highlightedColor:nil fontSize:10 cellBgColor:nil cellLineColor:nil];
    [action_picker setShadeColor:[UIColor colorWithWhite:0 alpha:0.2]];
//    [action_picker setNormalColor:[UIColor greenColor] highlightColor:[UIColor darkGrayColor]];
//    [action_picker setBgColor:[UIColor lightGrayColor]];
//    [action_picker setLineColor:[UIColor whiteColor]];
//    [action_picker setFontSize:10];
    [self.view addSubview:action_picker];
    [action_picker showView:^(int index, id sender) {
        NSLog(@"choose_index = %d",index);
        
        [action_picker hideView];
    } close:^(id sender) {
        [action_picker removeFromSuperview];
        action_picker = nil;
    }];
}

- (void)btnTouched {
    if (as_view) {
        [as_view removeFromSuperview];
        as_view = nil;
    }
    
    CGSize winsize = [[UIScreen mainScreen] bounds].size;

    as_view = [[CSActionSheet alloc] initWithFrame:CGRectMake(0, 0, winsize.width, winsize.height) titles:[NSArray arrayWithObjects: @"拍照", @"从手机相册选择", nil] cancal:@"取消" tips:@"请选择方式\n点击其他空白处收起"];
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
    as_view = [[CSActionSheet alloc] initWithFrame:CGRectMake(0, 0, winsize.width, winsize.height) cellX:0 cellSize:CGSizeMake(winsize.width, -1) titles:[NSArray arrayWithObjects: @"拍照", @"从手机相册选择", @"拍照", @"从手机相册选择", @"拍照", @"从手机相册选择", @"拍照", @"从手机相册选择", nil] normalColor:[UIColor greenColor] highlightColor:[UIColor darkGrayColor] cancal:@"取消" cancalNormalColor:[UIColor redColor] cancalHighlightColor:[UIColor redColor] fontSize:-1 tips:@"test info" tipsColor:[UIColor blueColor] tipsFontSize:-1 cellBgColor:nil cellLineColor:nil];
    
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
