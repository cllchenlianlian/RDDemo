//
//  CollectionViewCell.m
//  RDDemo
//
//  Created by 陈莲莲 on 16/7/27.
//  Copyright © 2016年 cll. All rights reserved.
//

#import "CollectionViewCell.h"


@implementation CollectionViewCell

- (void)awakeFromNib {
    
    [super awakeFromNib];
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.imageView                  = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        self.imageView.backgroundColor  = [UIColor clearColor];
        [self addSubview:self.imageView];
        
    }
    return self;
}

@end
