//
//  UIScrollView+LGType.h
//  ScrollViewTest
//
//  Created by lg on 2020/2/17.
//  Copyright © 2020 lg. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, LGScrollViewType) {
    LGScrollViewType_Min,
    LGScrollViewType_Center,
    LGScrollViewType_Max,
};

@interface UIScrollView (LGType)

@property(nonatomic) LGScrollViewType type;

/// 默认YES
@property(nonatomic) BOOL canScroll;

@end

NS_ASSUME_NONNULL_END
