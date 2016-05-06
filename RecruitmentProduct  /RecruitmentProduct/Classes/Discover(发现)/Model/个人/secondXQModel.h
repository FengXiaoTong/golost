//
//  secondXQModel.h
//  RecruitmentProduct
//
//  Created by andorid on 16/4/21.
//  Copyright © 2016年 RunShengInformation. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface secondXQModel : NSObject

/**
 *  beginTime = 2016-01-21 17:21:00;
    description = 不is地方科技阿什顿飞高科技
    ocation = 1251;
	status = 01;
	beginTimeStr = ;
	recruitmentId = C3DAC170C02311E5A755DF6B53D3A5FE;
	rscount = 0;
	provinceCode = ;
	agentArea = ;
	property = 综合招聘会;
	beginWeek = 四;
    endTimeStr = ;
	applyCount = 3;
	updateTime = ;
	endTime = 2018-01-21 17:21:00;
	organizersName = 河南建业;
	currentpage = 1;
	nowDate = 2016-04-21 10:21:707;
    recruitmentName = 招聘会名称招聘会名称招
    type = 01;
	countyName = ;
	createTime = 2016-01-21 17:55:49.0;
	endWeek = 日;
	cityName = ;
	locationName = ;
	address = 河南省郑州市惠济区政府;
	agentType = ;
    day = 21;
	brith = 2016年01月;
 */

  // 4.21新增


/**
*  图片上的年月
*/
@property (nonatomic, strong) NSString *brith;

/**
 *  图片上的日
 */
@property (nonatomic, assign) NSInteger day;

/**
 *  招聘会名称
 */

@property (nonatomic, strong) NSString *recruitmentName;

/**
 *  开始时间
 */
@property (nonatomic, strong) NSString *beginTime;

/**
 *  结束时间
 */
@property (nonatomic, strong) NSString *endTime;

/**
 *  开始星期
 */

@property (nonatomic, strong) NSString *beginWeek;

/**
 *  结束星期
 */
@property (nonatomic, strong) NSString *endWeek;

/**
 *  报名人数
 */
@property (nonatomic, assign) NSInteger applyCount;

/**
 *  参会地址
 */
@property (nonatomic, strong) NSString *address;










@end
