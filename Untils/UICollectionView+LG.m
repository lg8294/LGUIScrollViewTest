//
//  UICollectionView+LGNibCell.m
//  GuiTuHotel
//
//  Created by lg on 16/3/2.
//  Copyright © 2016年 PJ. All rights reserved.
//

#import "UICollectionView+LG.h"
#import <objc/runtime.h>

NS_ASSUME_NONNULL_BEGIN
@implementation UICollectionView (LGCell)

- (void)lg_registerCellWithClass:(Class)cellClass {
    NSString * cellName = NSStringFromClass(cellClass);
    [self registerClass:cellClass forCellWithReuseIdentifier:cellName];
}

- (void)lg_registerClass:(Class)viewClass forSupplementaryViewOfKind:(NSString *)elementKind {
    NSString * viewName = NSStringFromClass(viewClass);
    [self registerClass:viewClass forSupplementaryViewOfKind:elementKind withReuseIdentifier:viewName];
}


@end

@implementation UICollectionView (LGNibCell)

- (void)lg_registerNibCellWithClass:(Class)cellClass
{
    NSString * cellName = NSStringFromClass(cellClass);
    [self registerNib:[UINib nibWithNibName:cellName bundle:[NSBundle bundleWithIdentifier:cellName]] forCellWithReuseIdentifier:cellName];
}

- (void)lg_registerNibClass:(Class)viewClass forSupplementaryViewOfKind:(NSString *)elementKind {
    NSString * viewName = NSStringFromClass(viewClass);
    [self registerNib:[UINib nibWithNibName:viewName bundle:[NSBundle bundleWithIdentifier:viewName]] forSupplementaryViewOfKind:elementKind withReuseIdentifier:viewName];
}

@end

@implementation UICollectionView (LGOther)

- (NSMutableSet<Class> *)lg_registedCellClass {
    NSMutableSet<Class> *sets = objc_getAssociatedObject(self, _cmd);
    if (!sets) {
        sets = NSMutableSet.new;
        objc_setAssociatedObject(self, _cmd, sets, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return sets;
}

- (NSMutableSet<Class> *)lg_registedSupplementaryViewClass {
    NSMutableSet<Class> *sets = objc_getAssociatedObject(self, _cmd);
    if (!sets) {
        sets = NSMutableSet.new;
        objc_setAssociatedObject(self, _cmd, sets, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return sets;
}

- (nullable __kindof UICollectionViewCell *)lg_dequeueReusableCellWithClass:(Class)cellClass forIndexPath:(NSIndexPath *)indexPath {
    if (![[self lg_registedCellClass] containsObject:cellClass]) {
        [self lg_registerCellWithClass:cellClass];
        [[self lg_registedCellClass] addObject:cellClass];
    }
    return [self dequeueReusableCellWithReuseIdentifier:NSStringFromClass(cellClass) forIndexPath:indexPath];
}

- (nullable __kindof UICollectionReusableView *)lg_dequeueReusableSupplementaryViewOfKind:(NSString *)elementKind withClass:(Class)viewClass forIndexPath:(NSIndexPath *)indexPath {
    if (![[self lg_registedSupplementaryViewClass] containsObject:viewClass]) {
        [self lg_registerClass:viewClass forSupplementaryViewOfKind:elementKind];
        [[self lg_registedSupplementaryViewClass] addObject:viewClass];
    }
    return [self dequeueReusableSupplementaryViewOfKind:elementKind withReuseIdentifier:NSStringFromClass(viewClass) forIndexPath:indexPath];
}

@end
NS_ASSUME_NONNULL_END


