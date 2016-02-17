//
//  GKLeftSideMenuPresentationAnimation.m
//  GKAlertController
//
//  Created by Apple on 16/2/17.
//  Copyright © 2016年 zhishu. All rights reserved.
//

#import "GKLeftSideMenuPresentationAnimation.h"

@implementation GKLeftSideMenuPresentationAnimation

- (void) gk_animatePresentationWithTransitionContext:(id<UIViewControllerContextTransitioning>)transitionContext {
    UIViewController *presentedController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView * presentedControllerView = [transitionContext viewForKey:UITransitionContextToViewKey];
    UIView * containerView = [transitionContext containerView];
    
    if (!presentedControllerView || !containerView) {
        return;
    }
    
    //Position the presented view off the left of the container view
    presentedControllerView.frame = [transitionContext finalFrameForViewController:presentedController];
    
    CGFloat tempCenterX = presentedControllerView.center.x;
    tempCenterX -= containerView.bounds.size.width;
    presentedControllerView.center = CGPointMake(tempCenterX, presentedControllerView.center.y);
    
    [containerView addSubview:presentedControllerView];
    
    [UIView animateWithDuration:self.duration
                          delay:0.0
         usingSpringWithDamping:1.0
          initialSpringVelocity:0.0
                        options:UIViewAnimationOptionAllowUserInteraction
                     animations:^{
                         CGFloat tempCenterX = presentedControllerView.center.x;
                         tempCenterX += containerView.bounds.size.width;
                         presentedControllerView.center = CGPointMake(tempCenterX, presentedControllerView.center.y);
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
    
    //Animate the presented view off the right of the view
    [UIView animateWithDuration:self.duration
                          delay:0.0
         usingSpringWithDamping:1.0
          initialSpringVelocity:0.0
                        options:UIViewAnimationOptionAllowUserInteraction
                     animations:^{
                         CGFloat tempCenterX = presentedControllerView.center.x;
                         tempCenterX -= containerView.bounds.size.width;
                         presentedControllerView.center = CGPointMake(tempCenterX, presentedControllerView.center.y);
                     }
                     completion:^(BOOL finished) {
                         [transitionContext completeTransition:finished];
                     }];
}

@end
