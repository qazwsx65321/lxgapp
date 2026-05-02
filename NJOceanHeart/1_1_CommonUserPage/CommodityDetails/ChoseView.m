
//
//  ChoseView.m
//  AddShoppingCart
//
//  Created by 主用户 on 16/3/23.
//  Copyright © 2016年 江萧. All rights reserved.
//

#import "ChoseView.h"
#import "Ocean_GoodsDetailModel.h"

@interface ChoseView()

@property (nonatomic,strong) NSMutableArray * p_arr;

@property (nonatomic,strong) NSString * keyinfo;

@property (nonatomic,strong) SizeModel *p_sizeM;

@end

@implementation ChoseView
@synthesize alphaiView,whiteView,img,lb_detail,lb_price,lb_stock,mainscrollview,sizeView,colorView,countView,bt_sure,bt_cancle,lb_line,colorarr,sizearr,stock,stockdic;
-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        //半透明视图
        alphaiView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        alphaiView.backgroundColor = [UIColor blackColor];
        alphaiView.alpha = 0.2;
        [self addSubview:alphaiView];
        //装载商品信息的视图
        whiteView = [[UIView alloc] initWithFrame:CGRectMake(0, 200, self.frame.size.width, self.frame.size.height-200)];
        whiteView.backgroundColor = [UIColor whiteColor];
        [self addSubview:whiteView];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap)];
        [whiteView addGestureRecognizer:tap];
        
        //商品图片
        img = [[UIImageView alloc] initWithFrame:CGRectMake(10, -20, 100, 100)];
        img.backgroundColor = RGB(240, 240, 240);
        img.layer.cornerRadius = 4;
        img.layer.borderColor = [UIColor whiteColor].CGColor;
        img.layer.borderWidth = 5;
        [img.layer setMasksToBounds:YES];
        [whiteView addSubview:img];
        
        bt_cancle= [UIButton buttonWithType:UIButtonTypeCustom];
        bt_cancle.frame = CGRectMake(whiteView.frame.size.width-40, 10,30, 30);
        [bt_cancle setBackgroundImage:[UIImage imageNamed:@"close@3x"] forState:0];
        [whiteView addSubview:bt_cancle];
        
        //商品价格
        lb_price = [[UILabel alloc] initWithFrame:CGRectMake(img.frame.origin.x+img.frame.size.width+20, 10, whiteView.frame.size.width-(img.frame.origin.x+img.frame.size.width+40+40), 20)];
        lb_price.textColor = [UIColor redColor];
        lb_price.font = [UIFont systemFontOfSize:14];
        [whiteView addSubview:lb_price];
        //商品库存
        lb_stock = [[UILabel alloc] initWithFrame:CGRectMake(img.frame.origin.x+img.frame.size.width+20, lb_price.frame.origin.y+lb_price.frame.size.height, whiteView.frame.size.width-(img.frame.origin.x+img.frame.size.width+40+40), 20)];
        lb_stock.textColor = [UIColor blackColor];
        lb_stock.font = [UIFont systemFontOfSize:14];
        [whiteView addSubview:lb_stock];
        //用户所选择商品的尺码和颜色
        lb_detail = [[UILabel alloc] initWithFrame:CGRectMake(img.frame.origin.x+img.frame.size.width+20, lb_stock.frame.origin.y+lb_stock.frame.size.height, whiteView.frame.size.width-(img.frame.origin.x+img.frame.size.width+40+40), 40)];
        lb_detail.numberOfLines = 2;
        lb_detail.textColor = [UIColor blackColor];
        lb_detail.font = [UIFont systemFontOfSize:14];
        [whiteView addSubview:lb_detail];
        //分界线
        lb_line = [[UILabel alloc] initWithFrame:CGRectMake(0, img.frame.origin.y+img.frame.size.height+20, whiteView.frame.size.width, 0.5)];
        lb_line.backgroundColor = [UIColor lightGrayColor];
        [whiteView addSubview:lb_line];
        
        
        //确定按钮
        bt_sure= [UIButton buttonWithType:UIButtonTypeCustom];
        bt_sure.frame = CGRectMake(0, whiteView.frame.size.height-50,whiteView.frame.size.width, 50);
        [bt_sure setBackgroundColor:[UIColor redColor]];
        [bt_sure setTitleColor:[UIColor whiteColor] forState:0];
        bt_sure.titleLabel.font = [UIFont systemFontOfSize:20];
        [bt_sure setTitle:@"确定" forState:0];
        [bt_sure addTarget:self action:@selector(xsure) forControlEvents:UIControlEventTouchUpInside];
        [whiteView addSubview:bt_sure];
        //有的商品尺码和颜色分类特别多 所以用UIScrollView 分类过多显示不全的时候可滑动查看
        mainscrollview = [[UIScrollView alloc] initWithFrame:CGRectMake(0, lb_line.frame.origin.y+lb_line.frame.size.height, whiteView.frame.size.width, bt_sure.frame.origin.y-(lb_line.frame.origin.y+lb_line.frame.size.height))];
        mainscrollview.showsHorizontalScrollIndicator = NO;
        mainscrollview.showsVerticalScrollIndicator = NO;
        [whiteView addSubview:mainscrollview];
        //购买数量的视图
        countView = [[BuyCountView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 50)];
        [mainscrollview addSubview:countView];
        [countView.bt_add addTarget:self action:@selector(add) forControlEvents:UIControlEventTouchUpInside];
        countView.tf_count.delegate = self;
        [countView.bt_reduce addTarget:self action:@selector(reduce) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return self;
}
-(void)initTypeView:(NSArray *)sizeArr :(NSArray *)colorArr :(NSDictionary *)stockDic :(NSString *)imgUrl;
{
    sizearr = sizeArr;
    colorarr = colorArr;
    stockdic = stockDic;
    if (!sizeArr.count) {
        return;
    }
    //图片
    [img sd_setImageWithURL:[NSURL URLWithString:imgUrl]];
    
    CGFloat guigeY = 50;
    self.p_arr = [NSMutableArray array];
    for (int i =0; i<sizeArr.count; i++) {
        showMenuModel *menumodel = sizeArr[i];
        TypeView *type =[[TypeView alloc] initWithFrame:CGRectMake(0, guigeY, self.frame.size.width, 50) andDatasource:menumodel.two :menumodel.one];
        type.delegate = self;
        [self.p_arr addObject:@""];
        type.tag = 100+i;
        [mainscrollview addSubview:type];
        type.frame = CGRectMake(0, guigeY, self.frame.size.width, type.height);
        guigeY += type.height;
    }
    mainscrollview.contentSize = CGSizeMake(self.frame.size.width, guigeY+countView.frame.origin.y);

    
    
    //尺码
//    sizeView = [[TypeView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 50) andDatasource:sizearr :@"尺码"];
//    sizeView.delegate = self;
//    [mainscrollview addSubview:sizeView];
//    sizeView.frame = CGRectMake(0, 0, self.frame.size.width, sizeView.height);
//    //颜色分类
//    colorView = [[TypeView alloc] initWithFrame:CGRectMake(0, sizeView.frame.size.height, self.frame.size.width, 50) andDatasource:colorarr :@"颜色分类"];
//    colorView.delegate = self;
//    [mainscrollview addSubview:colorView];
//    colorView.frame = CGRectMake(0,sizeView.frame.size.height, self.frame.size.width, colorView.height);
//    //购买数量
    countView.frame = CGRectMake(0, colorView.frame.size.height+colorView.frame.origin.y, self.frame.size.width, 50);
    self.model.m_num = [NSNumber numberWithInt:1];
//    lb_price.text = @"¥100";
    lb_stock.text = @"库存-件";
    lb_detail.text = @"请选择 尺码 颜色分类";
    
    //点击图片放大图片
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showBigImage:)];
    img.userInteractionEnabled = YES;
    [img addGestureRecognizer:tap1];
    
    NSArray *allSku =  [stockDic allKeys];
    NSMutableArray *mutalArr = [NSMutableArray array];
    for (NSString *havstr in allSku) {
        NSArray *arr2 =  [havstr componentsSeparatedByString:@","];
        [mutalArr addObject:arr2];
    }
    
    
    NSInteger count = mutalArr.count;
    NSMutableArray * arrangeSet = [NSMutableArray array];
    for (int i =0 ; i<count; i++) {
        NSArray *childArr = mutalArr[i];
        NSInteger count1 = childArr.count;
        for (int j = 0; j<count1;j++) {
            if (j == i) {
                
            }
            
        }
        
        
    }
    
    
    
    
    
}
/**
 *  此处嵌入浏览图片代码
 */
