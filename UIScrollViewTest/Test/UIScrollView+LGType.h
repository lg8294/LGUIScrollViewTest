//
//  UIScrollView+LGType.h
//  ScrollViewTest
//
//  Created by lg on 2020/2/17.
//  Copyright © 2020 lg. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIScrollView (LGType)

@property(nonatomic) CGFloat previousOffsetY;

/// 默认YES
@property(nonatomic) BOOL canScroll;

@end

NS_ASSUME_NONNULL_END
