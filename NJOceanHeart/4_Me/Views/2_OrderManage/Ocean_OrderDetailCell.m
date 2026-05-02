//
//  Ocean_OrderDetailCell.m
//  NJOceanHeart
//
//  Created by 陈志伟 on 17/8/1.
//  Copyright © 2017年 Xuanr. All rights reserved.
//

#import "Ocean_OrderDetailCell.h"

#import "Ocean_OrderDetailModel.h"

@interface Ocean_OrderDetailCell ()

@property (nonatomic,strong) UIView *bgView;
@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,strong) UILabel *payWayLabel;
@property (nonatomic,strong) UIView *line;
@property (nonatomic,strong) UILabel *nameLabel;
@property (nonatomic,strong) UILabel *phoneLabel;
@property (nonatomic,strong) UILabel *addressLabel;
@property (nonatomic,strong) UILabel *stateLabel;

@end

@implementation Ocean_OrderDetailCell

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *cellsign = @"Ocean_OrderDetailCell";
    Ocean_OrderDetailCell *cell  = [tableView dequeueReusableCellWithIdentifier:cellsign];
    if (cell ==nil) {
        cell  = [[Ocean_OrderDetailCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellsign];
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
    
    self.titleLabel = [[UILabel alloc] init];
    self.titleLabel.text = @"配送方式";
    self.titleLabel.font = [UIFont systemFontOfSize:15];
    [self.bgView addSubview:self.titleLabel];
    
    self.payWayLabel = [[UILabel alloc] init];
    self.payWayLabel.text = @"在线支付";
    self.payWayLabel.textAlignment = NSTextAlignmentRight;
    self.payWayLabel.textColor = [UIColor lightGrayColor];
    self.payWayLabel.font = [UIFont systemFontOfSize:15];
    [self.bgView addSubview:self.payWayLabel];
    
    self.line = [[UIView alloc] init];
    self.line.backgroundColor = [UIColor colorWithWhite:0.949 alpha:1.000];
    [self.bgView addSubview:self.line];
    
    self.nameLabel = [[UILabel alloc] init];
    self.nameLabel.text = @"1233";
    self.nameLabel.font = [UIFont systemFontOfSize:15];
    [self.bgView addSubview:self.nameLabel];
    
    self.phoneLabel = [[UILabel alloc] init];
    self.phoneLabel.text = @"1555888888";
    self.phoneLabel.textAlignment = NSTextAlignmentRight;
    self.phoneLabel.textColor = [UIColor lightGrayColor];
    self.phoneLabel.font = [UIFont systemFontOfSize:15];
    [self.bgView addSubview:self.phoneLabel];
    
    self.addressLabel = [[UILabel alloc] init];
    self.addressLabel.text = @"金陵王榭3栋";
    self.addressLabel.font = [UIFont systemFontOfSize:15];
    self.addressLabel.numberOfLines = 0;
    [self.bgView addSubview:self.addressLabel];
    
    self.stateLabel = [[UILabel alloc] init];
    self.stateLabel.text = @"待支付";
    self.stateLabel.textAlignment = NSTextAlignmentRight;
    self.stateLabel.textColor = [UIColor colorWithRed:0.141 green:0.565 blue:0.349 alpha:1.000];
    self.stateLabel.font = [UIFont systemFontOfSize:15];
    [self.bgView addSubview:self.stateLabel];
    
}


- (void)setCellFrame:(Ocean_OrderDetailFrame *)cellFrame {
    _cellFrame = cellFrame;
    
    _bgView.frame = cellFrame.bgViewF;
    _titleLabel.frame = cellFrame.titleLabelF;
    _payWayLabel.frame = cellFrame.payWayLabelF;
    _line.frame = cellFrame.lineF;
    _nameLabel.frame = cellFrame.nameLabelF;
    _addressLabel.frame = cellFrame.addressLabelF;
    _stateLabel.frame = cellFrame.stateLabelF;
    _phoneLabel.frame = cellFrame.phoneLabelF;
    
   NSArray *arr = [cellFrame.model.m_address componentsSeparatedByString:@" "];
    
    _titleLabel.text = cellFrame.model.m_bname;
    _nameLabel.text = arr[0];
    _phoneLabel.text = arr[1];
    _addressLabel.text = arr[2];
    
    
}

- (void)setState:(NSString *)state {
    _state = state;
    NSDictionary *dic = [NSDictionary dictionary];
    dic = @{
            @"0":@"待支付",
            @"1":@"待发货",
            @"2":@"待收货",
            @"3":@"待评价",
            @"4":@"已完成",
            @"5":@"未付款已取消",
            @"6":@"退款",
            };
    
    _stateLabel.text = dic[state];
    
}


@end


@implementation Ocean_OrderDetailFrame

- (void)setModel:(Ocean_OrderDetailHead *)model {
    _model = model;
    
    _bgViewF = CGRectMake(0, 0, screen_Width, 100);
    _titleLabelF = CGRectMake(10, 10, screen_Width/2.f, 20);
    _payWayLabelF = CGRectMake(screen_Width/2.f, 10, screen_Width/2.f-10, 20);
    _lineF = CGRectMake(0, CGRectGetMaxY(_payWayLabelF)+10, screen_Width, 1);
    _nameLabelF = CGRectMake(10, CGRectGetMaxY(_lineF)+10, screen_Width/2.f - 10, 20);
    _phoneLabelF = CGRectMake(screen_Width/2.f, CGRectGetMaxY(_lineF)+10, screen_Width/2.f - 10, 20);
    
    CGSize stateS = [StringSizeModel sizeWithText:@"未付款已取消" font:[UIFont systemFontOfSize:15]];
    
    NSArray *arr = [model.m_address componentsSeparatedByString:@" "];
    _addressLabelF = CGRectMake(10, CGRectGetMaxY(_nameLabelF), screen_Width - 30 - stateS.width, [StringSizeModel sizeWithText:arr[2] font:[UIFont systemFontOfSize:15]  maxW:screen_Width - 30 - stateS.width].height);
    
    _stateLabelF = CGRectMake(CGRectGetMaxX(_addressLabelF)+10, CGRectGetMaxY(_nameLabelF), stateS.width, [StringSizeModel sizeWithText:arr[2] font:[UIFont systemFontOfSize:15]  maxW:screen_Width - 30 - stateS.width].height);
    
    _bgViewF = CGRectMake(0, 0, screen_Width, CGRectGetMaxY(_addressLabelF)+10);
    
    _cellHeight = CGRectGetMaxY(_addressLabelF)+10;
    
    
}

@end







@interface Ocean_OrderDetailBodyCell ()

@property (nonatomic,strong) UIView * bgView;
@property (nonatomic,strong) UIImageView * picImageView;
@property (nonatomic,strong) UILabel * titleLabel;
@property (nonatomic,strong) UILabel * infoLabel;
@property (nonatomic,strong) UILabel * priceLabel;
@property (nonatomic,strong) UILabel * numLabel;
@property (nonatomic,strong) UIButton *quitButton;
@property (nonatomic,strong) UIView *line;

@end
@implementation Ocean_OrderDetailBodyCell

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *cellsign = @"Ocean_OrderDetailBodyCell";
    Ocean_OrderDetailBodyCell *cell  = [tableView dequeueReusableCellWithIdentifier:cellsign];
    if (cell ==nil) {
        cell  = [[Ocean_OrderDetailBodyCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellsign];
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
    self.bgView.backgroundColor = [UIColor lightlightGrayColor];
    [self.contentView addSubview:self.bgView];
    
    self.picImageView = [[UIImageView alloc] init];
    [self.bgView addSubview:self.picImageView];
    
    self.titleLabel = [[UILabel alloc] init];
    self.titleLabel.text = @"这是一个商品";
    self.titleLabel.numberOfLines = 0;
    self.titleLabel.font = [UIFont systemFontOfSize:15];
    [self.bgView addSubview:self.titleLabel];
    
    self.infoLabel = [[UILabel alloc] init];
    self.infoLabel.numberOfLines = 0;
    self.infoLabel.text = @"规格:185M";
    self.infoLabel.font = [UIFont systemFontOfSize:15];
    [self.bgView addSubview:self.infoLabel];
    
    self.priceLabel = [[UILabel alloc] init];
    self.priceLabel.text = @"￥79.0";
    self.priceLabel.textColor = [UIColor redColor];
    self.priceLabel.font = [UIFont systemFontOfSize:15];
    [self.bgView addSubview:self.priceLabel];
    
    self.numLabel = [[UILabel alloc] init];
    self.numLabel.text = @"X1";
    self.numLabel.textAlignment = NSTextAlignmentRight;
    self.numLabel.font = [UIFont systemFontOfSize:15];
    [self.bgView addSubview:self.numLabel];
    
    self.quitButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.quitButton.backgroundColor = [UIColor colorWithWhite:0.816 alpha:1.000];
    [self.quitButton setTitle:@"退款" forState:UIControlStateNormal];
    [self.quitButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    self.quitButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [self.bgView addSubview:self.quitButton];
    
    [self.quitButton addTarget:self action:@selector(quitClick) forControlEvents:UIControlEventTouchUpInside];
    
    self.line = [[UIView alloc] init];
    self.line.backgroundColor = [UIColor whiteColor];
    [self.bgView addSubview:self.line];
}

- (void)quitClick {
    
    
    if ([@"2" isEqualToString:_cellFrame.model.m_state]||[@"3" isEqualToString:_cellFrame.model.m_state]) {
        if ([@"0" isEqualToString:_cellFrame.model.m_returngoodsflag]) {
            if ([self.delegate respondsToSelector:@selector(didQuitClick:)]) {
                [self.delegate didQuitClick:self];
            }
        }
    }
    
    
    
}

- (void)setCellFrame:(Ocean_OrderDetailBodyFrame *)cellFrame {
    
    _cellFrame = cellFrame;
    
    _bgView.frame = cellFrame.bgViewF;
    _picImageView.frame = cellFrame.picImageViewF;
    _titleLabel.frame = cellFrame.titleLabelF;
    _infoLabel.frame = cellFrame.infoLabelF;
    _priceLabel.frame = cellFrame.priceLabelF;
    _numLabel.frame = cellFrame.numLabelF;
    _quitButton.frame = cellFrame.quitButtonF;
    _quitButton.layer.cornerRadius = 5;
    _line.frame = cellFrame.lineF;
    
    _titleLabel.text = cellFrame.model.m_title;
    
    
    
    if ([@"1" isEqualToString:cellFrame.model.m_returngoodsflag]) {
        
        if ([@"0" isEqualToString:cellFrame.model.m_checkorder]) {
            [_quitButton setTitle:@"审核中" forState:UIControlStateNormal];
        }else if ([@"1" isEqualToString:cellFrame.model.m_checkorder]) {
            [_quitButton setTitle:@"退款成功" forState:UIControlStateNormal];
        }else {
            [_quitButton setTitle:@"退款失败" forState:UIControlStateNormal];
        }
        
        
    }else {
        [_quitButton setTitle:@"退款" forState:UIControlStateNormal];
    }
    
    _infoLabel.text = [NSString stringWithFormat:@"规格:%@",cellFrame.model.m_guigename];
    _priceLabel.text = [NSString stringWithFormat:@"￥%@",cellFrame.model.m_price];
    [self.picImageView sd_setImageWithURL:[NSURL URLWithString:cellFrame.model.m_pic]];
    _numLabel.text = [NSString stringWithFormat:@"X%@",cellFrame.model.m_num];
    
    
}

@end

@implementation Ocean_OrderDetailBodyFrame

- (void)setModel:(Ocean_OrderDetailModel *)model {
    _model = model;
    
    CGFloat bgW = screen_Width;
    CGFloat bgH = 100;
    
    _bgViewF = CGRectMake(0, 0, bgW, bgH);
    
    _picImageViewF = CGRectMake(10, 10, 80, 80);
    
    CGFloat titleX = CGRectGetMaxX(_picImageViewF)+10;
    _titleLabelF = CGRectMake(titleX, 10, bgW - 10 - titleX, [StringSizeModel sizeWithText:model.m_title font:[UIFont systemFontOfSize:15] maxW:bgW - 10 - titleX].height);
    
    _infoLabelF = CGRectMake(titleX, CGRectGetMaxY(_titleLabelF)+10, screen_Width - 10 - titleX, [StringSizeModel sizeWithText:[NSString stringWithFormat:@"规格:%@",model.m_guigename] font:[UIFont systemFontOfSize:15] maxW:screen_Width - 10 - titleX].height);
    
    _priceLabelF = CGRectMake(titleX, CGRectGetMaxY(_infoLabelF)+10, screen_Width - 60 - titleX, 20);
    
    _numLabelF = CGRectMake(CGRectGetMaxX(_priceLabelF), CGRectGetMaxY(_infoLabelF)+10, 50, 20);
    
    if ([@"2" isEqualToString:model.m_state]||[@"3" isEqualToString:model.m_state]) {
        
        NSString *str = @"";
        
        if ([@"1" isEqualToString:model.m_returngoodsflag]) {
            
            if ([@"0" isEqualToString:model.m_checkorder]) {
                str = @"审核中";
            }else if ([@"1" isEqualToString:model.m_checkorder]) {
                str = @"退款成功";
            }else {
                str = @"退款失败";
            }
            
            
        }else {
            str = @"退款";
        }
        
        CGSize qiuS = [StringSizeModel sizeWithText:str font:[UIFont systemFontOfSize:14]];
        
        _quitButtonF = CGRectMake(screen_Width - 20 - qiuS.width, CGRectGetMaxY(_numLabelF)+10, qiuS.width + 10, 30);
        _bgViewF = CGRectMake(0, 0, screen_Width, CGRectGetMaxY(_quitButtonF)+10);
        
    }else {
        _quitButtonF = CGRectMake(screen_Width - 10 - 50.f/320.f*screen_Width, CGRectGetMaxY(_numLabelF)+10, 0, 0);
        _bgViewF = CGRectMake(0, 0, screen_Width, CGRectGetMaxY(_numLabelF)+10);
    }
    
    
    _lineF = CGRectMake(0, CGRectGetMaxY(_bgViewF)-1, screen_Width, 1);
    
    _cellHeight = CGRectGetMaxY(_bgViewF);
    
}

@end






@interface Ocean_OrderDetailFootCell ()

@property (nonatomic,strong) UIView * bgView;
@property (nonatomic,strong) UILabel *totalLabel;
@property (nonatomic,strong) UILabel *ordernoLabel;
@property (nonatomic,strong) UILabel *timeLabel;
@property (nonatomic,strong) UILabel *wayLabel;
@property (nonatomic,strong) UILabel *numLabel;
@property (nonatomic,strong) UIButton *wuliuBtn;

@end
@implementation Ocean_OrderDetailFootCell

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *cellsign = @"Ocean_OrderDetailFootCell";
    Ocean_OrderDetailFootCell *cell  = [tableView dequeueReusableCellWithIdentifier:cellsign];
    if (cell ==nil) {
        cell  = [[Ocean_OrderDetailFootCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellsign];
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
    
    self.totalLabel = [[UILabel alloc] init];
    self.totalLabel.text = @"共2件商品 合计:369.00元(含运费0.0元)";
    self.totalLabel.textAlignment = NSTextAlignmentRight;
    self.totalLabel.font = [UIFont systemFontOfSize:15];
    [self.bgView addSubview:self.totalLabel];
    
    self.ordernoLabel = [[UILabel alloc] init];
    self.ordernoLabel.text = @"订单编号：TWO20170713173421921";
    self.ordernoLabel.textColor = [UIColor colorWithRed:0.588 green:0.592 blue:0.600 alpha:1.000];
    self.ordernoLabel.font = [UIFont systemFontOfSize:15];
    [self.bgView addSubview:self.ordernoLabel];
    
    self.timeLabel = [[UILabel alloc] init];
    self.timeLabel.text = @"下单时间：2017-07-13 17:34:21";
    self.timeLabel.textColor = [UIColor colorWithRed:0.588 green:0.592 blue:0.600 alpha:1.000];
    self.timeLabel.font = [UIFont systemFontOfSize:15];
    [self.bgView addSubview:self.timeLabel];
    
    self.wayLabel = [[UILabel alloc] init];
    self.wayLabel.text = @"配送方式:商家配送 预计送达时间:20:00:00";
    self.wayLabel.textColor = [UIColor colorWithRed:0.588 green:0.592 blue:0.600 alpha:1.000];
    self.wayLabel.font = [UIFont systemFontOfSize:15];
    [self.bgView addSubview:self.wayLabel];
    
    self.numLabel = [[UILabel alloc] init];
    self.numLabel.text = @"运单号:449023708483";
    self.numLabel.textColor = [UIColor colorWithRed:0.588 green:0.592 blue:0.600 alpha:1.000];
    self.numLabel.font = [UIFont systemFontOfSize:15];
    [self.bgView addSubview:self.numLabel];
    
    self.wuliuBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.wuliuBtn setTitle:@"查看物流" forState:UIControlStateNormal];
    [self.wuliuBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    self.wuliuBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [self.wuliuBtn addTarget:self action:@selector(lookClick) forControlEvents:UIControlEventTouchUpInside];
    [self.bgView addSubview:self.wuliuBtn];
    
}

- (void)lookClick {
    
    if ([self.delegate respondsToSelector:@selector(lookWuliu:)]) {
        [self.delegate lookWuliu:self];
    }
    
}

- (void)setModel:(Ocean_OrderDetailHead *)model {
    _model = model;
    
    if ([@"2" isEqualToString:model.m_isfee]) {
        
        //快递
        _wayLabel.text = [NSString stringWithFormat:@"配送方式: %@",model.m_expressname];
        _numLabel.text = [NSString stringWithFormat:@"运单号: %@",model.m_expressnumber];
        _wuliuBtn.hidden = NO;
        
    }else {
        //配送
        _wayLabel.text = @"配送方式: 商家配送";
        _numLabel.text = [NSString stringWithFormat:@"预计送达时间: %@",model.m_expressnumber];
        _wuliuBtn.hidden = YES;
    }
    
}

- (void)setTime:(NSString *)time {
    _time = time;
    
    _timeLabel.text = [NSString stringWithFormat:@"下单时间: %@",[NSString stringWithDateFormater:@"yyyy-MM-dd HH:mm:ss" andTimeString:time]];
}

- (void)setTotal:(NSString *)total {
    _total = total;
    
    _totalLabel.text = total;
}

- (void)setOrderno:(NSString *)orderno {
    _orderno = orderno;
    
    _ordernoLabel.text = [NSString stringWithFormat:@"订单编号: %@",orderno];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.bgView.frame = CGRectMake(0, 0, screen_Width, 160);
    self.totalLabel.frame = CGRectMake(10, 10, screen_Width - 20, 20);
    self.ordernoLabel.frame = CGRectMake(10, self.totalLabel.bottom + 15, screen_Width - 20, 20);
    self.timeLabel.frame = CGRectMake(10, self.ordernoLabel.bottom + 5, screen_Width - 20, 20);
    self.wayLabel.frame = CGRectMake(10, self.timeLabel.bottom + 5, screen_Width - 20, 20);
    self.numLabel.frame = CGRectMake(10, self.wayLabel.bottom + 5, 220.f/320.f*screen_Width - 20, 20);
    self.wuliuBtn.frame = CGRectMake(screen_Width - 100.f/320.f*screen_Width - 10, self.wayLabel.bottom + 5, 100.f/320.f*screen_Width, 20);
    
}

@end





