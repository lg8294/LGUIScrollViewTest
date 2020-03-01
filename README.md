#  多个 UIScrollView 嵌套
提供一种解决方案，实现2个同方向滑动的 UIScrollView 嵌套。

## 需求
1. 父视图滑到到指定位置后停止滑动，子视图开始滑动；
2. 子视图滑动到底部后，如果继续向上滑，出现子视图的 bounces 效果；
3. 向下滑动，滑动到顶部的时候，出现父视图的 bounces 效果；

## 实现思路
1. 通过设置父视图的 - (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer 返回 YES，实现父子视图同时响应滑动手势；
2. 通过实现父子视图的代理方法 - (void)scrollViewDidScroll:(UIScrollView *)scrollView，实现需求 1；
3. 通过实现子视图的代理方法 - (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView 实现需求 2；
4. 需求3 默认实现；
