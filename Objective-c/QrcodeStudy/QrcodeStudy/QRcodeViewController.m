//
//  QRcodeViewController.m
//  QrcodeStudy
//
//  Created by 司开发 on 2019/9/23.
//  Copyright © 2019 李杰. All rights reserved.
//

#import "QRcodeViewController.h"

#import "QRCode/QRCodeReaderView.h"

#define DeviceMaxHeight ([UIScreen mainScreen].bounds.size.height)
#define DeviceMaxWidth ([UIScreen mainScreen].bounds.size.width)
#define widthRate DeviceMaxWidth/320
#define IOS8 ([[UIDevice currentDevice].systemVersion intValue] >= 8 ? YES : NO)


@interface QRcodeViewController ()<QRCodeReaderViewDelegate>
{
    QRCodeReaderView * readview;//二维码扫描对象
}
@property (weak, nonatomic) IBOutlet UIBarButtonItem *exitBtn;


@end

@implementation QRcodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    readview = [[QRCodeReaderView alloc]initWithFrame:CGRectMake(0, 0, DeviceMaxWidth, DeviceMaxHeight)];
    readview.delegate = self;
    [self.view addSubview:readview];
    
    NSLog(@"create readview");
    [readview start];
}


- (IBAction)exitBtnClicked:(UIBarButtonItem *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (void)reStartScan
{
    [readview start];
}


#pragma mark -QRCodeReaderViewDelegate
- (void)readerScanResult:(NSString *)result
{
    NSLog(@"receive result : %@",result);
    
    [readview stop];
    
    //for test
    [self performSelector:@selector(reStartScan) withObject:nil afterDelay:3.0];
}

@end
