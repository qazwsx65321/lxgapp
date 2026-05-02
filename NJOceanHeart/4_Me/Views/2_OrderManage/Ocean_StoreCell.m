//
//  Ocean_StoreCell.m
//  NJOceanHeart
//
//  Created by qiushi on 2017/7/31.
//  Copyright © 2017年 Xuanr. All rights reserved.
//

#import "Ocean_StoreCell.h"

#import "Ocean_StoreModel.h"

@implementation Ocean_StoreCell

@end

//头部
@interface Ocean_StoreHeadCell ()

@property (nonatomic,strong) UIView * bgView;
@property (nonatomic,strong) UIImageView * picImageView;
@property (nonatomic,strong) UILabel * titleLabel;
@property (nonatomic,strong) UILabel * stateLabel;

@end

@implementation Ocean_StoreHeadCell



+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *cellsign = @"Ocean_StoreHeadCell";
    Ocean_StoreHeadCell *cell  = [tableView dequeueReusableCellWithIdentifier:cellsign];
    if (cell ==nil) {
        cell  = [[Ocean_StoreHeadCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellsign];
        
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor whiteColor];
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        self.bgView = [[UIView alloc] init];
        self.bgView.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:self.bgView];
        
        self.picImageView = [[UIImageView alloc] init];
        self.picImageView.image = [UIImage imageNamed:@"shop"];
        [self.bgView addSubview:self.picImageView];
        
        self.titleLabel = [[UILabel alloc] init];
        self.titleLabel.text = @"衣服专卖店>";
        self.titleLabel.textColor = [UIColor lightGrayColor];
        self.titleLabel.font = [UIFont systemFontOfSize:15];
        [self.bgView addSubview:self.titleLabel];
        
        self.stateLabel = [[UILabel alloc] init];
        self.stateLabel.text = @"等待买家付款";
        self.stateLabel.textAlignment = NSTextAlignmentRight;
        self.stateLabel.textColor = [UIColor redColor];
        self.stateLabel.font = [UIFont systemFontOfSize:15];
        [self.bgView addSubview:self.stateLabel];
        
    }
    return self;
}

- (void)setIsHideState:(BOOL)isHideState {
    _isHideState = isHideState;
    
    _stateLabel.hidden = isHideState ? YES : NO;
}

-(void)setOrderModel:(Ocean_StoreOrderModel *)orderModel{
    _orderModel = orderModel;
    static NSDictionary *dic;
    dic = @{
            @"0":@"待支付",
            @"1":@"待发货",
            @"2":@"待收货",
            @"3":@"待评价",
            @"4":@"已完成",
            @"5":@"未付款已取消",
            @"6":@"退款",
            };
    [self.picImageView sd_setImageWithURL:[NSURL URLWithString:orderModel.m_logo] placeholderImage:[UIImage imageNamed:@"shop"]];
    self.titleLabel.text = [NSString stringWithFormat:@"%@ >",orderModel.m_bname];
    self.stateLabel.text = dic[orderModel.m_state];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.bgView.x = 0;
    self.bgView.y = 0;
    self.bgView.width = screen_Width;
    self.bgView.height = 40;
    
    self.picImageView.x = 10;
    self.picImageView.y = 10;
    self.picImageView.width = 20;
    self.picImageView.height = 20;
    
    self.titleLabel.x = self.picImageView.right + 10;
    self.titleLabel.y = 5;
    self.titleLabel.width = [StringSizeModel sizeWithText:self.titleLabel.text font:[UIFont systemFontOfSize:15]].width;
    self.titleLabel.height = 30;
    
    self.stateLabel.x = self.titleLabel.right;
    self.stateLabel.y = 5;
    self.stateLabel.width = screen_Width - 10 - self.stateLabel.x;
    self.stateLabel.height = 30;
    
}

@end


//商品列表
@interface Ocean_StoreBodyCell()

@property (nonatomic,strong) UIView * bgView;
@property (nonatomic,strong) UIImageView * picImageView;
@property (nonatomic,strong) UILabel * titleLabel;
@property (nonatomic,strong) UILabel * infoLabel;
@property (nonatomic,strong) UILabel * priceLabel;
@property (nonatomic,strong) UILabel * numLabel;
@property (nonatomic,strong) UIView *line;

