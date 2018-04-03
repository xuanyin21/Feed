//
//  ImageViewWithSpinner.m
//  Feed
//
//  Created by Xuan Yin on 4/1/18.
//  Copyright © 2018 Shawn Yin. All rights reserved.
//

#import "ImageViewWithSpinner.h"

@implementation ImageViewWithSpinner

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
//        _spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
//        [self addSubview:_spinner];
//        
//        [self setTranslatesAutoresizingMaskIntoConstraints:NO];
//        
//        NSLayoutConstraint *constrant1 = [NSLayoutConstraint constraintWithItem:self.spinner attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0.0];
//        //子view的中心纵坐标等于父view的中心纵坐标
//        NSLayoutConstraint *constrant2 = [NSLayoutConstraint constraintWithItem:self.spinner attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0.0];
//        
//        NSLayoutConstraint *constrant3 = [NSLayoutConstraint constraintWithItem:self.spinner attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationGreaterThanOrEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:20.0];
//        //子view的高度为200
//        NSLayoutConstraint *constrant4 = [NSLayoutConstraint constraintWithItem:self.spinner attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationGreaterThanOrEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:20.0];
//        
//        [self addConstraints:@[constrant1, constrant2, constrant3, constrant4]];
    }
    
    return self;
}

@end
