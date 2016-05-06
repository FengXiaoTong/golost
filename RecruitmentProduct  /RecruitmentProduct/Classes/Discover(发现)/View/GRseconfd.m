//
//  GRseconfd.m
//  RecruitmentProduct
//
//  Created by andorid on 16/4/16.
//  Copyright © 2016年 RunShengInformation. All rights reserved.
//

#import "GRseconfd.h"
#import "Common.h"
#import "UIView+ZYFrame.h"
#import "secondXQModel.h"

#define kCOLORB Color(80, 80, 80)
#define kCOLORW Color(120, 120, 120)

@implementation GRseconfd

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getvalueFromNotifi:) name:@"headerModel" object:nil];
        self.backgroundColor = [UIColor whiteColor];
        [self addSubViews];
    }
    return self;
}

-(void)getvalueFromNotifi:(NSNotification *)notifi{
    NSDictionary *dict = [NSDictionary dictionaryWithDictionary:notifi.object];
    _model = dict[@"model"];
    self.nameLabel.text = self.model.recruitmentName;
    self.beginLabel.text = [@"开始时间 : " stringByAppendingString:[self.model.beginTime stringByAppendingString:self.model.beginWeek]];
    self.endLabel.text = [@"结束时间 : " stringByAppendingString: [self.model.endTime stringByAppendingString:self.model.endWeek]];
    self.peopleCountLabel.text = [NSString stringWithFormat:@"%ld", self.model.applyCount];
    self.addressLabel.text = self.model.address;
}
/**
 *  4.16删掉全部子视图  重新写
 */

// 重写set方法
//-(void)setModel:(secondXQModel *)model{
//    _model = model;
//    
//}


