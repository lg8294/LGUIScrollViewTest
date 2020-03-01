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

- (void)setPreviousOffsetY:(CGFloat)previousOffsetY {
    objc_setAssociatedObject(self, _cmd, @(previousOffsetY), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (CGFloat)previousOffsetY {
    id value = objc_getAssociatedObject(self, @selector(setPreviousOffsetY:));
    if (value) {
        return [value floatValue];
    }
    return 0;
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
