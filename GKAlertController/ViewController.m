//
//  ViewController.m
//  GKAlertController
//
//  Created by Apple on 16/2/1.
//  Copyright © 2016年 zhishu. All rights reserved.
//

#import "ViewController.h"
#import "GKAlertViewController.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    [self.view addSubview:imageView];
    imageView.image = [UIImage imageNamed:@"手机界面图"];
    
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(50, 100, 100, 44);
    
    [self.view addSubview:button];
    
    [button setTitle:@"alertView" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(alertGKAlertView) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)alertGKAlertView {
//    UIVisualEffect *visualEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
//    UIVisualEffectView *visualEffectView = [[UIVisualEffectView alloc] initWithEffect:visualEffect];
//    
//    visualEffectView.frame = self.view.bounds;
//    
//    [self.view addSubview:visualEffectView];

    GKAlertViewController * gkAlert = [GKAlertViewController alertControllerWithTitle:@"haha" message:@"hah" preferredStyle:UIAlertControllerStyleActionSheet];
    
    [gkAlert addAction:[UIAlertAction actionWithTitle:@"test1" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//        [visualEffectView removeFromSuperview];
    }]];
    
    [gkAlert addAction:[UIAlertAction actionWithTitle:@"TEST2" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
//        [visualEffectView removeFromSuperview];
    }]];
    
    [self presentViewController:gkAlert animated:YES completion:^{
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
