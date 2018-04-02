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
#define MARGIN_LEFT 8
#define MARGIN_TOP 5
#define HEIGHT_TITLE 20
#define HEIGHT_DESCRIPTION 30

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
        
        _imageView = [[ImageViewWithSpinner alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height - HEIGHT_BOTTOM)];
        _imageView.contentMode = UIViewContentModeScaleToFill;
        
        _titleLbl = [[UILabel alloc] initWithFrame:CGRectMake(MARGIN_LEFT, frame.size.height - HEIGHT_BOTTOM + MARGIN_TOP, frame.size.width - MARGIN_LEFT*2, HEIGHT_TITLE)];
        _titleLbl.font = [UIFont fontWithName:@"Helvetica" size:16];
        _titleLbl.adjustsFontSizeToFitWidth = true;
        _titleLbl.minimumScaleFactor = 0.7;
        
        _descriptionLbl = [[UILabel alloc] initWithFrame:CGRectMake(MARGIN_LEFT, frame.size.height - HEIGHT_BOTTOM + HEIGHT_TITLE + MARGIN_TOP, frame.size.width - MARGIN_LEFT*2, HEIGHT_DESCRIPTION)];
        _descriptionLbl.numberOfLines = 2;
        _descriptionLbl.adjustsFontSizeToFitWidth = true;
        _descriptionLbl.minimumScaleFactor = 0.7;
        _descriptionLbl.font = [UIFont fontWithName:@"Helvetica" size:11];
       
        [self addSubview:_imageView];
        [self addSubview:_titleLbl];
        [self addSubview: _descriptionLbl];
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
