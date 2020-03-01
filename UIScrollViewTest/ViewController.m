//
//  ViewController.m
//  UIScrollViewTest
//
//  Created by lg on 2020/2/28.
//  Copyright © 2020 lg. All rights reserved.
//

#import "ViewController.h"
#import "UIView+Gradient.h"
#import "LGScrollView.h"
#import "LGCollectionView.h"
#import "LGCollectionViewCell.h"
#import "LGCollectionReusableView.h"
#import "UICollectionView+LG.h"
#import "UIScrollView+LGAttribute.h"

#define SCREEN_WIDTH (UIScreen.mainScreen.bounds.size.width)
#define SCREEN_HEIGHT (UIScreen.mainScreen.bounds.size.height)

@interface ViewController ()<UIScrollViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property(nonatomic) UICollectionView *mainScrollView;
@property(nonatomic) UICollectionView *subScrollView;

@property(nonatomic) UIButton *btn;

@end

@implementation ViewController

- (void)loadView {
    self.view = self.mainScrollView;
    
    self.btn = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.btn setTitle:@"Reload" forState:UIControlStateNormal];
    [self.btn addTarget:self action:@selector(actionReload) forControlEvents:UIControlEventTouchUpInside];
    [self.btn sizeToFit];
    [self.btn setCenter:CGPointMake(SCREEN_WIDTH/2, SCREEN_HEIGHT/2)];
    [self.view addSubview:self.btn];
}

- (void)actionReload {
    [self.mainScrollView reloadData];
    [self.subScrollView reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    [self test2];
    [self test1];
}

- (void)test2 {
    [self actionReload];
}
- (void)test1 {
    [self.mainScrollView setContentSize:CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT+200)];

    [self.subScrollView setFrame:CGRectMake(0, 200, SCREEN_WIDTH, SCREEN_HEIGHT)];
    [self.mainScrollView addSubview:self.subScrollView];

    UIView *yellowView = UIView.new;
    //    yellowView.backgroundColor = UIColor.yellowColor;
    [yellowView setGradientBackgroundWithColors:@[UIColor.yellowColor, UIColor.blueColor] locations:nil startPoint:CGPointMake(0, 0) endPoint:CGPointMake(0, 1)];
    yellowView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 1000);
    [self.subScrollView addSubview:yellowView];
    [self.subScrollView setContentSize:CGSizeMake(SCREEN_WIDTH, 1000)];
    
    self.mainScrollView.dataSource = nil;
    self.subScrollView.dataSource = nil;
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (collectionView == self.mainScrollView) {
        return 1;
    } else {
        return 30;
    }
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView lg_dequeueReusableCellWithClass:LGCollectionViewCell.class forIndexPath:indexPath];
    if (collectionView == self.mainScrollView) {
        [cell.contentView addSubview:self.subScrollView];
    } else {
        [cell setGradientBackgroundWithColors:@[UIColor.yellowColor, UIColor.blueColor] locations:nil startPoint:CGPointMake(0, 0) endPoint:CGPointMake(0, 1)];
    }
    return cell;
}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    if (collectionView == self.mainScrollView) {
        return [collectionView lg_dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withClass:LGCollectionReusableView.class forIndexPath:indexPath];
    } else {
        return nil;
    }
}
#pragma mark - UIScrollViewDelegate

