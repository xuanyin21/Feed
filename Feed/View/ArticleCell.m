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

@interface ArticleCell ()

@property (nonatomic, strong) UILabel *titleLbl;
@property (nonatomic, strong) ImageViewWithSpinner *imageView;

@end

@implementation ArticleCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
//        self.backgroundColor = [UIColor whiteColor];
//        _imageView = [[ImageViewWithSpinner alloc] init];
//        _imageView.contentMode = UIViewContentModeScaleToFill;
//        _titleLbl = [[UILabel alloc] init];
//        _titleLbl.numberOfLines = 2;
//        _titleLbl.font = [UIFont fontWithName:@"Helvetica" size:14];
//        
//        [self addSubview:_imageView];
//        [self addSubview:_titleLbl];
//        
//        [self setTranslatesAutoresizingMaskIntoConstraints:NO];
//        
//        NSLayoutConstraint *imageViewLeft = [NSLayoutConstraint constraintWithItem:_imageView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1.0f constant:0];
//        NSLayoutConstraint *imageViewRight = [NSLayoutConstraint constraintWithItem:_imageView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeRight multiplier:1.0f constant:0];
//        NSLayoutConstraint *imageViewTop = [NSLayoutConstraint constraintWithItem:_imageView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1.0f constant:0];
//        NSLayoutConstraint *imageViewBottom = [NSLayoutConstraint constraintWithItem:_imageView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1.0f constant:-50.0];
//        
//        NSLayoutConstraint *titleViewLeft = [NSLayoutConstraint constraintWithItem:_titleLbl attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1.0f constant:8.0];
//        NSLayoutConstraint *titleViewRight = [NSLayoutConstraint constraintWithItem:_titleLbl attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeRight multiplier:1.0f constant:-8.0];
//        NSLayoutConstraint *titleViewTop = [NSLayoutConstraint constraintWithItem:_titleLbl attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:_imageView attribute:NSLayoutAttributeTop multiplier:1.0f constant:5.0];
//        NSLayoutConstraint *titleViewBottom = [NSLayoutConstraint constraintWithItem:_titleLbl attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1.0f constant:-5.0];
//        
//        [self addConstraints:@[imageViewLeft, imageViewRight, imageViewTop, imageViewBottom, titleViewBottom, titleViewTop, titleViewRight, titleViewLeft]];
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

- (void)layoutIfNeeded
{
    NSLog(@"%f",self.frame.size.width);
    [self setNeedsLayout];
}

@end
