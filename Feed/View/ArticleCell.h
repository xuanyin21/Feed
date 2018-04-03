//
//  ArticleCell.h
//  Feed
//
//  Created by Xuan Yin on 3/29/18.
//  Copyright © 2018 Shawn Yin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ArticleCell : UICollectionViewCell

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *imageUrlStr;
@property (nonatomic, strong) UIActivityIndicatorView *spinner;

@end
