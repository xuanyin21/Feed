//
//  XMLParseManager.m
//  Feed
//
//  Created by ACTON Software Develop on 3/29/18.
//  Copyright © 2018 Shawn Yin. All rights reserved.
//

#import "XMLParseManager.h"
#import "Article.h"

@interface XMLParseManager ()

@property (nonatomic, strong) NSString *currentElementName;

@end

@implementation XMLParseManager

+ (instancetype)sharedManager {
    static dispatch_once_t onceToken;
    static XMLParseManager *instance;
    
    dispatch_once(&onceToken, ^{
        instance = [XMLParseManager new];
        instance.articleList = [NSMutableArray array];
    });
    
    return instance;
}

- (void)loadData {
    NSURL *url = [NSURL URLWithString:@"https://www.personalcapital.com/blog/feed/?cat=3,891,890,68,284"];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    
    [request setTimeoutInterval:10.0];
    [request setCachePolicy:NSURLRequestReloadIgnoringCacheData];
    
    NSURLSession *sharedSession = [NSURLSession sharedSession];
    
    NSURLSessionDataTask *dataTask = [sharedSession dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if (data && (error == nil)) {
            
            [self parseData:data];
        } else {
            NSLog(@"error=%@",error);
        }
    }];
    
    [dataTask resume];
}

- (void)parseData:(NSData *)data {
    NSXMLParser *xmlParser = [[NSXMLParser alloc] initWithData:data];
    xmlParser.delegate = self;
    
    [xmlParser parse];
}


- (void)parserDidStartDocument:(NSXMLParser *)parser {
    NSLog(@"parser start");
    
    [_articleList removeAllObjects];

}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary<NSString *,NSString *> *)attributeDict {
    NSLog(@"start element : %@", elementName);
    
    if ([elementName isEqualToString:@"item"]) {
        Article *article = [[Article alloc] init];
        [_articleList addObject:article];
    } else if ([elementName isEqualToString:@"media:content"]) {
        Article *article = [_articleList lastObject];
        article.imageUrlStr = [attributeDict objectForKey:@"url"];
    } else {
        self.currentElementName = elementName;
    }
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
    
    Article *article = [_articleList lastObject];
    
    if ([self.currentElementName isEqualToString: @"title"]) {
        
        if (article.title != nil) {
            NSMutableString *str = [NSMutableString stringWithString: article.title];
            [str appendString:string];
            article.title = str;
        } else {
            article.title = string;
        }
        
    } else if ([self.currentElementName isEqualToString: @"description"]) {
        
        article.descriptionStr = string;
    } else if ([self.currentElementName isEqualToString: @"link"]) {
        
        article.linkStr = string;
    }
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
    NSLog(@"end element : %@", elementName);
    self.currentElementName = nil;
}

- (void)parserDidEndDocument:(NSXMLParser *)parser {
    [self.delegate dataDidLoad];
}

@end
