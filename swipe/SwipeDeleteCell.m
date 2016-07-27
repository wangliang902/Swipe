//
//  SwipeDeleteCell.m
//  Healthy
//
//  Created by Lenny on 16/7/26.
//  Copyright © 2016年 xiongwen. All rights reserved.
//

#import "SwipeDeleteCell.h"
#import "Masonry.h"

@interface SwipeDeleteCell ()<UIGestureRecognizerDelegate>
{
    CGFloat _sWide;//滑动宽度
    CGPoint _initCenter;//起始中心位置
    CGPoint _originCenter;//起始中心位置
    UIPanGestureRecognizer *panGesture;
}
@property(nonatomic,strong)UIView *conV;//滑动前展示页面视图
@property(nonatomic,strong)UIView *swipeV;//滑动出来的视图
@property(nonatomic,copy)SwipeBlock block;
@property(nonatomic,copy)SwipeBlock startblock;
@end

@implementation SwipeDeleteCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        _sWide = 100;
        self.state = NO;
        [self setUI];
        [self addGestue];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setUI {
    
    [self.contentView addSubview:self.swipeV];
    [self.contentView addSubview:self.conV];
    
    [self.conV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.mas_equalTo(0);
    }];
    [self.swipeV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.top.bottom.mas_equalTo(0);
        make.width.mas_equalTo(_sWide);
    }];
}

- (void)addSwipeBlock:(SwipeBlock)outBlock withBeginBlock:(SwipeBlock)statrBlock{
    
    self.startblock = statrBlock;
    self.block = outBlock;
}

- (void)goBack {
    
    if (self.state == YES) {
        [UIView animateWithDuration:0.2 animations:^{
            self.conV.center = CGPointMake(self.center.x, _initCenter.y);
        } completion:^(BOOL finished) {
            self.state = NO;
        }];
    }
}



//#pragma mark - delegate 
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    
    if ([gestureRecognizer isKindOfClass:[UIPanGestureRecognizer class]])
    {
        UIPanGestureRecognizer *panGestureRecognizer = (UIPanGestureRecognizer *)gestureRecognizer;
        CGPoint vel = [panGestureRecognizer velocityInView:self.contentView];
        if ((fabs(vel.x) >fabs(vel.y))&& vel.x<0)
        {
            return YES;
        }else
        {
            return NO;
        }
    }
    return YES;
}


#pragma mark - motheds
- (void)addGestue {
    
    panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGestureAction:)];
    panGesture.delegate = self;
    [self.conV addGestureRecognizer:panGesture];
}

- (void)panGestureAction:(UIPanGestureRecognizer *)pan {
    
    
    CGPoint directionP = [pan velocityInView:pan.view];
    CGPoint tranP = [pan translationInView:pan.view];
    
    if (pan.state == UIGestureRecognizerStateBegan) {
        if (self.startblock != nil) {
            self.startblock(self);
        }
        _initCenter = pan.view.center;
    }else if (pan.state == UIGestureRecognizerStateChanged){
    
        if (fabs(directionP.y) < fabs(directionP.x)) {
            //横向滑动时
            if (self.state == NO) {
                //向左滑动  （ 滑动出来时）
                if (-tranP.x > _sWide) {
                    tranP.x = -_sWide;
                }else if (tranP.x > 0){
                    //向右滑动
                    tranP.x = 0;
                }
                pan.view.center = CGPointMake(_initCenter.x + tranP.x, _initCenter.y);
            }else {
                //滑回去
                if (tranP.x < 0) {
                    tranP.x = 0;
                }else if (tranP.x > _sWide) {
                    tranP.x = _sWide;
                }
                pan.view.center = CGPointMake(_initCenter.x + tranP.x, _initCenter.y);
            }
        }
    }else {
        
        if (self.state == NO) {
            
            if (-tranP.x > _sWide / 3) {
                //滑动出去
                [UIView animateWithDuration:0.2 animations:^{
                    pan.view.center = CGPointMake(_initCenter.x - _sWide, _initCenter.y);
                } completion:^(BOOL finished) {
                    self.state = YES;
                    if (self.block != nil) {
                        self.block(self);
                    }
                }];
            }else {
                //滑动回去
                [UIView animateWithDuration:0.2 animations:^{
                    pan.view.center = CGPointMake(_initCenter.x, _initCenter.y);
                }completion:^(BOOL finished) {
                    self.state = NO;
                    if (self.block != nil) {
                        self.block(self);
                    }
                }];
            }
        }else {
            //滑动回去
            [UIView animateWithDuration:0.2 animations:^{
                pan.view.center = CGPointMake(_initCenter.x + _sWide, _initCenter.y);
            }completion:^(BOOL finished) {
                self.state = NO;
                if (self.block != nil) {
                    self.block(self);
                };
            }];
        }
    }
}

#pragma mark - setter 
- (UIView *)conV {
    if (_conV == nil) {
        _conV = [[UIView alloc] initWithFrame:CGRectZero];
        _conV.backgroundColor = [UIColor yellowColor];
    }
    return _conV;
}

- (UIView *)swipeV {
    if (_swipeV == nil) {
        _swipeV = [[UIView alloc] initWithFrame:CGRectZero];
        _swipeV.backgroundColor = [UIColor redColor];
    }
    return _swipeV;
}

@end
