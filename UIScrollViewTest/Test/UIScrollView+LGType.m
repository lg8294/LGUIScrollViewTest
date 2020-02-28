//
//  UIScrollView+LGType.m
//  ScrollViewTest
//
//  Created by lg on 2020/2/17.
//  Copyright © 2020 lg. All rights reserved.
//

#import "UIScrollView+LGType.h"
#import <objc/runtime.h>

@implementation UIScrollView (LGType)

- (void)setType:(LGScrollViewType)type {
    objc_setAssociatedObject(self, _cmd, @(type), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (LGScrollViewType)type {
    NSNumber *value = objc_getAssociatedObject(self, @selector(setType:));
    if (value) {
        return (LGScrollViewType)[value integerValue];
    }
    
    [self setType:LGScrollViewType_Min];
    return LGScrollViewType_Min;
}

- (void)setCanScroll:(BOOL)canScroll {
    objc_setAssociatedObject(self, _cmd, @(canScroll), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (BOOL)canScroll {
    id value = objc_getAssociatedObject(self, @selector(setCanScroll:));
    if (value) {
        return [value boolValue];
    }
    return YES;
}
@end