- (void)addSubViews
{
    
    /**
     *  日期图片
     */
    self.dateImage = [[UIImageView alloc] init];
    self.dateImage.image = [UIImage imageNamed:@"juxing"];
    [self addSubview:self.dateImage];
    
    /**
     *  日期图片上面的label
     */
    self.dataImageLabelUp = [[UILabel alloc] init];
    self.dataImageLabelUp.font = [UIFont systemFontOfSize:9.0];
    self.dataImageLabelUp.textColor = [UIColor whiteColor];
    self.dataImageLabelUp.text = @"2016-09";
    
    self.dataImageLabelDown = [[UILabel alloc] init];
    self.dataImageLabelDown.font = [UIFont systemFontOfSize:19.0];
    self.dataImageLabelDown.textColor = [UIColor whiteColor];
    self.dataImageLabelDown.text = @"30";
    
    [self.dateImage addSubview:_dataImageLabelUp];
    [self.dateImage addSubview:_dataImageLabelDown];
    
    /**
     *  招聘会名称
     */
    self.nameLabel = [[UILabel alloc] init];
    self.nameLabel.font = [UIFont systemFontOfSize:17.0];
    self.nameLabel.textColor = kCOLORB;
    self.nameLabel.text = @"郑州CBD国际会展中心大型综合招聘会";
    [self addSubview:self.nameLabel];
    
    /**
     *  开始时间
     */
    self.beginLabel = [[UILabel alloc] init];
    self.beginLabel.font = [UIFont systemFontOfSize:14.0];
    self.beginLabel.textColor = kCOLORW;
    self.beginLabel.text = @"开始时间 : 2016/07/08 08:00(周三)";
    [self addSubview:self.beginLabel];
    
    /**
     *  结束时间
     */
    self.endLabel = [[UILabel alloc] init];
    self.endLabel.font = [UIFont systemFontOfSize:14.0];
    self.endLabel.textColor = kCOLORW;
    self.endLabel.text = @"开始时间 : 2016/07/11 08:00(周六)";
    [self addSubview:self.endLabel];
    
    /**
     *  上面横线
     */
    self.upImageView = [[UIImageView alloc] init];
    self.upImageView.image = [UIImage imageNamed:@"hengxian"];
    [self addSubview:self.upImageView];
    
    /**
     *  中间竖线
     */
    self.midImageView = [[UIImageView alloc] init];
    self.midImageView.image = [UIImage imageNamed:@"111111"];
    [self addSubview:self.midImageView];
    
    /**
     *  下边横线
     */
    self.downImageView = [[UIImageView alloc] init];
    self.downImageView.image = [UIImage imageNamed:@"hengxian"];
    [self addSubview:self.downImageView];
    
    /**
     *  报名人数
     */
    self.peopleLabel = [[UILabel alloc] init];
    self.peopleLabel.font = [UIFont systemFontOfSize:15.0];
    self.peopleLabel.textColor = kCOLORW;
    self.peopleLabel.text = @"报名人数 :";
    [self addSubview:self.peopleLabel];
    
    self.peopleCountLabel = [[UILabel alloc] init];
    self.peopleCountLabel.font = [UIFont systemFontOfSize:15.0];
    self.peopleCountLabel.textColor = Color(255, 68, 102);
    self.peopleCountLabel.text = @"78520";
    [self addSubview:self.peopleCountLabel];
    
    /**
     *  点击报名button
     */
    self.button = [UIButton buttonWithType:0];
    self.button.titleLabel.font = [UIFont systemFontOfSize:15.0];
    [self.button setTitleColor:Color(70, 120, 220) forState:0];
    [self.button setTitle:@"立即报名" forState:0];
    [self.button addTarget:self action:@selector(actionButton:) forControlEvents:(UIControlEventTouchUpInside)];
    [self addSubview:self.button];
    
    /**
     *  参会地址
     */
    self.addressNameLabel = [[UILabel alloc] init];
    self.addressNameLabel.font = [UIFont systemFontOfSize:15.0];
    self.addressNameLabel.textColor = kCOLORB;
    self.addressNameLabel.text = @"参会具体地址 :";
    [self addSubview:self.addressNameLabel];
    
    /**
     *  详细参会地址
     */
    self.addressLabel = [[UILabel alloc] init];
    self.addressLabel.font = [UIFont systemFontOfSize:13.0];
    self.addressLabel.textColor = kCOLORW;
    self.addressLabel.text = @"郑州市高新区长春路与梧桐路交叉口国家大学科技园创业大厦";
    self.addressLabel.numberOfLines = 0;
    [self addSubview:self.addressLabel];
    
    
    /**
     *  乘车路线
     */
    self.wayNameLabel = [[UILabel alloc] init];
    self.wayNameLabel.font = [UIFont systemFontOfSize:15.0];
    self.wayNameLabel.text = @"建议乘车路线 :";
    self.wayNameLabel.textColor = kCOLORB;
    [self addSubview:self.wayNameLabel];
    
    self.wayLabel = [[UILabel alloc] init];
    self.wayLabel.font = [UIFont systemFontOfSize:13.0];
    self.wayLabel.textColor = kCOLORW;
    self.wayLabel.text = @"看了介绍电话谁离开的结果来看是谁离开的结果来看是觉得价格就是看到过格拉斯哥网上价格评审实力派地告诉的软件公司领导机构四大金刚;是我的说的;路公交;老师";
    
    self.wayLabel.numberOfLines = 0;
    [self addSubview:self.wayLabel];
    
    /**
     *  参会对象
     */
    self.joinNameLabel = [[UILabel alloc] init];
    self.joinNameLabel.font = [UIFont systemFontOfSize:15.0];
    self.joinNameLabel.text = @"参会对象 :";
    self.joinNameLabel.textColor = kCOLORB;
    [self addSubview:self.joinNameLabel];
    
    self.joinLabel = [[UILabel alloc] init];
    self.joinLabel.font = [UIFont systemFontOfSize:13.0];
    self.joinLabel.textColor = kCOLORW;
    self.joinLabel.text = @"老师的归属感是等级施工搜ID结果就是的价格睡了多久了开始给收到控股搜我机构我我国是迫切爱过后我二哥手机登录后开始的数量的口感还是";
    self.joinLabel.numberOfLines = 0;
    [self addSubview:self.joinLabel];
    
    
    
    
}

