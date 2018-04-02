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

@end

@implementation FeedViewController

static NSString * const reuseIdentifier = @"ArticleCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    [self loadXMLData];
    
    UIBarButtonItem *rightBarButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(loadXMLData)];
    
    [self.navigationItem setRightBarButtonItem:rightBarButton];
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    self.collectionView = [[UICollectionView alloc] initWithFrame:[UIScreen mainScreen].bounds collectionViewLayout:flowLayout];
    [self.collectionView registerClass:[ArticleCell class] forCellWithReuseIdentifier:reuseIdentifier];
    [self.collectionView registerClass:[FirstArticleCell class] forCellWithReuseIdentifier:@"FirstArticleCell"];
    
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    
    self.collectionView.contentInset = UIEdgeInsetsMake(23, 16, 10, 16);
    self.collectionView.backgroundColor = [UIColor clearColor];
    [self.view addSubview: self.collectionView];
}

- (void)loadXMLData
{
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
- (void)dataDidLoad {
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.collectionView reloadData];
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
        cell.descriptionStr = article.descriptionStr;
        
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
        itemWidth = (self.collectionView.frame.size.width - (self.collectionView.contentInset.left + self.collectionView.contentInset.right + 10)) / 2;
        itemHeight = itemWidth*300/780 + 60;
    }
    
    return CGSizeMake(itemWidth, itemHeight);
}

#pragma mark <UICollectionViewDelegate>

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    Article *article = _xmlManager.articleList[indexPath.row];
    NSURL *link = [NSURL URLWithString:article.linkStr];
    ArticleWebViewController *webVC = [ArticleWebViewController new];
    webVC.link = link;
    
    [self.navigationController pushViewController:webVC animated:YES];
}

@end
