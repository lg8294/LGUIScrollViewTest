//
//  UICollectionView+LGNibCell.h
//  GuiTuHotel
//
//  Created by lg on 16/3/2.
//  Copyright © 2016年 PJ. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@interface UICollectionView (LGCell)

- (void)lg_registerCellWithClass:(Class)cellClass;
- (void)lg_registerClass:(Class)viewClass forSupplementaryViewOfKind:(NSString *)elementKind;

@end

@interface UICollectionView (LGNibCell)

/**
 *  注册一个nib类型的cell,reuseIdentifier为cell的类名
 *
 *  @param cellClass cell类
 */
- (void)lg_registerNibCellWithClass:(Class)cellClass;
- (void)lg_registerNibClass:(Class)viewClass forSupplementaryViewOfKind:(NSString *)elementKind;


@end

@interface UICollectionView (LGOther)

/// 重用一个 cell，如果 cellClass 未注册，会自动注册
/// @param cellClass  cell 类
/// @param indexPath indexPath description
- (nullable __kindof UICollectionViewCell *)lg_dequeueReusableCellWithClass:(Class)cellClass forIndexPath:(NSIndexPath *)indexPath;

/// 重用一个 SupplementaryView，如果未注册，会自动注册
/// @param elementKind elementKind description
/// @param viewClass viewClass description
/// @param indexPath indexPath description
- (nullable __kindof UICollectionReusableView *)lg_dequeueReusableSupplementaryViewOfKind:(NSString *)elementKind withClass:(Class)viewClass forIndexPath:(NSIndexPath *)indexPath;

@end

NS_ASSUME_NONNULL_END
