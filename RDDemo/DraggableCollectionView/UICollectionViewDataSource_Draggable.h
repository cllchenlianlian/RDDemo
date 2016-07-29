//
//  ViewController.h
//  RDDemo
//
//  Created by 陈莲莲 on 16/7/27.
//  Copyright © 2016年 cll. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IndexPathImageView.h"

@class LSCollectionViewHelper;

@protocol UICollectionViewDataSource_Draggable <UICollectionViewDataSource>
@required

- (BOOL)collectionView:(UICollectionView *)collectionView moveItemAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath;
- (BOOL)collectionView:(UICollectionView *)collectionView canMoveItemAtIndexPath:(NSIndexPath *)indexPath;

@optional

- (BOOL)collectionView:(UICollectionView *)collectionView canMoveItemAtIndexPath:(NSIndexPath *)indexPath toIndexPath:(NSIndexPath *)toIndexPath;
- (void)collectionView:(UICollectionView *)collectionView didMoveItemAtIndexPath:(NSIndexPath *)indexPath toIndexPath:(NSIndexPath *)toIndexPath;

- (void)collectionView:(UICollectionView *)collectionView startMoveItemAtIndexPath:(NSIndexPath *)indexPath;

- (BOOL)collectionView:(UICollectionView *)collectionView movingItemAtIndexPath:(NSIndexPath *)indexPath currentLoction:(CGPoint)point withMovingCell:(IndexPathImageView*)cell;

- (void)collectionView:(UICollectionView *)collectionView endMoveItemAtIndexPath:(NSIndexPath *)indexPath withMovingCell:(IndexPathImageView*)cell;



@end
