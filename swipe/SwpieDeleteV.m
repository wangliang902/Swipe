//
//  SwpieDeleteV.m
//  Healthy
//
//  Created by Lenny on 16/7/26.
//  Copyright © 2016年 xiongwen. All rights reserved.
//

#import "SwpieDeleteV.h"
#import "SwipeDeleteCell.h"
#define WS(weakSelf)  __weak __typeof(&*self)weakSelf = self;

@interface SwpieDeleteV ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)NSMutableArray *swipeOutCells;
@end

@implementation SwpieDeleteV

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        [self setUI];
    }
    return self;
}

- (void)setUI {
    
    [self addSubview:self.tableV];
}

#pragma mark - delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 100;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    SwipeDeleteCell *cell = [tableView dequeueReusableCellWithIdentifier:@"scell" forIndexPath:indexPath];
    WS(weakSelf);
    [cell addSwipeBlock:^(SwipeDeleteCell *outCell) {
        if (outCell.state == YES) {
            [weakSelf.swipeOutCells addObject:outCell];
        }else {
            if ([weakSelf.swipeOutCells containsObject:outCell]) {
                [weakSelf.swipeOutCells removeObject:outCell];
            }
        }
    } withBeginBlock:^(SwipeDeleteCell *outCell) {
        if (weakSelf.swipeOutCells.count > 0) {
            for (SwipeDeleteCell *cell in weakSelf.swipeOutCells) {
                [cell goBack];
            }
        }
    }];
    return cell;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    if (self.swipeOutCells.count > 0) {
        for (SwipeDeleteCell *cell in self.swipeOutCells) {
            [cell goBack];
        }
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (self.swipeOutCells.count > 0) {
        for (SwipeDeleteCell *cell in self.swipeOutCells) {
            [cell goBack];
        }
    }
}

#pragma mark - setter 
- (UITableView *)tableV {
    if (_tableV == nil) {
        
        _tableV = [[UITableView alloc] initWithFrame:(self.bounds) style:(UITableViewStylePlain)];
        _tableV.delegate = self;
        _tableV.dataSource = self;
        [_tableV registerClass:[SwipeDeleteCell class] forCellReuseIdentifier:@"scell"];
    }
    return _tableV;
}

- (NSMutableArray *)swipeOutCells {
    if (_swipeOutCells == nil) {
        _swipeOutCells = [NSMutableArray array];
    }
    return _swipeOutCells;
}

@end
