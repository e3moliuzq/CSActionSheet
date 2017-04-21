//
//  CSActionPicker.m
//  NotePad
//
//  Created by e3mo on 16/8/5.
//  Copyright © 2016年 e3mo. All rights reserved.
//

#import "CSActionPicker.h"

#define CSAP_CELL_HEIGHT             50.f
#define CSAP_CELL_LABEL_SIZE         14.f

#define CSAP_DEFAULT_NORMAL_COLOR        [UIColor colorWithRed:0 green:0.478 blue:1 alpha:1]
#define CSAP_DEFAULT_HIGHLIGHT_COLOR     [UIColor colorWithRed:0 green:0.25 blue:0.7 alpha:1]
#define CSAP_DEFAULT_CELL_BG_COLOR       [UIColor whiteColor]
#define CSAP_DEFAULT_CELL_LINE_COLOR     [UIColor colorWithWhite:220.f/255.f alpha:1]
#define CSAP_DEFAULT_SHADE_BG_COLOR      [UIColor colorWithWhite:0 alpha:0.2]


@implementation CSActionPicker

- (id)initWithFrame:(CGRect)frame titles:(NSArray *)titles {
    return [self initWithFrame:frame cellX:0.f cellSize:CGSizeMake(frame.size.width, CSAP_CELL_HEIGHT) titles:titles normalColor:nil highlightedColor:nil fontSize:-1 cellBgColor:nil cellLineColor:nil];
}

- (id)initWithFrame:(CGRect)frame cellX:(float)cellX cellSize:(CGSize)size titles:(NSArray *)titles normalColor:(UIColor *)normalColor highlightedColor:(UIColor *)highlightColor fontSize:(float)fontSize cellBgColor:(UIColor *)bgColor cellLineColor:(UIColor *)lineColor {
    
    if (fontSize < 1) {
        fontSize = CSAP_CELL_LABEL_SIZE;
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
        size.height = CSAP_CELL_HEIGHT;
    }
    if (!normalColor) {
        normalColor = CSAP_DEFAULT_NORMAL_COLOR;
        if (!highlightColor) {
            highlightColor = CSAP_DEFAULT_HIGHLIGHT_COLOR;
        }
    }
    if (!bgColor) {
        bgColor = CSAP_DEFAULT_CELL_BG_COLOR;
    }
    if (!lineColor) {
        lineColor = CSAP_DEFAULT_CELL_LINE_COLOR;
    }
    
    self = [super initWithFrame:frame];
    if (self) {
        self.clipsToBounds = YES;
        
        isInAction = NO;
        
        titles_array = [[NSArray alloc] initWithArray:titles];
        
        [self setBackgroundColor:[UIColor clearColor]];
        
        
        close_btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [close_btn setFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        [close_btn setBackgroundColor:CSAP_DEFAULT_SHADE_BG_COLOR];
        [close_btn addTarget:self action:@selector(closeBtnTouched:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:close_btn];
        
        [self initShowViewWithNormalColor:normalColor highlightedColor:highlightColor bgColor:bgColor lineColor:lineColor cellX:cellX cellSize:size fontSize:fontSize];
    }
    
    return self;
}

- (void)initShowViewWithNormalColor:(UIColor *)normalColor highlightedColor:(UIColor *)color bgColor:(UIColor*)bgColor lineColor:(UIColor*)lineColor cellX:(float)cellX cellSize:(CGSize)size fontSize:(float)fontSize {
    show_view = [[UIView alloc] initWithFrame:CGRectMake(cellX, self.frame.size.height, size.width, 0)];
    [show_view setBackgroundColor:[UIColor clearColor]];
    [self addSubview:show_view];
    
    float picker_height = 0;
    
    
    picker_bg = [[UIView alloc] initWithFrame:CGRectMake(0, 0, size.width, titles_array.count*size.height)];
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
        UIScrollView *scrollview = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height*5.5)];
        [scrollview setBackgroundColor:[UIColor clearColor]];
        [scrollview setScrollEnabled:YES];//能否滑动
        [scrollview setShowsHorizontalScrollIndicator:NO];
        [scrollview setShowsVerticalScrollIndicator:YES];
        [scrollview setPagingEnabled:NO];//设置是否按页翻动
        [scrollview setBounces:NO];//设置是否反弹
        [scrollview setIndicatorStyle:UIScrollViewIndicatorStyleDefault];//设置风格
        [scrollview setDirectionalLockEnabled:NO];//设置是否同时运动
        
        
        [scrollview addSubview:picker_bg];
        
        [scrollview setContentSize:CGSizeMake(picker_bg.frame.size.width, picker_bg.frame.size.height)];//设置滑动范围
        [show_view addSubview:scrollview];
        
        picker_height += scrollview.frame.size.height;
    }
    else {
        [show_view addSubview:picker_bg];
        
        picker_height += titles_array.count * size.height;
    }
    
    CGRect frame = show_view.frame;
    frame.size.height = picker_height;
    frame.origin.y = -frame.size.height;
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
            [btn setTitleColor:CSAP_DEFAULT_NORMAL_COLOR forState:UIControlStateNormal];
            [btn setTitleColor:CSAP_DEFAULT_HIGHLIGHT_COLOR forState:UIControlStateHighlighted];
        }
    }
}

- (void)setFontSize:(float)fontsize {
    if (fontsize < 1) {
        fontsize = CSAP_CELL_LABEL_SIZE;
    }
    for (int i=0; i<titles_array.count; i++) {
        UIButton *btn = (UIButton*)[picker_bg viewWithTag:2000+i];
        [btn.titleLabel setFont:[UIFont systemFontOfSize:fontsize]];
    }
}

- (void)setLineColor:(UIColor*)color {
    for (int i=1; i<titles_array.count; i++) {
        UIView *line = (UIView*)[picker_bg viewWithTag:1000+i];
        if (color) {
            [line setBackgroundColor:color];
        }
        else {
            [line setBackgroundColor:CSAP_DEFAULT_CELL_LINE_COLOR];
        }
    }
}

- (void)setBgColor:(UIColor*)color {
    if (color) {
        [picker_bg setBackgroundColor:color];
    }
    else {
        [picker_bg setBackgroundColor:CSAP_DEFAULT_CELL_BG_COLOR];
    }
}

- (void)setShadeColor:(UIColor*)color {
    if (color) {
        [close_btn setBackgroundColor:color];
    }
    else {
        [close_btn setBackgroundColor:CSAP_DEFAULT_SHADE_BG_COLOR];
    }
}

- (void)sureBtnTouched:(id)sender {
    UIButton *btn = (UIButton*)sender;
    
    if (self.action) {
        self.action((int)btn.tag-2000, self);
    }
}

- (void)closeBtnTouched:(id)sender {
    if (isInAction) {
        return;
    }
    
    [self hideView];
}

- (void)showView:(void (^)(int, id))action close:(void (^)(id))close {
    if (isInAction) {
        return;
    }
    self.action = action;
    self.close = close;
    
    isInAction = YES;
    
    [UIView animateWithDuration:0.3 animations:^{
        CGRect frame = show_view.frame;
        frame.origin.y = 0;
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
        frame.origin.y = -show_view.frame.size.height;
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
