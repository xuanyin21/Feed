//
//  ImageDownloader.m
//  Feed
//
//  Created by Xuan Yin on 4/1/18.
//  Copyright © 2018 Shawn Yin. All rights reserved.
//

#import "ImageDownloader.h"

@implementation ImageDownloader

+ (instancetype)sharedDownloader {
    static dispatch_once_t once;
    static ImageDownloader *instance;
    dispatch_once(&once, ^{
        instance = [self new];
    });
    return instance;
}

- (void)downloadImageWithURL:(NSURL *)url completed:(ImageDownloaderCompletedBlock)completedBlock
{
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    
    [request setTimeoutInterval:15.0];
    [request setCachePolicy:NSURLRequestReloadIgnoringCacheData];
    
    NSURLSession *sharedSession = [NSURLSession sharedSession];
    
    NSURLSessionDataTask *dataTask = [sharedSession dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (data && (error==nil)) {
            UIImage *image = [UIImage imageWithData:data];
            dispatch_async(dispatch_get_main_queue(), ^{
                completedBlock(image, nil);
            });
        }
    }];
    
    [dataTask resume];
}

@end
