//
//  CSActionSheet.m
//
//
//  Created by e3mo on 15/7/7.
//  Copyright (c) 2015年 times. All rights reserved.
//

#import "CSActionSheet.h"

#define CSAS_CELL_HEIGHT             50.f
#define CSAS_CELL_LABEL_SIZE         14.f

#define CSAS_DEFAULT_NORMAL_COLOR               [UIColor colorWithRed:0 green:0.478 blue:1 alpha:1]
#define CSAS_DEFAULT_HIGHLIGHT_COLOR            [UIColor colorWithRed:0 green:0.25 blue:0.7 alpha:1]
#define CSAS_DEFAULT_CANCAL_NORMAL_COLOR        [UIColor colorWithRed:0.9 green:0 blue:0 alpha:1]
#define CSAS_DEFAULT_CANCAL_HIGHLIGHT_COLOR     [UIColor colorWithRed:0.6 green:0 blue:0 alpha:1]
#define CSAS_DEFAULT_CELL_BG_COLOR              [UIColor whiteColor]
#define CSAS_DEFAULT_CELL_LINE_COLOR            [UIColor colorWithWhite:220.f/255.f alpha:1]
#define CSAS_DEFAULT_SHADE_BG_COLOR             [UIColor colorWithWhite:0 alpha:0.2]
#define CSAS_DEFAULT_TIPS_COLOR                 [UIColor grayColor]

@implementation CSActionSheet

- (id)initWithFrame:(CGRect)frame titles:(NSArray *)titles cancal:(NSString *)cancal tips:(NSString *)tips {
    return [self initWithFrame:frame cellX:0.f cellSize:CGSizeMake(frame.size.width, CSAS_CELL_HEIGHT) titles:titles normalColor:nil highlightColor:nil cancal:cancal cancalNormalColor:nil cancalHighlightColor:nil fontSize:-1 tips:tips tipsColor:nil tipsFontSize:-1 cellBgColor:nil cellLineColor:nil];
}

