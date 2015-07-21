//
//  ZMPMagicMoveTransion.h
//  ZMPMagicMove
//
//  Created by zmp1123 on 7/21/15.
//  Copyright (c) 2015 zmp1123. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ZMPMagicMoveTransion : NSObject<UIViewControllerAnimatedTransitioning>

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext;

@end
