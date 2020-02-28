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
#import "UIScrollView+LGType.h"

#define SCREEN_WIDTH (UIScreen.mainScreen.bounds.size.width)
#define SCREEN_HEIGHT (UIScreen.mainScreen.bounds.size.height)

@interface ViewController ()<UIScrollViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property(nonatomic) UICollectionView *redScrollView;
@property(nonatomic) UICollectionView *greenScrollView;
@property(nonatomic) UIView *containerView;

@property(nonatomic) UIButton *btn;

@end

@implementation ViewController {
    CGFloat _currentOffset;
}
- (void)loadView {
    //    [super loadView];
    //    [self.view addSubview:self.redScrollView];
    self.view = self.redScrollView;
    
    self.btn = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.btn setTitle:@"Reload" forState:UIControlStateNormal];
    [self.btn addTarget:self action:@selector(actionReload) forControlEvents:UIControlEventTouchUpInside];
    [self.btn sizeToFit];
    [self.btn setCenter:CGPointMake(SCREEN_WIDTH/2, SCREEN_HEIGHT/2)];
    [self.view addSubview:self.btn];
}

- (void)actionReload {
    [self.redScrollView reloadData];
    [self.greenScrollView reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self test2];
    
}

- (void)test2 {
    
    [self actionReload];
    //    [self.containerView addSubview:self.greenScrollView];
    //    [self.greenScrollView reloadData];
}
- (void)test1 {
    //    [self.redScrollView setContentSize:CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT+200)];
    //
    //    [self.greenScrollView setFrame:CGRectMake(0, 200, SCREEN_WIDTH, SCREEN_HEIGHT)];
    //    [self.redScrollView addSubview:self.greenScrollView];
    //
    //    UIView *yellowView = UIView.new;
    //    //    yellowView.backgroundColor = UIColor.yellowColor;
    //    [yellowView setGradientBackgroundWithColors:@[UIColor.yellowColor, UIColor.blueColor] locations:nil startPoint:CGPointMake(0, 0) endPoint:CGPointMake(0, 1)];
    //    yellowView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 1000);
    //    [self.greenScrollView addSubview:yellowView];
    //    [self.greenScrollView setContentSize:CGSizeMake(SCREEN_WIDTH, 1000)];
}
#pragma mark - UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (collectionView == self.redScrollView) {
        return 1;
    } else {
        return 100;
    }
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView lg_dequeueReusableCellWithClass:LGCollectionViewCell.class forIndexPath:indexPath];
    if (collectionView == self.redScrollView) {
        [cell.contentView addSubview:self.greenScrollView];
    } else {
        [cell setGradientBackgroundWithColors:@[UIColor.yellowColor, UIColor.blueColor] locations:nil startPoint:CGPointMake(0, 0) endPoint:CGPointMake(0, 1)];
    }
    return cell;
}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    if (collectionView == self.redScrollView) {
        return [collectionView lg_dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withClass:LGCollectionReusableView.class forIndexPath:indexPath];
    } else {
        return nil;
    }
}
#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    NSLog(@"%@ - %@",scrollView.tag==0?@"red":@"green", NSStringFromCGPoint(scrollView.contentOffset));
    /* 方案二 */
    if (scrollView == self.redScrollView) {
        CGFloat contentOffset = scrollView.contentSize.height-CGRectGetHeight(scrollView.bounds);
        
        if (!scrollView.canScroll) {
            // 这里通过固定contentOffset的值，来实现不滚动
            scrollView.contentOffset = CGPointMake(0, contentOffset);
        } else if (scrollView.contentOffset.y >= contentOffset) {
            scrollView.contentOffset = CGPointMake(0, contentOffset);
            scrollView.canScroll = NO;
            
            // 通知delegate内容开始可以滚动
            self.greenScrollView.canScroll = YES;
            //            if (self.delegate && [self.delegate respondsToSelector:@selector(nestTableViewContentCanScroll:)]) {
            //                [self.delegate nestTableViewContentCanScroll:self];
            //            }
        }
        //        scrollView.showsVerticalScrollIndicator = _canScroll;
        
        //        if (self.delegate && [self.delegate respondsToSelector:@selector(nestTableViewDidScroll:)]) {
        //            [self.delegate nestTableViewDidScroll:_tableView];
        //        }
    } else {
        if (!scrollView.canScroll) {
            // 这里通过固定contentOffset，来实现不滚动
            scrollView.contentOffset = CGPointZero;
        } else if (scrollView.contentOffset.y <= 0) {
            scrollView.canScroll = NO;
            // 通知容器可以开始滚动
            self.redScrollView.canScroll = YES;
        }
        //        scrollView.showsVerticalScrollIndicator = _canContentScroll;
    }
    /* 方案一 */
    //    if (scrollView == self.redScrollView) {
    //        BOOL isPullDown = scrollView.contentOffset.y < _currentOffset;
    //        _currentOffset = scrollView.contentOffset.y;
    //        CGFloat maxY = scrollView.contentSize.height-CGRectGetHeight(scrollView.bounds)-0.5;
    //
    //        if (_currentOffset >= maxY) {
    //            // 滑到底部，停止滑动
    //            scrollView.type = LGScrollViewType_Max;
    //
    //        } else if (_currentOffset <= 0) {
    //            // 滑动到顶部
    //            scrollView.type = LGScrollViewType_Min;
    //        } else {
    //            // 在中间可滑动部分
    //            scrollView.type = LGScrollViewType_Center;
    //        }
    //
    //        switch (scrollView.type) {
    //            case LGScrollViewType_Max:
    //            {
    //                scrollView.contentOffset = CGPointMake(scrollView.contentOffset.x, maxY);
    //                //                self.worksVc.collectionView.scrollEnabled = YES;
    //            }
    //                break;
    //            case LGScrollViewType_Center:
    //            {
    //                //                self.worksVc.collectionView.scrollEnabled = NO;
    //                //                if (self.worksVc.offsetType != OffsetTypeCenter) {
    //                //                    [self.worksVc.collectionView setContentOffset:CGPointZero];
    //                //                }
    //            }
    //                break;
    //            case LGScrollViewType_Min:
    //            {
    //                //                self.worksVc.collectionView.scrollEnabled = NO;
    //                [self.greenScrollView setContentOffset:CGPointZero];
    //            }
    //
    //            default:
    //                break;
    //        }
    //
    //        if (self.greenScrollView.type == LGScrollViewType_Center) {
    //            scrollView.contentOffset = CGPointMake(scrollView.contentOffset.x, maxY);
    //        }
    //    } else if (scrollView == self.greenScrollView) {
    ////        LGScrollViewType type = self.redScrollView.type;
    //
    //        if (scrollView.contentOffset.y <= 0) {
    //            scrollView.type = LGScrollViewType_Min;
    //            self.redScrollView.bounces = YES;
    //        }
    //        else if (scrollView.contentOffset.y > scrollView.contentSize.height-scrollView.bounds.size.height-0.5) {
    //            scrollView.type = LGScrollViewType_Max;
    //            self.redScrollView.bounces = NO;
    //        }
    //        else {
    //            scrollView.type = LGScrollViewType_Center;
    //        }
    //
    //
    //
    ////        if (type == LGScrollViewType_Min) {
    ////            scrollView.contentOffset = CGPointZero;
    ////        }
    ////        if (type == LGScrollViewType_Center) {
    ////            scrollView.contentOffset = CGPointZero;
    ////        }
    //    }
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    if (collectionView == self.redScrollView) {
        return CGSizeMake(SCREEN_WIDTH, 200);
    } else {
        return CGSizeZero;
    }
}
- (void)collectionView:(UICollectionView *)collectionView didEndDisplayingCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
    if (collectionView == self.redScrollView) {
        [self.greenScrollView setFrame:cell.bounds];
    }
}
#pragma mark - Lazy
- (UICollectionView *)redScrollView {
    if (!_redScrollView) {
        //        UIScrollView *v = [self.class createScrollView];
        UICollectionViewFlowLayout *layout = UICollectionViewFlowLayout.new;
        layout.estimatedItemSize = CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT);
        layout.minimumLineSpacing = 0;
        layout.minimumInteritemSpacing = 0;
        
        LGCollectionView *v = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) collectionViewLayout:layout];
        [v setBackgroundColor:UIColor.redColor];
        [v setDelegate:self];
        [v setDataSource:self];
        
        _redScrollView = v;
        //        [v.applyViews addObject:self.greenScrollView];
    }
    return _redScrollView;
}

