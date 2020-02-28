//
//  LGCollectionReusableView.m
//  ScrollViewTest
//
//  Created by lg on 2020/2/17.
//  Copyright © 2020 lg. All rights reserved.
//

#import "LGCollectionReusableView.h"

@implementation LGCollectionReusableView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self prepareForReuse];
    }
    return self;
}

- (void)prepareForReuse {
    self.backgroundColor = UIColor.blueColor;
}
@end
