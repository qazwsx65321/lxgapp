//
//  MeHeaderCell.m
//  NinthTribe-O
//
//  Created by 史伟文 on 2017/3/27.
//  Copyright © 2017年 NanJing. All rights reserved.
//

#import "MeHeaderCell.h"

@interface MeHeaderCell()

@property (nonatomic, strong)UILabel *titleLabel;
@property (nonatomic, strong)UIImageView *headImageView;
@property (nonatomic, strong)UILabel *nameLabel;

@end

@implementation MeHeaderCell

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *cellIdentifier = @"MeHeaderCell";
    MeHeaderCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[MeHeaderCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        cell.backgroundColor = [UIColor whiteColor];
    }
    
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor clearColor];
        // 绘制底图
        [self setupCellView];
        
    }
    return self;
}

- (void)setupCellView
{
  
    
//    _titleLabel = [[UILabel alloc] init];
//    _titleLabel.text = @"我的";
//    _titleLabel.textAlignment = NSTextAlignmentCenter;
//    _titleLabel.font = [UIFont boldSystemFontOfSize:20];
//    _titleLabel.textColor = [UIColor whiteColor];
//    [self.contentView addSubview:_titleLabel];
    
    _headImageView = [[UIImageView alloc] init];
    [self.contentView addSubview:_headImageView];
    _headImageView.image = [UIImage imageNamed:@"me_user"];
    
    _nameLabel = [[UILabel alloc] init];
    //_nameLabel.text = @"登录/注册";
    _nameLabel.textColor = [UIColor blackColor];
    _nameLabel.textAlignment = NSTextAlignmentCenter;
    _nameLabel.font = [UIFont systemFontOfSize:14];
    [self.contentView addSubview:_nameLabel];
    
    _messageLb = [[UILabel alloc] init];
    //_nameLabel.text = @"登录/注册";
    _messageLb.textColor = RGB(245, 180, 83);
    _messageLb.textAlignment = NSTextAlignmentCenter;
    _messageLb.font = [UIFont systemFontOfSize:13];
    [self.contentView addSubview:_messageLb];
    _messageLb.text = @"卡片等级: 银卡";
    
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
   
    
    _titleLabel.width = self.width;
    _titleLabel.height = 20;
    _titleLabel.x = 0;
    _titleLabel.y = 35;
    
    _headImageView.width = _headImageView.height = self.width *80/440;
    _headImageView.centerX = self.width/2;
    _headImageView.layer.borderColor = [UIColor whiteColor].CGColor;
    _headImageView.layer.borderWidth = .8;
    _headImageView.layer.shadowOffset = CGSizeMake(10, 10);
    _headImageView.layer.shadowOpacity = .8;
    _headImageView.layer.shadowColor = RGB(240, 240, 240).CGColor;
    _headImageView.layer.cornerRadius =  _headImageView.width /2;
    _headImageView.layer.masksToBounds = YES;
   _headImageView.centerY =  (self.height * 323/262)/2-5;

    
    _nameLabel.width = self.width;
    _nameLabel.height = 15;
    _nameLabel.x = 0;
    _nameLabel.y = CGRectGetMaxY(_headImageView.frame) + 10;
    
    _messageLb.width = self.width;
    _messageLb.height = 14;
    _messageLb.x = 0;
    _messageLb.y = CGRectGetMaxY(_nameLabel.frame) + 10;
    
}

- (void)setHeadpicture:(NSString *)headpicture
{
    _headpicture = headpicture;
    if ([headpicture hasPrefix:@"http"]) {
        [_headImageView sd_setImageWithURL:[NSURL URLWithString:headpicture] placeholderImage:[UIImage imageNamed:@"me_user"]];
    } else {
        _headImageView.image = [UIImage imageNamed:@"me_user"];
    }
}

- (void)setName:(NSString *)name
{
    _name = name;
    _nameLabel.text = name;
}

-(void)drawRect:(CGRect)rect{
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(0, 0)];
    [path addLineToPoint:CGPointMake(0, rect.size.height *250/262)];
    [path addLineToPoint:CGPointMake(rect.size.width, rect.size.height *73/262)];
    [path addLineToPoint:CGPointMake(rect.size.width, 0)];
    [path closePath];
    [BackgroundColors(1) setFill];
    CGContextAddPath(ctx, path.CGPath);
    CGContextDrawPath(ctx, kCGPathFill);


}

@end
