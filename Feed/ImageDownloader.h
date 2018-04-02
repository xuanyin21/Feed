//
//  ImageDownloader.h
//  Feed
//
//  Created by Xuan Yin on 4/1/18.
//  Copyright © 2018 Shawn Yin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef void(^ImageDownloaderCompletedBlock)(UIImage * _Nullable image, NSError * _Nullable error);

@interface ImageDownloader : NSObject

+ (instancetype)sharedDownloader;

- (void)downloadImageWithURL:(NSURL *)url completed:(ImageDownloaderCompletedBlock)completedBlock;

@end
