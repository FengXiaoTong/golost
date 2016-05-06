//
//  ZPFcompanyDetailsModel.h
//  RecruitmentProduct
//
//  Created by runsheng on 16/4/25.
//  Copyright © 2016年 RunShengInformation. All rights reserved.
//

#import <JSONModel/JSONModel.h>



@interface JobList : NSObject

@property (nonatomic, copy) NSString *publishAreaName;

@property (nonatomic, copy) NSString *agentArea;

@property (nonatomic, copy) NSString *latitude;

@property (nonatomic, assign) NSInteger topSort;

@property (nonatomic, copy) NSString *jobMainType;

@property (nonatomic, copy) NSString *provinceCode;

@property (nonatomic, copy) NSString *sb;

@property (nonatomic, copy) NSString *agentType;

@property (nonatomic, copy) NSString *companyName;

@property (nonatomic, copy) NSString *contactInfo;

@property (nonatomic, copy) NSString *cityName;

@property (nonatomic, copy) NSString *countResumeNum;

@property (nonatomic, copy) NSString *finallyDate;

@property (nonatomic, copy) NSString *jobId;

@property (nonatomic, copy) NSString *releaseStatus;

@property (nonatomic, copy) NSString *companyId;

@property (nonatomic, copy) NSString *experience;

@property (nonatomic, copy) NSString *topEndDate;

@property (nonatomic, copy) NSString *jobArea;

@property (nonatomic, copy) NSString *longitude;

@property (nonatomic, assign) NSInteger currentpage;

@property (nonatomic, copy) NSString *buginCreateDate;

@property (nonatomic, copy) NSString *jobNum;

@property (nonatomic, copy) NSString *createPerson;

@property (nonatomic, copy) NSString *jobDesc;

@property (nonatomic, copy) NSString *fullText;

@property (nonatomic, assign) NSInteger rscount;

@property (nonatomic, copy) NSString *countyName;

@property (nonatomic, copy) NSString *sort;

@property (nonatomic, copy) NSString *publishAreaId;

@property (nonatomic, copy) NSString *departId;

@property (nonatomic, assign) NSInteger personCount;

@property (nonatomic, copy) NSString *receiveSet;

@property (nonatomic, copy) NSString *education;

@property (nonatomic, copy) NSString *salary;

@property (nonatomic, copy) NSString *updateDate;

@property (nonatomic, copy) NSString *updatePerson;

@property (nonatomic, copy) NSString *isAudit;

@property (nonatomic, copy) NSString *templateId;

@property (nonatomic, copy) NSString *brightTag;

@property (nonatomic, copy) NSString *createDate;

@property (nonatomic, copy) NSString *filterId;

@property (nonatomic, copy) NSString *jobReply;

@property (nonatomic, copy) NSString *buginFinallyDate;

@property (nonatomic, copy) NSString *jobSecondType;

@property (nonatomic, copy) NSString *endFinallyDate;

@property (nonatomic, copy) NSString *jobNature;

@property (nonatomic, copy) NSString *jobState;

@property (nonatomic, copy) NSString *jobName;

@property (nonatomic, copy) NSString *publishDate;

@property (nonatomic, copy) NSString *releaseTime;

@property (nonatomic, copy) NSString *filePath;

@property (nonatomic, copy) NSString *publishArea;

@property (nonatomic, copy) NSString *companyArea;

@property (nonatomic, copy) NSString *endCreateDate;

@property (nonatomic, copy) NSString *jobCity;

@property (nonatomic, copy) NSString *receiveEmail;

@property (nonatomic, assign) NSInteger seeCount;

@end









@interface ZPFcompanyDetailsModel : JSONModel

@property (nonatomic, copy) NSString *agentArea;

@property (nonatomic, copy) NSString *latitude;

@property (nonatomic, copy) NSString *blockedMoney;

@property (nonatomic, copy) NSString *zyzpCompanyDetailsURL;

@property (nonatomic, copy) NSString *jobPhone;

