//
//  SwipeDeleteCell.h
//  Healthy
//
//  Created by Lenny on 16/7/26.
//  Copyright © 2016年 xiongwen. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SwipeDeleteCell;

typedef void(^SwipeBlock)(SwipeDeleteCell *outCell);

@interface SwipeDeleteCell : UITableViewCell

@property(nonatomic,assign)BOOL state;//是否已滑动出去
//添加滑动的结束的block
- (void)addSwipeBlock:(SwipeBlock)outBlock withBeginBlock:(SwipeBlock)statrBlock;
//
- (void)goBack;

@end
