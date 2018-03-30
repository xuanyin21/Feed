//
//  XMLParseManager.h
//  Feed
//
//  Created by ACTON Software Develop on 3/29/18.
//  Copyright © 2018 Shawn Yin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XMLParseManager : NSObject<NSXMLParserDelegate>

+(instancetype) sharedManager;

@property (nonatomic, strong) NSMutableArray *articleList;

- (void)loadData;

@end
