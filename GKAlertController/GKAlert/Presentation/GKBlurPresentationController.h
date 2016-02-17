//
//  GKBlurPresentationController.h
//  GKAlertController
//
//  Created by Apple on 16/2/2.
//  Copyright © 2016年 zhishu. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GKBlurPresentationController;
@protocol GKBlurPresentationFrameDelegate <NSObject>

@required
- (BOOL)shouldCustomFrameOfPresentatedView;
@optional
- (CGRect)frameOfPresentedViewWithContainerView:(UIView *)containerView startingViewController:(UIViewController *)belowViewController;

@end

@interface GKBlurPresentationController : UIPresentationController

@property (nonatomic, weak) id<GKBlurPresentationFrameDelegate> delegateForFrame;

@end
