//
//  positionSectionHeaderView.m
//  RecruitmentProduct
//
//  Created by runsheng on 16/4/8.
//  Copyright © 2016年 RunShengInformation. All rights reserved.
//  职位类别自定义组头

#import "positionSectionHeaderView.h"
#import "positionGroup.h"

@interface positionSectionHeaderView ()
@property (nonatomic, strong) UIButton *bgBtn;


@end


@implementation positionSectionHeaderView

static NSString *headerViewIdentifier = @"headerView";

+(instancetype)headerViewWithTableView:(UITableView *)tableView
{
    positionSectionHeaderView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:headerViewIdentifier];
    if (headerView == nil) {
        headerView = [[positionSectionHeaderView alloc] initWithReuseIdentifier:headerViewIdentifier];
        
    }
    return headerView;
}

-(instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        //1、添加背景btn
        UIButton *bgBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.contentView addSubview:bgBtn];
        
        //对bgBtn添加背景图片（普通、高亮）
        UIImage *image = [[UIImage imageNamed:@"buddy_header_bg"] resizableImageWithCapInsets:UIEdgeInsetsMake(44, 0, 44, 1) resizingMode:UIImageResizingModeStretch];
        UIImage *highLightedImage = [[UIImage imageNamed:@"buddy_header_bg_highlighted"] resizableImageWithCapInsets:UIEdgeInsetsMake(44, 0, 44, 1) resizingMode:UIImageResizingModeStretch];
        
        [bgBtn setBackgroundImage:image forState:UIControlStateNormal];
        [bgBtn setBackgroundImage:highLightedImage forState:UIControlStateHighlighted];
        
        //设置bgBtn的字体颜色
        [bgBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        //设置内容的显示
        bgBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        
        //设置内容的偏移量
        bgBtn.contentEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
        
        //设置标题的偏移量
        bgBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
        
        //设置btn中图片视图的内容模式
        bgBtn.imageView.contentMode = UIViewContentModeCenter;
        
        bgBtn.imageView.clipsToBounds = NO;
        //设置bgBtn的图片和标题
        [bgBtn setImage:[UIImage imageNamed:@"buddy_header_arrow"] forState:UIControlStateNormal];
        
        //bgBtn添加事件监听
        [bgBtn addTarget:self action:@selector(bgBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        //2、在背景btn上面添加右边的label
        UILabel *label = [[UILabel alloc] init];
        [self.contentView addSubview:label];
        
        //设置label的文本对齐方式
        label.textAlignment = NSTextAlignmentRight;
        
        _bgBtn = bgBtn;
        
    }
    return self;
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    
    //设置bgBtn的frame
    _bgBtn.frame = self.bounds;
    

}


-(void)bgBtnClick:(UIButton *)btn
{
    //1、更改当前section的打开状态
    if (_group.isOpen) {
        _group.isOpen = NO;
        
    }else{
        _group.isOpen = YES;
    }
    
    //2、刷新表视图
    if (_headerViewClick) {
        _headerViewClick();
    }
}

-(void)setGroup:(positionGroup *)group
{
    _group = group;
    
    //设置子视图属性
    [_bgBtn setTitle:@"职业类别组名" forState:UIControlStateNormal];
    
    if (!_group.isOpen) {
        _bgBtn.imageView.transform = CGAffineTransformIdentity;
    }else{
        _bgBtn.imageView.transform = CGAffineTransformMakeRotation(M_PI_2);
    }
}
@end