@property (nonatomic, copy) NSString *manOrWoman;

@property (nonatomic, copy) NSString *inviterState;

@property (nonatomic, copy) NSString *loginTime;

@property (nonatomic, copy) NSString *businesslicenseFilePath;

@property (nonatomic, copy) NSString *inviterId;

@property (nonatomic, copy) NSString *inviterIds;

@property (nonatomic, copy) NSString *agentType;

@property (nonatomic, copy) NSString *companyName;

@property (nonatomic, copy) NSString *jobMainType;

@property (nonatomic, copy) NSString *cityName;

@property (nonatomic, assign) NSInteger jobCount;

@property (nonatomic, copy) NSString *chooseProvinceCode;

@property (nonatomic, copy) NSString *jobManOrWoman;

@property (nonatomic, copy) NSString *companyUrl;

@property (nonatomic, copy) NSString *companyId;

@property (nonatomic, copy) NSString *mainIndustry;

@property (nonatomic, copy) NSString *chooseCountyCode;

@property (nonatomic, copy) NSString *longitude;

@property (nonatomic, copy) NSString *minorIndustry;

@property (nonatomic, assign) NSInteger currentpage;

@property (nonatomic, copy) NSString *compnayPersons;

@property (nonatomic, copy) NSString *jobLinkman;

@property (nonatomic, copy) NSString *postalcode;

@property (nonatomic, copy) NSString *provinceCode;

@property (nonatomic, copy) NSString *companyCountry;

@property (nonatomic, copy) NSString *logoFilePath;

@property (nonatomic, copy) NSString *status;

@property (nonatomic, copy) NSString *throughBus;

@property (nonatomic, copy) NSString *agentAreaCounty;

@property (nonatomic, assign) NSInteger pageEnd;

@property (nonatomic, copy) NSString *createPerson;

@property (nonatomic, assign) NSInteger rscount;

@property (nonatomic, assign) NSInteger scoreCount;

@property (nonatomic, copy) NSString *jobTelephone;

@property (nonatomic, copy) NSString *countyName;

@property (nonatomic, copy) NSString *updateDate;

@property (nonatomic, copy) NSString *companyAreaName;

@property (nonatomic, copy) NSString *updatePerson;

@property (nonatomic, copy) NSString *email;

@property (nonatomic, copy) NSString *chooseCityCode;

@property (nonatomic, copy) NSString *checkState;

@property (nonatomic, copy) NSString *infoPerfect;

@property (nonatomic, copy) NSString *companyAddress;

@property (nonatomic, strong) NSArray *jobList;

@property (nonatomic, copy) NSString *companyEmail;

@property (nonatomic, assign) NSInteger freeDownLoad;

@property (nonatomic, copy) NSString *industry;

@property (nonatomic, copy) NSString *loginState;

@property (nonatomic, copy) NSString *mainIndustryName;

@property (nonatomic, copy) NSString *createDate;

@property (nonatomic, assign) NSInteger pageBegin;

@property (nonatomic, copy) NSString *areaName;

@property (nonatomic, assign) NSInteger resumeCount;

@property (nonatomic, copy) NSString *linkman;

@property (nonatomic, copy) NSString *telephone;

@property (nonatomic, copy) NSString *companyUserName;

@property (nonatomic, copy) NSString *userName;

@property (nonatomic, copy) NSString *needTip;

@property (nonatomic, copy) NSString *zyMoney;

@property (nonatomic, assign) BOOL ischeckState;

@property (nonatomic, copy) NSString *filePath;

@property (nonatomic, copy) NSString *phone;

@property (nonatomic, copy) NSString *companyArea;

@property (nonatomic, copy) NSString *isQualified;

@property (nonatomic, copy) NSString *loginUserName;

@property (nonatomic, copy) NSString *path;

@property (nonatomic, copy) NSString *companyType;

@property (nonatomic, strong) NSArray *searchUserTypeIds;

@property (nonatomic, copy) NSString *companyDesc;

@property (nonatomic, copy) NSString *companyPage;

@end



