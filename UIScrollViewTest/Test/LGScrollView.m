//
//  LGScrollView.m
//  ScrollViewTest
//
//  Created by lg on 2020/2/17.
//  Copyright © 2020 lg. All rights reserved.
//

#import "LGScrollView.h"

@interface LGScrollView ()<UIGestureRecognizerDelegate>

@end
@implementation LGScrollView


- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRequireFailureOfGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return YES;
}

@end
