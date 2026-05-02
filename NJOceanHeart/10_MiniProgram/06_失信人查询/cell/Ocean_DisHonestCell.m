//
//  Ocean_DisHonestCell.m
//  NJOceanHeart
//
//  Created by 陈志伟 on 17/9/13.
//  Copyright © 2017年 Xuanr. All rights reserved.
//

#import "Ocean_DisHonestCell.h"

@interface Ocean_DisHonestCell ()

@property (nonatomic,strong) UIView *bgView;
@property (nonatomic,strong) UILabel *nameLabel;
@property (nonatomic,strong) UILabel *idLabel;
@property (nonatomic,strong) UILabel *ageLabel;
@property (nonatomic,strong) UILabel *sexLabel;
@property (nonatomic,strong) UILabel *filingdateLabel;
@property (nonatomic,strong) UILabel *casenoLabel;
@property (nonatomic,strong) UILabel *baseonnoLabel;
@property (nonatomic,strong) UILabel *baseonorgLabel;
@property (nonatomic,strong) UILabel *courtLabel;
@property (nonatomic,strong) UILabel *provinceLabel;
@property (nonatomic,strong) UILabel *dutyLabel;
@property (nonatomic,strong) UILabel *performanceLabel;
@property (nonatomic,strong) UILabel *descriptionLabel;
@property (nonatomic,strong) UILabel *pubdateLabel;

@end

@implementation Ocean_DisHonestCell

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *cellsign = @"Ocean_DisHonestCell";
    Ocean_DisHonestCell *cell  = [tableView dequeueReusableCellWithIdentifier:cellsign];
    if (cell ==nil) {
        cell  = [[Ocean_DisHonestCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellsign];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor clearColor];
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        [self setupControls];
    }
    return self;
}

-(void)setupControls{
    
    self.bgView = [[UIView alloc] init];
    self.bgView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:self.bgView];
    
    self.nameLabel = [[UILabel alloc] init];
    self.nameLabel.font = [UIFont systemFontOfSize:13];
//    self.nameLabel.text = @"姓名或公司名称: 何某文";
    [self.bgView addSubview:self.nameLabel];
    
    self.idLabel = [[UILabel alloc] init];
    self.idLabel.font = [UIFont systemFontOfSize:13];
//    self.idLabel.text = @"身份证或组织机构代码: 510224196911117077";
    [self.bgView addSubview:self.idLabel];
    
    self.ageLabel = [[UILabel alloc] init];
    self.ageLabel.font = [UIFont systemFontOfSize:13];
//    self.ageLabel.text = @"年龄: 47";
    [self.bgView addSubview:self.ageLabel];
    
    self.sexLabel = [[UILabel alloc] init];
    self.sexLabel.font = [UIFont systemFontOfSize:13];
//    self.sexLabel.text = @"性别: 男";
    [self.bgView addSubview:self.sexLabel];
    
    self.filingdateLabel = [[UILabel alloc] init];
    self.filingdateLabel.font = [UIFont systemFontOfSize:13];
//    self.filingdateLabel.text = @"立案时间: 2016年06月21日";
    [self.bgView addSubview:self.filingdateLabel];
    
    self.casenoLabel = [[UILabel alloc] init];
    self.casenoLabel.font = [UIFont systemFontOfSize:13];
//    self.casenoLabel.text = @"案号: (2016)渝0105执2783号";
    [self.bgView addSubview:self.casenoLabel];
    
    self.baseonnoLabel = [[UILabel alloc] init];
    self.baseonnoLabel.font = [UIFont systemFontOfSize:13];
//    self.baseonnoLabel.text = @"执行依据文号: （2016）渝0105民初7339号";
    [self.bgView addSubview:self.baseonnoLabel];
    
    self.baseonorgLabel = [[UILabel alloc] init];
    self.baseonorgLabel.font = [UIFont systemFontOfSize:13];
//    self.baseonorgLabel.text = @"做出执行依据单位: 重庆市江北区人民法院";
    [self.bgView addSubview:self.baseonorgLabel];
    
    self.courtLabel = [[UILabel alloc] init];
    self.courtLabel.font = [UIFont systemFontOfSize:13];
//    self.courtLabel.text = @"执行法院: 重庆市江北区人民法院";
    [self.bgView addSubview:self.courtLabel];
    
    self.provinceLabel = [[UILabel alloc] init];
    self.provinceLabel.font = [UIFont systemFontOfSize:13];
//    self.provinceLabel.text = @"省份: 重庆";
    [self.bgView addSubview:self.provinceLabel];
    
    self.dutyLabel = [[UILabel alloc] init];
    self.dutyLabel.font = [UIFont systemFontOfSize:13];
//    self.dutyLabel.text = @"生效法律文书确定的义务: 见判决书";
    self.dutyLabel.numberOfLines = 0;
    [self.bgView addSubview:self.dutyLabel];
    
    self.performanceLabel = [[UILabel alloc] init];
    self.performanceLabel.font = [UIFont systemFontOfSize:13];
//    self.performanceLabel.text = @"被执行人履行情况: 全部未履行";
    self.performanceLabel.numberOfLines = 0;
    [self.bgView addSubview:self.performanceLabel];
    
    self.descriptionLabel = [[UILabel alloc] init];
    self.descriptionLabel.font = [UIFont systemFontOfSize:13];
//    self.descriptionLabel.text = @"失信被执行人行为具体情形: 其他有履行能力而拒不履行生效法律文书确定义务";
    self.descriptionLabel.numberOfLines = 0;
    [self.bgView addSubview:self.descriptionLabel];
    
    self.pubdateLabel = [[UILabel alloc] init];
    self.pubdateLabel.font = [UIFont systemFontOfSize:13];