- (id)initWithFrame:(CGRect)frame cellX:(float)cellX cellSize:(CGSize)size titles:(NSArray *)titles normalColor:(UIColor *)normalColor highlightColor:(UIColor *)highlightColor cancal:(NSString *)cancal cancalNormalColor:(UIColor *)cancalNormalColor cancalHighlightColor:(UIColor *)cancalHighlightColor fontSize:(float)fontSize tips:(NSString *)tips tipsColor:(UIColor *)tipsColor tipsFontSize:(float)tipsFontSize cellBgColor:(UIColor *)bgColor cellLineColor:(UIColor *)lineColor {
    
    if (fontSize < 1) {
        fontSize = CSAS_CELL_LABEL_SIZE;
    }
    if (tipsFontSize < 1) {
        tipsFontSize = CSAS_CELL_LABEL_SIZE;
    }
    if (cellX < 0) {
        cellX = 0;
    }
    if (size.width > frame.size.width) {
        size.width = frame.size.width;
    }
    else if (size.width <= 0) {
        size.width = frame.size.width-cellX;
    }
    if (size.height <= 0) {
        size.height = CSAS_CELL_HEIGHT;
    }
    if (!normalColor) {
        normalColor = CSAS_DEFAULT_NORMAL_COLOR;
        if (!highlightColor) {
            highlightColor = CSAS_DEFAULT_HIGHLIGHT_COLOR;
        }
    }
    if (!cancalNormalColor) {
        cancalNormalColor = CSAS_DEFAULT_CANCAL_NORMAL_COLOR;
        if (!cancalHighlightColor) {
            cancalHighlightColor = CSAS_DEFAULT_CANCAL_NORMAL_COLOR;
        }
    }
    if (tipsColor) {
        tipsColor = CSAS_DEFAULT_TIPS_COLOR;
    }
    if (!bgColor) {
        bgColor = CSAS_DEFAULT_CELL_BG_COLOR;
    }
    if (!lineColor) {
        lineColor = CSAS_DEFAULT_CELL_LINE_COLOR;
    }
    if (!cancal || cancal.length == 0) {
        cancal = @"取消";
    }
    
    
    self = [super initWithFrame:frame];
    if (self) {
        self.clipsToBounds = YES;
        
        isInAction = NO;
        
        titles_array = [[NSArray alloc] initWithArray:titles];
        
        [self setBackgroundColor:[UIColor clearColor]];
        
        
        close_btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [close_btn setFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        [close_btn setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.3]];
        [close_btn addTarget:self action:@selector(closeBtnTouched:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:close_btn];
        
        [self initShowView:cancal normalColor:normalColor highlightedColor:highlightColor cancalNormalColor:cancalNormalColor cancalHighlightedColor:cancalHighlightColor tips:tips tipsColor:tipsColor bgColor:bgColor lineColor:lineColor cellX:cellX cellSize:size fontSize:fontSize tipsFontSize:tipsFontSize];
    }
    
    return self;
}

- (void)initShowView:(NSString*)cancal normalColor:(UIColor *)normalColor highlightedColor:(UIColor *)color cancalNormalColor:(UIColor *)cancalNormalColor cancalHighlightedColor:(UIColor *)cancalHighlightColor tips:(NSString *)tips tipsColor:(UIColor *)tipsColor bgColor:(UIColor*)bgColor lineColor:(UIColor*)lineColor cellX:(float)cellX cellSize:(CGSize)size fontSize:(float)fontSize tipsFontSize:(float)tipsFontSize {
    show_view = [[UIView alloc] initWithFrame:CGRectMake(cellX, self.frame.size.height, size.width, 0)];
    [show_view setBackgroundColor:[UIColor clearColor]];
    [self addSubview:show_view];
    
    float picker_height = 0;
    
    if (tips && tips.length > 0) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, show_view.frame.size.width-20, 0)];
        [label setText:tips];
        [label setTextColor:tipsColor];
        [label setTextAlignment:NSTextAlignmentCenter];
        label.numberOfLines = 0;
        [label setFont:[UIFont systemFontOfSize:tipsFontSize]];
        [label setBackgroundColor:[UIColor clearColor]];
        [label sizeToFit];
        CGRect frame = label.frame;
        frame.size.width = show_view.frame.size.width-20;
        label.frame = frame;
        tips_label = label;
        
        UIView *tips_bg = [[UIView alloc] initWithFrame:CGRectMake(0, 0, show_view.frame.size.width, label.frame.size.height+20)];
        [tips_bg setBackgroundColor:bgColor];
        tips_bg.tag = 999;
        [show_view addSubview:tips_bg];
        
        [tips_bg addSubview:tips_label];
        
        picker_height += tips_bg.frame.size.height;
        
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, picker_height-1, show_view.frame.size.width, 1)];
        [line setBackgroundColor:lineColor];
        line.tag = 998;
        [tips_bg addSubview:line];
    }
    
    
    
    picker_bg = [[UIView alloc] initWithFrame:CGRectMake(0, picker_height, size.width, titles_array.count*size.height)];
    [picker_bg setBackgroundColor:bgColor];
    
    for (int i=0; i<titles_array.count; i++) {
        NSString *title = [titles_array objectAtIndex:i];
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setFrame:CGRectMake(0, i*size.height, size.width, size.height)];
        [btn setTitle:title forState:UIControlStateNormal];
        [btn setTitleColor:normalColor forState:UIControlStateNormal];
        if (color) {
            [btn setTitleColor:color forState:UIControlStateHighlighted];
        }
        [btn.titleLabel setFont:[UIFont systemFontOfSize:fontSize]];
        [btn setBackgroundColor:[UIColor clearColor]];
        [btn addTarget:self action:@selector(sureBtnTouched:) forControlEvents:UIControlEventTouchUpInside];
        [btn setTag:2000+i];
        [picker_bg addSubview:btn];
        
        if (i != 0) {
            UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, i*size.height-0.5, size.width, 1)];
            [line setBackgroundColor:lineColor];
            line.tag = 1000+i;
            [picker_bg addSubview:line];
        }
    }
    
    if (titles_array.count > 6) {
        UIScrollView *scrollview = [[UIScrollView alloc] initWithFrame:CGRectMake(0, picker_height, size.width, size.height*5.5)];
        [scrollview setBackgroundColor:[UIColor clearColor]];
        [scrollview setScrollEnabled:YES];//能否滑动
        [scrollview setShowsHorizontalScrollIndicator:NO];
        [scrollview setShowsVerticalScrollIndicator:YES];
        [scrollview setPagingEnabled:NO];//设置是否按页翻动
        [scrollview setBounces:NO];//设置是否反弹
        [scrollview setIndicatorStyle:UIScrollViewIndicatorStyleDefault];//设置风格
        [scrollview setDirectionalLockEnabled:NO];//设置是否同时运动
        
        CGRect frame = picker_bg.frame;
        frame.origin.y = 0;
        picker_bg.frame = frame;
        
        [scrollview addSubview:picker_bg];
        
        [scrollview setContentSize:CGSizeMake(picker_bg.frame.size.width, picker_bg.frame.size.height)];//设置滑动范围
        [show_view addSubview:scrollview];
        
        picker_height += scrollview.frame.size.height;
    }
    else {
        [show_view addSubview:picker_bg];
        
        picker_height += titles_array.count * size.height;
    }
    
    
    
    UIImageView *cancal_bg = [[UIImageView alloc] initWithFrame:CGRectMake(0, picker_height+5, show_view.frame.size.width, size.height)];
    [cancal_bg setBackgroundColor:bgColor];
    cancal_bg.tag = 997;
    [show_view addSubview:cancal_bg];
    
    cancal_btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [cancal_btn setFrame:CGRectMake(0, picker_height+5, cancal_bg.frame.size.width, size.height)];
    [cancal_btn setTitle:cancal forState:UIControlStateNormal];
    [cancal_btn setTitleColor:cancalNormalColor forState:UIControlStateNormal];
    if (cancalHighlightColor) {
        [cancal_btn setTitleColor:cancalHighlightColor forState:UIControlStateHighlighted];
    }
    [cancal_btn.titleLabel setFont:[UIFont boldSystemFontOfSize:fontSize]];
    [cancal_btn setBackgroundColor:[UIColor clearColor]];
    [cancal_btn addTarget:self action:@selector(sureBtnTouched:) forControlEvents:UIControlEventTouchUpInside];
    cancal_btn.tag = 1999;
    [show_view addSubview:cancal_btn];
    
    
    CGRect frame = show_view.frame;
    frame.size.height = picker_height + cancal_bg.frame.size.height + 5;
    show_view.frame = frame;
}


