//
//  ArticleWebViewController.m
//  Feed
//
//  Created by Xuan Yin on 4/2/18.
//  Copyright © 2018 Shawn Yin. All rights reserved.
//

#import "ArticleWebViewController.h"
#import <WebKit/WebKit.h>

@interface ArticleWebViewController ()<WKNavigationDelegate>

@property (nonatomic, strong) WKWebView *webView;
@property (nonatomic, strong) UIActivityIndicatorView *spinner;
@property (nonatomic, strong) UIToolbar *bottomToolBar;
@property (nonatomic, strong) UIBarButtonItem *backBarButtonItem;
@property (nonatomic, strong) UIBarButtonItem *forwardBarButtonItem;

@end

@implementation ArticleWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setupViews];
}

- (void)setupViews
{
    _webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 114)];
    
    _webView.navigationDelegate = self;
    NSURLRequest *request = [NSURLRequest requestWithURL: _link];
    [_webView loadRequest:request];
    
    [self.view addSubview:_webView];
    
    _spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    _spinner.center = self.view.center;
    [self.view addSubview:_spinner];
    
    _bottomToolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height - 114, self.view.frame.size.width, 50)];
    [_bottomToolBar setBarStyle:UIBarStyleDefault];
    [self.view addSubview:_bottomToolBar];
    
    UIButton *backButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    [backButton setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    
    [backButton addTarget:self action:@selector(goBack) forControlEvents:UIControlEventTouchUpInside];
    UIButton *forwardButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    [forwardButton setImage:[UIImage imageNamed:@"forward"] forState:UIControlStateNormal];
    
    [forwardButton addTarget:self action:@selector(goForward) forControlEvents:UIControlEventTouchUpInside];
    _backBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    _forwardBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:forwardButton];
    
    UIBarButtonItem *spaceItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    [_bottomToolBar setItems:@[_backBarButtonItem, _forwardBarButtonItem, spaceItem]];
    
    _backBarButtonItem.enabled = NO;
    _forwardBarButtonItem.enabled = NO;
    
    [_webView addObserver:self forKeyPath:@"canGoForward" options:NSKeyValueObservingOptionNew context:nil];
    [_webView addObserver:self forKeyPath:@"canGoBack" options:NSKeyValueObservingOptionNew context:nil];
    
}

#pragma mark MKWebView Forward and Back actions
- (void)goForward
{
    if (_webView.canGoForward) {
        [_webView goForward];
    }
}

- (void)goBack
{
    if (_webView.canGoBack) {
        [_webView goBack];
    }
}

#pragma mark KVO
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{
    
    if ([keyPath isEqualToString:@"canGoForward"]) {
        _forwardBarButtonItem.enabled = [[change objectForKey:NSKeyValueChangeNewKey] boolValue];
    } else if ([keyPath isEqualToString:@"canGoBack"]) {
        _backBarButtonItem.enabled = [[change objectForKey:NSKeyValueChangeNewKey] boolValue];
    }
}

#pragma mark <WKNavigationDelegate>
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation
{
    _spinner.hidden = false;
    [_spinner startAnimating];
}

-(void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation
{
    _spinner.hidden = true;
    [_spinner stopAnimating];
}

- (void)dealloc
{
    [self.webView removeObserver:self forKeyPath:@"canGoForward"];
    [self.webView removeObserver:self forKeyPath:@"canGoBack"];
    self.webView = nil;
}

@end
