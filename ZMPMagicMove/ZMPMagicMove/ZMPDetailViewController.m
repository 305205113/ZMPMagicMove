//
//  ZMPDetailViewController.m
//  ZMPMagicMove
//
//  Created by zmp1123 on 7/21/15.
//  Copyright (c) 2015 zmp1123. All rights reserved.
//

#import "ZMPDetailViewController.h"
#import "ZMPMagicMovePopTransion.h"

@interface ZMPDetailViewController ()<UINavigationControllerDelegate>{
    UIPercentDrivenInteractiveTransition *percentDrivenTransition;
    ZMPMagicMovePopTransion *magicMovePopTransion;
}

@end

@implementation ZMPDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    magicMovePopTransion = [[ZMPMagicMovePopTransion alloc] init];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    self.navigationController.delegate = self;
    
    //手势监听器
    UIScreenEdgePanGestureRecognizer *edgePan = [[UIScreenEdgePanGestureRecognizer alloc] initWithTarget:self action:@selector(edgePanGesture:)];
    edgePan.edges = UIRectEdgeLeft;
    [self.view addGestureRecognizer:edgePan];
    
}

- (void)edgePanGesture:(UIScreenEdgePanGestureRecognizer *)edgePan{
    CGFloat progress = [edgePan translationInView:self.view].x / self.view.bounds.size.width;
    if (edgePan.state == UIGestureRecognizerStateBegan) {
        percentDrivenTransition = [[UIPercentDrivenInteractiveTransition alloc] init];
        [self.navigationController popViewControllerAnimated:YES];
    }else if (edgePan.state == UIGestureRecognizerStateChanged){
        [percentDrivenTransition updateInteractiveTransition:progress];
    }else if (edgePan.state == UIGestureRecognizerStateEnded){
        if (progress > 0.5) {
            [percentDrivenTransition finishInteractiveTransition];
        }else{
            [percentDrivenTransition cancelInteractiveTransition];
        }
        percentDrivenTransition = nil;
    }
}

- (id)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC{
    
    if (operation == UINavigationControllerOperationPop) {
        return magicMovePopTransion;
    }else{
        return nil;
    }
}

- (id)navigationController:(UINavigationController *)navigationController interactionControllerForAnimationController:(id<UIViewControllerAnimatedTransitioning>)animationController{
    if ([animationController isEqual:magicMovePopTransion]) {
        return percentDrivenTransition;
    }else{
        return nil;
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
