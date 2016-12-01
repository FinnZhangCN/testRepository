//
//  ViewController.m
//  gitTest
//
//  Created by Finn Zhang on 2016/12/1.
//  Copyright © 2016年 Finn. All rights reserved.
//

#import "ViewController.h"
#import <UIImageView+WebCache.h>
#import <AFNetworking.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"test");
    UIImageView *imageView =[[UIImageView alloc] initWithFrame:self.view.bounds];
    [imageView sd_setImageWithURL:[NSURL URLWithString:@"http://pic12.nipic.com/20110108/6091831_083033006193_2.jpg"] placeholderImage:nil];
    [self.view addSubview:imageView];
    
    // test cocoapods AFN测试
    // 上传操作
    [self upload];
}

- (void)upload {
    // 会话管理
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    // 确定非文件参数---(字典的形式)
    NSDictionary *dict = @{
                           @"username":@"Finn"
                           };
    // 发送请求 - 注意! 文件上传最好使用POST,因为GET对于文件的路径有限制,不适合此场景
    [manager POST:@"http://120.25.226.186:32812/upload" parameters:dict constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        NSData *data = [NSData dataWithContentsOfFile:[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).lastObject stringByAppendingPathComponent:@"屏幕快照 2016-09-29 11.23.35.png"]];
        [formData appendPartWithFileData:data name:@"file" fileName:@"cat" mimeType:@"image/png"];
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        // 上传进度
        NSLog(@"%f",1.0 * uploadProgress.completedUnitCount / uploadProgress.totalUnitCount);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"上传成功");
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error ---%@",error);
    }];
}


@end
