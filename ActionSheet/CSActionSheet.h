//
//  CSActionSheet.h
//  taishan
//
//  Created by e3mo on 15/7/7.
//  Copyright (c) 2015年 times. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol CSActionSheetViewDelegate <NSObject>

@optional
- (void)csActionSheetSure:(id)sender chooseIndex:(int)index;//选择后执行的delegate，index为选择值：cancal为0，其他数据从1开始依次递增
- (void)csActionSheetClose:(id)sender;//隐藏动画执行完成的delegate
@end

@interface CSActionSheet : UIView {
    UIView *show_view;
    
    UIButton *close_btn;
    
    BOOL isInAction;
    
    NSArray *titles_array;
}
@property (nonatomic,weak) id<CSActionSheetViewDelegate> delegate;

/**
 iOS自带的UIActionSheet不能改变颜色，故写这个
 */

/**
 该控件会有一个黑色半透明的遮罩，点击遮罩选择框将执行hideView动画
 frame：决定遮罩的位置大小和选择框的宽度
 titles：选项文字数组
 cancal：取消按钮的文字
 normal_color：文字普通状态颜色
 highlighted_color：文字点击状态颜色，可为nil
 cellBgColor：选项框背景颜色
 cellLineColor:选择框分隔线颜色
 */
- (id)initWithFrame:(CGRect)frame titles:(NSArray*)titles cancal:(NSString*)cancal normal_color:(UIColor*)normalColor highlighted_color:(UIColor*)color;
- (id)initWithFrame:(CGRect)frame titles:(NSArray *)titles cancal:(NSString *)cancal normal_color:(UIColor *)normalColor highlighted_color:(UIColor *)color cellBgColor:(UIColor*)bgColor cellLineColor:(UIColor*)lineColor;

- (void)showView;//执行出现动画，初始化后需要执行
- (void)hideView;//执行隐藏动画
- (BOOL)viewIsInAction;//判断当前是否在动画过程中


@end
