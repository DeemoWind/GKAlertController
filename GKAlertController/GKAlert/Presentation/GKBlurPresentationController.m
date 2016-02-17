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
@property (nonatomic) UIView *snapShotAboveDimmingView;

@end

@implementation GKBlurPresentationController

#pragma mark - getter and setter
- (UIView *)dimmingView {
    if (!_dimmingView) {
        _dimmingView = ({
            UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
//            UIVibrancyEffect *vibrancyEffect = [UIVibrancyEffect effectForBlurEffect:blurEffect];
            UIView * view = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
            view.frame = self.containerView.bounds;
            
//            view.backgroundColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.1];
//            view.alpha = 0.0;
            
            UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dealDismissTap:)];
            [view addGestureRecognizer:tapGesture];
            
            view;
            
        });
    }
    return _dimmingView;
}
- (UIView *)snapShotAboveDimmingView {
    if (!_snapShotAboveDimmingView) {
        _snapShotAboveDimmingView = ({
            UIView *view = [self.presentingViewController.view snapshotViewAfterScreenUpdates:NO];
            view;
        });
    }
    return _snapShotAboveDimmingView;
}


#pragma mark dismiss method in dimmingView getter 
- (void)dealDismissTap:(UITapGestureRecognizer*)tapGestureRecognizer {
    [self.presentingViewController dismissViewControllerAnimated:YES completion:^{
        
    }];
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
    [containerView addSubview:self.snapShotAboveDimmingView];
    [containerView addSubview:presentedView];
    
    //Fade in the dimming view alongside the transition
    
    id<UIViewControllerTransitionCoordinator> transitionCoordinator = self.presentingViewController.transitionCoordinator;
    
    if (transitionCoordinator) {
        [transitionCoordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {
//            self.dimmingView.alpha = 1.0;
            self.snapShotAboveDimmingView.alpha = 0.0;
            
        } completion:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {
            [self.snapShotAboveDimmingView setHidden:YES];
        }];
    }
    
}

- (void)presentationTransitionDidEnd:(BOOL)completed {
    
    //The presentation shoulde be completed as normal.
    //If the presentation didn't complete, remove the dimming view
    if (!completed) {
        [self.dimmingView removeFromSuperview];
        [self.snapShotAboveDimmingView removeFromSuperview];
    }
}

- (void)dismissalTransitionWillBegin {
    //Fade out the dimming view alongside the transition
    id<UIViewControllerTransitionCoordinator> transitionCoordinator = self.presentingViewController.transitionCoordinator;
    
    if (transitionCoordinator) {
        [transitionCoordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {
//            self.dimmingView.alpha = 0.0;
            [self.snapShotAboveDimmingView setHidden:NO];
            self.snapShotAboveDimmingView.alpha = 1.0;
        } completion:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {
            
        }];
    }
}

- (void)dismissalTransitionDidEnd:(BOOL)completed {
    
    if (completed) {
//        [self.dimmingView removeFromSuperview];
        [self.snapShotAboveDimmingView removeFromSuperview];
    }
}

- (CGRect)frameOfPresentedViewInContainerView {
    UIView *containerView = self.containerView;
    if (!containerView || !self.delegateForFrame || ![self.delegateForFrame respondsToSelector:@selector(frameOfPresentedViewWithContainerView:startingViewController:)]) {
        return CGRectZero;
    }
//    NSLog(@"%s -->> presentingViewController %@",__func__,self.presentingViewController);
    if ([self.delegateForFrame respondsToSelector:@selector(shouldCustomFrameOfPresentatedView)]) {
        if ([self.delegateForFrame shouldCustomFrameOfPresentatedView]) {
            return [self.delegateForFrame frameOfPresentedViewWithContainerView:containerView startingViewController:self.presentingViewController];
        }
    }
    
    
    //We don't want the presented view to fill the whole container view, so inset it's frame
    CGRect frame = containerView.bounds;
    frame = CGRectInset(frame, 50.0, 150.0);
    return frame;
//    return CGRectZero;
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