- (void)setNormalColor:(UIColor*)color highlightColor:(UIColor*)hcolor {
    for (int i=0; i<titles_array.count; i++) {
        UIButton *btn = (UIButton*)[picker_bg viewWithTag:2000+i];
        if (color) {
            [btn setTitleColor:color forState:UIControlStateNormal];
            if (hcolor) {
                [btn setTitleColor:hcolor forState:UIControlStateHighlighted];
            }
            else {
                [btn setTitleColor:color forState:UIControlStateHighlighted];
            }
        }
        else {
            [btn setTitleColor:CSAS_DEFAULT_NORMAL_COLOR forState:UIControlStateNormal];
            [btn setTitleColor:CSAS_DEFAULT_HIGHLIGHT_COLOR forState:UIControlStateHighlighted];
        }
    }
}

- (void)setCancalLabelColor:(UIColor*)color highlightedColor:(UIColor*)hcolor {
    if (color) {
        [cancal_btn setTitleColor:color forState:UIControlStateNormal];
        if (hcolor) {
            [cancal_btn setTitleColor:hcolor forState:UIControlStateHighlighted];
        }
        else {
            [cancal_btn setTitleColor:color forState:UIControlStateHighlighted];
        }
    }
    else {
        [cancal_btn setTitleColor:CSAS_DEFAULT_CANCAL_NORMAL_COLOR forState:UIControlStateNormal];
        [cancal_btn setTitleColor:CSAS_DEFAULT_CANCAL_HIGHLIGHT_COLOR forState:UIControlStateHighlighted];
    }
}

