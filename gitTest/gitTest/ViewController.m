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
    // 上传的基本使用
    // 下载的基本使用
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

- (void)download {
    // 创建会话管理
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    // 创建请求
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://4493bz.1985t.com/uploads/allimg/150127/4-15012G52133.jpg"]];
    // 发送请求   注意! 该方法会返回一个NSURLSessionDownloadTask对象
    NSURLSessionDownloadTask *task = [manager downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
        //downloadProgress内部的属性中有已下载内容,以及目标文件内容,故很方便的监听到下载进度
        NSLog(@"%f",1.0 * downloadProgress.completedUnitCount / downloadProgress.totalUnitCount);
    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        // 此block块需要返回文件存放的目标路径,内部会自动实现剪切操作
        // 文件名
        NSString *fileName = [response suggestedFilename];
        // cache路径
        NSString *cache = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).lastObject;
        // 全路径
        NSString *fullPath = [cache stringByAppendingPathComponent:fileName];
        // 返回路径
        return [NSURL fileURLWithPath:fullPath];
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        // 下载完成后的回调
        NSLog(@"path--%@",filePath);
    }];
    
    // 需要手动开启!
    [task resume];
}



@end
