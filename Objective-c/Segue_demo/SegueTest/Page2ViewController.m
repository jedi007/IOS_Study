//
//  Page2ViewController.m
//  SegueTest
//
//  Created by csdc-iMac on 15/8/13.
//  Copyright (c) 2015年 csdc. All rights reserved.
//

#import "Page2ViewController.h"

@interface Page2ViewController ()

@end

@implementation Page2ViewController

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if(self)
    {
        NSLog(@"Page2ViewController initWithCoder");
    }
    return self;
}

- (id)init
{
    self = [super init];
    if(self)
    {
        NSLog(@"Page2ViewController init");
    }
    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibNameOrNil];
    if(self)
    {
        NSLog(@"Page2ViewController initWithNibName");
    }
    return self;
}

- (void)dealloc
{
    NSLog(@"Page2ViewController dealloc");
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.textField.text = self.string;
}

- (IBAction)toPage1:(id)sender {
    NSLog(@"toPage1 is called");
    [self dismissViewControllerAnimated:YES completion:^{}];
    
    // 呼叫协议中的方法并带入编辑框中的值
    [self.delegate passValue:self.textField.text];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)UnwindToMainMenu:(id)sender {
    NSLog(@"UnwindToMainMenu is called in page2");
    _string = @"p2 message to main";
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
