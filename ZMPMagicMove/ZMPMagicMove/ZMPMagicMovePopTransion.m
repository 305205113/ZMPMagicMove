//
//  ZMPMagicMovePopTransion.m
//  ZMPMagicMove
//
//  Created by zmp1123 on 7/21/15.
//  Copyright (c) 2015 zmp1123. All rights reserved.
//

#import "ZMPMagicMovePopTransion.h"
#import "ViewController.h"
#import "ZMPDetailViewController.h"

@implementation ZMPMagicMovePopTransion

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext{
    return 0.5;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext{

    ZMPDetailViewController *fromVC = (ZMPDetailViewController *)[transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    ViewController *toVC = (ViewController *)[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    UIView *container = [transitionContext containerView];
    
    UIView *snapshotView = [fromVC.avatarImageView snapshotViewAfterScreenUpdates:false];
    snapshotView.frame = [container convertRect:fromVC.avatarImageView.frame fromView:fromVC.view];
    fromVC.avatarImageView.hidden = YES;
    
    toVC.view.frame = [transitionContext finalFrameForViewController:toVC];
    toVC.selectedCell.imageView.hidden = YES;
    
    [container insertSubview:toVC.view belowSubview:fromVC.view];
    [container addSubview:snapshotView];
    
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext] delay:0 options:UIViewAnimationOptionCurveEaseInOut  animations:^{
        snapshotView.frame = [container convertRect:toVC.selectedCell.imageView.frame fromView:toVC.selectedCell];
        fromVC.view.alpha = 0;
    } completion:^(BOOL finished) {
        toVC.selectedCell.imageView.hidden = NO;
        [snapshotView removeFromSuperview];
        fromVC.avatarImageView.hidden = NO;
        
        [transitionContext completeTransition:(![transitionContext transitionWasCancelled])];
    }];
    
    
}

@end
