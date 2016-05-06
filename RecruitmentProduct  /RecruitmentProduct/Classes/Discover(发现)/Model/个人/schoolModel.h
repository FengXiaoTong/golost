//
//  schoolModel.h
//  RecruitmentProduct
//
//  Created by andorid on 16/4/21.
//  Copyright © 2016年 RunShengInformation. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface schoolModel : NSObject

/**
 *  salary = 05;
	jobName = 金融网络销售;
	publishAreaName = 北京-东城区;
	experience = 03;
	companyName = 腾讯网络科技有限公司;
	education = ;
	jobId = B63AC6D0672E11E5BE28BFF06181A4E8;
    filePath = /enterprise/images/23C254304A2D11E5B067F05A8F00
    companyId = 23C254304A2D11E5B067F05A8F00256A;
 */


  // 4.21新增
/**
*  职位名称
*/
@property (nonatomic, strong) NSString *jobName;

/**
 *  公司地址
 */
@property (nonatomic, strong) NSString *publishAreaName;

/**
 *  公司名称
 */
@property (nonatomic, strong) NSString *companyName;

/**
 *  学历
 */
@property (nonatomic, strong) NSString *education;

/**
 *  薪资
 */
@property (nonatomic, assign) NSInteger salary;

/**
 *  日期
 */
@property (nonatomic, strong) NSString *publishDate;











@end
