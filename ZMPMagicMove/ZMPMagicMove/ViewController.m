//
//  ViewController.m
//  ZMPMagicMove
//
//  Created by zmp1123 on 7/21/15.
//  Copyright (c) 2015 zmp1123. All rights reserved.
//

#import "ViewController.h"
#import "ZMPDetailViewController.h"
#import "ZMPCollectionViewCell.h"
#import "ZMPMagicMoveTransion.h"
#import "ZMPMagicMovePopTransion.h"

@interface ViewController ()<UINavigationControllerDelegate,UICollectionViewDelegate,UICollectionViewDataSource>{
    ZMPMagicMoveTransion *magicMoveTransion;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    magicMoveTransion = [[ZMPMagicMoveTransion alloc] init];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    self.navigationController.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (id)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC{

    if (operation == UINavigationControllerOperationPush) {
        return magicMoveTransion;
    }else{
        return nil;
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString:@"detail"]) {
        ZMPDetailViewController *detailVC = segue.destinationViewController;
        detailVC.image = _selectedCell.imageView.image;
    }
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 10;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    ZMPCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cardcell" forIndexPath:indexPath];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    _selectedCell = (ZMPCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];

    [self performSegueWithIdentifier:@"detail" sender:nil];
}


@end
