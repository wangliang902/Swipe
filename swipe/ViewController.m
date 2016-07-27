//
//  ViewController.m
//  swipe
//
//  Created by Lenny on 16/7/26.
//  Copyright © 2016年 Lenny. All rights reserved.
//

#import "ViewController.h"
#import "SwpieDeleteV.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    SwpieDeleteV *sDelV = [[SwpieDeleteV alloc] initWithFrame:(CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height))];
    [self.view addSubview:sDelV];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
