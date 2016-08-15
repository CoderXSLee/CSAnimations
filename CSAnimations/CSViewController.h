/**************************************************************
 文件名称：XSViewController.h
 作   者：李雪松
 备   注：
 创建时间：15-1-21.
 修改历史：
 版权信息：  Copyright (c) 2015年 Ariel. All rights reserved.
 ***************************************************************/

#import <UIKit/UIKit.h>
//#import <MJRefresh/MJRefresh.h>


@interface CSViewController : UIViewController
/** tabBar高度 */
@property (nonatomic, assign) CGFloat tabBarHeight;
/** 导航栏高度 */
@property (nonatomic, assign) CGFloat navigationHeight;
/** 导航栏 */
@property (nonatomic, strong) UIView *navigationView;
/** 导航栏左侧view */
@property (nonatomic, strong) UIView *leftView;
/** 导航栏右侧view */
@property (nonatomic, strong) UIView *rightView;
/** 导航栏中间view */
@property (nonatomic, strong) UIView *centerView;

@property (nonatomic, strong) UIView *lineView;

/** 导航栏标题 */
@property (nonatomic, copy) NSString *centerTitle;
/** 百度界面统计名称 */
@property (nonatomic, strong) NSString *statisticTitle;

//================================ 刷新控件 ================================
/** 下拉刷新控件 */
@property (strong, nonatomic) MJRefreshHeader *mj_header;
/** 上拉刷新控件 */
@property (strong, nonatomic) MJRefreshFooter *mj_footer;
/** 添加下拉刷新 */
- (void)headerWithScrollView:(UIScrollView *)scrollView refreshingTarget:(id)target refreshingAction:(SEL)action;
/** 添加上拉刷新 */
- (void)footerWithScrollView:(UIScrollView *)scrollView refreshingTarget:(id)target refreshingAction:(SEL)action;
@end
