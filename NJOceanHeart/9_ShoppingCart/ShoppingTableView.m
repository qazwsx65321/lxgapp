#import "ShoppingTableView.h"
#import "Header.h"
#import "Util.h"
#import "ShoppingBtn.h"
#import "ShoppingTableViewCell.h"
#import "Ocean_ ShowCartModel.h"
#import "Ocean_MainforceCommodityController.h"
#import "Ocean_MainStoreController.h"
#import "YiRenShareTools.h"
@interface ShoppingTableView ()<ShoppingTableViewCellDelegate>
{
    
}
@end

@implementation ShoppingTableView
{
    
}
-(id) initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    
    self  = [super initWithFrame:frame style:style];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(CalculationPrice) name:@"jisuan" object:nil];
        self.backgroundColor =UIColorRGBA(238, 238, 238, 1);
        self.delegate = self;
        self.dataSource = self;
        self.separatorColor = UIColorRGBA(221, 221, 221, 1);
        self.tableFooterView = [[UIView alloc]init];
        self.showsVerticalScrollIndicator = NO;
        if ([self respondsToSelector:@selector(setSeparatorInset:)])
        {
            [self setSeparatorInset:UIEdgeInsetsZero];
        }
        if ([self respondsToSelector:@selector(setLayoutMargins:)])
        {
            [self setLayoutMargins:UIEdgeInsetsZero];
        }
      
    }
    return self;
}


-(void)setShoppingArray:(NSMutableArray *)shoppingArray{
    
    if (_shoppingArray != shoppingArray) {
        
        _shoppingArray = shoppingArray;
    
        [self reloadData];
        
    }
}


#pragma mark 分割线去掉左边15个像素
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)])
    {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setLayoutMargins:)])
    {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}



- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40;
}

#pragma mark头部视图
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{

    Ocean__ShowCartGoodsHead *headModel = _shoppingArray[section];
    
        UIView *view=[[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40)];
        view.backgroundColor = [UIColor whiteColor];
        
        [Util setFoursides:view Direction:@"top" sizeW:SCREEN_WIDTH];
        
        ShoppingBtn *collocationBtn = [[ShoppingBtn alloc] initWithFrame:CGRectMake(0, 0, 55, 40)];
        collocationBtn.tag = section;
        [collocationBtn addTarget:self action:@selector(CollocationBtn:) forControlEvents:UIControlEventTouchDown];
        [view addSubview:collocationBtn];
        
        UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake(55, 10, 22, 19)];

        img.centerY = collocationBtn.centerY;
        [img sd_setImageWithURL:[NSURL URLWithString:headModel.m_logo] placeholderImage:[UIImage imageNamed:@"shop"]];
        [view addSubview:img];
        [Util makeCorner:3 view:img];
        
        UILabel *subLabel = [[UILabel alloc] initWithFrame:CGRectMake([Util ReturnViewFrame:img Direction:@"X"] + 10, 10, SCREEN_WIDTH - ([Util ReturnViewFrame:img Direction:@"X"] + 10) , 20)];
        subLabel.centerY = collocationBtn.centerY;
        subLabel.y +=2;
        subLabel.textColor = [UIColor grayColor];
        subLabel.textAlignment = NSTextAlignmentLeft;
        subLabel.font = [UIFont systemFontOfSize:13.0];
        [view addSubview:subLabel];
    
    
            
        subLabel.text = headModel.m_bname;
        [subLabel sizeToFit];
        UILabel * p_zytypeLb = [self creatLb:[UIFont systemFontOfSize:13] :[UIColor lightGrayColor] :   NSTextAlignmentCenter];
        [view addSubview:p_zytypeLb];
        p_zytypeLb.size = CGSizeMake(35, 16);
        p_zytypeLb.centerY =  subLabel.centerY;
        p_zytypeLb.x = subLabel.right +5;
        p_zytypeLb.layer.cornerRadius = 2;
        p_zytypeLb.text = @"自营";
    
        p_zytypeLb.textColor = BackgroundColors(1);
        p_zytypeLb.layer.masksToBounds = YES;
        p_zytypeLb.layer.borderColor = BackgroundColors(1).CGColor;
        p_zytypeLb.layer.borderWidth = 1;
    
        UIImageView *acceImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"more01"]];
        [view addSubview:acceImage];
        [acceImage sizeToFit];
        acceImage.centerY =  subLabel.centerY;
        //用来判断 section Header 是否被选中
        if (headModel.headClickState == 1) {
            
            [collocationBtn setImage:[UIImage imageNamed:@"iconfont-zhengque"] forState:UIControlStateNormal];
  
        }else{
            
            [collocationBtn setImage:[UIImage imageNamed:@"iconfont-yuanquan"] forState:UIControlStateNormal];

        }
    
 
    if ([@"1" isEqualToString:headModel.m_zytype]) {
        p_zytypeLb.hidden = NO;
        acceImage.x = p_zytypeLb.right+15;
    }else{
        p_zytypeLb.hidden = YES;
        acceImage.x = subLabel.right+15;
    }
    
    UIControl *control = [[UIControl alloc]init];
    control.tag = section;
    [control addTarget:self action:@selector(enterStore:) forControlEvents:UIControlEventTouchUpInside];
    control.height = view.height;
    control.x = img.x;
    control.width = acceImage.right - control.x;
    [view addSubview:control];
    
    
    
    
        return  view;
    
    
    
    
}
#pragma mark-进入商品详情/进入商铺

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    Ocean__ShowCartGoodsHead *shoppingmodel = _shoppingArray[indexPath.section];
    Ocean__ShowCartGoodsModel *cellmodel = shoppingmodel.m_goodslist[indexPath.row];
    Ocean_MainforceCommodityController *mainVC = [[Ocean_MainforceCommodityController alloc]init];
    mainVC.m_gid = cellmodel.m_gid;
    [self.m_controller.navigationController pushViewController:mainVC animated:YES];
    
}

