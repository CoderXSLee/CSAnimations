//
//  SCAnimationViewController.h
//  ChiefSteward
//
//  Created by Apple on 16/4/26.
//  Copyright © 2016年 李雪松. All rights reserved.
//

#import <UIKit/UIKit.h>

/** 动画执行完成的回调block */
typedef void (^Completion )(void);

@interface SCAnimationViewController : UIViewController

@property (nonatomic, strong) NSMutableArray <CALayer *> *animationLayers;

@property (nonatomic, strong) NSMutableArray <CALayer *> *animationBigLayers;


// MARK: 商品添加到购物车动画
- (void)addProductsAnimationWithImageView:(UIImageView *)imageView toX:(CGFloat)toX completion:(Completion)completion NS_AVAILABLE_IOS(8_0);

// MARK: - 添加商品到右下角购物车动画
- (void)addProductsToBigShopCarAnimation:(UIImageView *)imageView;


@end
