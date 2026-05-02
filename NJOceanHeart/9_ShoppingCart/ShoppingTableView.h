//
//  ShoppingTableView.h
//  TDS
//
//  Created by 黎金 on 16/3/24.
//  Copyright © 2016年 sixgui. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ShoppingTableView : UITableView<UITableViewDataSource,UITableViewDelegate>
{

}

@property (nonatomic, strong) NSMutableArray *shoppingArray;
@property (nonatomic, strong) UIView *bottom;
@property (nonatomic,weak) UIViewController * m_controller;

-(void)allBtn:(BOOL)isbool;

-(void)editBtn:(BOOL)isbool;

-(void)deleteBtn:(BOOL)isbool;


@end