@end
@implementation Ocean_StoreBodyCell

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *cellsign = @"Ocean_StoreBodyCell";
    Ocean_StoreBodyCell *cell  = [tableView dequeueReusableCellWithIdentifier:cellsign];
    if (cell ==nil) {
        cell  = [[Ocean_StoreBodyCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellsign];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor whiteColor];
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
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
        
        self.line = [[UIView alloc] init];
        self.line.backgroundColor = [UIColor whiteColor];
        [self.bgView addSubview:self.line];
        
    }
    return self;
}

- (void)setCellFrame:(Ocean_StoreBodyFrame *)cellFrame {
    _cellFrame = cellFrame;
    
    _bgView.frame = cellFrame.bgViewF;
    _picImageView.frame = cellFrame.picImageViewF;
    _titleLabel.frame = cellFrame.titleLabelF;
    _infoLabel.frame = cellFrame.infoLabelF;
    _priceLabel.frame = cellFrame.priceLabelF;
    _numLabel.frame = cellFrame.numLabelF;
//    
    _titleLabel.text = cellFrame.model.m_title;
    
    _infoLabel.text = [NSString stringWithFormat:@"规格:%@",cellFrame.model.m_guigename];
    _priceLabel.text = [NSString stringWithFormat:@"￥%@",cellFrame.model.m_price];
    [self.picImageView sd_setImageWithURL:[NSURL URLWithString:cellFrame.model.m_pic]];
    _numLabel.text = [NSString stringWithFormat:@"X%@",cellFrame.model.m_num];
    _line.frame = cellFrame.lineF;
    
}


@end
//商品列表--计算cell高度
@implementation Ocean_StoreBodyFrame

- (void)setModel:(Ocean_StoreCommodityModel *)model {
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
    
    _bgViewF = CGRectMake(0, 0, screen_Width, CGRectGetMaxY(_numLabelF)+10);
    
    _lineF = CGRectMake(0, CGRectGetMaxY(_bgViewF)-1, screen_Width, 1);
    
    _cellHeight = CGRectGetMaxY(_bgViewF);
    
}

@end


//尾部
@interface Ocean_StoreFootCell ()

@property (nonatomic,strong) UIView * bgView;
@property (nonatomic,strong) UILabel * totalLabel;
@property (nonatomic,strong) UIButton * cancelButton;
@property (nonatomic,strong) UIButton * rightButton;

