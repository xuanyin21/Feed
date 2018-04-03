//
//  FirstArticleCell.m
//  Feed
//
//  Created by Xuan Yin on 4/1/18.
//  Copyright © 2018 Shawn Yin. All rights reserved.
//

#import "FirstArticleCell.h"
#import "ImageViewWithSpinner+WebImage.h"
#import "ImageViewWithSpinner.h"

#define HEIGHT_BOTTOM 60
#define MARGIN_LEFT_RIGHT 8
#define MARGIN_TOP_BOTTOM 5
#define HEIGHT_TITLE 20

@interface FirstArticleCell ()

@property (nonatomic, strong) UILabel *titleLbl;
@property (nonatomic, strong) UILabel *descriptionLbl;
@property (nonatomic, strong) ImageViewWithSpinner *imageView;

@end

@implementation FirstArticleCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        
        _imageView = [[ImageViewWithSpinner alloc] init];
        _imageView.contentMode = UIViewContentModeScaleToFill;
        
        _titleLbl = [[UILabel alloc] init];
        _titleLbl.font = [UIFont fontWithName:@"Helvetica-Light" size:14];
        
        _descriptionLbl = [[UILabel alloc] init];
        _descriptionLbl.numberOfLines = 2;
        _descriptionLbl.font = [UIFont fontWithName:@"Helvetica-Light" size:11];
       
        [self addSubview:_imageView];
        [self addSubview:_titleLbl];
        [self addSubview: _descriptionLbl];
        
        [_imageView setTranslatesAutoresizingMaskIntoConstraints:NO];
        [_titleLbl setTranslatesAutoresizingMaskIntoConstraints:NO];
        [_descriptionLbl setTranslatesAutoresizingMaskIntoConstraints:NO];
        
        NSLayoutConstraint *imageViewLeft = [NSLayoutConstraint constraintWithItem:_imageView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1.0f constant:0];
        NSLayoutConstraint *imageViewRight = [NSLayoutConstraint constraintWithItem:_imageView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeRight multiplier:1.0f constant:0];
        NSLayoutConstraint *imageViewTop = [NSLayoutConstraint constraintWithItem:_imageView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1.0f constant:0];
        NSLayoutConstraint *imageViewBottom = [NSLayoutConstraint constraintWithItem:_imageView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1.0f constant:-HEIGHT_BOTTOM];
        
        NSLayoutConstraint *titleLeft = [NSLayoutConstraint constraintWithItem:_titleLbl attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1.0f constant:MARGIN_LEFT_RIGHT];
        NSLayoutConstraint *titleRight = [NSLayoutConstraint constraintWithItem:_titleLbl attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeRight multiplier:1.0f constant:-MARGIN_LEFT_RIGHT];
        NSLayoutConstraint *titleTop = [NSLayoutConstraint constraintWithItem:_titleLbl attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:_imageView attribute:NSLayoutAttributeBottom multiplier:1.0f constant:MARGIN_TOP_BOTTOM];
        NSLayoutConstraint *titleHeight = [NSLayoutConstraint constraintWithItem:_titleLbl attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0f constant:HEIGHT_TITLE];
        
        NSLayoutConstraint *descriptionLeft = [NSLayoutConstraint constraintWithItem:_descriptionLbl attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1.0f constant:MARGIN_LEFT_RIGHT];
        NSLayoutConstraint *descriptionRight = [NSLayoutConstraint constraintWithItem:_descriptionLbl attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeRight multiplier:1.0f constant:-MARGIN_LEFT_RIGHT];
        NSLayoutConstraint *descriptionTop = [NSLayoutConstraint constraintWithItem:_descriptionLbl attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:_titleLbl attribute:NSLayoutAttributeBottom multiplier:1.0f constant:0];
        NSLayoutConstraint *descriptionBottom = [NSLayoutConstraint constraintWithItem:_descriptionLbl attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1.0f constant:-MARGIN_TOP_BOTTOM];
        
        [self addConstraints:@[imageViewLeft, imageViewRight, imageViewTop, imageViewBottom, titleHeight, titleTop, titleRight, titleLeft, descriptionTop, descriptionLeft, descriptionRight, descriptionBottom]];
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

- (void)setDescriptionStr:(NSString *)descriptionStr
{
    self.descriptionLbl.text = descriptionStr;
}

@end
