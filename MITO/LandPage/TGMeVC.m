//
//  TGMeVC.m
//  baisibudejie
//
//  Created by targetcloud on 2017/3/5.
//  Copyright © 2017年 targetcloud. All rights reserved.
//

#import "TGMeVC.h"
#import "TGSettingVC.h"
#import <MJExtension/MJExtension.h>
#import "TGSquareM.h"
#import "TGSquareCell.h"

static NSString * const ID = @"cell";
static NSInteger const cols = 4;
static CGFloat const onemargin = 1;
#define itemWH (ScreenW - (cols - 1) * onemargin) / cols

@interface TGMeVC ()<UICollectionViewDataSource,UICollectionViewDelegate>//,SFSafariViewControllerDelegate
@property (nonatomic, strong) NSMutableArray *squareItems;
@property (nonatomic, weak) UICollectionView *collectionV;
@end

@implementation TGMeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNavBar];
    [self setupFootView];
    [self loadData];
    
    self.tableView.sectionHeaderHeight = 0;
    self.tableView.sectionFooterHeight = Margin;
    
    self.tableView.contentInset = UIEdgeInsetsMake(Margin - 35, 0, 0, 0);
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tabBarButtonDidRepeatClick) name:TabBarButtonDidRepeatClickNotification object:nil];
}

//-(void) viewDidAppear:(BOOL)animated{
//    [super viewDidAppear:animated];
//    NSLog(NSStringFromUIEdgeInsets(self.tableView.contentInset));//2017-03-07 20:20:09.400 baisibudejie[2910:88464] {64, 0, 49, 0}
//}

- (void)loadData{
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    
    NSMutableSet *newSet = [NSMutableSet set];
    newSet.set = mgr.responseSerializer.acceptableContentTypes;
    [newSet addObject:@"text/html"];
    mgr.responseSerializer.acceptableContentTypes = newSet;
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"a"] = @"square";
    parameters[@"c"] = @"topic";
    
    
    [KTHttpTool get:CommonURL params:parameters success:^(id responseObj) {
        NSArray *dictArr = responseObj[@"square_list"];
        _squareItems = [TGSquareM mj_objectArrayWithKeyValuesArray:dictArr];
        [self resloveData];
        NSInteger count = _squareItems.count;
        NSInteger rows = (count - 1) / cols + 1;
        self.collectionV.height = rows * itemWH;
        self.tableView.tableFooterView = self.collectionV;//MARK:2
        [self.collectionV reloadData];
    } failure:^(NSError *error) {
        
    }];
    
}

- (void)resloveData{//一行补足剩余空白
    NSInteger exter = self.squareItems.count % cols;
    if (exter) {
        exter = cols - exter;
        for (int i = 0; i < exter; i++) {
            [self.squareItems addObject:[[TGSquareM alloc] init]];
        }
    }
}

- (void)setupNavBar{
    UIBarButtonItem *settingItem =  [UIBarButtonItem itemWithimage:[UIImage imageNamed:@"mine-setting-icon"] highImage:[UIImage imageNamed:@"mine-setting-icon-click"] target:self action:@selector(setting)];
    UIBarButtonItem *nightItem =  [UIBarButtonItem itemWithimage:[UIImage imageNamed:@"mine-moon-icon"] selImage:[UIImage imageNamed:@"mine-moon-icon-click"] target:self action:@selector(night:)];
    self.navigationItem.rightBarButtonItems = @[settingItem,nightItem];
    self.navigationItem.title = @"我的";
    
}

- (void)setupFootView{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(itemWH, itemWH);
    layout.minimumInteritemSpacing = onemargin;
    layout.minimumLineSpacing = onemargin;
    
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, 0, 1) collectionViewLayout:layout];
    _collectionV = collectionView;
    collectionView.backgroundColor = self.tableView.backgroundColor;
    self.tableView.tableFooterView = collectionView;//MARK:1
    collectionView.dataSource = self;
    collectionView.delegate = self;
    collectionView.scrollEnabled = NO;
    [collectionView registerNib:[UINib nibWithNibName:@"TGSquareCell" bundle:nil] forCellWithReuseIdentifier:ID];
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)night:(UIButton *)button{
    button.selected = !button.selected;
}

- (void)setting{
    TGSettingVC *settingVc = [[TGSettingVC alloc] init];
    [self.navigationController pushViewController:settingVc animated:YES];
}

- (void)tabBarButtonDidRepeatClick{
    if (self.view.window == nil) return;
    TGFunc
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.squareItems.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    TGSquareCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    cell.item = self.squareItems[indexPath.row];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    TGSquareM *item = self.squareItems[indexPath.row];
    if (![item.url containsString:@"http"]) return;
    
    
    
}

/*
//MARK: SFSafariViewController delegate
- (void)safariViewControllerDidFinish:(SFSafariViewController *)controller{
    self.navigationController.navigationBarHidden = NO;
    [self.navigationController popViewControllerAnimated:YES];
}
*/
@end
