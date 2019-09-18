//
//  ScanViewController.m
//  QrcodeStudy
//
//  Created by 司开发 on 2019/9/12.
//  Copyright © 2019 李杰. All rights reserved.
//

#import "ScanViewController.h"


// 导入<AVFoundation/AVFoundation.h>框架
#import <AVFoundation/AVFoundation.h>

@interface ScanViewController ()<AVCaptureMetadataOutputObjectsDelegate>
/** 捕捉会话 */
@property (nonatomic, weak) AVCaptureSession *session;
/** 预览图层 */
@property (nonatomic, weak) AVCaptureVideoPreviewLayer *layer;

@end

@implementation ScanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 扫描二维码
    [self scanCIQRCode];
}

/**
 *  扫描二维码
 */
- (void)scanCIQRCode
{
    // 1. 创建捕捉会话
    AVCaptureSession *session = [[AVCaptureSession alloc] init];
    self.session = session;
    
    // 2. 添加输入设备(数据从摄像头输入)
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    AVCaptureDeviceInput *input = [AVCaptureDeviceInput deviceInputWithDevice:device error:nil];
    [session addInput:input];
    
    // 3. 添加输出数据接口
    AVCaptureMetadataOutput *output = [[AVCaptureMetadataOutput alloc] init];
    // 设置输出接口代理
    [output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    [session addOutput:output];
    // 3.1 设置输入元数据的类型(类型是二维码数据)
    // 注意，这里必须设置在addOutput后面，否则会报错
    [output setMetadataObjectTypes:@[AVMetadataObjectTypeQRCode]];
    
    // 4.添加扫描图层
    AVCaptureVideoPreviewLayer *layer = [AVCaptureVideoPreviewLayer layerWithSession:session];
    //Video Gravity 视频播放时的拉伸方式
    //AVLayerVideoGravityResize,       // 非均匀模式。两个维度完全填充至整个视图区域
    //AVLayerVideoGravityResizeAspect,  // 等比例填充，直到一个维度到达区域边界
    //AVLayerVideoGravityResizeAspectFill, // 等比例填充，直到填充满整个视图区域，其中一个维度的部分区域会被裁剪
    layer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    layer.frame = self.view.bounds;
    [self.view.layer addSublayer:layer];
    self.layer = layer;
    
    // 5. 开始扫描
    [session startRunning];
}

#pragma mark - <AVCaptureMetadataOutputObjectsDelegate>

- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection
{
    NSLog(@"\n\n\n\n\nmetadataObjects:%@",metadataObjects);
    if (metadataObjects.count) {// 扫描到了数据
        AVMetadataMachineReadableCodeObject *lastObject = [metadataObjects lastObject];
        AVMetadataMachineReadableCodeObject *firstObject = [metadataObjects objectAtIndex : 0];
        
        NSLog(@"lastObject: %@",lastObject);
        NSLog(@"firstObject: %@",firstObject);
        
        // 停止扫描
        [self.session stopRunning];
        
        // 将预览图层移除
        [self.layer removeFromSuperlayer];
    }else{
        NSLog(@"没有扫描到数据");
    }
}


@end
