//
//  ViewController.m
//  gitTest
//
//  Created by Finn Zhang on 2016/12/1.
//  Copyright © 2016年 Finn. All rights reserved.
//

#import "ViewController.h"
#import <UIImageView+WebCache.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"test");
    UIImageView *imageView =[[UIImageView alloc] initWithFrame:self.view.bounds];
    [imageView sd_setImageWithURL:[NSURL URLWithString:@"http://pic12.nipic.com/20110108/6091831_083033006193_2.jpg"] placeholderImage:nil];
    [self.view addSubview:imageView];
}

@end
