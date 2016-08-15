/**************************************************************
 文件名称：XSViewController.m
 作   者：李雪松
 备   注：
 创建时间：15-1-21.
 修改历史：
 版权信息：  Copyright (c) 2015年 Ariel. All rights reserved.
 ***************************************************************/

#import "CSViewController.h"
//#import "MJChiBaoZiHeader.h"
//#import "MJChiBaoZiFooter.h"

#define navigationViewWidth (CGRectGetWidth(self.navigationView.frame))
#define navigationViewHeight (CGRectGetHeight(self.navigationView.frame))
#define leftViewWidth (CGRectGetWidth(_leftView.frame))
#define leftViewHeight (CGRectGetHeight(_leftView.frame))
#define centerViewWidth (CGRectGetWidth(_centerView.frame))
#define rightViewWidth (CGRectGetWidth(_rightView.frame))

@interface CSViewController ()

@end

@implementation CSViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // iOS 7 的时候 当控制器中有 navigationbar,statusBar,tabBar,时
    // 系统会自动调整 UIScrollview 的 contentInset,
    // 设置为 NO 不让系统自动调整, 需要自己调整
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    // 隐藏系统的导航条
    self.navigationController.navigationBar.hidden = YES;
    
//    self.edgesForExtendedLayout = UIRectEdgeNone;
//    self.extendedLayoutIncludesOpaqueBars = NO;
//    self.modalPresentationCapturesStatusBarAppearance = NO;
    
    self.view.backgroundColor = UIColorFromHEX(0xf1f1f1);
    
    // 设置状态栏 高亮白色样式
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    self.tabBarHeight = 49;
    self.navigationHeight = 64;
}

- (void)setLeftView:(UIView *)leftView
{
    _leftView = leftView;
    [self.navigationView addSubview:_leftView];
    _leftView.frame = CGRectMake(0, 20, leftViewWidth, MIN(leftViewHeight, navigationViewHeight-20));
}

- (void)setRightView:(UIView *)rightView
{
    _rightView = rightView;
    [self.navigationView addSubview:_rightView];
    _rightView.frame = CGRectMake(navigationViewWidth - MAX(rightViewWidth, 50), 20, MAX(rightViewWidth, 50), 44);
}

- (void)setCenterView:(UIView *)centerView
{
    [_centerView removeFromSuperview];
    _centerView = centerView;
    [self.navigationView addSubview:_centerView];
    _centerView.frame = CGRectMake(MAX((navigationViewWidth - centerViewWidth)/2, 50), 20, MIN(centerViewWidth, navigationViewWidth-100) ,44 );
}

- (UIView *)navigationView
{
    if (_navigationView == nil) {
        _navigationView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, APP_SCREEN_WIDTH,64)];
        _navigationView.backgroundColor = UIColorFromRGB(164,0,8);
        // _lineView = [[UIView alloc] initWithFrame:CGRectMake(0, navigationViewHeight - 0.5, APP_SCREEN_WIDTH, 0.5)];
        // _lineView.backgroundColor = [UIColor grayColor];
        // _lineView.alpha = 0.5;
        // [_navigationView addSubview:_lineView];
        [self.view addSubview:_navigationView];
      
    }
    return _navigationView;
}

//- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
//{
//    if (self.navigationController.viewControllers.count == 1)//关闭主界面的右滑返回
//    {
//        return NO;
//    }
//    else
//    {
//        return YES;
//    }
//}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

-(BOOL)shouldAutorotate
{
    return NO;
}

-(UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait;
}

- (void)dealloc
{
    //     [[NSNotificationCenter defaultCenter] removeObserver:self name:MCNetworkingReachabilityDidChangeNotification object:nil];
    LSLog(@">>>>>> 控制器释放 <<<<<<");
}

//================================ 刷新控件 ================================
- (void)headerWithScrollView:(UIScrollView *)scrollView refreshingTarget:(id)target refreshingAction:(SEL)action {
//    MJChiBaoZiHeader *header = [MJChiBaoZiHeader headerWithRefreshingTarget:target refreshingAction:action];
//    header.lastUpdatedTimeLabel.hidden = YES;
//    header.stateLabel.hidden = YES;
//    scrollView.mj_header = header;
//    self.mj_header = header;
}

- (void)footerWithScrollView:(UIScrollView *)scrollView refreshingTarget:(id)target refreshingAction:(SEL)action {
//    MJChiBaoZiFooter *footer = [MJChiBaoZiFooter footerWithRefreshingTarget:target refreshingAction:action];
//    footer.triggerAutomaticallyRefreshPercent = 0.5;
//    footer.refreshingTitleHidden = YES;
//    scrollView.mj_footer = footer;
//    self.mj_footer = footer;
}

#pragma mark - Getters and Setters

- (void)setCenterTitle:(NSString *)centerTitle {
    NSAssert(centerTitle != nil, @"centerTitle不能为nil");
    _centerTitle = [centerTitle copy];
    // 标题
    UILabel *centerTitlelabel = [[UILabel alloc]init];
    centerTitlelabel.text = centerTitle;
    centerTitlelabel.backgroundColor = [UIColor clearColor];
    centerTitlelabel.textColor = [UIColor whiteColor];
    centerTitlelabel.font = CSAUTOFONT(18);
    [centerTitlelabel sizeToFit];
    self.centerView = centerTitlelabel;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.view bringSubviewToFront:_navigationView];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
     LSLog(@">>>打开当前类：%@",[NSString stringWithUTF8String:object_getClassName(self)]);
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        if (self.statisticTitle&&![self.statisticTitle isEqualToString:@""]) {
//            [[MCStatistical sharedInstance] pageviewStartWithName:self.MC_Title];
            
        }
    });
}

-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    LSLog(@">>>退出当前类：%@",[NSString stringWithUTF8String:object_getClassName(self)]);
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        if (self.statisticTitle&&![self.statisticTitle isEqualToString:@""]) {
//            [[MCStatistical sharedInstance] pageviewEndWithName:self.MC_Title];
        }
    });
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.4 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        [SVProgressHUD dismiss];
//    });
}

- (void)backButtonClick:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)closeButtonClick:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

//- (UIStatusBarStyle)preferredStatusBarStyle {
//    return UIStatusBarStyleLightContent;
//}

@end
