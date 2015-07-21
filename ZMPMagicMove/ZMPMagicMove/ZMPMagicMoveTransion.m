//
//  ZMPMagicMoveTransion.m
//  ZMPMagicMove
//
//  Created by zmp1123 on 7/21/15.
//  Copyright (c) 2015 zmp1123. All rights reserved.
//

#import "ZMPMagicMoveTransion.h"
#import "ViewController.h"
#import "ZMPDetailViewController.h"

@implementation ZMPMagicMoveTransion

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext{
    return 0.5;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext{
    //1、获取动画的源控制器和目标控制器
    ViewController *fromVC = (ViewController *)[transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    ZMPDetailViewController *toVC = (ZMPDetailViewController *)[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    UIView *container = [transitionContext containerView];
    
    //2、创建一个Cell中imageView的截图，并把imageView隐藏，造成使用户以为移动的就是 imageView 的假象
    UIView *snapshotView = [fromVC.selectedCell.imageView snapshotViewAfterScreenUpdates:false];
    snapshotView.frame = [container convertRect:fromVC.selectedCell.imageView.frame fromView:fromVC.selectedCell];
    fromVC.selectedCell.imageView.hidden = YES;
    
    //3.设置目标控制器的位置，并把透明度设为0，在后面的动画中慢慢显示出来变为1
    toVC.view.frame = [transitionContext finalFrameForViewController:toVC];
    toVC.view.alpha = 0;
    toVC.avatarImageView.hidden = YES;
    
    //4.都添加到 container 中。注意顺序不能错了
    [container addSubview:toVC.view];
    [container addSubview:snapshotView];
    
    //5.执行动画
    /*
     这时avatarImageView.frame的值只是跟在IB中一样的，
     如果换成屏幕尺寸不同的模拟器运行时avatarImageView会先移动到IB中的frame,动画结束后才会突然变成正确的frame。
     所以需要在动画执行前执行一次toVC.avatarImageView.layoutIfNeeded() update一次frame
     */
    [toVC.avatarImageView layoutIfNeeded];
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext] delay:0 options:UIViewAnimationOptionCurveEaseInOut  animations:^{
        snapshotView.frame = toVC.avatarImageView.frame;
        toVC.view.alpha = 1;
    } completion:^(BOOL finished) {
        toVC.avatarImageView.hidden = NO;
        fromVC.selectedCell.imageView.hidden = NO;
        toVC.avatarImageView.image = toVC.image;
        [snapshotView removeFromSuperview];
        
        [transitionContext completeTransition:YES];
    }];

    
}

@end
