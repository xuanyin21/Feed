//
//  Article.h
//  Feed
//
//  Created by ACTON Software Develop on 3/29/18.
//  Copyright © 2018 Shawn Yin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Article : NSObject

@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *descriptionStr;
@property (strong, nonatomic) NSString *imageUrlStr;
@property (strong, nonatomic) NSString *linkStr;
@property (strong, nonatomic) NSDate *pubDate;

@end
