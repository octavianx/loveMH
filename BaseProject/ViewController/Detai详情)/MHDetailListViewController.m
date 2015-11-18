//
//  MHDetailListViewController.m
//  MH漫画控
//
//  Created by mis on 15/10/31.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import "MHDetailListViewController.h"
#import "MHDetaiListCell.h"
#import "MHDetaiFirstCell.h"
#import "MHDetailListViewModel.h"
#import "MHDetaiViewController.h"
@interface MHDetailListViewController ()<MHDetaiListBtnDelegate>

/**
 *  毛玻璃
 */
@property (strong, nonatomic) UIVisualEffectView *EffectView;

@property (strong, nonatomic)MHDetailListViewModel *ListVM;

@property (strong,nonatomic) MHDetaiFirstCell *Fcell;

@end

@implementation MHDetailListViewController
- (UIVisualEffectView *)EffectView {
    if (!_EffectView) {
        UIBlurEffect *effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
        _EffectView = [[UIVisualEffectView alloc]initWithEffect:effect];
        
        
    }
    return _EffectView;
}
- (MHDetailListViewModel *)ListVM {
    if (!_ListVM) {
        _ListVM = [MHDetailListViewModel new];
    }
    return _ListVM;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.allowsSelection = NO;
    
    //配置导航栏
    [self configNav];
    //注册单元格
//    [self.tableView registerNib:[UINib nibWithNibName:@"MHDetaiFirstCell" bundle:nil] forCellReuseIdentifier:@"Fcell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"MHDetaiListCell" bundle:nil]  forCellReuseIdentifier:@"cell"];
    [self.ListVM getRefrshDataWithSlug:self.imageModel.slug Completion:^(NSError *error) {
         [self.tableView reloadData];
    }];
    self.tableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [self.ListVM getMoreDataWithSlug:self.imageModel.slug Completion:^(NSError *error) {
            if (error) {
                [self showErrorMsg:error.localizedDescription];
                [self.tableView.footer endRefreshing];
                [self.tableView.mj_footer endRefreshingWithNoMoreData];
            }else {
                [self.tableView reloadData];
                [self.tableView.footer endRefreshing];

            }
        }];
    }];
    
}
- (void)configNav {
    self.title = self.imageModel.name;
       // [[UIBarButtonItem appearance]
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"barbutton_back_hov"] style:UIBarButtonItemStyleDone target:self action:@selector(back)];
    //设置导航栏背景为透名
    [self.navigationController.navigationBar setShadowImage:[UIImage imageNamed:@"bg_clear"]];
    
    UINavigationBar *nav = self.navigationController.navigationBar;
    nav.titleTextAttributes = @{NSFontAttributeName: [UIFont systemFontOfSize:24],NSForegroundColorAttributeName:[UIColor whiteColor]};
  
    
    UIImageView  *bg = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kWindowW, kWindowH)];
    [bg setImageWithURL:[NSURL URLWithString:self.imageModel.image_url]];
    self.EffectView.frame = bg.frame;
    [bg addSubview:self.EffectView];
    self.tableView.backgroundView = bg;
    
}
- (void)back {
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

        return self.ListVM.rowNum + 1;

}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        MHDetaiFirstCell *Fcell = [MHDetaiFirstCell DetailFirsCell];
        Fcell.bgView.backgroundColor = [UIColor whiteColor];
        Fcell.backgroundColor = [UIColor clearColor];
        [Fcell.coverView setImageWithURL:[NSURL URLWithString:self.imageModel.image_url]];
        Fcell.backgroundColor = [UIColor clearColor];
        return Fcell;
    }else {
        MHDetaiListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
        cell.leftModel = [self.ListVM objectForRow:(indexPath.row - 1)*2];
        cell.rightModel = [self.ListVM objectForRow:(indexPath.row -1)*2 +1];
        cell.delegate = self;
        return cell;
    }
    
}
- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    return 120;
}
- (void)presentMoredetail:(MHDetaiListCell *)cell WithID:(NSInteger)ID {
        DDLogVerbose(@"点击了showmore");
    
    MHDetaiViewController *detaiVC = [[MHDetaiViewController alloc]init];
    detaiVC.ID = ID;
    [self.navigationController pushViewController:detaiVC animated:YES];
}
//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
//   
//    
//    return  headerView;
//}
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


/*
 
 MHDerailListView *headerView = [MHDerailListView ListHeaderView];
 headerView.bgView.hidden = YES;
 headerView.backgroundColor = [UIColor clearColor];
 [headerView.ListCover setImageWithURL:[NSURL URLWithString:self.imageModel.image_url]];
 [Fcell.contentView addSubview:headerView];
 [headerView mas_makeConstraints:^(MASConstraintMaker *make) {
 make.edges.mas_equalTo(0);
 }];
 Fcell.backgroundColor = [UIColor clearColor];
 */

@end