//    self.pubdateLabel.text = @"发布时间: 2016年06月21日";
    [self.bgView addSubview:self.pubdateLabel];
}

- (void)setName:(NSString *)name {
    _name = name;
}

- (void)setIdnum:(NSString *)idnum {
    _idnum = idnum;
}

- (void)setCellframes:(Ocean_DisHonestFrame *)cellframes {
    _cellframes = cellframes;
    
    _bgView.frame = cellframes.bgViewF;
    _nameLabel.frame = cellframes.nameLabelF;
    _idLabel.frame = cellframes.idLabelF;
    _ageLabel.frame = cellframes.ageLabelF;
    _sexLabel.frame = cellframes.sexLabelF;
    _filingdateLabel.frame = cellframes.filingdateLabelF;
    _casenoLabel.frame = cellframes.casenoLabelF;
    _baseonnoLabel.frame = cellframes.baseonnoLabelF;
    _baseonorgLabel.frame = cellframes.baseonorgLabelF;
    _courtLabel.frame = cellframes.courtLabelF;
    _provinceLabel.frame = cellframes.provinceLabelF;
    _dutyLabel.frame = cellframes.dutyLabelF;
    _performanceLabel.frame = cellframes.performanceLabelF;
    _descriptionLabel.frame = cellframes.descriptionLabelF;
    _pubdateLabel.frame = cellframes.pubdateLabelF;
    
    
    _nameLabel.text = [NSString stringWithFormat:@"姓名或公司名称: %@",_name];
    _idLabel.text = [NSString stringWithFormat:@"身份证或组织机构代码: %@",cellframes.model.idcard];
    _ageLabel.text = [NSString stringWithFormat:@"年龄: %@",cellframes.model.age];
    _sexLabel.text = [NSString stringWithFormat:@"性别: %@",cellframes.model.sex];
    _filingdateLabel.text = [NSString stringWithFormat:@"立案时间: %@",cellframes.model.filingdate];
    _casenoLabel.text = [NSString stringWithFormat:@"案号: %@",cellframes.model.caseno];
    _baseonnoLabel.text = [NSString stringWithFormat:@"执行依据文号: %@",cellframes.model.baseonno];
    _baseonorgLabel.text = [NSString stringWithFormat:@"做出执行依据单位: %@",cellframes.model.baseonorg];
    _courtLabel.text = [NSString stringWithFormat:@"执行法院: %@",cellframes.model.court];
    _provinceLabel.text = [NSString stringWithFormat:@"省份: %@",cellframes.model.province];
    _dutyLabel.text = [NSString stringWithFormat:@"生效法律文书确定的义务: %@",cellframes.model.duty];
    _performanceLabel.text = [NSString stringWithFormat:@"被执行人履行情况: %@",cellframes.model.performance];
    _descriptionLabel.text = [NSString stringWithFormat:@"失信被执行人行为具体情形: %@",cellframes.model.desc];
    _pubdateLabel.text = [NSString stringWithFormat:@"发布时间: %@",cellframes.model.pubdate];
    
}

@end



@implementation Ocean_DisHonestFrame

- (void)setModel:(Ocean_ShiXinBody *)model {
    _model = model;
    
    
    _bgViewF = CGRectMake(0, 0, screen_Width, 430);
    _nameLabelF = CGRectMake(10, 10, screen_Width - 20, 20);
    _idLabelF = CGRectMake(10, 40, screen_Width - 20, 20);
    _ageLabelF = CGRectMake(10, 70, screen_Width - 20, 20);
    _sexLabelF = CGRectMake(10, 100, screen_Width - 20, 20);
    _filingdateLabelF = CGRectMake(10, 130, screen_Width - 20, 20);
    _casenoLabelF = CGRectMake(10, 160, screen_Width - 20, 20);
    _baseonnoLabelF = CGRectMake(10, 190, screen_Width - 20, 20);
    _baseonorgLabelF = CGRectMake(10, 220, screen_Width - 20, 20);
    _courtLabelF = CGRectMake(10, 250, screen_Width - 20, 20);
    _provinceLabelF = CGRectMake(10, 280, screen_Width - 20, 20);
    
    
    CGSize dutyS = [StringSizeModel sizeWithText:[NSString stringWithFormat:@"生效法律文书确定的义务: %@",model.duty] font:[UIFont systemFontOfSize:13] maxW:screen_Width - 20];
    
    _dutyLabelF = CGRectMake(10, 310, screen_Width - 20, dutyS.height);
    
    CGSize performanceS = [StringSizeModel sizeWithText:[NSString stringWithFormat:@"被执行人履行情况: %@",model.performance] font:[UIFont systemFontOfSize:13] maxW:screen_Width - 20];
    
    _performanceLabelF = CGRectMake(10, CGRectGetMaxY(_dutyLabelF)+10, screen_Width - 20, performanceS.height);
    
    CGSize descriptionS = [StringSizeModel sizeWithText:[NSString stringWithFormat:@"失信被执行人行为具体情形: %@",model.desc] font:[UIFont systemFontOfSize:13] maxW:screen_Width - 20];
    
    _descriptionLabelF = CGRectMake(10, CGRectGetMaxY(_performanceLabelF)+10, screen_Width - 20, descriptionS.height);
    
    
    _pubdateLabelF = CGRectMake(10, CGRectGetMaxY(_descriptionLabelF)+10, screen_Width - 20, 20);
    
    _bgViewF.size.height = CGRectGetMaxY(_pubdateLabelF)+10;
    
}

@end
