//
//  Ocean_BasicInfoCell.h
//  NJOceanHeart
//
//  Created by qiushi on 2017/6/27.
//  Copyright © 2017年 Xuanr. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol Ocean_BasicInfoCellDelegate <NSObject>
@optional
-(void)textFileChange:(UITextField *)tf;

@end

@class Ocean_PersonageInfoModel;
@interface Ocean_BasicInfoCell : UITableViewCell

@property (nonatomic,weak) UITextField * m_tf;
+ (instancetype)cellWithTableView:(UITableView *)tableView;
@property (nonatomic,strong) NSString * m_key;
//@property (nonatomic,strong) NSDictionary * m_infodic;
//@property (nonatomic,strong)  * infoModel;

-(void)setBaseDic:(NSDictionary *)infoDic andInfoModel:(Ocean_PersonageInfoModel *)infoModel;

@property (nonatomic,weak) id<Ocean_BasicInfoCellDelegate>delegate;

@end
