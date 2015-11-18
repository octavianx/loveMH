
//
//  MHRecentUpdateController.m
//  MHK
//
//  Created by mis on 15/11/12.
//  Copyright © 2015年 Tarena. All rights reserved.
//



#import "MHRecentUpdateController.h"
#import "MHRecentUpdateViewModel.h"
#import "RESideMenu.h"
#import "MHSearchResultViewModel.h"
#import "MHSearchResultTableController.h"
#import "MHDetaiViewController.h"
#import "CHTCollectionViewWaterfallLayout.h"
#import "PSCollectionView.h"
@implementation MHRecentUpdateCell

- (UILabel *)nameLb {
    if (_nameLb == nil) {
        _nameLb = [[UILabel alloc]init];
        _nameLb.font = [UIFont systemFontOfSize:11];
        _nameLb.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:_nameLb];
        [_nameLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(0);
            make.top.mas_equalTo(_iconView.mas_bottom).mas_equalTo(0);
        }];
    }
    return _nameLb;
}
- (UIImageView *)iconView {
    if (_iconView == nil) {
        _iconView = [[UIImageView alloc]init];
        [self.contentView addSubview:_iconView];
        [_iconView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.mas_equalTo(0);
            make.height.mas_equalTo(_iconView.mas_width);
        }];
    }
    return _iconView;
}



@end


@interface MHRecentUpdateController ()<UICollectionViewDelegate,UICollectionViewDataSource,CHTCollectionViewDelegateWaterfallLayout,UISearchBarDelegate>

@property(nonatomic,strong)UICollectionView *collectionView;
/**
 *  Recent的VM
 */
@property(nonatomic,strong)MHRecentUpdateViewModel *RecentVM;
/**
 *  搜索框
 */
@property(nonatomic,strong)UISearchBar *searchBar;

//所有item的大小
@property(nonatomic,strong)NSArray *cellSizes;

@end

@implementation MHRecentUpdateController


+ (UINavigationController *)defaultNav {
  static  UINavigationController *nav = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        MHRecentUpdateController *vc = [MHRecentUpdateController new];
        nav = [[UINavigationController alloc]initWithRootViewController:vc];
    });
    return nav;
}

- (NSArray *)cellSizes {
    if (!_cellSizes) {
        _cellSizes = @[
                       [NSValue valueWithCGSize:CGSizeMake(50, 50)],
                       [NSValue valueWithCGSize:CGSizeMake(50, 60)]
                      // [NSValue valueWithCGSize:CGSizeMake(80, 70)]
//                       [NSValue valueWithCGSize:CGSizeMake(100, 200)],
                      // [NSValue valueWithCGSize:CGSizeMake(100, 120)]
                       ];
    }
    return _cellSizes;
}

- (UICollectionView *)collectionView {
    if(_collectionView == nil) {
        CHTCollectionViewWaterfallLayout *layout = [[CHTCollectionViewWaterfallLayout alloc] init];
        layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
        layout.headerHeight = 10;
        layout.minimumColumnSpacing = 10;
        layout.minimumInteritemSpacing = 15;
        layout.columnCount = 3;
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        [self.view addSubview:_collectionView];
        _collectionView.backgroundColor = [UIColor whiteColor];
        [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(_searchBar.mas_bottom).mas_equalTo(0);
            make.left.right.bottom.mas_equalTo(0);
        }];
        // 设置代理
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        
        
        _collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            [self.RecentVM refreschDataWithCompletionHandle:^(NSError *error) {
                [_collectionView reloadData];
                [_collectionView.mj_header endRefreshing];
            }];
        }];
        _collectionView.mj_footer = [MJRefreshBackStateFooter footerWithRefreshingBlock:^{
            [self.RecentVM getMoreDateWithCompletionHandle:^(NSError *error) {
                if (error) {
                    [self showErrorMsg:error.localizedDescription];
                    [_collectionView.mj_footer endRefreshing];
                }else {
                    [_collectionView reloadData];
                    [_collectionView.mj_footer endRefreshing];
                }
            }];
        }];
        [_collectionView registerClass:[MHRecentUpdateCell class] forCellWithReuseIdentifier:@"Cell"];
    }
    return _collectionView;
}

- (UISearchBar *)searchBar {
    if (!_searchBar ) {
        _searchBar = [[UISearchBar alloc]initWithFrame:CGRectZero];
        
        
        [self.searchBar setSearchFieldBackgroundImage:[UIImage imageNamed:@"editdone_bk"] forState:UIControlStateNormal];
        [self.searchBar setImage:[UIImage imageNamed:@"barbutton_search_hov"] forSearchBarIcon:UISearchBarIconSearch state:UIControlStateNormal];
        self.searchBar.placeholder = @"请输入关键词";
        self.searchBar.delegate = self;
        [self.view addSubview:_searchBar];
        
        [_searchBar mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(64);
            make.left.right.mas_equalTo(0);
            make.height.mas_equalTo(30);
        }];
    }
    return _searchBar;
}
- (MHRecentUpdateViewModel *)RecentVM {
    if (!_RecentVM) {
        _RecentVM = [MHRecentUpdateViewModel new];
    }
    return _RecentVM;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"最近更新";
    [self conNav];
    self.searchBar.hidden = NO;
    
    
    [self collectionView];
    
    [_collectionView.mj_header beginRefreshing];
    
    
    // Do any additional setup after loading the view.
}
- (void)conNav {
    UIButton *menuBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    menuBtn.frame = CGRectMake(0, 0, 20, 18);
    [menuBtn setBackgroundImage:[UIImage imageNamed:@"menu"] forState:UIControlStateNormal];
    [menuBtn addTarget:self action:@selector(openOrCloseLeftList) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:menuBtn];
    
    UINavigationBar *nav = self.navigationController.navigationBar;
    nav.backgroundColor = [UIColor blackColor];

}
#pragma －－－－左滑界面
- (void)openOrCloseLeftList {
    
    [self presentLeftMenuViewController:nil];
    
}
#pragma mark 搜索框的代理
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    
    MHSearchResultTableController *vc = [MHSearchResultTableController new];
    
    vc.searchText = searchBar.text;
    
    [self.navigationController pushViewController:vc animated:YES];
    // 隐藏搜索框的取消按钮
    [searchBar setShowsCancelButton:NO animated:YES];

    DDLogVerbose(@"点击了最近更新的搜索按钮 %@",searchBar.text);
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    searchBar.text = nil;
    [searchBar setShowsCancelButton:NO animated:YES];
    [self.searchBar resignFirstResponder];
}
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar{
    
    
    // 显示搜索框的取消按钮
    [searchBar setShowsCancelButton:YES animated:YES];
    
    
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.RecentVM.rowNum;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    MHRecentUpdateCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    [cell.iconView setImageWithURL:[self.RecentVM iconViewForRow:indexPath.row]];
    cell.nameLb.text = [self.RecentVM titleForRow:indexPath.row];
    
    return cell;
}
#pragma mark --- delegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    MHDetaiViewController *vc = [MHDetaiViewController new];
    vc.ID = [self.RecentVM IdForRow:indexPath.row];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark ---- layout

///** section的上下左右边距 */
//- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
//    return UIEdgeInsetsMake(5, 20, 5, 20);
//}
///** 最小行间距 */
//- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
//    return 5;
//}
/** 每格cell的 宽高 */
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
//    CGFloat width = (kWindowW - 4 * 20) / 3;
//    CGFloat height = width + 17;
//    return CGSizeMake(width, height);
    
    return [self.cellSizes[indexPath.row % 2] CGSizeValue];
}
//- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
//    return 20;
//}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
