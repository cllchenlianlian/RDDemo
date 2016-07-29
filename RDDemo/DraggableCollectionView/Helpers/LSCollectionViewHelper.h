//
//  Copyright (c)  Luke Scott
//  https://github.com/lukescott/DraggableCollectionView
//  Distributed under MIT license
//

#import <UIKit/UIKit.h>

@interface LSCollectionViewHelper : NSObject <UIGestureRecognizerDelegate>

- (id)initWithCollectionView:(UICollectionView *)collectionView;

@property (nonatomic, readonly) UICollectionView *collectionView;
@property (nonatomic, readonly) UILongPressGestureRecognizer *longPressGestureRecognizer;
@property (nonatomic, readonly) UIPanGestureRecognizer *panPressGestureRecognizer;
@property (nonatomic, assign) UIEdgeInsets scrollingEdgeInsets;
@property (nonatomic, assign) CGFloat scrollingSpeed;
@property (nonatomic, assign) BOOL enabled;

@end
