//
//  ArticleWebViewController.m
//  Feed
//
//  Created by Xuan Yin on 4/2/18.
//  Copyright © 2018 Shawn Yin. All rights reserved.
//

#import "ArticleWebViewController.h"
#import <WebKit/WebKit.h>

@interface ArticleWebViewController ()

@property (nonatomic, strong) WKWebView *webView;

@end

@implementation ArticleWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height)];
    NSURLRequest *request = [NSURLRequest requestWithURL: _link];
    [_webView loadRequest:request];
    
    [self.view addSubview:_webView];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
