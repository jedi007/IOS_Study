//
//  ViewController.m
//  QrcodeStudy
//
//  Created by 司开发 on 2019/9/12.
//  Copyright © 2019 李杰. All rights reserved.
//

#import "ViewController.h"

#import "UIImage+Category.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSLog(@"viewDidLoad");
}

/**
 *  生成二维码
 */
- (void)creatCIQRCodeImage
{
    // 1.创建过滤器，这里的@"CIQRCodeGenerator"是固定的
    CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    
    // 2.恢复默认设置
    [filter setDefaults];
    
    // 3. 给过滤器添加数据
    NSString *dataString = @"二维码测试数据";
    NSData *data = [dataString dataUsingEncoding:NSUTF8StringEncoding];
    // 注意，这里的value必须是NSData类型
    [filter setValue:data forKeyPath:@"inputMessage"];
    
    // 4. 生成二维码
    CIImage *outputImage = [filter outputImage];
    
    //// 5. 显示二维码
    //self.QrcodeImage.image = [UIImage imageWithCIImage:outputImage];
    
    // 5. 改为生成高清二维码的方式
    self.QrcodeImage.image = [UIImage creatNonInterpolatedUIImageFormCIImage:outputImage withSize:200];
}

- (IBAction)createQrcode:(UIButton *)sender {
    [self creatCIQRCodeImage];
}

@end
