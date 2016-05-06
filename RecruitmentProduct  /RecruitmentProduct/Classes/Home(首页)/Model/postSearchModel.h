//
//  postSearchModel.h
//  RecruitmentProduct
//
//  Created by runsheng on 16/4/18.
//  Copyright © 2016年 RunShengInformation. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface postSearchModel : NSObject
/**
 *  全文搜索关键字
 */
@property (nonatomic, copy) NSString *keyWord;
/**
 *  当前页
 */
@property (nonatomic) NSInteger *currentpage;
/**
 *  工作地点
 */
@property (nonatomic, copy) NSString *jobCity;
/**
 *  用户ID
 */
@property (nonatomic, copy) NSString *personId;
/**
 *  结束页
 */
@property (nonatomic, copy) NSString *pageEnd;
/**
 *  职位发布地点
 */
@property (nonatomic, copy) NSString *publishAreaId;
/**
 *  学历
 */
@property (nonatomic, copy) NSString *education;
/**
 *  工作地址
 */
@property (nonatomic, copy) NSString *jobArea;
/**
 *  releaseTimeOn
 */
@property (nonatomic, copy) NSString *releaseTimeOn;
/**
 *  发布更新时间
 */
@property (nonatomic, copy) NSString *publishDate;
/**
 *  职位名称
 */
@property (nonatomic, copy) NSString *jobName;
/**
 *  rscount
 */
@property (nonatomic, copy) NSString *rscount;
/**
 *  职位置顶类型
 */
@property (nonatomic) NSInteger *topSort;
/**
 *  职位Id
 */
@property (nonatomic, copy) NSString *jobId;
/**
 *  高薪职位搜索
 */
@property (nonatomic, copy) NSString *isHighSalary;
/**
 *  月薪
 */
@property (nonatomic, copy) NSString *salary;
/**
 *  次要行业
 */
@property (nonatomic, copy) NSString *minorIndustry;
/**
 *  下载时间
 */
@property (nonatomic, copy) NSString *releaseTime;
/**
 *  职位亮点标签
 */
@property (nonatomic, copy) NSString *brightTag;
/**
 *  关键字
 */
@property (nonatomic, copy) NSString *fullText;
/**
 *  职位主要行业
 */
@property (nonatomic, copy) NSString *jobMainType;
/**
 *  公司名称或者职位名称
 */
@property (nonatomic, copy) NSString *companyNameJobName;
@property (nonatomic, copy) NSString *city;
/**
 *  公司Id
 */
@property (nonatomic, copy) NSString *companyId;
/**
 *  jobSecondType
 */
@property (nonatomic, copy) NSString *jobSecondType;
/**
 *  pageStart
 */
@property (nonatomic, copy) NSString *pageStart;
/**
 *  companyType
 */
@property (nonatomic, copy) NSString *companyType;
/**
 *  地区
 */
@property (nonatomic, copy) NSString *publishAreaName;
/**
 *  sm
 */
@property (nonatomic, copy) NSString *sm;
/**
 *  人数
 */
@property (nonatomic, copy) NSString *compnayPersons;
/**
 *  experienceOn
 */
@property (nonatomic, copy) NSString *experienceOn;
/**
 *  图标
 */
@property (nonatomic, copy) NSString *companyLogo;
/**
 *  isAdv
 */
@property (nonatomic, copy) NSString *isAdv;
/**
 *  endReleaseTim
 */
@property (nonatomic, copy) NSString *endReleaseTime;
/**
 *  brightTags
 */
@property (nonatomic, strong) NSArray *brightTags;
/**
 *  记录职位选择状态
 */
@property (nonatomic, copy) NSString *sb;
/**
 *  多选地区查询
 */
@property (nonatomic, copy) NSString *selectedPublishArea;
/**
 *  主要行业
 */
@property (nonatomic, copy) NSString *mainIndustry;
/**
 *  公司名称
 */
@property (nonatomic, copy) NSString *companyName;
/**
 *  热门职位
 */
@property (nonatomic, copy) NSString *areaId;
/**
 *  经验
 */
@property (nonatomic, copy) NSString *experience;
/**
 *  beginReleaseTime
 */
@property (nonatomic, copy) NSString *beginReleaseTime;
/**
 *  positionId
 */
@property (nonatomic, copy) NSString *positionId;
/**
 *  <#Description#>
 */
@property (nonatomic, copy) NSString *salaryOn;
/**
 *  compnayPersonsOn
 */
@property (nonatomic, copy) NSString *compnayPersonsOn;
/**
 *  jobNatures
 */
@property (nonatomic, copy) NSString *jobNatures;
@end