- (void)setTipsColor:(UIColor*)color {
    if (tips_label) {
        if (color) {
            [tips_label setTextColor:color];
        }
        else {
            [tips_label setTextColor:CSAS_DEFAULT_TIPS_COLOR];
        }
    }
}

- (void)setLineColor:(UIColor*)color {
    UIView *line = (UIView*)[show_view viewWithTag:998];
    if (line) {
        if (color) {
            [line setBackgroundColor:color];
        }
        else {
            [line setBackgroundColor:CSAS_DEFAULT_CELL_LINE_COLOR];
        }
    }
    
    for (int i=1; i<titles_array.count; i++) {
        UIView *line = (UIView*)[picker_bg viewWithTag:1000+i];
        if (color) {
            [line setBackgroundColor:color];
        }
        else {
            [line setBackgroundColor:CSAS_DEFAULT_CELL_LINE_COLOR];
        }
    }
}

- (void)setBgColor:(UIColor*)color {
    UIView *tips_bg = (UIView*)[show_view viewWithTag:999];
    if (tips_bg) {
        if (color) {
            [tips_bg setBackgroundColor:color];
        }
        else {
            [tips_bg setBackgroundColor:CSAS_DEFAULT_CELL_LINE_COLOR];
        }
    }
    
    if (color) {
        [picker_bg setBackgroundColor:color];
    }
    else {
        [picker_bg setBackgroundColor:CSAS_DEFAULT_CELL_BG_COLOR];
    }
    
    UIView *cancal_bg = (UIView*)[show_view viewWithTag:997];
    if (cancal_bg) {
        if (color) {
            [cancal_bg setBackgroundColor:color];
        }
        else {
            [cancal_bg setBackgroundColor:CSAS_DEFAULT_CELL_LINE_COLOR];
        }
    }
}

- (void)setShadeColor:(UIColor*)color {
    if (color) {
        [close_btn setBackgroundColor:color];
    }
    else {
        [close_btn setBackgroundColor:CSAS_DEFAULT_SHADE_BG_COLOR];
    }
}

- (void)setFontSize:(float)fontsize {
    if (fontsize < 1) {
        fontsize = CSAS_CELL_LABEL_SIZE;
    }
    for (int i=0; i<titles_array.count; i++) {
        UIButton *btn = (UIButton*)[picker_bg viewWithTag:2000+i];
        [btn.titleLabel setFont:[UIFont systemFontOfSize:fontsize]];
    }
}

- (void)setTipsFontSize:(float)fontsize {
    if (fontsize < 1) {
        fontsize = CSAS_CELL_LABEL_SIZE;
    }
    [tips_label setFont:[UIFont systemFontOfSize:fontsize]];
}

- (void)sureBtnTouched:(id)sender {
    UIButton *btn = (UIButton*)sender;

    if (self.action) {
        self.action((int)btn.tag-2000+1, self);
    }
}

- (void)closeBtnTouched:(id)sender {
    if (isInAction) {
        return;
    }
    
    [self hideView];
}

- (void)showView:(void (^)(int, id))action close:(void (^)(id))close {
    self.action = action;
    self.close = close;
    
    if (isInAction) {
        return;
    }
    isInAction = YES;
    
    [UIView animateWithDuration:0.3 animations:^{
        CGRect frame = show_view.frame;
        frame.origin.y = self.frame.size.height-frame.size.height;
        show_view.frame = frame;
        
    } completion:^(BOOL finished) {
        if (finished) {
            isInAction = NO;
        }
    }];
}

- (void)hideView {
    if (isInAction) {
        return;
    }
    isInAction = YES;
    
    [UIView animateWithDuration:0.3 animations:^{
        CGRect frame = show_view.frame;
        frame.origin.y = self.frame.size.height;
        show_view.frame = frame;
        
    } completion:^(BOOL finished) {
        if (finished) {
            isInAction = NO;
            
            if (self.close) {
                self.close(self);
            }
        }
    }];
}

- (BOOL)viewIsInAction {
    return isInAction;
}

@end
