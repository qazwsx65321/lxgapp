//
//  Ocean_ExplainView.m
//  NJOceanHeart
//
//  Created by 陈志伟 on 17/9/13.
//  Copyright © 2017年 Xuanr. All rights reserved.
//

#import "Ocean_ExplainView.h"

#import "XDLabel.h"

@interface Ocean_ExplainView ()

@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,strong) XDLabel *contentLabel;

@end

@implementation Ocean_ExplainView

- (instancetype)initWithFrame:(CGRect)frame withContentHight:(CGFloat)contentHight {
    if (self = [super initWithFrame:frame]) {
        
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 20)];
        self.titleLabel.font = [UIFont systemFontOfSize:13];
        [self addSubview:self.titleLabel];
        
        self.contentLabel = [[XDLabel alloc] initWithFrame:CGRectMake(0, 20, self.frame.size.width, contentHight)];
        self.contentLabel.font = [UIFont systemFontOfSize:13];
        self.contentLabel.numberOfLines = 0;
        [self addSubview:self.contentLabel];
        
    }
    return self;
}


- (void)setTitle:(NSString *)title {
    _title = title;
    _titleLabel.text = title;
}

- (void)setContent:(NSString *)content {
    _content = content;
    _contentLabel.text = content;
}

- (void)setLineSpace:(float)lineSpace {
    
    _lineSpace = lineSpace;
    _contentLabel.XD_lineSpace = lineSpace;
    _contentLabel.XD_headIndentSpace = 26;
    [_contentLabel XD_setAttributeWithType:LINESPACE | HEAdINDENTSPACE];
    
}

@end
