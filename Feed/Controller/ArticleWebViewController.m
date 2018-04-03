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
    UILabel *titleLabel = [UILabel new];
    titleLabel.text = _titleStr;
    titleLabel.textColor = [UIColor whiteColor];
    
    self.navigationItem.titleView = titleLabel;
    
    [self setupViews];
}

- (void)setupViews
{
    _webView = [[WKWebView alloc] init];
    _webView.navigationDelegate = self;
    NSURLRequest *request = [NSURLRequest requestWithURL: _link];
    [_webView loadRequest:request];
    [self.view addSubview:_webView];
    
    _spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    [self.view addSubview:_spinner];
    
    _bottomToolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height - 114, self.view.frame.size.width, 50)];
    [_bottomToolBar setBarStyle:UIBarStyleDefault];
    [self.view addSubview:_bottomToolBar];
    
    [_webView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [_bottomToolBar setTranslatesAutoresizingMaskIntoConstraints:NO];
    [_spinner setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    NSLayoutConstraint *webViewLeft = [NSLayoutConstraint constraintWithItem:_webView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeft multiplier:1.0f constant:0];
    NSLayoutConstraint *webViewRight = [NSLayoutConstraint constraintWithItem:_webView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeRight multiplier:1.0f constant:0];
    NSLayoutConstraint *webViewTop = [NSLayoutConstraint constraintWithItem:_webView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1.0f constant:0];
    NSLayoutConstraint *webViewBottom = [NSLayoutConstraint constraintWithItem:_webView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeBottom multiplier:1.0f constant:-50.0];
    
    NSLayoutConstraint *bottomToolBarLeft = [NSLayoutConstraint constraintWithItem:_bottomToolBar attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeft multiplier:1.0f constant:0];
    NSLayoutConstraint *bottomToolBarRight = [NSLayoutConstraint constraintWithItem:_bottomToolBar attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeRight multiplier:1.0f constant:0];
    NSLayoutConstraint *bottomToolBarTop = [NSLayoutConstraint constraintWithItem:_bottomToolBar attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:_webView attribute:NSLayoutAttributeBottom multiplier:1.0f constant:0];
    NSLayoutConstraint *bottomToolBarBottom = [NSLayoutConstraint constraintWithItem:_bottomToolBar attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeBottom multiplier:1.0f constant:0];
    
    NSLayoutConstraint *spinnerCenterX = [NSLayoutConstraint constraintWithItem:_spinner attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0.0];
    NSLayoutConstraint *spinnerCenterY = [NSLayoutConstraint constraintWithItem:_spinner attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0.0];
    
    [self.view addConstraints:@[webViewTop, webViewLeft, webViewRight, webViewBottom, bottomToolBarTop, bottomToolBarLeft, bottomToolBarRight, bottomToolBarBottom, spinnerCenterX, spinnerCenterY]];
    
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
    [_spinner startAnimating];
    _spinner.hidden = false;
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
