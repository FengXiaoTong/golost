//
//  interviewModel.h
//  RecruitmentProduct
//
//  Created by andorid on 16/4/21.
//  Copyright © 2016年 RunShengInformation. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface interviewModel : NSObject

/**
 *  solutionContent = ;
	singleMulti = 01;
	paperId = 110001;
	paperType = 01;
	questionOrders = 1;
	questionId = 11000101;
	paperName = 毕业生篇;
	questionName = 自我介绍主要应该介绍什么？;
	solutionList = ({
      questionId = 11000101;
	  solutionId = 1100010101;
	  score = 0;
	  solutionName = 个人基本情况;
	  solutionOrders = 1;
    })
 */

    // 4.21

/**
*  题目名
*/
@property (nonatomic, strong) NSString *questionName;

/**
 *  答案
 */
@property (nonatomic, strong) NSString *solutionName;

/**
 *  第几题
 */
@property (nonatomic, assign) NSInteger questionOrders;



@end
