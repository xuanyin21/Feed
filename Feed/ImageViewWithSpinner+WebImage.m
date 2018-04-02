//
//  ImageViewWithSpinner+WebImage.m
//  Feed
//
//  Created by Xuan Yin on 4/1/18.
//  Copyright © 2018 Shawn Yin. All rights reserved.
//

#import "ImageViewWithSpinner+WebImage.h"
#import "ImageDownloader.h"

@implementation ImageViewWithSpinner (WebImage)

- (void)setImageWithURL:(NSURL *)url {
    [self.spinner startAnimating];
    ImageDownloader *imageDownloader = [ImageDownloader sharedDownloader];
    [imageDownloader downloadImageWithURL:url completed:^(UIImage * _Nullable image, NSError * _Nullable error) {
        if (error == nil) {
            [self.spinner stopAnimating];
            self.spinner.hidden = YES;
            self.image = image;
        }
    }];
}

@end
