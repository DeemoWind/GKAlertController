//
//  GKBlurPresentationController.m
//  GKAlertController
//
//  Created by Apple on 16/2/2.
//  Copyright © 2016年 zhishu. All rights reserved.
//

#import "GKBlurPresentationController.h"

@interface GKBlurPresentationController ()

@property (nonatomic) UIView *dimmingView;

@end

@implementation GKBlurPresentationController

#pragma mark - getter and setter
- (UIView *)dimmingView {
    if (!_dimmingView) {
        _dimmingView = ({
            UIView *view = [[UIView alloc] initWithFrame:self.containerView.bounds];
            view.backgroundColor = [UIColor colorWithRed:1.0 green:0.0 blue:0.0 alpha:0.5];
            view.alpha = 0.0;
            view;
        });
    }
    return _dimmingView;
}

#pragma mark - override presentationTansition metod

- (void)presentationTransitionWillBegin {
    
    UIView *containerView = self.containerView;
    UIView *presentedView = self.presentedView;
    if (!containerView || !presentedView) {
        return;
    }
    
    //Add the dimming view and the presented view to the heirarchy
    self.dimmingView.frame = containerView.bounds;
    [containerView addSubview:self.dimmingView];
    [containerView addSubview:presentedView];
    
    //Fade in the dimming view alongside the transition
    
    id<UIViewControllerTransitionCoordinator> transitionCoordinator = self.presentedViewController.transitionCoordinator;
    
    if (transitionCoordinator) {
        [transitionCoordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {
            self.dimmingView.alpha = 1.0;
        } completion:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {
            
        }];
    }
    
}

- (void)presentationTransitionDidEnd:(BOOL)completed {
    //If the presitation didn't complete, remove the dimming view
    if (!completed) {
        [self.dimmingView removeFromSuperview];
    }
}

- (void)dismissalTransitionWillBegin {
    //Fade out the dimming view alongside the transition
    id<UIViewControllerTransitionCoordinator> transitionCoordinator = self.presentedViewController.transitionCoordinator;
    
    if (transitionCoordinator) {
        self.dimmingView.alpha = 0.0;
    }
}

- (void)dismissalTransitionDidEnd:(BOOL)completed {
    
    if (completed) {
        [self.dimmingView removeFromSuperview];
    }
}

- (CGRect)frameOfPresentedViewInContainerView {
    UIView *containerView = self.containerView;
    if (!containerView) {
        return CGRectZero;
    }
    
    //We don't want the presented view to fill the whole container view, so inset it's frame
    CGRect frame = containerView.bounds;
    frame = CGRectInset(frame, 50.0, 50.0);
    return frame;
}

#pragma mark - UIContentContainer protocol methods

- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator {
    [super viewWillTransitionToSize:size withTransitionCoordinator:coordinator];
    
    UIView *containerView = self.containerView;
    if (!containerView) {
        return;
    }
    
    [coordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {
        self.dimmingView.frame = containerView.bounds;
    } completion:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {
        
    }];
}
@end
