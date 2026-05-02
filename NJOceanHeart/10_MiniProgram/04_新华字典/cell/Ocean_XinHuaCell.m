//
//  Ocean_XinHuaCell.m
//  NJOceanHeart
//
//  Created by 陈志伟 on 17/9/13.
//  Copyright © 2017年 Xuanr. All rights reserved.
//

#import "Ocean_XinHuaCell.h"

#import "Ocean_ExplainView.h"

@interface Ocean_XinHuaCell ()

@property (nonatomic,strong) UIView *bgView;
@property (nonatomic,strong) UILabel *nameLabel;
@property (nonatomic,strong) UILabel *pinyinLabel;
@property (nonatomic,strong) UILabel *bihuaLabel;
@property (nonatomic,strong) UILabel *bushouLabel;
@property (nonatomic,strong) UILabel *jiegouLabel;
@property (nonatomic,strong) UILabel *bishunLabel;
@property (nonatomic,strong) UILabel *wubiLabel;
@property (nonatomic,strong) UILabel *englishLabel;
@property (nonatomic,strong) UILabel *explainLabel;

@end

@implementation Ocean_XinHuaCell

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *cellsign = @"Ocean_XinHuaCell";
    Ocean_XinHuaCell *cell  = [tableView dequeueReusableCellWithIdentifier:cellsign];
    if (cell ==nil) {
        cell  = [[Ocean_XinHuaCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellsign];
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
    [self.bgView addSubview:self.nameLabel];
    
    self.pinyinLabel = [[UILabel alloc] init];
    self.pinyinLabel.font = [UIFont systemFontOfSize:13];
    [self.bgView addSubview:self.pinyinLabel];
    
    self.bihuaLabel = [[UILabel alloc] init];
    self.bihuaLabel.font = [UIFont systemFontOfSize:13];
    [self.bgView addSubview:self.bihuaLabel];
    
    self.bushouLabel = [[UILabel alloc] init];
    self.bushouLabel.font = [UIFont systemFontOfSize:13];
    [self.bgView addSubview:self.bushouLabel];
    
    self.jiegouLabel = [[UILabel alloc] init];
    self.jiegouLabel.font = [UIFont systemFontOfSize:13];
    [self.bgView addSubview:self.jiegouLabel];
    
    self.bishunLabel = [[UILabel alloc] init];
    self.bishunLabel.font = [UIFont systemFontOfSize:13];
    [self.bgView addSubview:self.bishunLabel];
    
    self.wubiLabel = [[UILabel alloc] init];
    self.wubiLabel.font = [UIFont systemFontOfSize:13];
    [self.bgView addSubview:self.wubiLabel];
    
    self.englishLabel = [[UILabel alloc] init];
    self.englishLabel.font = [UIFont systemFontOfSize:13];
    [self.bgView addSubview:self.englishLabel];
    
    self.explainLabel = [[UILabel alloc] init];
    self.explainLabel.text = @"解释: ";
    self.explainLabel.font = [UIFont systemFontOfSize:13];
    [self.bgView addSubview:self.explainLabel];
    
    
}

- (void)setCellframes:(Ocean_XinHuaFrames *)cellframes {
    _cellframes = cellframes;
    
    
    _bgView.frame = cellframes.bgViewF;
    _nameLabel.frame = cellframes.nameLabelF;
    _pinyinLabel.frame = cellframes.pinyinLabelF;
    _bihuaLabel.frame = cellframes.bihuaLabelF;
    _bushouLabel.frame = cellframes.bushouLabelF;
    _jiegouLabel.frame = cellframes.jiegouLabelF;
    _bishunLabel.frame = cellframes.bishunLabelF;
    _wubiLabel.frame = cellframes.wubiLabelF;
    _englishLabel.frame = cellframes.englishLabelF;
    _explainLabel.frame = cellframes.explainLabelF;
    
    _nameLabel.text = [NSString stringWithFormat:@"字: %@",cellframes.dic[@"name"]];
    _pinyinLabel.text = [NSString stringWithFormat:@"拼音: %@",cellframes.dic[@"pinyin"]];
    _bihuaLabel.text = [NSString stringWithFormat:@"笔画: %@",cellframes.dic[@"bihua"]];
    _bushouLabel.text = [NSString stringWithFormat:@"部首: %@",cellframes.dic[@"bushou"]];
    _jiegouLabel.text = [NSString stringWithFormat:@"结构: %@",cellframes.dic[@"jiegou"]];
    _bishunLabel.text = [NSString stringWithFormat:@"笔顺: %@",cellframes.dic[@"bishun"]];
    _wubiLabel.text = [NSString stringWithFormat:@"五笔: %@",cellframes.dic[@"wubi"]];
    
    NSArray *arr = cellframes.dic[@"english"];
    NSString *str = arr[0];
    for (int i = 0; i < arr.count; i ++) {
        if (i > 0) {
            str = [NSString stringWithFormat:@"%@,%@",str,arr[i]];
        }
    }
    
    _englishLabel.text = [NSString stringWithFormat:@"英文: %@",str];
    
    
    for (int i = 0 ; i < cellframes.hightArray.count; i ++) {
        NSDictionary *dic = cellframes.hightArray[i];
        
        Ocean_ExplainView *explainView = [[Ocean_ExplainView alloc] initWithFrame:CGRectMake(self.explainLabel.right, [dic[@"webY"] floatValue],screen_Width - self.explainLabel.right - 10, [dic[@"webHeight"] floatValue]) withContentHight:[dic[@"contentHight"] floatValue]];
        explainView.title = dic[@"title"];
        explainView.content = dic[@"content"];
        explainView.lineSpace = 4;
        [self.bgView addSubview:explainView];
    }
    
    
}



@end



@implementation Ocean_XinHuaFrames

- (void)setDic:(NSDictionary *)dic {
    _dic = dic;
    
    _bgViewF = CGRectMake(0, 0, screen_Width, 100);
    _nameLabelF = CGRectMake(10, 10, screen_Width - 20, 20);
    _pinyinLabelF = CGRectMake(10, CGRectGetMaxY(_nameLabelF)+10, screen_Width - 20, 20);
    _bihuaLabelF = CGRectMake(10, CGRectGetMaxY(_pinyinLabelF)+10, screen_Width - 20, 20);
    _bushouLabelF = CGRectMake(10, CGRectGetMaxY(_bihuaLabelF)+10, screen_Width - 20, 20);
    _jiegouLabelF = CGRectMake(10, CGRectGetMaxY(_bushouLabelF)+10, screen_Width - 20, 20);
    _bishunLabelF = CGRectMake(10, CGRectGetMaxY(_jiegouLabelF)+10, screen_Width - 20, 20);
    _wubiLabelF = CGRectMake(10, CGRectGetMaxY(_bishunLabelF)+10, screen_Width - 20, 20);
    _englishLabelF = CGRectMake(10, CGRectGetMaxY(_wubiLabelF)+10, screen_Width - 20, 20);
    
    
    CGSize explainS = [StringSizeModel sizeWithText:@"解释: " font:[UIFont systemFontOfSize:13]];
    
    _explainLabelF = CGRectMake(10, CGRectGetMaxY(_englishLabelF)+10, explainS.width, 20);
    
    NSArray *arr = dic[@"explain"];
    
    self.hightArray = [NSMutableArray array];
    
    CGFloat CH = 0.0;
    CGFloat CY = CGRectGetMaxY(_englishLabelF)+10;
    for (int i = 0; i < arr.count; i ++) {
        
        NSString *content = arr[i][@"content"];
        
        
        CY = CGRectGetMaxY(_englishLabelF)+10+CH;
                
        NSAttributedString * attrStr = [[NSAttributedString alloc] initWithData:[content dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
        content = [NSString stringWithFormat:@"%@",attrStr];
        
        NSArray *array = [content componentsSeparatedByString:@"{"];
        content = array[0];
        
        CGSize conS = [StringSizeModel sizeWithText:content font:[UIFont systemFontOfSize:13] maxW:screen_Width - CGRectGetMaxX(_explainLabelF) - 10 withLineSpace:4];
        
        CGFloat conH = conS.height + 20;
        [self.hightArray addObject:@{@"webY":@(CY),
                                     @"webHeight":@(conS.height),
                                     @"contentHight":@(conH),
                                     @"title":arr[i][@"pinyin"],
                                     @"content":content
                                     }];
        
        CH += conH;
        
    }
    
    _bgViewF.size.height = CGRectGetMaxY(_englishLabelF) + 10 + CH;
    
    
    
    
}



//过滤后台返回字符串中的标签
- (NSString *)flattenHTML:(NSString *)html {
    
    NSScanner *theScanner;
    NSString *text = nil;
    
    theScanner = [NSScanner scannerWithString:html];
    
    while ([theScanner isAtEnd] == NO) {
        // find start of tag
        [theScanner scanUpToString:@"<" intoString:NULL] ;
        // find end of tag
        [theScanner scanUpToString:@">" intoString:&text] ;
        // replace the found tag with a space
        //(you can filter multi-spaces out later if you wish)
        html = [html stringByReplacingOccurrencesOfString:
                [NSString stringWithFormat:@"%@>", text]
                                               withString:@""];
    }
//    MidStrTitle = html;
    return html;
}



@end