-(void)enterStore:(UIButton *)sender{

    Ocean_MainStoreController  *storeVC= [[Ocean_MainStoreController alloc]init];
    Ocean__ShowCartGoodsHead *shoppingmodel = _shoppingArray[sender.tag];
    shopInfoModel *model = [shopInfoModel new];
    model.m_name = shoppingmodel.m_bname;
    model.m_gbid = shoppingmodel.m_bid;
    storeVC.m_shopInfo = model;
    [self.m_controller.navigationController pushViewController:storeVC animated:YES];
}


-(UILabel *)creatLb:(UIFont *)font :(UIColor *)textColor :(NSTextAlignment)textAlignment{
    UILabel *lable = [[UILabel alloc]init];
    lable.font = font;
    lable.textColor = textColor;
    lable.textAlignment = textAlignment;
    //    lable.numberOfLines = 0;
    return lable;
}



#pragma mark 底部间距
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    
    return 25;
    
}

#pragma mark底部视图
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    
    Ocean__ShowCartGoodsModel *forModel = _shoppingArray[section];
    if (forModel.headState == 1) {
        
        UIView *view=[[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40)];
        view.backgroundColor = [UIColor whiteColor];
        
        UILabel *priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(55, 0, SCREEN_WIDTH -55, 40)];
        priceLabel.textColor = BACKGROUNDCOLOR;
        priceLabel.text = @"小计:￥00.00";
        priceLabel.font = [UIFont systemFontOfSize:12.0];
        [view addSubview:priceLabel];
        
        UIView *bottomview = [[UIView alloc] initWithFrame:CGRectMake(0, 40, SCREEN_WIDTH, 10)];
        bottomview.backgroundColor = UIColorRGBA(238, 238, 238, 1);
        [view addSubview:bottomview];
        [Util setFoursides:bottomview Direction:@"top" sizeW:SCREEN_WIDTH];
        return  view;
        
    }else{
        
        UIView *bottomview = [[UIView alloc] initWithFrame:CGRectMake(0, 40, SCREEN_WIDTH, 10)];
        bottomview.backgroundColor = UIColorRGBA(238, 238, 238, 1);
        return bottomview;
    }
    
    
    return nil ;
}

#pragma mark  返回分区数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return _shoppingArray.count;
}

#pragma mark  每个分区多少行
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    Ocean__ShowCartGoodsHead *model = _shoppingArray[section];
    return model.m_goodslist.count;
}

#pragma mark 改变行的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    return 100;
    
}

