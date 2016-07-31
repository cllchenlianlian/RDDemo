//
//  ViewController.m
//  RDDemo
//
//  Created by 陈莲莲 on 16/7/27.
//  Copyright © 2016年 cll. All rights reserved.
//

#import "ViewController.h"
#import "UICollectionView+Draggable.h"
#import "DraggableCollectionViewFlowLayout.h"
#import "CollectionViewCell.h"

@interface ViewController ()<UICollectionViewDelegate,UICollectionViewDataSource_Draggable,UICollectionViewDelegateFlowLayout>
{
    UIView *trashView;
    BOOL    isMoving;
    BOOL    shouldDelegate;
    NSIndexPath *shouldDelegateIndexPath;
}

@property (strong, nonatomic) UICollectionView *collectionView;
@property (strong, nonatomic) NSMutableArray   *dataArray;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    DraggableCollectionViewFlowLayout *flowLayout   = [[DraggableCollectionViewFlowLayout alloc]init];
    CGFloat sizeWidth                               = ([UIScreen mainScreen].bounds.size.width - 4*10)/3;
    flowLayout.itemSize                             = CGSizeMake(sizeWidth, sizeWidth*1.4);
    flowLayout.sectionInset                         = UIEdgeInsetsMake(0, 10, 0, 10);
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    
    self.collectionView                             = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) collectionViewLayout:flowLayout];
    self.collectionView.backgroundColor             = [UIColor clearColor];
    self.collectionView.delegate                    = self;
    self.collectionView.dataSource                  = self;
    self.collectionView.draggable                   = YES;
    self.collectionView.alwaysBounceVertical        = YES;

    [self.collectionView registerClass:[CollectionViewCell class] forCellWithReuseIdentifier:@"CollectionViewCell"];
    [self.view addSubview:self.collectionView];
    
    self.dataArray = [NSMutableArray arrayWithObjects:@"2.png",@"4.png",@"5.png",@"6.png",@"3.png",@"7.png",@"8.png",@"9.png",@"10.png", nil];
    
    [self initTrashView];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"CollectionViewCell";
    CollectionViewCell *cell        = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    cell.imageView.image            = [UIImage imageNamed:[NSString stringWithFormat:@"%@",self.dataArray[indexPath.row]]];
    return cell;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canMoveItemAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canMoveItemAtIndexPath:(NSIndexPath *)indexPath toIndexPath:(NSIndexPath *)toIndexPath{
    return YES;
}

- (void)collectionView:(UICollectionView *)collectionView startMoveItemAtIndexPath:(NSIndexPath *)indexPath{
    isMoving = YES;
    [self showTrashView];
}

- (BOOL)collectionView:(UICollectionView *)collectionView movingItemAtIndexPath:(NSIndexPath *)indexPath currentLoction:(CGPoint)point withMovingCell:(IndexPathImageView*)cell{
    
    point = CGPointMake(point.x, point.y);
    CGPoint apoint = [self.view convertPoint:point fromView:self.collectionView];
    if (CGRectContainsPoint(CGRectMake(-CGRectGetWidth(cell.bounds) , (CGRectGetMinY(trashView.frame) - (CGRectGetHeight(cell.bounds)) / 2.0), CGRectGetWidth(trashView.bounds) + CGRectGetWidth(cell.bounds), (CGRectGetHeight(cell.bounds))  + CGRectGetHeight(trashView.bounds)), apoint)) {
        shouldDelegate              = YES;
        trashView.backgroundColor   = [UIColor redColor];
        trashView.transform         = CGAffineTransformMakeScale(1.3f, 1.3f);
        trashView.alpha             = 0.3;
        shouldDelegateIndexPath     = indexPath;
    }else{
        trashView.backgroundColor   = [UIColor blackColor];
        trashView.transform         = CGAffineTransformMakeScale(1.0f, 1.0f);
        trashView.alpha             = 0.6;
        shouldDelegate              = NO;
        shouldDelegateIndexPath     = nil;
    }
    return YES;
}

- (BOOL)collectionView:(UICollectionView *)collectionView moveItemAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath{

    if (self.dataArray.count <= fromIndexPath.item || self.dataArray.count <= toIndexPath.item) {
        [self hideTrashView];
        shouldDelegate              = NO;
        shouldDelegateIndexPath     = nil;
        isMoving                    = NO;
        return NO;
    }
    
    //删除图片
    if (shouldDelegate && shouldDelegateIndexPath.item == fromIndexPath.item) {
        trashView.backgroundColor   = [UIColor blackColor];
        trashView.transform         = CGAffineTransformMakeScale(1.0f, 1.0f);
        trashView.alpha             = 0.6;
       
        [self.dataArray removeObjectAtIndex:fromIndexPath.item];
        [self hideTrashView];
        [self resetCollectionView];
        shouldDelegate              = NO;
        shouldDelegateIndexPath     = nil;
        isMoving                    = NO;
        return NO;
    }
    
    //交换图片位置
    [self hideTrashView];
    NSString *index                 = [self.dataArray objectAtIndex:fromIndexPath.item];
    [self.dataArray removeObjectAtIndex:fromIndexPath.item];
    [self.dataArray insertObject:index atIndex:toIndexPath.item];
    [self resetCollectionView];
    isMoving                        = NO;
    return YES;
}

- (void)initTrashView{
    trashView                       = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(self.view.bounds) / 2.0, 55, 55)];
    trashView.backgroundColor       = [UIColor blackColor];
    trashView.alpha                 = 0.6;
    UIImageView *trashImage         = [[UIImageView alloc] initWithFrame:trashView.bounds];
    trashImage.image                = [UIImage imageNamed:@"trash.png"];
    [trashView addSubview:trashImage];
    [self.view addSubview:trashView];
    trashView.hidden                = YES;
}

- (void)hideTrashView{
    
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        trashView.frame             = CGRectMake(-55, CGRectGetHeight(self.view.bounds) / 2.0, 55, 55);
    } completion:^(BOOL finished) {
        trashView.hidden            = YES;
    }];

}

- (void)showTrashView{
    trashView.hidden                = NO;
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        trashView.frame             = CGRectMake(0, CGRectGetHeight(self.view.bounds) / 2.0, 55, 55);
    } completion:^(BOOL finished) {
    }];
}

- (void)resetCollectionView{
    
    self.collectionView.frame       = CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds));
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.collectionView reloadData];
    });
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
