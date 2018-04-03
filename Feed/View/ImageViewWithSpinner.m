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
        _spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        [self addSubview:_spinner];
        
        [_spinner setTranslatesAutoresizingMaskIntoConstraints:NO];
        
        NSLayoutConstraint *constrant1 = [NSLayoutConstraint constraintWithItem:_spinner attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0.0];

        NSLayoutConstraint *constrant2 = [NSLayoutConstraint constraintWithItem:_spinner attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0.0];
        
        [self addConstraints:@[constrant1, constrant2]];
    }
    
    return self;
}

@end
