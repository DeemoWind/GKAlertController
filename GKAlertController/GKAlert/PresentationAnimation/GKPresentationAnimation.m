//
//  GKPresentationAnimation.m
//  GKAlertController
//
//  Created by Apple on 16/2/3.
//  Copyright © 2016年 zhishu. All rights reserved.
//

#import "GKPresentationAnimation.h"

@protocol gkPresentationProtectProtocol <NSObject>

- (void) gk_animatePresentationWithTransitionContext:(id<UIViewControllerContextTransitioning>)transitionContext;
- (void) gk_animateDismissalWithTransitionContext:(id<UIViewControllerContextTransitioning>)transitionContext;

@end

@interface GKPresentationAnimation ()<gkPresentationProtectProtocol>

@end

@implementation GKPresentationAnimation

#pragma mark - initMethods
- (instancetype)init {
    self = [super init];
    if (self) {
        _isPresenting = NO;
        _duration = 0.5f;
        
    }
    return self;
}
- (instancetype)initWithIsPresenting:(BOOL)isPresenting duration:(CGFloat)duration {
    self = [super init];
    if (self) {
        _isPresenting = isPresenting;
        _duration = duration;
    }
    return self;
}

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return self.duration;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    if (_isPresenting) {
        [self gk_animatePresentationWithTransitionContext:transitionContext];
    }
    else {
        [self gk_animateDismissalWithTransitionContext:transitionContext];
    }
}

#pragma mark - Helper methods
- (void) gk_animatePresentationWithTransitionContext:(id<UIViewControllerContextTransitioning>)transitionContext {
    NSLog(@"___%s___\nSubClass should implementation this method for presentation animation!",__func__);
}
- (void) gk_animateDismissalWithTransitionContext:(id<UIViewControllerContextTransitioning>)transitionContext {
    NSLog(@"___%s___\nSubClass should implementation this method for dissmissal animation!",__func__);
}

#pragma mark - Helper method
@end