@end
@implementation Ocean_StoreFootCell

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *cellsign = @"Ocean_StoreFootCell";
    Ocean_StoreFootCell *cell  = [tableView dequeueReusableCellWithIdentifier:cellsign];
    if (cell ==nil) {
        cell  = [[Ocean_StoreFootCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellsign];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor whiteColor];
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        self.bgView = [[UIView alloc] init];
        self.bgView.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:self.bgView];
        
        self.totalLabel = [[UILabel alloc] init];
        self.totalLabel.text = @"共2件商品 合计:369.00元(含运费0.0元)";
        self.totalLabel.textAlignment = NSTextAlignmentRight;
        self.totalLabel.font = [UIFont systemFontOfSize:15];
        [self.bgView addSubview:self.totalLabel];
        
        self.cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
        self.cancelButton.backgroundColor = [UIColor redColor];
        [self.cancelButton setTitle:@"取消" forState:UIControlStateNormal];
        [self.cancelButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        self.cancelButton.titleLabel.font = [UIFont systemFontOfSize:13];
        [self.bgView addSubview:self.cancelButton];
        
        self.rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
        self.rightButton.backgroundColor = [UIColor redColor];
        [self.rightButton setTitle:@"付款" forState:UIControlStateNormal];
        [self.rightButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        self.rightButton.titleLabel.font = [UIFont systemFontOfSize:13];
        [self.bgView addSubview:self.rightButton];
        
        
        
        [self.cancelButton addTarget:self action:@selector(cancelClick) forControlEvents:UIControlEventTouchUpInside];
        [self.rightButton addTarget:self action:@selector(funClick) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return self;
}

- (void)cancelClick {
    
    
    
    if ([self.delegate respondsToSelector:@selector(didCancelClickCell:)]) {
        [self.delegate didCancelClickCell:self];
    }
}


- (void)funClick {
    
    if ([@"0" isEqualToString:_cellFrame.model.m_state]) {
        
        //付款
        if ([self.delegate respondsToSelector:@selector(didPayMoneyClickCell:)]) {
            [self.delegate didPayMoneyClickCell:self];
        }
        
    }else if ([@"1" isEqualToString:_cellFrame.model.m_state]) {
        
        //退款
        if ([self.delegate respondsToSelector:@selector(didQuitGetGoodsClickCell:)]) {
            [self.delegate didQuitGetGoodsClickCell:self];
        }
        
    }else if ([@"2" isEqualToString:_cellFrame.model.m_state]) {
        
        //确认收货
        if ([self.delegate respondsToSelector:@selector(didSureGetGoodsClickCell:)]) {
            [self.delegate didSureGetGoodsClickCell:self];
        }
        
        
    }else if ([@"3" isEqualToString:_cellFrame.model.m_state]) {
        
        //评价
        if ([self.delegate respondsToSelector:@selector(didEvaluateClickCell:)]) {
            [self.delegate didEvaluateClickCell:self];
        }
        
        
    }else {
        //暂无
    }
    
    
}

- (void)setGoodsNum:(NSString *)goodsNum {
    _goodsNum = goodsNum;
    
    Ocean_StoreOrderModel *model = _cellFrame.model;
    
    NSString *totalprice = model.m_fee;
    self.totalLabel.text = [NSString stringWithFormat:@"共%@件商品 合计:%@元(含运费0.0元)",goodsNum,totalprice];
    
}

- (void)setCellFrame:(Ocean_StoreFootFrame *)cellFrame {
    _cellFrame = cellFrame;
    
    _bgView.frame = cellFrame.bgViewF;
    _totalLabel.frame = cellFrame.totalLabelF;
    _cancelButton.frame = cellFrame.cancelButtonF;
    _cancelButton.layer.cornerRadius = 5;
    _rightButton.frame = cellFrame.rightButtonF;
    _rightButton.layer.cornerRadius = 5;
    
    //0:待支付 1 待发货 2 待收货 3 待评价 4 已完成订单 5 未付款已取消 6 代发货时取消订单要审核
    if ([@"0" isEqualToString:cellFrame.model.m_state]) {
        _cancelButton.hidden = NO;
        _rightButton.hidden = NO;
        [_cancelButton setTitle:@"取消" forState:UIControlStateNormal];
        [_rightButton setTitle:@"付款" forState:UIControlStateNormal];
    }else if ([@"1" isEqualToString:cellFrame.model.m_state]) {
        _cancelButton.hidden = YES;
        _rightButton.hidden = NO;
        [_rightButton setTitle:@"退款" forState:UIControlStateNormal];
    }else if ([@"2" isEqualToString:cellFrame.model.m_state]) {
        
        if ([@"1" isEqualToString:cellFrame.model.m_isfee]) {
            _cancelButton.hidden = YES;
        }else {
            _cancelButton.hidden = NO;
            [_cancelButton setTitle:@"查看物流" forState:UIControlStateNormal];
        }
        
        _rightButton.hidden = NO;
        [_rightButton setTitle:@"确认收货" forState:UIControlStateNormal];
    }else if ([@"3" isEqualToString:cellFrame.model.m_state]) {
        if ([@"1" isEqualToString:cellFrame.model.m_isfee]) {
            _cancelButton.hidden = YES;
        }else {
            _cancelButton.hidden = NO;
            [_cancelButton setTitle:@"查看物流" forState:UIControlStateNormal];
        }
        _rightButton.hidden = NO;
        [_rightButton setTitle:@"评价" forState:UIControlStateNormal];
    }else {
        _cancelButton.hidden = YES;
        _rightButton.hidden = YES;
    }
    
    Ocean_StoreOrderModel *model = cellFrame.model;
    NSString *num = [NSString stringWithFormat:@"%ld",model.GOODINFO.count];
    NSString *totalprice = model.m_fee;
//    NSString *yunprice 
    
    self.totalLabel.text = [NSString stringWithFormat:@"共%@件商品 合计:%@元(含运费0.0元)",num,totalprice];
}

@end


@implementation Ocean_StoreFootFrame

- (void)setModel:(Ocean_StoreOrderModel *)model {
    _model = model;
    NSMutableArray *mutalArr = [NSMutableArray array];
    for (Ocean_StoreCommodityModel *commodity in model.GOODINFO) {
        Ocean_StoreBodyFrame *bodyFram = [Ocean_StoreBodyFrame new];
        bodyFram.model = commodity;
        [mutalArr addObject:bodyFram];
    }
    _bodyFramArr = mutalArr;
    
    CGFloat BH = 0;
    
    _bgViewF = CGRectMake(0, 0, screen_Width, 40);
    
    _totalLabelF = CGRectMake(10, 10, screen_Width - 20, 20);
    
    //0:待支付 1 待发货 2 待收货 3 待评价 4 已完成订单 5 未付款已取消 6 代发货时取消订单要审核
    if ([@"0" isEqualToString:model.m_state]) {
        _cancelButtonF = CGRectMake(screen_Width - 180.f/320.f*screen_Width, CGRectGetMaxY(_totalLabelF)+10, 80.f/320.f*screen_Width, 30);
        _rightButtonF = CGRectMake(CGRectGetMaxX(_cancelButtonF)+10.f/320.f*screen_Width, CGRectGetMaxY(_totalLabelF)+10, 80.f/320.f*screen_Width, 30);
        BH = CGRectGetMaxY(_cancelButtonF)+10;
        
    }else if ([@"1" isEqualToString:model.m_state]) {
        _cancelButtonF = CGRectMake(screen_Width - 180.f/320.f*screen_Width, CGRectGetMaxY(_totalLabelF)+10, 0, 0);
        _rightButtonF = CGRectMake(screen_Width - 90.f/320.f*screen_Width, CGRectGetMaxY(_totalLabelF)+10, 80.f/320.f*screen_Width, 30);
        BH = CGRectGetMaxY(_rightButtonF)+10;
    }else if ([@"2" isEqualToString:model.m_state]) {
        
        if ([@"1" isEqualToString:model.m_isfee]) {
            _cancelButtonF = CGRectMake(0, CGRectGetMaxY(_totalLabelF)+10.f/320.f*screen_Width, 0, 0);
        }else {
            _cancelButtonF = CGRectMake(screen_Width - 180.f/320.f*screen_Width, CGRectGetMaxY(_totalLabelF)+10, 80.f/320.f*screen_Width, 30);
        }
        
        
        _rightButtonF = CGRectMake(screen_Width - 90.f/320.f*screen_Width, CGRectGetMaxY(_totalLabelF)+10.f/320.f*screen_Width, 80.f/320.f*screen_Width, 30);
        BH = CGRectGetMaxY(_rightButtonF)+10;
    }else if ([@"3" isEqualToString:model.m_state]) {
        
        if ([@"1" isEqualToString:model.m_isfee]) {
            _cancelButtonF = CGRectMake(0, CGRectGetMaxY(_totalLabelF)+10.f/320.f*screen_Width, 0, 0);
        }else {
            _cancelButtonF = CGRectMake(screen_Width - 180.f/320.f*screen_Width, CGRectGetMaxY(_totalLabelF)+10, 80.f/320.f*screen_Width, 30);
        }
        _rightButtonF = CGRectMake(screen_Width - 90.f/320.f*screen_Width, CGRectGetMaxY(_totalLabelF)+10.f/320.f*screen_Width, 80.f/320.f*screen_Width, 30);
        BH = CGRectGetMaxY(_rightButtonF)+10;
    }else {
        _cancelButtonF = CGRectMake(0, CGRectGetMaxY(_totalLabelF)+10.f/320.f*screen_Width, 0, 0);
        _rightButtonF = CGRectMake(screen_Width - 90.f/320.f*screen_Width, CGRectGetMaxY(_totalLabelF)+10.f/320.f*screen_Width, 0, 0);
        BH = CGRectGetMaxY(_totalLabelF)+10;
    }
    
    _bgViewF = CGRectMake(0, 0, screen_Width, BH);
    _cellHeight = BH;
    
}

@end
