//
//  TGEssenceNewVC.m
//  baisibudejie
//
//  Created by targetcloud on 2017/5/29.
//  Copyright © 2017年 targetcloud. All rights reserved.
//  Blog http://blog.csdn.net/callzjy
//  Mail targetcloud@163.com
//  Github https://github.com/targetcloud

#import "TGEssenceNewVC.h"
#import "ImageViewCell.h"
#import "LBPhotoBrowserManager.h"
#import "Peoper_dataModel.h"
#import "PeoperModel.h"
#import "TGPublishV.h"
@interface TGEssenceNewVC ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property(nonatomic , strong)NSMutableArray *dataArr;
@property(nonatomic , strong)UICollectionView *collectionView;
@property(nonatomic ,assign)NSInteger currentPage;
@end
const int PageSize = 10;
@implementation TGEssenceNewVC

-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;//UIStatusBarStyleDefault;
}

- (void)viewDidLoad {
    [super viewDidLoad];
     _currentPage = 5;
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self setupNavBar];
    [self initCollectView];
    [self loadData:_currentPage];
}

- (void)loadData:(NSInteger)page{
    
    NSString * url = [NSString stringWithFormat:@"http://wallpaper.apc.360.cn/index.php?c=WallPaper&a=getAppsByCategory&cid=9&start=%ld&count=10&from=360chrome",page];
    
    [KTHttpTool post:url  params:nil success:^(id responseObj) {
        NSString* success =responseObj[@"errno"];
        if (success.intValue == 0) {
            
            PeoperModel * model = [PeoperModel yy_modelWithDictionary:responseObj];
            for (Peoper_dataModel * mod in model.data) {
                [self.dataArr addObject:mod];
            }
        }
        [_collectionView reloadData];
    } failure:^(NSError *error) {
        
    }];
    
}

- (void)initCollectView{
    
    UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc]init];
    self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 64, kWidth, kHeight-108) collectionViewLayout:layout];
    self.collectionView.showsVerticalScrollIndicator = NO;
    self.collectionView.backgroundColor = [UIColor colorWithRed:235.0/255.0 green:235.0/255.0 blue:235.0/255.0 alpha:1];
    [self.collectionView registerClass:[ImageViewCell class] forCellWithReuseIdentifier:@"imageCellIdentify"];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.view addSubview:self.collectionView];
    
    DefineWeakSelf;
    self.collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        _currentPage = 5;
        [weakSelf handleRefresh:_currentPage];
       
    }];
    
    self.collectionView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        _currentPage += 1;
         [weakSelf handleRefresh:_currentPage];
    }];
    
    
}

- (void)handleRefresh:(NSInteger)page
{
    [self loadData:page];
    [self.collectionView.mj_header endRefreshing];
    [self.collectionView.mj_footer  endRefreshing];
}

#pragma mark -- UICollectionView datasource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return self.dataArr.count;
}

// 每个cell的尺寸
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(nonnull UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    return CGSizeMake(kWidth/3 - 2, kHeight/3 - 2);
}

// 垂直间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(nonnull UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 4;
}

// 水平间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(nonnull UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 2;
}

// cell
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    ImageViewCell *cell = (ImageViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"imageCellIdentify" forIndexPath:indexPath];
    
    Peoper_dataModel *model = self.dataArr[indexPath.row];
    cell.model = model;
    
    return cell;
}

#pragma mark - UICollectionView Delegate
// 点击cell响应
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSMutableArray *dataImgUrlMArr = [NSMutableArray array];
    for (Peoper_dataModel * model in self.dataArr) {
        [dataImgUrlMArr addObject:model.url_mobile];
    }
    [[LBPhotoBrowserManager defaultManager] showImageWithURLArray:dataImgUrlMArr fromCollectionView:collectionView selectedIndex:(int)indexPath.row unwantedUrls:nil];
    [[[LBPhotoBrowserManager defaultManager] addLongPressShowTitles:@[@"保存图片",@"分享",@"取消"]] addTitleClickCallbackBlock:^(UIImage *image, NSIndexPath *indexPath, NSString *title) {
        
        NSLog(@"%@%ld%@",image,indexPath.row,title);
        
        if (indexPath.row==1) {
            TGPublishV *publishV = [TGPublishV viewFromXIB];
            publishV.imgUrl = dataImgUrlMArr[indexPath.row];
            [[UIApplication sharedApplication].keyWindow addSubview:publishV];
            publishV.frame = [UIApplication sharedApplication].keyWindow.bounds;
        }
       
    }].lowGifMemory = NO;
}

- (NSMutableArray *)dataArr
{
    if (!_dataArr) {
        self.dataArr = [[NSMutableArray alloc] init];
    }
    return _dataArr;
}

- (void)setupNavBar{
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImageName:@"nav_item_game_icon-1" highImageName:@"nav_item_game_click_icon-1" target:self action:@selector(test)];
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithImageName:@"RandomAcross" highImageName:@"RandomAcrossClick" target:self action:@selector(randomAcross)];
    
    self.navigationItem.title = @"壁纸";
    
}

- (void)test{
    TGFunc
}

-(void)randomAcross{
    TGFunc
    
}

@end
