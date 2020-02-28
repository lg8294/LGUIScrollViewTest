//
//  LGCollectionView.m
//  ScrollViewTest
//
//  Created by lg on 2020/2/17.
//  Copyright © 2020 lg. All rights reserved.
//

#import "LGCollectionView.h"
#import "UIScrollView+LGType.h"

@interface LGCollectionView ()<UIGestureRecognizerDelegate>

@end
@implementation LGCollectionView

- (NSMutableArray<UIView *> *)applyViews {
    if (!_applyViews) {
        _applyViews = [@[] mutableCopy];
    }
    return _applyViews;
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    NSLog(@"%@-%p-%p-%@-%@",self.tag?@"green":@"red", self,gestureRecognizer.view,NSStringFromClass(gestureRecognizer.view.class),NSStringFromClass(gestureRecognizer.class));
//    UIScrollViewPanGestureRecognizer *a=nil;
    if ([gestureRecognizer isKindOfClass:NSClassFromString(@"UIScrollViewPanGestureRecognizer")]) {
        return YES;
    }
    return [super gestureRecognizerShouldBegin:gestureRecognizer];
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    UIView *view = gestureRecognizer.view;
    UIView *otherView = otherGestureRecognizer.view;
    
    if (self.applyViews && [self.applyViews containsObject:otherView]) {
//        NSLog(@"%ld-%p %@-%p 允许 %@-%p 同时进行",self.tag,self,NSStringFromClass(view.class),view,NSStringFromClass(otherView.class),otherView);
//        NSLog(@"%@ 允许 %@ 同时进行", view.tag?@"green":@"red",otherView.tag?@"green":@"red");
        return YES;
    }
//    NSLog(@"%ld-%p %@-%p 不允许 %@-%p 同时进行",self.tag,self,NSStringFromClass(view.class),view,NSStringFromClass(otherView.class),otherView);
//    NSLog(@"%@ 不允许 %@ 同时进行", view.tag?@"green":@"red",otherView.tag?@"green":@"red");
////    return [super gestureRecognizer:gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:otherGestureRecognizer];
//    return YES;
    return NO;
}

@end
