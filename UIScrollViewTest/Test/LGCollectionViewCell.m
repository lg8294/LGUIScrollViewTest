//
//  LGCollectionViewCell.m
//  ScrollViewTest
//
//  Created by lg on 2020/2/17.
//  Copyright © 2020 lg. All rights reserved.
//

#import "LGCollectionViewCell.h"

@implementation LGCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self prepareForReuse];
    }
    return self;
}

- (void)prepareForReuse {
    self.backgroundColor = UIColor.yellowColor;
}
@end
