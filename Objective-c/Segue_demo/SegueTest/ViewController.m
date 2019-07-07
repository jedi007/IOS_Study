//
//  ViewController.m
//  SegueTest
//
//  Created by csdc-iMac on 15/8/13.
//  Copyright (c) 2015年 csdc. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    NSLog(@"prepareForSegue is called");
    
    // 将page2变量设为segue所跳转的界面控制器
    Page2ViewController* page2 = segue.destinationViewController;
    // 对page2中的变量设置值
    [page2 setValue:self.textField.text forKey:@"string"];
    
    // 设定委托为self
    page2.delegate = self;
    //[page2 setValue:self forKey:@"delegate"];
}

- (void)passValue:(NSString *)value {
    // 设定编辑框内容为协议传过来的值
    self.textField.text = value;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//通过代码使用segue跳转到page2，prepareForSegue之后仍然会被调用
- (IBAction)goSecondPageInWay2:(id)sender {
    NSLog(@"goSecondPageInWay2 is called");
    [self performSegueWithIdentifier:@"goSecondPageSegueID" sender:self];
}

//在跳转到page2前，可以在这做一些逻辑判断
-(BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender
{
    NSLog(@"shouldPerformSegueWithIdentifier is called, identifier is %@",identifier);
    int test = 2;
    if( test == 1)
        return YES;
    else
        return NO;//开始不允许跳转，只有当验证账号和密码正确可以进入后由登录代码执行切换
}

/*
    1. unwind 方法。添加上该方法后，其他Viewcontroller就可以拖拽btn链接到exit来跳转到该viewcontroller。
    2. 该方式可以实现在a->b->c->d结构的segue直接从d跳转回a,中间的b、c会自动释放掉
*/
/* Objective-C */
- (IBAction)unwindToThisViewController:(UIStoryboardSegue*)sender
{
    UIViewController *sourceViewController = sender.sourceViewController;
    // Pull any data from the view controller which initiated the unwind segue.
    
    //unwind方式跳转回来的可通过这种方式传值
    Page2ViewController* p2 = sender.sourceViewController;
    NSLog(@"p2 string: %@",p2.string);
    //该函数执行后，按栈顺序依次，先释放page3，然后释放page2
}

/* Swift */
//@IBAction func unwindToThisViewController(sender: UIStoryboardSegue)
//{
//    let sourceViewController = sender.sourceViewController
//    // Pull any data from the view controller which initiated the unwind segue.
//}
@end
