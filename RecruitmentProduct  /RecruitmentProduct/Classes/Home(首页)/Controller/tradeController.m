//
//  tradeController.m
//  RecruitmentProduct
//
//  Created by runsheng on 16/4/8.
//  Copyright © 2016年 RunShengInformation. All rights reserved.
//

#import "tradeController.h"
#import "Common.h"
#import "UIView+ZYFrame.h"
#import "zyCollectionViewCell.h"
#import "tradeHeaderReusableView.h"

// 间距
#define margin 10
// 每行个数
#define number 3

@interface tradeController ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic, strong) zyCollectionViewCell *cell;
@end

@implementation tradeController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.titleView = [[UISearchBar alloc] init];
    [self didSetUpCollectionView];
}

- (void)didSetUpCollectionView{
   
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    
    float width = (screenW - (number+1)*margin)/number;
    
    flowLayout.itemSize = CGSizeMake(width, width/7*3);
    // 每行最小间距
    flowLayout.minimumLineSpacing = margin * 2;
    // 每列最小间距
    flowLayout.minimumInteritemSpacing = margin/2;
    // 设置滚动方向
    flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    // 设置header区域大小
    flowLayout.headerReferenceSize = CGSizeMake(screenW, 50);
    
    flowLayout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:flowLayout];
    collectionView.delegate = self;
    collectionView.dataSource = self;
    collectionView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:collectionView];
    
    [collectionView registerClass:[zyCollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    [collectionView registerClass:[tradeHeaderReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header"];
    
}

#pragma mark - dataSource
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 5;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 4;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    
    
    
    zyCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    // 重用重影问题
    NSArray *subViews = cell.subviews;
    for (UIView *vi in subViews) {
        [vi removeFromSuperview];
    }
    
    cell.layer.cornerRadius = cell.height/2;
    cell.backgroundColor = Color(200, 200, 200);
    cell.title = @"计算机软件yutyeutyutyuy";
    _cell = cell;
    
    return cell;
}


#pragma mark - 点击cell
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    MYLog(@"%@",_cell.title);
}
#pragma mark - 设置组头组尾
-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    
    tradeHeaderReusableView *resuableView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header" forIndexPath:indexPath];
    NSArray *subViews = resuableView.subviews;
    for (UIView *vi in subViews) {
        [vi removeFromSuperview];
    }
    resuableView.headerTitle = @"IT/通信/电子/互联网";
    return resuableView;
    
}


@end
