//
//  CSActionSheet.m
//
//
//  Created by e3mo on 15/7/7.
//  Copyright (c) 2015年 times. All rights reserved.
//

#import "CSActionSheet.h"

@implementation CSActionSheet

- (id)initWithFrame:(CGRect)frame titles:(NSArray *)titles cancal:(NSString *)cancal normal_color:(UIColor *)normalColor highlighted_color:(UIColor *)color {
    return [self initWithFrame:frame titles:titles cancal:cancal normal_color:normalColor highlighted_color:color cellBgColor:[UIColor whiteColor]];
}

- (id)initWithFrame:(CGRect)frame titles:(NSArray *)titles cancal:(NSString *)cancal normal_color:(UIColor *)normalColor highlighted_color:(UIColor *)color cellBgColor:(UIColor*)bgColor {
    
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
        
        [self initShowView:cancal normal_color:normalColor highlighted_color:color bgColor:bgColor];
    }
    
    return self;
}

- (void)initShowView:(NSString*)cancal normal_color:(UIColor *)normalColor highlighted_color:(UIColor *)color bgColor:(UIColor*)bgColor {
    show_view = [[UIView alloc] initWithFrame:CGRectMake(0, self.frame.size.height, self.frame.size.width, 0)];
    [show_view setBackgroundColor:[UIColor clearColor]];
    [self addSubview:show_view];
    
    float picker_height = titles_array.count * 50;
    
    UIImageView *picker_bg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, show_view.frame.size.width, picker_height)];
    [picker_bg setBackgroundColor:bgColor];
    [show_view addSubview:picker_bg];
    
    for (int i=0; i<titles_array.count; i++) {
        NSString *title = [titles_array objectAtIndex:i];
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setFrame:CGRectMake(0, i*50, picker_bg.frame.size.width, 50)];
        [btn setTitle:title forState:UIControlStateNormal];
        [btn setTitleColor:normalColor forState:UIControlStateNormal];
        if (color) {
            [btn setTitleColor:color forState:UIControlStateHighlighted];
        }
        [btn.titleLabel setFont:[UIFont boldSystemFontOfSize:16]];
        [btn setBackgroundColor:[UIColor clearColor]];
        [btn addTarget:self action:@selector(sureBtnTouched:) forControlEvents:UIControlEventTouchUpInside];
        [btn setTag:i+1];
        [show_view addSubview:btn];
        
        if (i != 0) {
            UIImageView *line1 = [[UIImageView alloc] initWithFrame:CGRectMake(0, i*50-0.5, show_view.frame.size.width, 1)];
            [line1 setBackgroundColor:[UIColor colorWithRed:220.f/255.f green:220.f/255.f blue:220.f/255.f alpha:1]];
            [picker_bg addSubview:line1];
        }
    }
    
    
    UIImageView *cancal_bg = [[UIImageView alloc] initWithFrame:CGRectMake(0, picker_height+5, show_view.frame.size.width, 50)];
    [cancal_bg setBackgroundColor:bgColor];
    [show_view addSubview:cancal_bg];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setFrame:CGRectMake(0, picker_height+5, cancal_bg.frame.size.width, 50)];
    [btn setTitle:cancal forState:UIControlStateNormal];
    [btn setTitleColor:normalColor forState:UIControlStateNormal];
    if (color) {
        [btn setTitleColor:color forState:UIControlStateHighlighted];
    }
    [btn.titleLabel setFont:[UIFont boldSystemFontOfSize:16]];
    [btn setBackgroundColor:[UIColor clearColor]];
    [btn addTarget:self action:@selector(sureBtnTouched:) forControlEvents:UIControlEventTouchUpInside];
    btn.tag = 0;
    [show_view addSubview:btn];
    
    
    CGRect frame = show_view.frame;
    frame.size.height = picker_height + cancal_bg.frame.size.height + 5;
    show_view.frame = frame;
}

- (void)sureBtnTouched:(id)sender {
    UIButton *btn = (UIButton*)sender;
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(csActionSheetSure:chooseIndex:)]) {
        [self.delegate csActionSheetSure:self chooseIndex:(int)btn.tag];
    }
}

- (void)closeBtnTouched:(id)sender {
    if (isInAction) {
        return;
    }
    
    [self hideView];
}

- (void)showView {
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
            
            if (self.delegate && [self.delegate respondsToSelector:@selector(csActionSheetClose:)]) {
                [self.delegate csActionSheetClose:self];
            }
        }
    }];
}

- (BOOL)viewIsInAction {
    return isInAction;
}

@end
