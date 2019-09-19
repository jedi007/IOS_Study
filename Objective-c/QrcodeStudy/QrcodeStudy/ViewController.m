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

@property (weak, nonatomic) IBOutlet UITextField *TextField_inputString;
@property (nonatomic) CGRect originalFrame;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //点击页面收起键盘
    self.view.userInteractionEnabled = YES;
    UITapGestureRecognizer *sTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(fingerTapped:)];
    [self.view addGestureRecognizer:sTap];
    
    //注册键盘出现的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    //注册键盘消失的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
    _originalFrame = self.view.frame;
}


-(void)fingerTapped:(UITapGestureRecognizer *)gestureRecognizer
{
    [self.view endEditing:YES];
}


- (void) viewWillDisappear:(BOOL)animated
{
    //解除键盘出现通知
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardDidShowNotification object:nil];
    
    //解除键盘隐藏通知
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardDidHideNotification object:nil];
    
    [super viewWillDisappear:animated];
}


//键盘显示事件
- (void) keyboardWillShow:(NSNotification *)notification
{
    //获取键盘高度，在不同设备上，以及中英文下是不同的
    CGFloat kbHeight = [[notification.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size.height;
    
    // 取得键盘的动画时间，这样可以在视图上移的时候更连贯
    double duration = [[notification.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    [UIView animateWithDuration:duration animations:^{
        self.view.frame = CGRectMake(0.0f, -200, self->_originalFrame.size.width, self->_originalFrame.size.height);
    }];
}

//键盘消失事件
- (void) keyboardWillHide:(NSNotification *)notify {
    double duration = [[notify.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    //视图下沉恢复原状
    [UIView animateWithDuration:duration animations:^{
        self.view.frame = self->_originalFrame;
    }];
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
    NSString *dataString = _TextField_inputString.text;//@"D1B119140067";
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
