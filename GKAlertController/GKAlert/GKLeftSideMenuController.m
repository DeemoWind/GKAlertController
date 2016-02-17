//
//  GKLeftSideMenuController.m
//  GKAlertController
//
//  Created by Apple on 16/2/17.
//  Copyright © 2016年 zhishu. All rights reserved.
//

#import "GKLeftSideMenuController.h"
#import "GKBlurPresentationController.h"
#import "GKLeftSideMenuPresentationAnimation.h"

@interface GKLeftSideMenuController ()<GKBlurPresentationFrameDelegate>

@end

@implementation GKLeftSideMenuController

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
        return ({
            GKBlurPresentationController *presentationVC = [[GKBlurPresentationController alloc] initWithPresentedViewController:presented
                                                                                                        presentingViewController:presenting];
            presentationVC.delegateForFrame = self;
            
            presentationVC;
        });
    }
    return nil;
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    if (presented == self) {
        return [[GKLeftSideMenuPresentationAnimation alloc] initWithIsPresenting:YES duration:0.5f];
    }
    return nil;
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    if (dismissed == self) {
        return [[GKLeftSideMenuPresentationAnimation alloc] initWithIsPresenting:NO duration:0.5f];
    }
    return nil;
}
#pragma mark - GKBlurPresentationFrameDelegate
- (BOOL)shouldCustomFrameOfPresentatedView {
    return YES;
}
- (CGRect)frameOfPresentedViewWithContainerView:(UIView *)containerView startingViewController:(UIViewController *)belowViewController {
    CGRect frame = containerView.bounds;
    CGFloat x = frame.origin.x;
    CGFloat y = frame.origin.y;
    CGFloat width = frame.size.width;
    CGFloat height = frame.size.height;
    
    width *= 0.8;
    
    return CGRectMake(x, y, width, height);
}
@end
