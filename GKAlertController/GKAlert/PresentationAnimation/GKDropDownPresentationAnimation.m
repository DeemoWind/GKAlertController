//
//  GKPresentationAnimation.m
//  GKAlertController
//
//  Created by Apple on 16/2/2.
//  Copyright © 2016年 zhishu. All rights reserved.
//

#import "GKDropDownPresentationAnimation.h"

@implementation GKDropDownPresentationAnimation



#pragma mark - UIViewControllerAnimatedTransitioning protocol method
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
// This is a convenience and if implemented will be invoked by the system when the transition context's completeTransition: method is invoked.
//- (void)animationEnded:(BOOL) transitionCompleted;

#pragma mark - Helper methods
- (void) gk_animatePresentationWithTransitionContext:(id<UIViewControllerContextTransitioning>)transitionContext {
    UIViewController *presentedController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView * presentedControllerView = [transitionContext viewForKey:UITransitionContextToViewKey];
    UIView * containerView = [transitionContext containerView];
    
    if (!presentedControllerView || !containerView) {
        return;
    }
    
    //Position the presented view off the top of the container view
    presentedControllerView.frame = [transitionContext finalFrameForViewController:presentedController];
    
    CGFloat tempCenterY = presentedControllerView.center.y;
    tempCenterY -= containerView.bounds.size.height;
    presentedControllerView.center = CGPointMake(presentedControllerView.center.x, tempCenterY);
    
    [containerView addSubview:presentedControllerView];
    
    [UIView animateWithDuration:self.duration
                          delay:0.0
         usingSpringWithDamping:1.0
          initialSpringVelocity:0.0
                        options:UIViewAnimationOptionAllowUserInteraction
                     animations:^{
                         CGFloat tempCenterY = presentedControllerView.center.y;
                         tempCenterY += containerView.bounds.size.height;
                         presentedControllerView.center = CGPointMake(presentedControllerView.center.x, tempCenterY);
                     }
                     completion:^(BOOL finished) {
                         [transitionContext completeTransition:finished];
                     }];
    
    
}

- (void) gk_animateDismissalWithTransitionContext:(id<UIViewControllerContextTransitioning>)transitionContext {
    UIView *presentedControllerView = [transitionContext viewForKey:UITransitionContextFromViewKey];
    UIView *containerView = [transitionContext containerView];
    
    //在此，UITransitionContextToViewKey 为 null 因为这是dismiss的过程
    if (!presentedControllerView || !containerView) {
        return;
    }

    //Animate the presented view off the bottom of the view
    [UIView animateWithDuration:self.duration
                          delay:0.0
         usingSpringWithDamping:1.0
          initialSpringVelocity:0.0
                        options:UIViewAnimationOptionAllowUserInteraction
                     animations:^{
                         CGFloat tempCenterY = presentedControllerView.center.y;
                         tempCenterY += containerView.bounds.size.height;
                         presentedControllerView.center = CGPointMake(presentedControllerView.center.x, tempCenterY);
                     }
                     completion:^(BOOL finished) {
                         [transitionContext completeTransition:finished];
    }];
}

@end
