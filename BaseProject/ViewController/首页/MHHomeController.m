//
//  MHHomeController.m
//  MH漫画控
//
//  Created by mis on 15/10/26.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import "MHHomeController.h"
#import "scrollDisplayViewController.h"
#import "MHBannerViewModel.h"
#import "MHTableViewCell.h"
#import "MHHotrecommandViewModel.h"
#import "MHHomeHeaderView.h"
#import "MHHomepageViewModel.h"
#import "MHNewCollectionViewModel.h"
#import "MHGirlHeader.h"
#import "MHDetaiViewController.h"
#import "MHDetailListViewController.h"
#import "MHSearchResultTableController.h"
#import "RESideMenu.h"
@interface MHHomeController ()<ScrollDisplayViewControllerDelegate,ButtunCheckDelegate,UISearchBarDelegate>
/**
 *  banner的ViewModel
 */
@property (nonatomic,strong)MHBannerViewModel *BannerVM;

/**
 * Hotrecommand的VM
 */
@property (nonatomic,strong)MHHotrecommandViewModel *HotVM;

/**
 * HomePage的VM
 */
@property (nonatomic,strong)MHHomepageViewModel *HomePageVM;

@property (nonatomic,strong)MHNewCollectionViewModel *collectionVM;

/**
 *  滚动视图框架
 */
@property (nonatomic,strong)ScrollDisplayViewController *SVC;

@property (nonatomic,strong)UILabel *titleLabel;

@property (nonatomic,strong)UILabel *descLabel;
/**
 *  遮罩
 */
@property (nonatomic,strong)UIButton *cover;
/**
 *  搜索结果
 */
@property (nonatomic,strong)MHSearchResultTableController *searchResult;
/**
 *  搜索按钮
 */
@property(nonatomic,strong)UISearchBar *searchBar;

@end

