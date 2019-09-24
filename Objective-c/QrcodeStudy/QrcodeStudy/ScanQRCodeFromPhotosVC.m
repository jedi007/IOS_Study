//
//  ScanQRCodeFromPhotosVC.m
//  QrcodeStudy
//
//  Created by 司开发 on 2019/9/24.
//  Copyright © 2019 李杰. All rights reserved.
//

#import "ScanQRCodeFromPhotosVC.h"

//播放声音
#import <AVFoundation/AVFoundation.h>


#define IOS8 ([[UIDevice currentDevice].systemVersion intValue] >= 8 ? YES : NO)

@interface ScanQRCodeFromPhotosVC ()<UIImagePickerControllerDelegate>

@property (strong, nonatomic) CIDetector *detector;

@property (weak, nonatomic) IBOutlet UIImageView *testImageView;

@end

@implementation ScanQRCodeFromPhotosVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


- (IBAction)longPressToScanPhoto:(UILongPressGestureRecognizer *)sender {
    
    
    
    NSLog(@"longPress received");
    
    UIImage *image = _testImageView.image;
    
    NSString* scanResult = [self getImageQRCod:image];
    NSLog(@"scanResult : %@",scanResult);
    UIAlertView * alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:[[NSString alloc] initWithFormat:@"解析成功，识别出的二维码是： %@",scanResult] delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alertView show];
}


#pragma mark - 从相册扫描二维码
- (IBAction)sacnFromphotos:(UIButton *)sender {
    self.detector = [CIDetector detectorOfType:CIDetectorTypeQRCode context:nil options:@{ CIDetectorAccuracy : CIDetectorAccuracyHigh }];
    
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
        //判断设备是否支持相册
        
        if (IOS8) {
            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"未开启访问相册权限，现在去开启！" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
            alert.tag = 4;
            [alert show];
        }
        else{
            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"设备不支持访问相册，请在设置->隐私->照片中进行设置！" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
        }
        
        return;
    }
    
    UIImagePickerController *mediaUI = [[UIImagePickerController alloc] init];
    mediaUI.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    mediaUI.mediaTypes = [UIImagePickerController         availableMediaTypesForSourceType:UIImagePickerControllerSourceTypeSavedPhotosAlbum];
    mediaUI.allowsEditing = NO;
    mediaUI.delegate = self;
    [self presentViewController:mediaUI animated:YES completion:^{
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:YES];
    }];
}


- (NSString *)getImageQRCod:(UIImage* )image
{
    CIDetector* detector2 = [CIDetector detectorOfType:CIDetectorTypeQRCode context:nil options:@{ CIDetectorAccuracy : CIDetectorAccuracyHigh }];
    NSArray *features = [detector2 featuresInImage:[CIImage imageWithCGImage:image.CGImage]];
    NSLog(@"features.count : %ld",features.count);
    if (features.count >=1) {
        
        CIQRCodeFeature *feature = [features objectAtIndex:0];
        NSString *scannedResult = feature.messageString;
        
        //音效
        SystemSoundID soundID;
        NSString *strSoundFile = [[NSBundle mainBundle] pathForResource:@"noticeMusic" ofType:@"wav"];
        AudioServicesCreateSystemSoundID((__bridge CFURLRef)[NSURL fileURLWithPath:strSoundFile],&soundID);
        AudioServicesPlaySystemSound(soundID);
        
        NSLog(@"scannedResult : %@",scannedResult);
        return scannedResult;
    }
    else{
        UIAlertView * alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:@"解析错误，请选择正确的二维码图片" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alertView show];
        return NULL;
    }
}


#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    
    UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
    if (!image){
        image = [info objectForKey:UIImagePickerControllerOriginalImage];
    }
    
    NSString* scannedResult = [self getImageQRCod:image];
    
    NSLog(@"scannedResult in imagePickerController cb: %@",scannedResult);
    
    [picker dismissViewControllerAnimated:YES completion:^{
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:YES];
    }];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:^{
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:YES];
    }];
    
}

@end
