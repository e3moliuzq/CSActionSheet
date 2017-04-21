//
//  CSActionSheet.h
//  taishan
//
//  Created by e3mo on 15/7/7.
//  Copyright (c) 2015年 times. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface CSActionSheet : UIView {
    UIView *show_view;
    UIView *picker_bg;
    
    UIButton *close_btn;
    
    UILabel *tips_label;
    UIButton *cancal_btn;
    
    BOOL isInAction;
    
    NSArray *titles_array;
}

@property (readwrite, copy) void (^close) (id sender);//结束hideView动画时
@property (readwrite, copy) void (^action) (int index, id sender);//点击选项时

/**
 iOS自带的UIActionSheet不能改变颜色，故写这个
 */

/**
 该控件会有一个黑色半透明的遮罩，点击遮罩选择框将执行hideView动画
 frame：决定遮罩的位置大小和选择框的宽度
 titles：选项文字数组
 cellX：显示内容在frame中x的位置
 cellSize：显示内容一项的大小
 cancal：取消按钮的文字
 normal_color：文字普通状态颜色
 highlighted_color：文字点击状态颜色，可为nil
 cellBgColor：选项框背景颜色
 cellLineColor:选择框分隔线颜色
 tips：提示文字，可换行，可为空，为空则隐藏模块
 tipsColor：提示文字颜色，可为空，为空则为默认颜色
 fontsize：显示文字的大小
 */
- (id)initWithFrame:(CGRect)frame titles:(NSArray *)titles cancal:(NSString *)cancal tips:(NSString *)tips;
- (id)initWithFrame:(CGRect)frame cellX:(float)cellX cellSize:(CGSize)size titles:(NSArray *)titles normalColor:(UIColor *)normalColor highlightColor:(UIColor *)highlightColor cancal:(NSString *)cancal cancalNormalColor:(UIColor *)cancalNormalColor cancalHighlightColor:(UIColor *)cancalHighlightColor fontSize:(float)fontSize tips:(NSString*)tips tipsColor:(UIColor*)tipsColor tipsFontSize:(float)tipsFontSize cellBgColor:(UIColor*)bgColor cellLineColor:(UIColor*)lineColor;

/**
 此处设置会重新读取显示内容再进行修改，效率比较低，如果有设定最好在初始化设置
 */
- (void)setNormalColor:(UIColor*)color highlightColor:(UIColor*)hcolor;
- (void)setCancalLabelColor:(UIColor*)color highlightedColor:(UIColor*)hcolor;//设置取消按钮的颜色，highColor可为空
- (void)setTipsColor:(UIColor*)color;
- (void)setLineColor:(UIColor*)color;
- (void)setBgColor:(UIColor*)color;
- (void)setShadeColor:(UIColor*)color;
- (void)setFontSize:(float)fontsize;
- (void)setTipsFontSize:(float)fontsize;

- (void)showView:(void (^) (int index, id sender))action close:(void (^) (id sender))close;//执行出现动画，初始化后需要执行
- (void)hideView;//执行隐藏动画
- (BOOL)viewIsInAction;//判断当前是否在动画过程中


@end