#pragma mark 代理数据源
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    static NSString *identifer=@"detacell";
    ShoppingTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifer];
    if (cell == nil) {
        
        cell=[[ShoppingTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer];
        cell.delegate = self;
    }

    Ocean__ShowCartGoodsHead *shoppingmodel = _shoppingArray[indexPath.section];
    Ocean__ShowCartGoodsModel *cellmodel = shoppingmodel.m_goodslist[indexPath.row];
    cellmodel.section = indexPath.section;
    cellmodel.row = indexPath.row;
    cell.model = cellmodel;
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    return cell;
}

#pragma mark 单选
-(void)ShoppingTableViewCell:(Ocean__ShowCartGoodsModel *)model{
    
    Ocean__ShowCartGoodsHead *headmodel = _shoppingArray[model.section];
    
    int i = 0;
    for (Ocean__ShowCartGoodsModel *cellmodel in headmodel.m_goodslist) {
        
        if ( cellmodel.cellClickState == 1) {
            
            i++;
        }
    }
    
    if (i == headmodel.m_goodslist.count) {
       
        headmodel.headClickState = 1;
        
    }else{
    
         headmodel.headClickState = 0;
    }
    
    [self CalculationPrice];
    [self reloadData];
}

#pragma mark 分组全选
-(void)CollocationBtn:(UIButton *)sender{

    Ocean__ShowCartGoodsHead *model = _shoppingArray[sender.tag];
    [self RefreshAllCellState:model];
    
    [self CalculationPrice];
    [self reloadData];
}

#pragma mark 刷新cell状态
-(void)RefreshAllCellState:(Ocean__ShowCartGoodsHead *)model{

    if (model.headClickState == 1) {
        
        model.headClickState = 0;
        
        for (Ocean__ShowCartGoodsModel *cellmodel in model.m_goodslist) {
            
            cellmodel.cellClickState = 0;
        }
        
    }else{
        
        model.headClickState = 1;
        
        for (Ocean__ShowCartGoodsModel *cellmodel in model.m_goodslist) {
            
            cellmodel.cellClickState = 1;
        }
    }
}

#pragma mark 计算价格
-(void)CalculationPrice{

    //所有商品的总价
    CGFloat allPrict = 0.0;
    
    //结算处的个数
    NSInteger numInteger = 0;
    
    //用于判断是否全选
    NSMutableArray *allClickArray = [[NSMutableArray alloc] init];
    
    //纪录选中的cellModel;
    NSMutableArray *cellModelArray = [[NSMutableArray alloc] init];
    
    for (Ocean__ShowCartGoodsHead *model in _shoppingArray) {
        
        //用于判断是否全选，当该数组个数和_shoppingArray个数一样时，说明我选中了全部产品
        if (model.headClickState ==1) {
            
            [allClickArray addObject:[NSString stringWithFormat:@"%ld",(long)model.headClickState]];
        }
        
        //纪录每个分组下面的头部 和 尾部 数据的变化
        NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
        
        //纪录搭配下面选中的必选cell，用来和当前该条数据中必选单品做比较，是否讲必选单品都选中，如果都选中了，就会享受搭配折扣，反之不享受，按原价计算
        NSMutableArray *array = [[NSMutableArray alloc] init];
        
        //每条数据下面的总价
        CGFloat allprice = 0.0;
        
        for (Ocean__ShowCartGoodsModel *cellmodel in model.m_goodslist) {
            
            //计算每个cell的总价
            if (cellmodel.cellClickState == 1) {
                
                [cellModelArray addObject:cellmodel];
                numInteger = numInteger +1;
                allprice = allprice + [cellmodel.m_num integerValue] * [cellmodel.m_price floatValue] ;
            }
            
            //纪录选中的必选单品
//            if (cellmodel.cellClickState == 1 && cellmodel.mustInteger == 1){
//            
//                [array addObject:cellmodel.ID];
//            }
        }
        
        // “搭配购” 下面必选单品的id 和 当前选中的必选单品 做比较，如果该搭配下面的必选单品都选中后，则享受搭配折扣，同时我们的头部视图和页尾相应的改变状态
        if ([[self RutrnCellModel:model] isEqualToArray:array] && array.count >0) {
            
           // CGFloat oldprice = allprice;
//            CGFloat _newprice = allprice * [model.discount floatValue] * 0.1;
//            NSString *string = [NSString stringWithFormat:@"已享受%@折优惠，已减%.2f元",model.discount ,oldprice - _newprice];
//            [dict setObject:string forKey:@"headTitle"];
//            [dict setObject:[NSString stringWithFormat:@"小计 ¥%.2f",_newprice] forKey:@"footerTitle"];
//            [dict setObject:[NSString stringWithFormat:@"  立减 ¥%.2f",oldprice - _newprice] forKey:@"footerMinus"];
//            allprice = _newprice;
            
        }else{
        
            //说明单品没有被选中或者没有完全选中，提示
            NSString *string = [NSString stringWithFormat:@"选择必选单品,即可享受%@折优惠",@3];
            [dict setObject:string forKey:@"headTitle"];
            [dict setObject:[NSString stringWithFormat:@"小计 ¥%.2f",allprice] forKey:@"footerTitle"];
            [dict setObject:@"  立减 ¥0.00" forKey:@"footerMinus"];
            
        }
        
        allPrict = allPrict + allprice;
        
        //model.headPriceDict = dict;
    }
    
    
    NSDictionary *dict = @{
                           @"cellModel":cellModelArray,
                           @"allPrice":[NSString stringWithFormat:@"￥%.2f",allPrict],
                           @"num":[NSString stringWithFormat:@"%lu",(unsigned long)numInteger],
                           @"allState":allClickArray.count == _shoppingArray.count && _shoppingArray.count>0?@"YES":@"NO"
                           };
    NSNotification *notification =[NSNotification notificationWithName:@"AllPrice" object:nil userInfo:dict];
    [[NSNotificationCenter defaultCenter] postNotification:notification];

    
}

