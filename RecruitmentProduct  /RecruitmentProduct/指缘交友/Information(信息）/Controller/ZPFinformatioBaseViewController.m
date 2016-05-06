//
//  ZPFinformatioBaseViewController.m
//  RecruitmentProduct
//
//  Created by runsheng on 16/5/4.
//  Copyright © 2016年 RunShengInformation. All rights reserved.
//

#import "ZPFinformatioBaseViewController.h"



#define TITLE_BT_WIDTH 38
#define TITLE_BT_HEIGHT 17
#define TITLE_BT_SPACING (screenW - TITLE_BT_WIDTH*4)/4



@interface ZPFinformatioBaseViewController ()<UIScrollViewDelegate>{
    
    
//    UIScrollView *_scrollView;
    //存储导航条上的button
    NSMutableArray *_buttonArray;
    //在点击事件中使用，用来记录上一次的点击
    UIButton *_button;
    //导航条上button下方的线
    UILabel *_lineLab;
    
}


@end

@implementation ZPFinformatioBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _buttonArray = [NSMutableArray array];
    
    [self createScrollView];
    

   
}

-(void)viewWillAppear:(BOOL)animated {

    [super viewWillAppear:animated];
    
    if (!_buttonArray.count) {
        NSArray *array = @[@"私信",@"学习",@"邀请",@"系统"];
        [self setTitleButton:array];
        for (UIButton *bt in _buttonArray) {
            [self.navigationController.navigationBar addSubview:bt];
        }
        [self.navigationController.navigationBar addSubview:_lineLab];
    }else {
    
        for (UIButton *bt in _buttonArray) {
            [self.navigationController.navigationBar addSubview:bt];
        }
        [self.navigationController.navigationBar addSubview:_lineLab];
    }
}

-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];

    for (UIButton *bt in _buttonArray) {
        [bt removeFromSuperview];
    }
    [_lineLab removeFromSuperview];
    
}


- (void)setTitleButton:(NSArray *)array {
    
    for (int i = 0; i < array.count; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        
        button.frame = CGRectMake(TITLE_BT_SPACING/2 + (TITLE_BT_WIDTH + TITLE_BT_SPACING)*i, 0, TITLE_BT_WIDTH, TITLE_BT_HEIGHT);
        button.centerY = self.navigationController.navigationBar.height/2;
        button.tag = 100+i;
        [button setTitle:array[i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        [_buttonArray addObject:button];
    }
    
    [self buttonAction:_buttonArray[0]];
    _lineLab = [[UILabel alloc] init];
    _lineLab.backgroundColor = UIColorFromRGB(0xFFDA43, 1.0);
    _lineLab.frame = CGRectMake(TITLE_BT_SPACING/2, CGRectGetMaxY(_button.frame) + 6, TITLE_BT_WIDTH, 1);
}

- (void)buttonAction:(UIButton *)button {
    
    NSInteger offSet = button.tag - 100;
    
    if ([button isEqual:_button]) {
        return;
    }else {
        [button setTitleColor:UIColorFromRGB(0xFFDA43, 1.0) forState:UIControlStateNormal];
            //     button.titleLabel.font = [UIFont boldSystemFontOfSize:20];
        if (_button) {
            //    _button.titleLabel.font = [UIFont systemFontOfSize:17];
            [_button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        }
        
    }

    [_scrollView setContentOffset:CGPointMake(screenW*offSet, 0) animated:YES];
    
    _button = button;
    
}

- (void)createScrollView {
    
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, screenW, VIEW_HEIGHT)];
    _scrollView.backgroundColor = Color(238, 238, 238);
    _scrollView.bounces = NO;
    _scrollView.delegate = self;
    _scrollView.pagingEnabled = YES;
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.backgroundColor = [UIColor yellowColor];
    _scrollView.contentSize = CGSizeMake(screenW*4, VIEW_HEIGHT);
    [self.view addSubview:_scrollView];
}



-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    NSInteger count = _scrollView.contentOffset.x/screenW;
    [self buttonAction:_buttonArray[count]];
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    _lineLab.x = scrollView.contentOffset.x/4 + TITLE_BT_SPACING/2;
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
