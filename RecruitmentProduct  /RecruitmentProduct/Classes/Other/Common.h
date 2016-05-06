//
//  Common.h

//
//  Created by qingyun on 15/12/23.
//  Copyright © 2015年 qingyun. All rights reserved.
//

#ifndef Common_h
#define Common_h
#import <AFNetworking.h>
#import <SDWebImageCompat.h>


#ifdef DEBUG //处于开发阶段
#define MYLog(...) NSLog(__VA_ARGS__)
#else//处于发布阶段
#define MYLog(...)
#endif

#define screenW [UIScreen mainScreen].bounds.size.width
#define screenH [UIScreen mainScreen].bounds.size.height

#define baseUrl @"http://192.168.100.67/zyzpPhone/"

#define kEnterprise @"enterprise"
#define kPerson @"person"
#define kPersonId @"personId"
#define kCompanyId @"companyId"
#define KHouseholdMark @"householdMark"
#define kAccountFileName @"kAccountFileName"

// 企业个人切换判断
#define judgeTabBarCIsPerson [self.tabBarController isKindOfClass:[zyzpTabBarController class]]



// 颜色R,G,B
#define Color(r,g,b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]

// 随机颜色
#define RandomColor [UIColor colorWithRed:arc4random_uniform(256)/255.0 green:arc4random_uniform(256)/255.0 blue:arc4random_uniform(256)/255.0 alpha:1.0]

#define zyMainColor [UIColor colorWithRed:(70)/255.0 green:(120)/255.0 blue:(220)/255.0 alpha:1.0]
//职位详情界面文字常用颜色
#define deatilMainColor [UIColor colorWithRed:(80)/255.0 green:(80)/255.0 blue:(80)/255.0 alpha:1.0]

#define ColorWithRGB(r,g,b) [UIColor colorWithRed:r/255. green:g/255. blue:b/255. alpha:1]
//首页四个btn高度
#define fourBtnHight 100

/************cell**************/
#define YFMargin 10
#define nameFont [UIFont systemFontOfSize:15]
#define timeFont [UIFont systemFontOfSize:11]
#define sourceFont timeFont





#endif /* Common_h */
