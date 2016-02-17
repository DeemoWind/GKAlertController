//
//  GKPresentationAnimation.h
//  GKAlertController
//
//  Created by Apple on 16/2/3.
//  Copyright © 2016年 zhishu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GKPresentationAnimation : NSObject<UIViewControllerAnimatedTransitioning>
{
    
@protected
    BOOL _isPresenting;
    NSTimeInterval _duration;
    
@public
    
}

@property (nonatomic) BOOL isPresenting;
@property (nonatomic) NSTimeInterval duration;

- (instancetype)initWithIsPresenting:(BOOL)isPresenting duration:(CGFloat)duration;

@end