- (UICollectionView *)greenScrollView {
    if (!_greenScrollView) {
        UICollectionViewFlowLayout *layout = UICollectionViewFlowLayout.new;
        layout.estimatedItemSize = CGSizeMake(100, 100);
        layout.minimumLineSpacing = 10;
        layout.minimumInteritemSpacing = 10;
        
        LGCollectionView *v = [[LGCollectionView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) collectionViewLayout:layout];
        [v setBackgroundColor:UIColor.greenColor];
        [v setDelegate:self];
        [v setDataSource:self];
        v.tag = 1;
        _greenScrollView = v;
        [v.applyViews addObject:self.redScrollView];
        //        [v setMultipleTouchEnabled:NO];
        //        [v setAllowsMultipleSelection:NO];
    }
    return _greenScrollView;
}

- (UIView *)containerView {
    if (!_containerView) {
        _containerView = UIView.new;
        [_containerView setBackgroundColor:UIColor.cyanColor];
        //        [self.greenScrollView reloadData];
        //        [_containerView addSubview:self.greenScrollView];
    }
    return _containerView;
}

+ (UIScrollView *)createScrollView {
    UIScrollView *v = [[LGCollectionView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) collectionViewLayout:UICollectionViewFlowLayout.new];
    
    return v;
}
@end

