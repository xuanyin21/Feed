//
//  ArticleCell.m
//  Feed
//
//  Created by Xuan Yin on 3/29/18.
//  Copyright © 2018 Shawn Yin. All rights reserved.
//

#import "ArticleCell.h"
#import "ImageViewWithSpinner+WebImage.h"
#import "ImageViewWithSpinner.h"

#define HEIGHT_BOTTOM 50
#define MARGIN_LEFT_RIGHT 8
#define MARGIN_TOP_BOTTOM 5

@interface ArticleCell ()

@property (nonatomic, strong) UILabel *titleLbl;
@property (nonatomic, strong) ImageViewWithSpinner *imageView;

@end

@implementation ArticleCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        _imageView = [[ImageViewWithSpinner alloc] init];
        _imageView.contentMode = UIViewContentModeScaleToFill;
        _titleLbl = [[UILabel alloc] init];
        _titleLbl.numberOfLines = 2;
        _titleLbl.font = [UIFont fontWithName:@"Helvetica-Light" size:14];
        
        [self addSubview:_imageView];
        [self addSubview:_titleLbl];
        
        [_imageView setTranslatesAutoresizingMaskIntoConstraints:NO];
        [_titleLbl setTranslatesAutoresizingMaskIntoConstraints:NO];
        
        NSLayoutConstraint *imageViewLeft = [NSLayoutConstraint constraintWithItem:_imageView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1.0f constant:0];
        NSLayoutConstraint *imageViewRight = [NSLayoutConstraint constraintWithItem:_imageView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeRight multiplier:1.0f constant:0];
        NSLayoutConstraint *imageViewTop = [NSLayoutConstraint constraintWithItem:_imageView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1.0f constant:0];
        NSLayoutConstraint *imageViewBottom = [NSLayoutConstraint constraintWithItem:_imageView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1.0f constant:-HEIGHT_BOTTOM];
        
        NSLayoutConstraint *titleLeft = [NSLayoutConstraint constraintWithItem:_titleLbl attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1.0f constant:MARGIN_LEFT_RIGHT];
        NSLayoutConstraint *titleRight = [NSLayoutConstraint constraintWithItem:_titleLbl attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeRight multiplier:1.0f constant:-MARGIN_LEFT_RIGHT];
        NSLayoutConstraint *titleTop = [NSLayoutConstraint constraintWithItem:_titleLbl attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:_imageView attribute:NSLayoutAttributeBottom multiplier:1.0f constant:MARGIN_TOP_BOTTOM];
        NSLayoutConstraint *titleBottom = [NSLayoutConstraint constraintWithItem:_titleLbl attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1.0f constant:-MARGIN_TOP_BOTTOM];
        
        [self addConstraints:@[imageViewLeft, imageViewRight, imageViewTop, imageViewBottom, titleBottom, titleTop, titleRight, titleLeft]];
    }
    return self;
}

- (void)setTitle:(NSString *)title
{
    self.titleLbl.text = title;
}

- (void)setImageUrlStr:(NSString *)imageUrlStr
{
    [_imageView setImageWithURL:[NSURL URLWithString:imageUrlStr]];
}

@end
