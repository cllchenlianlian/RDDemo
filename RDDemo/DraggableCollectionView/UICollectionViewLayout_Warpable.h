//
//  ViewController.h
//  RDDemo
//
//  Created by 陈莲莲 on 16/7/27.
//  Copyright © 2016年 cll. All rights reserved.
//

#import <Foundation/Foundation.h>

@class LSCollectionViewLayoutHelper;

@protocol UICollectionViewLayout_Warpable <NSObject>
@required

@property (readonly, nonatomic) LSCollectionViewLayoutHelper *layoutHelper;

@end
