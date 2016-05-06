//
//  MoreViewController.m
//  RecruitmentProduct
//
//  Created by runsheng on 16/4/13.
//  Copyright © 2016年 RunShengInformation. All rights reserved.
//

#import "MoreViewController.h"
#import <UIImageView+WebCache.h>
#import "Common.h"
#import "UIView+ZYFrame.h"
#import "IntroduceViewController.h"
#import "QuestionViewController.h"
#import "TouchViewController.h"
#import "IdeaViewController.h"
#import "PageViewController.h"

@interface MoreViewController ()
@property(nonatomic, strong) NSArray *titleArr;

@end

@implementation MoreViewController

-(NSArray *)titleArr{
    if (_titleArr == nil) {
        
        _titleArr = @[@"平台介绍",@"常见问题",@"联系我们",@"意见反馈",@"清除缓存",@"版本号"];
    }
    return _titleArr;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    self.navigationController.navigationBar.hidden = NO;
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.titleArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:1 reuseIdentifier:identifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
    }
    cell.textLabel.text = self.titleArr[indexPath.row];
    
    
    return cell;
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        IntroduceViewController *IntroduceVC = [[IntroduceViewController alloc] init];
        [self.navigationController pushViewController:IntroduceVC animated:YES];
    }else if (indexPath.row == 1) {
        QuestionViewController *QuestionVC = [[QuestionViewController alloc] init];
        [self.navigationController pushViewController:QuestionVC animated:YES];
        
    }else if (indexPath.row == 2){
        TouchViewController  *TouchVC = [[TouchViewController alloc] init];
        [self.navigationController pushViewController:TouchVC animated:YES];
    }else if (indexPath.row == 3){
        IdeaViewController  *IdeaVC = [[IdeaViewController alloc] init];
        [self.navigationController pushViewController:IdeaVC animated:YES];
    }else if (indexPath.row == 4){
        [self clearTheCache];
    }else if (indexPath.row == 5){
        PageViewController  *PageVC = [[PageViewController alloc] init];
        [self.navigationController pushViewController:PageVC animated:YES];
    }
}




-(void)clearTheCache {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"亲爱的用户，您好！" message:[NSString stringWithFormat:@"确定清空%.2fM的本地缓存图片？",[self CacheFileSize]] preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        return ;
    }];
    UIAlertAction *loginAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [MoreViewController clearCache];
    }];
    [alertController addAction:cancelAction];
    [alertController addAction:loginAction];
    [self presentViewController:alertController animated:YES completion:nil];
    
}

- (float)CacheFileSize {
    return [MoreViewController fileSizeAtPath:[NSString stringWithFormat:@"%@/Library/Caches",NSHomeDirectory()]];
}

+ (float)fileSizeAtPath:(NSString *)path {
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:path]) {
        __block NSUInteger size = 0;
        dispatch_sync(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            //获取path路径下子文件
            NSDirectoryEnumerator *enumerator = [fileManager enumeratorAtPath:path];
            for (NSString *fileName in enumerator) {
                NSString *filePath = [path stringByAppendingPathComponent:fileName];
                NSDictionary *attributes = [fileManager attributesOfItemAtPath:filePath error:nil];
                size += [attributes fileSize];
            }
        });
        
        //获取SDWebImage缓存大小
        size += [SDImageCache sharedImageCache].getSize;
        return size/1024.0/1024.0;
    }
    return 0;
}

+ (NSString *)cacheDirectory {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    
    return paths[0];
}
//清理缓存
+ (void)clearCache {
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:[self cacheDirectory]]) {
        NSArray *childFiles = [fileManager subpathsAtPath:[self cacheDirectory]];
        for (NSString *childName in childFiles) {
            NSString *childPath = [[self cacheDirectory] stringByAppendingPathComponent:childName];
            [fileManager removeItemAtPath:childPath error:nil];
        }
    }
    dispatch_queue_t queue = dispatch_queue_create("com.iluckly.serial", DISPATCH_QUEUE_SERIAL);
    dispatch_async(queue, ^{
        [[SDImageCache sharedImageCache] clearDisk];
    });
    dispatch_async(queue, ^{
        NSLog(@"OK");
    });
    
    
}





@end

