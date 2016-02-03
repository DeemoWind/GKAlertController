//
//  GKAlertViewController.m
//  GKAlertController
//
//  Created by Apple on 16/2/1.
//  Copyright © 2016年 zhishu. All rights reserved.
//

#import "GKAlertViewController.h"
#import "GKBlurPresentationController.h"
#import "GKPresentationAnimation.h"

@interface GKAlertViewController ()

@end

@implementation GKAlertViewController

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self commonInit];
    }
    return self;
}
- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self commonInit];
    }
    return self;
}
//- (instancetype)init {
//    self = [super init];
//    if (self) {
//        [self commonInit];
//    }
//    return self;
//}

- (void)commonInit {
    self.modalPresentationStyle = UIModalPresentationCustom;
    self.transitioningDelegate = self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIButton * testButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:testButton];
    testButton.frame = CGRectMake(0, 0, 100, 44);
    testButton.backgroundColor = [UIColor brownColor];
    [testButton addTarget:self action:@selector(dealTestButton:) forControlEvents:UIControlEventTouchUpInside];
    
    self.view.backgroundColor = [UIColor cyanColor];
}

- (void)dealTestButton:(UIButton *)button {
    [self.presentingViewController dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UIViewControllerTransitioningDelegate methods
- (UIPresentationController *)presentationControllerForPresentedViewController:(UIViewController *)presented
                                                      presentingViewController:(UIViewController *)presenting
                                                          sourceViewController:(UIViewController *)source {
    if (presented == self) {
        return [[GKBlurPresentationController alloc] initWithPresentedViewController:presented presentingViewController:presenting];
    }
    return nil;
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    if (presented == self) {
        return [[GKPresentationAnimation alloc] initWithIsPresenting:YES duration:0.5f];
    }
    return nil;
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    if (dismissed == self) {
        return [[GKPresentationAnimation alloc] initWithIsPresenting:NO duration:0.5f];
    }
    return nil;
}

@end