#pragma mark 返回 “搭配购” 下面必选单品的id，用于和当前选中的必选单品做比较
-(NSArray *)RutrnCellModel:(Ocean__ShowCartGoodsHead *)model{

    NSMutableArray *array = [[NSMutableArray alloc] init];
    return [array copy];
}

#pragma mark 全选
-(void)allBtn:(BOOL)isbool{

    //当isbool为yes时,是全选状态，为no反之
    if (isbool) {
        
        for (Ocean__ShowCartGoodsHead *model in _shoppingArray) {
            
            //选中状态时 model.headClickState = 0; 然后调用 [self RefreshAllCellState:model];改为1
            model.headClickState = 0;
            [self RefreshAllCellState:model];
        }
        
    }else{
    
        for (Ocean__ShowCartGoodsHead *model in _shoppingArray) {
            
            model.headClickState = 1;
            [self RefreshAllCellState:model];
        }
    }
    
    [self CalculationPrice];
    [self reloadData];
}

#pragma mark 编辑
-(void)editBtn:(BOOL)isbool{

    for (Ocean__ShowCartGoodsHead *model in _shoppingArray) {
        
        if (!isbool) {
            
            for (Ocean__ShowCartGoodsModel *cellmodel in model.m_goodslist) {
                
                cellmodel.cellEditState = 1;
            }
            
        }else{
        
            for (Ocean__ShowCartGoodsModel *cellmodel in model.m_goodslist) {
                
                cellmodel.cellEditState = 0;
            }
        }
    }
   
    [self reloadData];
}

#pragma mark 删除
-(void)deleteBtn:(BOOL)isbool{

    NSMutableArray *headDeleteArray = [[NSMutableArray alloc] init];
    for (Ocean__ShowCartGoodsHead *model in _shoppingArray) {
        
        if (model.headClickState == 1) {
            
            [headDeleteArray addObject:model];
            
        }else{
        
            NSMutableArray *cellDeleteArray = [[NSMutableArray alloc] init];
            for (Ocean__ShowCartGoodsModel *cellmodel in model.m_goodslist) {
                
                if (cellmodel.cellClickState == 1) {
                    
                    [cellDeleteArray addObject:cellmodel];
                }
            }
            
            NSMutableArray *headcellArray = [NSMutableArray arrayWithArray:model.m_goodslist];
            for (Ocean__ShowCartGoodsModel *cellmodel in cellDeleteArray) {
                
                if ([headcellArray containsObject:cellmodel]) {
                    
                    [headcellArray removeObject:cellmodel];
                }
            }
            model.m_goodslist = headcellArray;
        }
    
    }
    
    NSMutableArray *shopArray = [NSMutableArray arrayWithArray:_shoppingArray];
    for (Ocean__ShowCartGoodsHead *model in headDeleteArray) {
        
        if ([shopArray containsObject:model]) {
            
            [shopArray removeObject:model];
        }
    }
    _shoppingArray = shopArray;
    
    [self CalculationPrice];
    [self reloadData];
    
}