-(void)showBigImage:(UITapGestureRecognizer *)tap
{
    NSLog(@"放大图片");
}
#pragma mark-typedelegete
-(void)btnFromView:(TypeView *)typeView index:(int) tag andGuiGe:(NSString *)guige
{
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    //选择种类
    NSInteger type = typeView.tag -100;
//    NSInteger style = tag;
    showMenuModel *menumodel = sizearr[type];
    NSString *str = [NSString stringWithFormat:@"%@:%@",menumodel.one,guige];
    [self.p_arr replaceObjectAtIndex:type withObject:str];
    NSMutableString *choose = [NSMutableString string];
    [choose appendString:@"请选择:"];
    NSMutableString *mutal = [NSMutableString string];
    NSInteger allcount = self.p_arr.count;
    self.p_sizeM = nil;
    
    BOOL isALL = YES;
    
    for (int i = 0; i<allcount; i++) {
        NSString *str = self.p_arr[i];
        if (!str.length) {
            isALL = NO;
            showMenuModel *menumodel = sizearr[i];
            [choose appendString:[NSString stringWithFormat:@"%@ ",menumodel.one]];
        }
        if (i == allcount-1) {
            [mutal appendString:str];
            continue;
        }
        [mutal appendString:[NSString stringWithFormat:@"%@,",str]];
        
    }
    
    self.keyinfo = mutal;
    
    if (!isALL) {
        lb_detail.text = choose;
    }else{
     NSDictionary * objdic =   stockdic[mutal];
        if (objdic) {
          SizeModel *sizeM =  [SizeModel mj_objectWithKeyValues:objdic];
            self.p_sizeM  = sizeM;
            lb_price.text = [NSString stringWithFormat:@"¥ %@",sizeM.m_price];
            lb_stock.text = [NSString stringWithFormat:@"库存:%@件",sizeM.m_kcnum];
            lb_detail.text =mutal;
            [img sd_setImageWithURL:[NSURL URLWithString:sizeM.m_guige] placeholderImage:[UIImage imageNamed:@""]];
        }else{
            lb_detail.text = @"暂无库存";
        }
    }
    
   
    
//    //通过seletIndex是否>=0来判断尺码和颜色是否被选择，－1则是未选择状态
//    if (sizeView.seletIndex >=0&&colorView.seletIndex >=0) {
//        //尺码和颜色都选择的时候
//        NSString *size =[sizearr objectAtIndex:sizeView.seletIndex];
//        NSString *color =[colorarr objectAtIndex:colorView.seletIndex];
//        lb_stock.text = [NSString stringWithFormat:@"库存%@件",[[stockdic objectForKey: size] objectForKey:@"soldnum"]];
//        lb_detail.text = [NSString stringWithFormat:@"已选 \"%@\" \"%@\"",size,color];
//        stock =[[[stockdic objectForKey: size] objectForKey:color] intValue];
//        
//        [self reloadTypeBtn:[stockdic objectForKey:size] :colorarr :colorView];
//        [self reloadTypeBtn:[stockdic objectForKey:color] :sizearr :sizeView];
//        NSLog(@"%d",colorView.seletIndex);
//        img.image = [UIImage imageNamed:[NSString stringWithFormat:@"%d.jpg",colorView.seletIndex+1]];
//    }else if (sizeView.seletIndex ==-1&&colorView.seletIndex == -1)
//    {
//        //尺码和颜色都没选的时候
//        lb_price.text = @"¥100";
//        lb_stock.text = @"库存100000件";
//        lb_detail.text = @"请选择 尺码 颜色分类";
//        stock = 100000;
//        //全部恢复可点击状态
//        [self resumeBtn:colorarr :colorView];
//        [self resumeBtn:sizearr :sizeView];
//        
//    }else if (sizeView.seletIndex ==-1&&colorView.seletIndex >= 0)
//    {
//        //只选了颜色
//        NSString *color =[colorarr objectAtIndex:colorView.seletIndex];
//        //根据所选颜色 取出该颜色对应所有尺码的库存字典
//        NSDictionary *dic = [stockdic objectForKey:color];
//        [self reloadTypeBtn:dic :sizearr :sizeView];
//        [self resumeBtn:colorarr :colorView];
//        lb_stock.text = @"库存100000件";
//        lb_detail.text = @"请选择 尺码";
//        stock = 100000;
//        
//        img.image = [UIImage imageNamed:[NSString stringWithFormat:@"%d.jpg",colorView.seletIndex+1]];
//    }else if (sizeView.seletIndex >= 0&&colorView.seletIndex == -1)
//    {
//        //只选了尺码
//        NSString *size =[sizearr objectAtIndex:sizeView.seletIndex];
//        //根据所选尺码 取出该尺码对应所有颜色的库存字典
//        NSDictionary *dic = [stockdic objectForKey:size];
//        [self resumeBtn:sizearr :sizeView];
//        [self reloadTypeBtn:dic :colorarr :colorView];
//        lb_stock.text = [NSString stringWithFormat:@"库存 %@",[dic objectForKey:@"m_kcnum"]];
//        lb_price.text = [NSString stringWithFormat:@"¥ %@",[dic objectForKey:@"m_price"]];
//        lb_detail.text = @"请选择 颜色分类";
//        stock = [[dic objectForKey:@"m_kcnum"] intValue];
//        
//        self.model.m_gid = [dic objectForKey:@"m_gid"];
//        self.model.m_dgid = [dic objectForKey:@"m_dgid"];
//
//    }
}
//恢复按钮的原始状态
-(void)resumeBtn:(NSArray *)arr :(TypeView *)view
{
    for (int i = 0; i< arr.count; i++) {
        UIButton *btn =(UIButton *) [view viewWithTag:100+i];
        btn.enabled = YES;
        btn.selected = NO;
        [btn setBackgroundColor:[UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1]];
        [btn setTitleColor:[UIColor blackColor] forState:0];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        if (view.seletIndex == i) {
            btn.selected = YES;
            [btn setBackgroundColor:[UIColor redColor]];
        }
    }
}
//根据所选的尺码或者颜色对应库存量 确定哪些按钮不可选
-(void)reloadTypeBtn:(NSDictionary *)dic :(NSArray *)arr :(TypeView *)view
{
    for (int i = 0; i<arr.count; i++) {
        int count = [[dic objectForKey:[arr objectAtIndex:i]] intValue];
        UIButton *btn =(UIButton *)[view viewWithTag:100+i];
        btn.selected = NO;
        [btn setBackgroundColor:[UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1]];
        //库存为零 不可点击
        if (count == 0) {
            btn.enabled = NO;
            [btn setTitleColor:[UIColor lightGrayColor] forState:0];
        }else
        {
            btn.enabled = YES;
            [btn setTitleColor:[UIColor blackColor] forState:0];
        }
        //根据seletIndex 确定用户当前点了那个按钮
        if (view.seletIndex == i) {
            btn.selected = YES;
            [btn setBackgroundColor:[UIColor redColor]];
        }
    }
}
#pragma mark-数量加减
-(void)add
{
    if (!self.p_sizeM) {
        [MBProgressHUD showInfoMessage:@"暂无库存"];
        return;
    }
    
    int count =[countView.tf_count.text intValue];
    if (count <[self.p_sizeM.m_kcnum integerValue]) {
        countView.tf_count.text = [NSString stringWithFormat:@"%d",count+1];
        self.model.m_num = [NSNumber numberWithInt:count + 1];
    }else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"数量超出范围" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alert show];
    }
}
-(void)reduce
{
    if (!self.p_sizeM) {
        [MBProgressHUD showInfoMessage:@"暂无库存"];
        return;
    }
    
    int count =[countView.tf_count.text intValue];
    if (count > 1) {
        countView.tf_count.text = [NSString stringWithFormat:@"%d",count-1];
        self.model.m_num = [NSNumber numberWithInt:count - 1];

    }else
    {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"至少要购买一份哦~" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
                [alert show];
    }
}
#pragma mark-tf
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    mainscrollview.contentOffset = CGPointMake(0, countView.frame.origin.y);
    return YES;
}
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    int count =[countView.tf_count.text intValue];
    if (count > self.stock) {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"数量超出范围" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        alert.tag = 100;
        [alert show];
        countView.tf_count.text = [NSString stringWithFormat:@"%d",self.stock];
        [self tap];
    }
}


-(void)xsure{
    if (self.keyinfo.length) {
        NSArray *arr =  [self.keyinfo componentsSeparatedByString:@","];
        if (arr.count ==_p_arr.count && ![@"" isEqualToString:[arr lastObject]]) {
            if (self.p_sizeM) {
                [[NSNotificationCenter defaultCenter]postNotificationName:@"finishChooseShop" object:self.p_sizeM];
            }else{
                lb_detail.text = @"暂无库存";
                [MBProgressHUD showInfoMessage:@"暂无库存"];

            }
        }else{
        
            [MBProgressHUD showInfoMessage:@"请选择完整后提交"];
        
        }
        
    }
}


-(void)tap
{
//    mainscrollview.contentOffset = CGPointMake(0, 0);
//    [countView.tf_count resignFirstResponder];
}
/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