- (void)layoutSubviews
{
    self.dateImage.x = 10;
    self.dateImage.y = 15;
    self.dateImage.width = 55;
    self.dateImage.height = 58;
    
    self.dataImageLabelUp.x = (self.dateImage.width - self.dataImageLabelUp.width) / 2;
    self.dataImageLabelUp.y = 13;
//    self.dataImageLabelUp.width = 47;
//    self.dataImageLabelUp.height = 9;
    [self.dataImageLabelUp sizeToFit];
    
    self.dataImageLabelDown.x = 15;
    self.dataImageLabelDown.y = self.dateImage.height - self.dataImageLabelDown.height - 9;
//    self.dataImageLabelDown.width = 27;
//    self.dataImageLabelDown.height = 19;
    [self.dataImageLabelDown sizeToFit];
    
    
    // 招聘会名称
    self.nameLabel.x = CGRectGetMaxX(self.dateImage.frame) + 6;
    self.nameLabel.y = 17;
//    self.nameLabel.width = screenW - 20;
    self.nameLabel.width = screenW - self.nameLabel.x - 10;
    self.nameLabel.numberOfLines = 0;
    [self.nameLabel sizeToFit];
    
    self.beginLabel.x = self.nameLabel.x;
    self.beginLabel.y = CGRectGetMaxY(self.nameLabel.frame) + 4;
    [self.beginLabel sizeToFit];
    
    self.endLabel.x = self.beginLabel.x;
    [self.endLabel sizeToFit];
    self.endLabel.y = CGRectGetMaxY(self.beginLabel.frame) + 5;
    
    
    self.upImageView.x = 10;
    self.upImageView.y =CGRectGetMaxY(self.endLabel.frame) + 12;
    self.upImageView.width = screenW - 20;
    self.upImageView.height = 1;
    
    self.peopleLabel.x = 21;
    self.peopleLabel.y = CGRectGetMaxY(self.upImageView.frame) + 8;
    [self.peopleLabel sizeToFit];
    
    self.peopleCountLabel.x = CGRectGetMaxX(self.peopleLabel.frame) + 5;
    self.peopleCountLabel.y = self.peopleLabel.y;
    [self.peopleCountLabel sizeToFit];
    
    self.midImageView.x = (screenW - 1) / 2;
    self.midImageView.y = CGRectGetMaxY(self.upImageView.frame) + 4;
    self.midImageView.width = 1;
    self.midImageView.height = 22;
    
    self.button.x = CGRectGetMaxX(self.midImageView.frame) + 48;
    self.button.y = CGRectGetMaxY(self.upImageView.frame) + 8;
    self.button.width = 75;
    self.button.height = 12;
    
    self.downImageView.x = 10;
    self.downImageView.y = CGRectGetMaxY(self.midImageView.frame) + 4;
    self.downImageView.width = screenW - 20;
    self.downImageView.height = 1;
    
    self.addressNameLabel.x = 10;
    self.addressNameLabel.y = CGRectGetMaxY(self.downImageView.frame) + 12;
    [self.addressNameLabel sizeToFit];
    
    self.addressLabel.x = 10;
    self.addressLabel.y = CGRectGetMaxY(self.addressNameLabel.frame) + 8;
    self.addressLabel.width = screenW - 20;
    [self.addressLabel sizeToFit];
    
    self.wayNameLabel.x = 10;
    self.wayNameLabel.y = CGRectGetMaxY(self.addressLabel.frame) + 15;
    [self.wayNameLabel sizeToFit];
    
    self.wayLabel.x = 10;
    self.wayLabel.y = CGRectGetMaxY(self.wayNameLabel.frame) + 8;
    self.wayLabel.width = screenW - 20;
    [self.wayLabel sizeToFit];
    
    self.joinNameLabel.x = 10;
    self.joinNameLabel.y = CGRectGetMaxY(self.wayLabel.frame) + 15;
    [self.joinNameLabel sizeToFit];
    
    self.joinLabel.x = 10;
    self.joinLabel.y = CGRectGetMaxY(self.joinNameLabel.frame) + 8;
    self.joinLabel.width = screenW - 20;
    [self.joinLabel sizeToFit];
    
    self.dateImage.y = CGRectGetMaxY(self.endLabel.frame) - self.dateImage.height;
    
}

- (void)actionButton:(UIButton *)button
{
    NSLog(@"1");
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"报名成功" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
//    self.model.applyCount = self.model.applyCount + 1;
    [alertView show];
    
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