- (BOOL)scrollViewShouldScrollToTop:(UIScrollView *)scrollView {
    return scrollView.canScroll;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if (scrollView == self.subScrollView) {
        // 子视图滑动到底部后，设置 contentOffset.y 小于最大的 contentOffset.y，这样下次再u往上滑动的时候可以触发滑动，执行 bounces 效果
        if (scrollView.contentSize.height > scrollView.bounds.size.height) {
            // 子视图内容高度大于自身视图高度，获取最大 contentOffset.y
            CGFloat maxY = scrollView.contentSize.height - scrollView.bounds.size.height;
            if (scrollView.contentOffset.y >= maxY) {
                scrollView.contentOffset = CGPointMake(0, maxY-0.5);
            }
        } else {
        }
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    NSLog(@"%@ - %@",scrollView.tag==0?@"父视图":@"子视图", NSStringFromCGPoint(scrollView.contentOffset));
    
    if (scrollView == self.mainScrollView) {

        if (self.subScrollView.canScroll && self.subScrollView.contentOffset.y <= 0) {
            // 子视图滑动到顶部，设置子视图不能滚动，同时设置父视图可以滚动
            self.subScrollView.canScroll = NO;
            self.subScrollView.showsVerticalScrollIndicator = NO;
            self.mainScrollView.canScroll = YES;
            self.mainScrollView.showsVerticalScrollIndicator = YES;
        }
        
        // 获取父视图应该停止的位置
        CGFloat contentOffset = 0;
        if (scrollView.contentSize.height > scrollView.bounds.size.height) {
            // 父视图内容高度大于自身视图高度，获取停止临界点
            contentOffset = scrollView.contentSize.height-CGRectGetHeight(scrollView.bounds);
        }
        
        if (!scrollView.canScroll) {
            // 父视图不可以滚动
            scrollView.contentOffset = CGPointMake(0, contentOffset);
        } else if (scrollView.contentOffset.y >= contentOffset) {
            // 超过临界值，设置自己不可以滚动，同时设置子视图可以滚动
//            scrollView.contentOffset = CGPointMake(0, contentOffset);
            scrollView.canScroll = NO;
            scrollView.showsVerticalScrollIndicator = NO;
            self.subScrollView.canScroll = YES;
            self.subScrollView.showsVerticalScrollIndicator = YES;
        } else {
            // 在临界值内，设置子视图不可以滚动
            self.subScrollView.canScroll = NO;
            self.subScrollView.showsVerticalScrollIndicator = NO;
        }
        
    } else {
        
        if (!scrollView.canScroll) {
            // 子视图不可以滚动
            scrollView.contentOffset = CGPointZero;
        }
//        else if (scrollView.contentOffset.y <= 0) {
//            // 子视图滑动到顶部，设置自己不能滚动，同时设置父视图可以滚动
//            scrollView.canScroll = NO;
//            scrollView.showsVerticalScrollIndicator = NO;
//            self.mainScrollView.canScroll = YES;
//            self.mainScrollView.showsVerticalScrollIndicator = YES;
//        }
//        else {
//        }
    }
    
    scrollView.previousOffsetY = scrollView.contentOffset.y;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    if (collectionView == self.mainScrollView) {
        return CGSizeMake(SCREEN_WIDTH, 200);
    } else {
        return CGSizeZero;
    }
}

- (void)collectionView:(UICollectionView *)collectionView didEndDisplayingCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
    if (collectionView == self.mainScrollView) {
        [self.subScrollView setFrame:cell.bounds];
    }
}

#pragma mark - Lazy
- (UICollectionView *)mainScrollView {
    if (!_mainScrollView) {
        //        UIScrollView *v = [self.class createScrollView];
        UICollectionViewFlowLayout *layout = UICollectionViewFlowLayout.new;
        layout.estimatedItemSize = CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT);
        layout.minimumLineSpacing = 0;
        layout.minimumInteritemSpacing = 0;
        
        LGCollectionView *v = [[LGCollectionView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) collectionViewLayout:layout];
        [v setBackgroundColor:UIColor.redColor];
        [v setDelegate:self];
        [v setDataSource:self];
        [v.applyViews addObject:self.subScrollView];
        _mainScrollView = v;
    }
    return _mainScrollView;
}

- (UICollectionView *)subScrollView {
    if (!_subScrollView) {
        UICollectionViewFlowLayout *layout = UICollectionViewFlowLayout.new;
        layout.estimatedItemSize = CGSizeMake(100, 100);
        layout.minimumLineSpacing = 10;
        layout.minimumInteritemSpacing = 10;
        
        LGCollectionView *v = [[LGCollectionView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) collectionViewLayout:layout];
        [v setBackgroundColor:UIColor.greenColor];
        [v setDelegate:self];
        [v setDataSource:self];
        v.tag = 1;
        _subScrollView = v;
    }
    return _subScrollView;
}

+ (UIScrollView *)createScrollView {
    UIScrollView *v = [[LGCollectionView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) collectionViewLayout:UICollectionViewFlowLayout.new];
    
    return v;
}
@end

