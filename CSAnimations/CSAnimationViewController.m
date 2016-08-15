//
//  CSAnimationViewController.m
//  ChiefSteward
//
//  Created by Apple on 16/4/26.
//  Copyright © 2016年 李雪松. All rights reserved.
//

#import "CSAnimationViewController.h"

@interface CSAnimationViewController ()<UIScrollViewDelegate>
{
    UIView *_tempView; // 动画执行中需要使用的View // 在动画结束后释放
    Completion _completion; // 动画执行完毕后的回调  // 在动画结束后清除
}
@end

@implementation CSAnimationViewController

static id _instace;

#pragma mark - Life Cycle

+ (id)allocWithZone:(struct _NSZone *)zone {
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        _instace = [super allocWithZone:zone];
    });
    return _instace;
}

+ (instancetype)sharedInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instace = [[self alloc] init];
    });
    return _instace;
}

- (id)copyWithZone:(NSZone *)zone {
    return _instace;
}


- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [_tempView removeFromSuperview];
    _tempView = nil;
}

#pragma mark - init View
#pragma mark - Network Request

#pragma mark - UITableViewDelegate

#pragma mark - ScrollViewDelegate


- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
//    if (_animationLayers.count > 0) {
//        CALayer *transitionLayer =  _animationLayers[0];
//        transitionLayer.hidden = YES;
//        [transitionLayer removeFromSuperlayer];
//        [_animationBigLayers removeObjectAtIndex:0];
//    }
}
#pragma mark - CustomDelegate
#pragma mark - Event Response
#pragma mark - Private Methods
// 商品添加到购物车动画
- (void)addProductsAnimationWithImageView:(UIImageView *)imageView toX:(CGFloat)toX completion:(Completion)completion {
    
    if (_animationLayers == nil) {
        _animationLayers = [NSMutableArray array];
    }
    
    _completion = completion; // 动画执行完毕后的回调  // 在动画结束后
    
    // 为了解决 添加商品 到购物车的动画最终的落点不在购车的两个车轮子中间、
    // 因为tabBar在Window的最上层, 挡住了动画的一部分
    // 所以在动画进行中的时候，需要一个临时的View在Window的最上层，用来显示动画
    // 这样tabBar才不会挡住 动画最终的落点
    
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    
    if (_tempView == nil) {
        _tempView = [[UIView alloc] init];
        _tempView.userInteractionEnabled = NO;
        _tempView.backgroundColor = [UIColor clearColor];
        [window addSubview:_tempView];
        [window bringSubviewToFront:_tempView];
    }
    _tempView.frame = window.bounds;
    
    CGFloat x = toX+2;
    CGFloat y = _tempView.layer.frame.size.height - 25;
    CGPoint p3 = CGPointMake(x, y);
    [self animationWithImageView:imageView Point:p3 forkey:@"cartParabola"];
}

// MARK: - 添加商品到右下角购物车动画
- (void)addProductsToBigShopCarAnimation:(UIImageView *)imageView {
    if (_animationBigLayers == nil) {
        _animationBigLayers = [NSMutableArray array];
    }

    CGPoint p3 = CGPointMake(imageView.superview.frame.size.width - 40, imageView.superview.layer.bounds.size.height - 40);
    [self animationWithImageView:imageView Point:p3 forkey:@"BigShopCarAnimation"];
}



- (void)animationWithImageView:(UIImageView *)imageView Point:(CGPoint)point forkey:(NSString *)key {
    
    CGRect frame = [imageView convertRect:imageView.bounds toView:self.view];
    CALayer *transitionLayer = [[CALayer alloc] init];
    transitionLayer.frame = frame;
    transitionLayer.contents = imageView.layer.contents;

//    [self.view.layer addSublayer:transitionLayer];
    [_tempView.layer addSublayer:transitionLayer];
    [self.animationLayers addObject:transitionLayer];
    
    CGPoint p1 = transitionLayer.position;
    CGPoint p3 = point;
    
    CAKeyframeAnimation *positionAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, nil, p1.x, p1.y);
//    CGPathAddCurveToPoint(path, nil, p1.x+30, p1.y-30, p3.x, p1.y+200, p3.x, p3.y);
    CGPathAddCurveToPoint(path, nil, p1.x, p1.y, p3.x, p1.y, p3.x, p3.y);
    positionAnimation.path = path;
    
    // 动画执行过程中的透明度... opacity 类似于 UIView 的 alpha // opacityAnimation 可以不设置
    CABasicAnimation *opacityAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    opacityAnimation.fromValue = @1;
    opacityAnimation.toValue = @.7;
    
    CABasicAnimation *transformAnimation = [CABasicAnimation animationWithKeyPath:@"transform"];
    transformAnimation.fromValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
    transformAnimation.toValue = [NSValue valueWithCATransform3D:CATransform3DScale(CATransform3DIdentity, 0.13, 0.13, 1)];
    
    CAAnimationGroup *groupAnimation = [[CAAnimationGroup alloc] init];
    groupAnimation.animations = @[positionAnimation, transformAnimation, opacityAnimation];
    groupAnimation.duration = .5;
    groupAnimation.delegate = self;
//  闪闪闪闪闪闪闪闪闪闪闪闪还是那个闪闪闪闪闪闪闪闪闪闪
    groupAnimation.removedOnCompletion = NO;
    groupAnimation.fillMode = kCAFillModeForwards;
    [transitionLayer addAnimation:groupAnimation forKey:key];
}

// MARK: - 动画停止后的回调
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    
    if (self.animationLayers.count > 0) {
        CALayer *transitionLayer = self.animationLayers[0];
        transitionLayer.hidden = YES;
        [transitionLayer removeFromSuperlayer];
        [_animationLayers removeObjectAtIndex:0];
        [_tempView.layer removeAnimationForKey:@"cartParabola"];
    }
    
    if (self.animationBigLayers.count > 0) {
        CALayer *transitionLayer = self.animationBigLayers[0];
        transitionLayer.hidden = YES;
        [transitionLayer removeFromSuperlayer];
        [_animationBigLayers removeObjectAtIndex:0];
        [_tempView.layer removeAnimationForKey:@"BigShopCarAnimation"];
    }
    if (_completion) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            _completion();
            // _completion = nil;
        });
    }
}


#pragma mark - Public Methods
#pragma mark - Getters And Setters


@end