#pragma mark 响应选中事件

- (NSArray *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 添加一个删除按钮
    UITableViewRowAction *deleteRowAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive title:@"删除"handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
        Ocean__ShowCartGoodsHead *shoppingmodel = _shoppingArray[indexPath.section];
        Ocean__ShowCartGoodsModel *cellmodel = shoppingmodel.m_goodslist[indexPath.row];
        [HttpRequestTools requestUserInfoWithData:@{
                                                    @"m_uid":[Ocean_UserInfo sharedOcean_UserInfo].m_uid,
                                                    @"m_session":[Ocean_UserInfo sharedOcean_UserInfo].m_session,
                                                    @"m_goodsid":cellmodel.m_gid,
                                                    @"m_guigeid":cellmodel.m_dgid,
                                                    } methodName:@"DELETECART" completion:^(id respInfo, NSError *error) {
                
                                                        if (!error) {
                                                            if ([respInfo[@"ERRORCODE"] isEqualToString:@"0000"])
                                                            {
//                                                                [[NSNotificationCenter defaultCenter] postNotificationName:@"reload" object:nil];
                                                                [MBProgressHUD showInfoMessage:respInfo[@"ERRORDESTRIPTION"]];
                                                                Ocean__ShowCartGoodsHead *shoppingmodel = _shoppingArray[indexPath.section];
                                                                [shoppingmodel.m_goodslist removeObjectAtIndex:indexPath.row];
                                                                [_shoppingArray replaceObjectAtIndex:indexPath.section withObject:shoppingmodel];
                                                                if(shoppingmodel.m_goodslist.count == 0) {
                                                                     [_shoppingArray removeObjectAtIndex:indexPath.section];
                                                                    [self deleteSections:[NSIndexSet indexSetWithIndex:indexPath.section] withRowAnimation:YES];
                                                                }
                                                                if (_shoppingArray.count == 0) {
                                                                    _bottom.hidden = YES;
                                                                    [self showshopPageView:@"购物车没有商品" andImageName:@"commentEmpty"];

                                                                }
                                                                else
                                                                {
//                                                                [self deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
                                                                }
                                                                [self reloadData];
                                                                [self CalculationPrice];

                                        
                                                            }else{
                                                                
                                                                [MBProgressHUD showInfoMessage:respInfo[@"ERRORDESTRIPTION"]];                                                            }
                                                        }else{

                                                            [MBProgressHUD showInfoMessage:respInfo[@"ERRORDESTRIPTION"]];
                                                        }

        }];
        
    }];
    
    // 关注按钮
    UITableViewRowAction *editRowAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"关注"handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
        [MBProgressHUD showInfoMessage:@"关注"];
    }];
    
#pragma mark - 分享
    UITableViewRowAction *shareRowAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"分享"handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
        
        Ocean__ShowCartGoodsHead *shoppingmodel = _shoppingArray[indexPath.section];
        Ocean__ShowCartGoodsModel *cellmodel = shoppingmodel.m_goodslist[indexPath.row];
        
        
        [YiRenShareTools ShareTitle:cellmodel.m_title andiconName:cellmodel.m_listpic andInfo:@"" andUrl:@"http://show.xuanrui68.com/XuanR_HyZxSoftWare_Server/register/user/register.jsp?spreadcode="];
        [self reloadData];
    }];
    
    editRowAction.backgroundColor = RGB(21, 163, 115);
    shareRowAction.backgroundColor = RGB(255, 210, 58);

    // 将设置好的按钮放到数组中返回
    return @[deleteRowAction, editRowAction, shareRowAction];
}


@end
