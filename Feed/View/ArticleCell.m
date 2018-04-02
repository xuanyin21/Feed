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
        self.backgroundColor = [UIColor whiteColor];
        _imageView = [[ImageViewWithSpinner alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height - 50)];
        _imageView.contentMode = UIViewContentModeScaleToFill;
        _titleLbl = [[UILabel alloc] initWithFrame:CGRectMake(8, frame.size.height - 45, frame.size.width - 16, 40)];
        _titleLbl.numberOfLines = 2;
        _titleLbl.font = [UIFont fontWithName:@"Helvetica" size:14];
        
        [self addSubview:_imageView];
        [self addSubview:_titleLbl];
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