@implementation MHHomeController
+ (UINavigationController *)defaultNavi {
    static UINavigationController *navi = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        MHHomeController *vc = [MHHomeController new];
        navi = [[UINavigationController alloc]initWithRootViewController:vc];
    });
    return navi;
}
- (MHSearchResultTableController *)searchResult {
    if (!_searchResult) {
        _searchResult = [[MHSearchResultTableController alloc]init];
        [self addChildViewController:_searchResult];
        [self.view addSubview:_searchResult.view];
        [_searchResult.view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(10);
            make.left.mas_equalTo(20);
            make.right.mas_equalTo(340);
            make.height.mas_equalTo(200);
        }];
        
    }
    return _searchResult;
}
- (UIButton *)cover {
    if (!_cover) {
        _cover = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, kWindowW, kWindowH * 2)];
        _cover.backgroundColor = [UIColor blackColor];
        _cover.alpha = 0;
        /**
         *点击遮盖
         */
        [_cover bk_addEventHandler:^(id sender) {
             [self.searchBar resignFirstResponder];
        } forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_cover];
    }
    return _cover;
}
- (MHNewCollectionViewModel *)collectionVM {
    if (!_collectionVM) {
        _collectionVM  = [MHNewCollectionViewModel new];
    }
    return _collectionVM;
}
-(MHHomepageViewModel *)HomePageVM {
    if (!_HomePageVM) {
        _HomePageVM = [MHHomepageViewModel new];
    }
    return _HomePageVM;
}
- (MHBannerViewModel *)BannerVM {
    if (!_BannerVM) {
        _BannerVM = [MHBannerViewModel new];
    }
    return _BannerVM;
}
- (MHHotrecommandViewModel *)HotVM {
    if (!_HotVM) {
        _HotVM = [MHHotrecommandViewModel new];
        
    }
    return _HotVM;
}
- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.font = [UIFont systemFontOfSize:18];
        _titleLabel.textColor = [UIColor whiteColor];
    }
    return _titleLabel;
}
- (UILabel *)descLabel {
    if (!_descLabel) {
        _descLabel = [[UILabel alloc]init];
        _descLabel.font = [UIFont systemFontOfSize:14];
        _descLabel.numberOfLines = 0;
        _descLabel.textColor = [UIColor whiteColor];
    }
    return _descLabel;
}
- (void)viewDidLoad {
    
    [super viewDidLoad];
   
   
    //发送请求，加载首页数据
    [self senRequest];

   //配资导航栏
    [self configNav];
    /** 中间的搜索框
    系统自带的
     */
    
    UIView *titleView = [[UIView alloc] init];
    titleView.width = kWindowW - 70;
    titleView.height = 28;
    self.navigationItem.titleView = titleView;
    self.searchBar = [[UISearchBar alloc] init];
//  [self.searchBar setBackgroundImage:[UIImage imageNamed:@"editdone_bk"]];

    [self.searchBar setSearchFieldBackgroundImage:[UIImage imageNamed:@"editdone_bk"] forState:UIControlStateNormal];
// [self.searchBar setImage:[UIImage imageNamed:@"nav_search"] forSearchBarIcon:UISearchBarIconSearch  state:UIControlStateNormal];
    [self.searchBar setImage:[UIImage imageNamed:@"barbutton_search_hov"] forSearchBarIcon:UISearchBarIconSearch state:UIControlStateNormal];
    self.searchBar.placeholder = @"请输入关键词";
    self.searchBar.delegate = self;
    self.searchBar.frame = titleView.frame;
    
    [titleView addSubview:self.searchBar];
   
}
- (void)configNav {
    
    UIButton *menuBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    menuBtn.frame = CGRectMake(0, 0, 20, 18);
    [menuBtn setBackgroundImage:[UIImage imageNamed:@"menu"] forState:UIControlStateNormal];
    [menuBtn addTarget:self action:@selector(openOrCloseLeftList) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:menuBtn];
    UINavigationBar *nav = self.navigationController.navigationBar;
    nav.backgroundColor = [UIColor blackColor];
    

}
#pragma mark ---搜索框的代理
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar{

    // 显示遮盖
    [UIView animateWithDuration:0.2 animations:^{
        self.cover.alpha = 0.7;
        self.tableView.scrollEnabled = NO;
    }];
    // 显示搜索框的取消按钮
    [searchBar setShowsCancelButton:YES animated:YES];
    
    
}
/**
 *  键盘弹出：搜索框结束编辑文字
 */
- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar
{
    // 1.显示导航栏
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    
    // 2.隐藏遮盖
    [UIView animateWithDuration:0.2 animations:^{
        self.cover.alpha = 0;
         self.tableView.scrollEnabled = YES;
    }];
    //4. 隐藏搜索框的取消按钮
    [searchBar setShowsCancelButton:NO animated:YES];
    

    //5.移除搜索结果
    searchBar.text = nil;
    self.searchResult.view.hidden = YES;
}


- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    DDLogVerbose(@"点击了搜索框");
    if (searchBar.text.length) {
        self.searchResult.view.hidden = NO;
        self.searchResult.searchText = searchText;
    }else {
        self.searchResult.view.hidden = YES;
    }
}
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    [self.searchBar resignFirstResponder];
}
#pragma －－－－左滑界面
- (void) openOrCloseLeftList {
    
 [self presentLeftMenuViewController:nil];
    
}
- (void)senRequest {
    //获取banner滚动视图的数据
    [self.BannerVM getDataCompleteHandle:^(NSError *error) {
        
        [self configHeaderView];
        
    }];
    [self.tableView registerNib:[UINib nibWithNibName:@"MHTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    self.tableView.allowsSelection = NO;
    
    //获取热门推荐
    [self.HotVM getDataCompleteHandle:^(NSError *error) {
        [self.tableView reloadData];

    }];
    //获取中间以及最后的滚动部分的数据
    [self.HomePageVM getDataCompleteHandle:^(NSError *error) {
        [self.tableView reloadData];
    }];
    
    //获取最新上架的数据
    
    [self.collectionVM getDataCompleteHanle:^(NSError *error) {
        [self.tableView reloadData];
    }];

    
}
//  除去分界线
kRemoveCellSeparator
- (void)configHeaderView {
    UIView *view =  [[UIView alloc]initWithFrame:CGRectMake(0, 0, 0, 200)];
    [_SVC removeFromParentViewController];
    NSArray *imageArr = self.BannerVM.headImageURLs;
    _SVC = [[ScrollDisplayViewController alloc]initWithImgPaths:imageArr];
    _SVC.delegate = self;
    [self addChildViewController:_SVC];
    [view addSubview:_SVC.view];
    [_SVC.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(view);
    }];
   //设置标签的内容
    self.titleLabel.text = [self.BannerVM titleForPage:0];
 
    self.descLabel.text = [self.BannerVM descForPage:0];

    [view addSubview:self.titleLabel];
    
    [view addSubview:self.descLabel];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(view.mas_left).mas_equalTo(10);
        make.bottom.mas_equalTo(view.mas_bottom).mas_equalTo(-50);
    }];
    [self.descLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(view.mas_left).mas_equalTo(10);
        make.top.mas_equalTo(self.titleLabel.mas_bottom).mas_equalTo(10);
    }];
    
    self.tableView.tableHeaderView = view;
    
}
#pragma mark ---ScrollDisplayViewControllerDelegate  
- (void)scrollDisplayViewController:(ScrollDisplayViewController *)scrollDisplayViewController currentIndex:(NSInteger)index {
    //伴随跳动改变表情内容
    self.titleLabel.text = [self.BannerVM titleForPage:index];
    self.descLabel.text = [self.BannerVM descForPage:index];

}
- (void)scrollDisplayViewController:(ScrollDisplayViewController *)scrollDisplayViewController didSelectedIndex:(NSInteger)index {
    DDLogVerbose(@"点击了封面滚动图片");

    MHDetaiViewController *vc = [MHDetaiViewController new];
    MHBannerModel *model = self.BannerVM.dataArr[index];
    vc.ID = model.objects.meta_id.integerValue;
    [self.navigationController pushViewController:vc animated:YES];
    
 

}
#pragma mark - Table view data source
- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 2;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    MHTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.delegate = self;
    
    if (indexPath.row == 0 && indexPath.section == 0) {
            cell.objects = [self.HotVM.objects copy];
        
            return cell;
        
    }else if (indexPath.row == 1 && indexPath.section == 0) {
        if (self.HomePageVM.dataArr.count == 0) {
            
            return cell;
            
        }else {
            
            cell.isShowlabel = NO;
            cell.images = self.HomePageVM.dataArr[3];
         
        }
            return cell;
    }
    if (indexPath.row == 0 && indexPath.section == 1) {
        
            cell.objects =[self.collectionVM.dataArr copy];
        
            return cell;
    }else if (indexPath.row == 1 && indexPath.section == 1) {
            if (self.HomePageVM.dataArr.count == 0) {
                return cell;
            }else {
                cell.isShowlabel = YES;
                cell.images = self.HomePageVM.dataArr[1];
            
            }

            return cell;
    }

    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    return 140;
}
//设置表头的高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 60;
}
//设置表头视图
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == 0 ) {
     return   [MHHomeHeaderView headerView];
    }else {
        MHHomeHeaderView *view = [MHHomeHeaderView headerView];
        view.titleLabel.text = @"第一时间一饱眼福";
        view.contenLabel.text = @"新书上架";
        return view;
    }
}
#pragma mark --- button点击方法
-(void)cellButtnprestnView:(MHTableViewCell *)cell withID:(NSInteger)ID{
    
    MHDetaiViewController *detaiVC = [[MHDetaiViewController alloc]init];
    detaiVC.ID = ID;
    [self.navigationController pushViewController:detaiVC animated:YES];
}
- (void)cellBttonOtherPrestnView:(MHTableViewCell *)cell WithImageModel:(MHHomepageObjectModel *)imageModel {
    MHDetailListViewController *detailListVC = [[MHDetailListViewController alloc]init];
    detailListVC.imageModel = imageModel;
   
    [self.navigationController pushViewController:detailListVC animated:YES];
    
    
}
/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
