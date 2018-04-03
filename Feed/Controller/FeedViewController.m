//
//  FeedViewController.m
//  Feed
//
//  Created by ACTON Software Develop on 3/29/18.
//  Copyright © 2018 Shawn Yin. All rights reserved.
//

#import "FeedViewController.h"
#import "XMLParseManager.h"
#import "ArticleCell.h"
#import "FirstArticleCell.h"
#import "Article.h"
#import "ArticleWebViewController.h"

@interface FeedViewController ()<UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, XMLParseManagerDelegate>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) XMLParseManager *xmlManager;
@property (nonatomic, strong) UIActivityIndicatorView *spinner;

@end

@implementation FeedViewController

static NSString * const reuseIdentifier = @"ArticleCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    UIBarButtonItem *rightBarButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(loadXMLData)];
    
    [self.navigationItem setRightBarButtonItem:rightBarButton];
    [self.navigationItem setBackBarButtonItem:[[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:nil]];
    
    UILabel *titleLabel = [UILabel new];
    titleLabel.text = @"Research & Insights";
    titleLabel.textColor = [UIColor whiteColor];
    
    self.navigationItem.titleView = titleLabel;
    
    [self setupViews];
    [self loadXMLData];
    
    
}

- (void)setupViews
{
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
    [self.collectionView registerClass:[ArticleCell class] forCellWithReuseIdentifier:reuseIdentifier];
    [self.collectionView registerClass:[FirstArticleCell class] forCellWithReuseIdentifier:@"FirstArticleCell"];
    
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    
    self.collectionView.contentInset = UIEdgeInsetsMake(23, 16, 10, 16);
    self.collectionView.backgroundColor = [UIColor clearColor];
    [self.view addSubview: self.collectionView];
    
    _spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    [self.view addSubview:_spinner];
    
    [self.collectionView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [_spinner setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    NSLayoutConstraint *left = [NSLayoutConstraint constraintWithItem:self.collectionView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeft multiplier:1.0f constant:0];
    NSLayoutConstraint *right = [NSLayoutConstraint constraintWithItem:self.collectionView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeRight multiplier:1.0f constant:0];
    NSLayoutConstraint *top = [NSLayoutConstraint constraintWithItem:self.collectionView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1.0f constant:0];
    NSLayoutConstraint *bottom = [NSLayoutConstraint constraintWithItem:self.collectionView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeBottom multiplier:1.0f constant:0];
    
    NSLayoutConstraint *spinnerCenterX = [NSLayoutConstraint constraintWithItem:_spinner attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0.0];
    NSLayoutConstraint *spinnerCenterY = [NSLayoutConstraint constraintWithItem:_spinner attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0.0];
    
    [self.view addConstraints:@[top, right, bottom, left, spinnerCenterX, spinnerCenterY]];
}

- (void)loadXMLData
{
    [_spinner startAnimating];
    _spinner.hidden = NO;
    
    if (_xmlManager == nil) {
        _xmlManager = [XMLParseManager sharedManager];
        _xmlManager.delegate = self;
    }
    
    [_xmlManager loadData];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark <XMLParseManagerDelegate>
- (void)dataDidLoad
{
    dispatch_async(dispatch_get_main_queue(), ^{
        self.spinner.hidden = YES;
        [self.spinner stopAnimating];
        
        [self.collectionView reloadData];
    });
    
}

- (void)failToLoadWith:(NSError *)error
{
    dispatch_async(dispatch_get_main_queue(), ^{
        
        self.spinner.hidden = YES;
        [self.spinner stopAnimating];
        
        UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"Fail to load RSS Feeds" message:error.localizedDescription preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:nil];
        [alertVC addAction:cancel];
        [self presentViewController:alertVC animated:YES completion:nil];
    });
}

#pragma mark <UICollectionViewDataSource>
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _xmlManager.articleList.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0) {
        FirstArticleCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier: @"FirstArticleCell" forIndexPath:indexPath];
        Article *article = _xmlManager.articleList.firstObject;
        
        cell.title = article.title;
        cell.imageUrlStr = article.imageUrlStr;
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        dateFormatter.dateFormat = @"MMM d, yyyy";
        NSString *pudDateStr = [dateFormatter stringFromDate:article.pubDate];
        NSString *descriptionStr = [NSString stringWithFormat:@"%@ - %@", pudDateStr, [[[NSAttributedString alloc] initWithData:[article.descriptionStr dataUsingEncoding:NSUTF8StringEncoding]
                                                                                                                            options:@{NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType,
                                                                                                                                      NSCharacterEncodingDocumentAttribute: @(NSUTF8StringEncoding)}
                                                                                                                 documentAttributes:nil error:nil] string]];
        cell.descriptionStr = descriptionStr;
        
        return cell;
    } else {
        ArticleCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
        Article *article = _xmlManager.articleList[indexPath.row];
        
        cell.title = article.title;
        cell.imageUrlStr = article.imageUrlStr;
        
        return cell;
    }
}

#pragma mark <UICollectionViewDelegateFlowLayout>
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat itemWidth;
    CGFloat itemHeight;
    
    if (indexPath.row == 0) {
        itemWidth = self.collectionView.frame.size.width - (self.collectionView.contentInset.left + self.collectionView.contentInset.right);
        itemHeight = itemWidth*300/780 + 60;
    } else {
        if ( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad )
        {
            itemWidth = (self.collectionView.frame.size.width - (self.collectionView.contentInset.left + self.collectionView.contentInset.right + 20)) / 3;
        } else {
            itemWidth = (self.collectionView.frame.size.width - (self.collectionView.contentInset.left + self.collectionView.contentInset.right + 10)) / 2;
        }
        
        itemHeight = itemWidth*300/780 + 60;
    }
    
    return CGSizeMake(itemWidth, itemHeight);
}

#pragma mark <UICollectionViewDelegate>

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    Article *article = _xmlManager.articleList[indexPath.row];
    NSURL *link = [NSURL URLWithString:[NSString stringWithFormat:@"%@?displayMobileNavigation=0", article.linkStr]];
    ArticleWebViewController *webVC = [ArticleWebViewController new];
    webVC.link = link;
    webVC.titleStr = article.title;
    [self.navigationController pushViewController:webVC animated:YES];
}

- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator
{
    [super viewWillTransitionToSize:size withTransitionCoordinator:coordinator];
    [self.collectionView.collectionViewLayout invalidateLayout];
}

@end
