//
//  SwpieDeleteV.h
//  Healthy
//
//  Created by Lenny on 16/7/26.
//  Copyright © 2016年 xiongwen. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SwpieDeleteVDelegate <UITableViewDelegate>

@end

@protocol SwpieDeleteVDataSource <UITableViewDataSource>

@end

@interface SwpieDeleteV : UIView

@property(nonatomic,strong)UITableView *tableV;
@property(nonatomic,assign)id<SwpieDeleteVDelegate> delegate;
@property(nonatomic,assign)id<SwpieDeleteVDataSource> dataSource;

@end
