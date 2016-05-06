//
//  secondModel.h
//  RecruitmentProduct
//
//  Created by andorid on 16/4/20.
//  Copyright © 2016年 RunShengInformation. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface secondModel : NSObject
/**
 *  {
	description = 不is地方科技阿什顿飞高科技哈斯科技的回复您空间阿斯顿后;
	endWeek = 日;
	beginWeek = 四;
	recruitmentName = 招聘会名称;
	endDate = 2018-01-21 17:21:00;
	type = 综合招聘;
	createTime = 2016-01-21 17:55;
	location = 河南-郑州-金水区;
	property = 综合招聘会;
	recruitmentId = C3DAC170C02311E5A755DF6B53D3A5FE;
	organizersName = 河南建业;
	beginDate = 2016-01-21 17:21:00;
	beginTime = 2016-01-21 17:55;
	endTime = 2018-01-21 17:55;
	status = 01;
	address = 河南省郑州市惠济区政府;
 }
 */
/**
*  描述
*/


@property (nonatomic,strong) NSString *endWeek;

/**
 *  招聘会名称
 */
@property (nonatomic,strong) NSString *organizersName;

/**
 *  活动地址
 */
@property (nonatomic,strong) NSString *address;

/**
 *  活动类型
 */
@property (nonatomic,strong) NSString *property;

/**
 *  活动人数
 */
@property (nonatomic,assign) NSInteger applyCount;

/**
 *  活动时间
 */
@property (nonatomic,strong) NSString *createTime;

/**
 *  4.21新增 recruitmentId
 */
@property (nonatomic, strong) NSString *recruitmentId;



//@property (nonatomic,copy) NSString *title;




//-(instancetype)initWithModelWithDictionary:(NSDictionary *)dict;









@end
