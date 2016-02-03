//
//  GKPresentationAnimation.h
//  GKAlertController
//
//  Created by Apple on 16/2/2.
//  Copyright © 2016年 zhishu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GKPresentationAnimation : NSObject<UIViewControllerAnimatedTransitioning>

@property (nonatomic) BOOL isPresenting;
@property (nonatomic) NSTimeInterval duration;

- (instancetype)initWithIsPresenting:(BOOL)isPresenting duration:(CGFloat)duration;

@end
