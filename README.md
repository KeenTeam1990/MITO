# MITO-xiaoshuangbizi
你觉得赞，请Star

### 运行效果

![](https://github.com/KeenTeam1990/MITO/blob/master/PIC/IMG_2585.PNG)

![](https://github.com/KeenTeam1990/MITO/blob/master/PIC/IMG_2586.PNG)

### 点赞效果
![](https://github.com/KeenTeam1990/MITO/blob/master/PIC/IMG_2589.PNG)

### 随听模块效果
![](https://github.com/KeenTeam1990/MITO/blob/master/PIC/IMG_2590.PNG)

### 下拉刷新控件效果
![](https://github.com/KeenTeam1990/MITO/blob/master/PIC/IMG_2591.PNG)

pod 'RESideMenu', '~> 4.0.7'

pod 'DACircularProgress'

pod 'FLAnimatedImage'

pod 'Masonry'

pod 'pop'

pod 'Ono'

end
...


```objc
@interface TGEssenceNewVC ()
@property (nonatomic, weak) TGSementBarVC *segmentBarVC;
@end

@implementation TGEssenceNewVC

-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;//UIStatusBarStyleDefault;
}

- (TGSementBarVC *)segmentBarVC {
    if (!_segmentBarVC) {
        TGSementBarVC *vc = [[TGSementBarVC alloc] init];
        [self addChildViewController:vc];
        _segmentBarVC = vc;
    }
    return _segmentBarVC;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.segmentBarVC.segmentBar.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 35);
    self.segmentBarVC.view.frame = self.view.bounds;
    [self.view addSubview:self.segmentBarVC.view];
    NSArray *items = @[@"推荐", @"视频", @"图片", @"段子",@"排行",@"互动区",@"网红",@"社会",@"投票",@"美女",@"冷知识",@"游戏"];
    NSMutableArray* childVCs = [NSMutableArray array];
    [childVCs addObject:[[TGRecommendedVC alloc] init]];
    [childVCs addObject:[[TGVideoPlayVC alloc] init]];
    [childVCs addObject:[[TGPictureVC alloc] init]];
    [childVCs addObject:[[TGJokesVC alloc] init]];
    [childVCs addObject:[[TGRankingVC alloc] init]];
    [childVCs addObject:[[TGInteractVC alloc] init]];
    [childVCs addObject:[[TGRedNetVC alloc] init]];
    [childVCs addObject:[[TGSocietyVC alloc] init]];
    [childVCs addObject:[[TGVoteVC alloc] init]];
    [childVCs addObject:[[TGBeautyVC alloc] init]];
    [childVCs addObject:[[TGColdKnowledgeVC alloc] init]];
    [childVCs addObject:[[TGGameVC alloc] init]];
    [self.segmentBarVC setupWithItems:items childVCs:childVCs];

    [self.segmentBarVC.segmentBar updateViewWithConfig:^(TGSegmentConfig *config) {
        config.selectedColor([UIColor lightTextColor])
              .normalColor([UIColor lightTextColor])
              .selectedFont([UIFont systemFontOfSize:14])
              .normalFont([UIFont systemFontOfSize:13])
              .indicateExtraW(8)
              .indicateH(2)
              .indicateColor([UIColor whiteColor])
              .showMore(NO)//是否显示更多面板
              .circleScroll(YES)//是否循环滚动，第0个再向前，那么到最后一个;最后一个向后，那么到第0个
              .moreCellBGColor([[UIColor grayColor] colorWithAlphaComponent:0.3])
              .moreBGColor([UIColor clearColor])
              .moreCellFont([UIFont systemFontOfSize:13])
              .moreCellTextColor(NavTinColor)
              .moreCellMinH(30)
              .showMoreBtnlineView(YES)
              .moreBtnlineViewColor([UIColor lightTextColor])
              .moreBtnTitleFont([UIFont systemFontOfSize:13])
              .moreBtnTitleColor([UIColor lightTextColor])
              .margin(18)
              .barBGColor(NavTinColor)
        ;
    }];
}
@end
```
### 如果您喜欢本项目,请Star

如果有不懂的地方可以加入QQ交流群讨论：<a target="_blank" href="//shang.qq.com/wpa/qunwpa?idkey=c9dc4ab0b2062e0004b3b2ed556da1ce898631742e15780297feb3465ad08eda">**812144991**</a>。这个QQ群讨论技术范围包括：iOS、H5混合开发、前端开发、PHP开发，欢迎大家讨论技术。

