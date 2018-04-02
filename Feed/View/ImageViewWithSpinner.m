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
        _spinner.center = self.center;
        [self addSubview:_spinner];
    }
    
    return self;
}

@end
