//
//  Page3ViewController.m
//  SegueTest
//
//  Created by 司开发 on 2019/7/7.
//  Copyright © 2019 csdc. All rights reserved.
//

#import "Page3ViewController.h"

@interface Page3ViewController ()

@end

@implementation Page3ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)dealloc
{
    NSLog(@"Page3ViewController dealloc");
}

//unwind方式直接返回page1，page3和中间的page2都会被自动释放
- (IBAction)UnwindToMainMenu:(id)sender {
    NSLog(@"UnwindToMainMenu is called in page3");
    _string = @"p3 message to main";
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
